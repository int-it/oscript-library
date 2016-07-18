﻿#Использовать ".."

Перем юТест;
Перем УправлениеКонфигуратором;

Процедура Инициализация()
	
	УправлениеКонфигуратором = Новый УправлениеКонфигуратором;
	Лог = Логирование.ПолучитьЛог("oscript.lib.v8runner");
	Лог.УстановитьУровень(УровниЛога.Отладка);
	
КонецПроцедуры

Функция ПолучитьСписокТестов(Тестирование) Экспорт
	
	юТест = Тестирование;
	
	СписокТестов = Новый Массив;
	СписокТестов.Добавить("ТестДолжен_ИзменитьКаталогСборки");
	СписокТестов.Добавить("ТестДолжен_СоздатьВременнуюБазу");
	СписокТестов.Добавить("ТестДолжен_ПроверитьНазначениеПутиКПлатформе");
	
	Возврат СписокТестов;
	
КонецФункции

Процедура ТестДолжен_ИзменитьКаталогСборки() Экспорт
	
	ПоУмолчанию = ТекущийКаталог();
	юТест.ПроверитьРавенство(УправлениеКонфигуратором.КаталогСборки(), ПоУмолчанию, "По умолчанию каталог сборки должен совпадать с текущим каталогом");
	
	СтароеЗначение = УправлениеКонфигуратором.КаталогСборки(КаталогВременныхФайлов());
	юТест.ПроверитьРавенство(СтароеЗначение, ПоУмолчанию, "Предыдущее значение каталога должно возвращяться при его смене");
	юТест.ПроверитьРавенство(УправлениеКонфигуратором.КаталогСборки(), КаталогВременныхФайлов(), "Каталог сборки должен быть изменен");
	
КонецПроцедуры

Процедура ТестДолжен_СоздатьВременнуюБазу() Экспорт
	
	Если УправлениеКонфигуратором.ВременнаяБазаСуществует() Тогда
		УдалитьФайлы(УправлениеКонфигуратором.ПутьКВременнойБазе());
	КонецЕсли;
	
	юТест.ПроверитьЛожь(УправлениеКонфигуратором.ВременнаяБазаСуществует(), "Временной базы не должно быть в каталоге <"+УправлениеКонфигуратором.ПутьКВременнойБазе()+">");
	УправлениеКонфигуратором.СоздатьФайловуюБазу(УправлениеКонфигуратором.ПутьКВременнойБазе());
	Сообщить(УправлениеКонфигуратором.ВыводКоманды());
	юТест.ПроверитьИстину(УправлениеКонфигуратором.ВременнаяБазаСуществует(), "Временная база должна существовать");
	УдалитьФайлы(УправлениеКонфигуратором.ПутьКВременнойБазе());
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьНазначениеПутиКПлатформе() Экспорт
	
	ПутьПоУмолчанию = УправлениеКонфигуратором.ПолучитьПутьКВерсииПлатформы("8.3");
	юТест.ПроверитьЛожь(ПустаяСтрока(ПутьПоУмолчанию));
	юТест.ПроверитьРавенство(ПутьПоУмолчанию, УправлениеКонфигуратором.ПутьКПлатформе1С());
	
	НовыйПуть = "тратата";
	Попытка
		УправлениеКонфигуратором.ПутьКПлатформе1С(НовыйПуть);
	Исключение
		Возврат;
	КонецПопытки;
	
	ВызватьИсключение "Не было выброшено исключение при попытке установить неверный путь";
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////////////
// Инициализация

Инициализация();