﻿/////////////////////////////////////////////////////////////////////////
//
// OneScript Package Manager
// Установщик пакетов для OneScript
// Выполняется, как os-приложение в командной строке:
//
// opm install my-package.ospx
//
/////////////////////////////////////////////////////////////////////////

#Использовать cmdline
#Использовать logos

#Использовать "."

Перем Лог;

Процедура ВыполнитьКоманду(Знач Аргументы)
	
	ОбработкаКоманд = СоздатьОбработчикКоманд();
	Парсер = Новый ПарсерАргументовКоманднойСтроки();
	
	ОбработкаКоманд.ДобавитьОписанияКоманд(Парсер);
	
	Параметры = Парсер.Разобрать(Аргументы);
	ПараметрыКоманды = Парсер.РазобратьКоманду(Аргументы);
	Если ПараметрыКоманды = Неопределено Тогда
		ВывестиСправкуПоКомандам(ОбработкаКоманд);
		ЗавершитьРаботу(1);
	КонецЕсли;
	
	Попытка
		ОбработкаКоманд.ВыполнитьКоманду(ПараметрыКоманды);
	Исключение
		Лог.Отладка(ОписаниеОшибки());
		Сообщить(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		ЗавершитьРаботу(1);
	КонецПопытки;
	
КонецПроцедуры

Процедура ВывестиСправкуПоКомандам(Знач ОбработкаКоманд)
	
	ОбработкаКоманд.ВывестиСправкуПоКомандам();
	
КонецПроцедуры

/////////////////////////////////////////////////////////////////////////
// Вспомогательные функции

Функция СоздатьОбработчикКоманд()
	Возврат Новый ДиспетчерКомандПриложения();
КонецФункции

/////////////////////////////////////////////////////////////////////////
// Точка входа

Лог = Логирование.ПолучитьЛог("oscript.app.opm");

НастройкиПриложения.УстановитьФайлНастроек("opm.conf");
ВыполнитьКоманду(АргументыКоманднойСтроки);