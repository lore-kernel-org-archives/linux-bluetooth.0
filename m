Return-Path: <bluez-devel-admin@lists.sourceforge.net>
In-Reply-To: <200508261256.03156.marcel@hilzinger.hu>
References: <E7BE78BC-60F2-40BC-8ABA-9F5E5F8DA5DA@gmx.net> <200508261256.03156.marcel@hilzinger.hu>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4D6C873D-FF91-4AC7-90E6-45FD50432EBB@gmx.net>
Cc: bluez-devel@lists.sourceforge.net
From: lists <gargarmel@gmx.net>
Subject: Re: [Bluez-devel] send appointment to cellular phone
To: marcel@hilzinger.hu
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 26 Aug 2005 15:56:31 +0200


Am 26.08.2005 um 12:56 schrieb Marcel Hilzinger:

> Am Donnerstag, 25. August 2005 22:28 schrieb lists:
>
>> hey,
>>
>> i'm just programming a shopping list for my flat-sharing-folks and
>> want to distribute shopping-lists as appointments onto our cellular
>> phones.
>>
>> well, i have some early testing experience with bluez about 2 years
>> ago (with multisync). but now i just want to send an appointment
>> (.ics file) to my device (i.e Siemens S55) and accept it there as
>> appointment in my calendar.
>>
>> i tried to send a single .ics file via obexftp, but it's just placed
>> on the file-system of my phone. no question whether i want to import
>> it to the calendar.
>>
>> does anyone have a hint, how i should send this and in what format?
>>
> Please send the ics file to me (privately). I will check if it's a  
> problem of
> the file or of the phone.

hi marcel,
this was the first thought i had, too. :o)

but then used a file that i first sent from the phone to my laptop.
it's a .vcs file with this content:

BEGIN:VCALENDAR
VERSION:1.0
BEGIN:VEVENT
CATEGORIES:MISCELLANEOUS
DTSTART:20050826T100000
DTEND:20050826T110000
DESCRIPTION;CHARSET=UTF-8;ENCODING=QUOTED-PRINTABLE:Messe=20Frankfurt=2
0bis=20so
LOCATION;CHARSET=UTF-8;ENCODING=QUOTED-PRINTABLE:
END:VEVENT
END:VCALENDAR

i think the problem is (as fred mentioned) my approach using obexftp.

hope i'll feed the list with a solution, soon!

regards,
ralph.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
