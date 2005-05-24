Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42931C81.2010104@logicacmg.com>
From: "Tomas Honzak (WN CZ)" <Tomas.T.Honzak@logicacmg.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <4291DFA9.6010401@logicacmg.com>	 <1116857742.30044.88.camel@pegasus>  <4292E9B9.7080907@logicacmg.com> <1116925311.30044.134.camel@pegasus> <4292EEF8.80102@logicacmg.com>
In-Reply-To: <4292EEF8.80102@logicacmg.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] SOLVED: Internal Bluetooth on dell latitude d610
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 24 May 2005 14:22:25 +0200

Hello,
Kernel 2.6.12-pre4 fixed the problem.
Thanks!
Tomas

Tomas Honzak (WN CZ) wrote:

> O.K., although our IS-support will probably not like me :)
> I'll give it a try and let you know.
> Thanks,
> Tomas
>
> Marcel Holtmann wrote:
>
>> Hi Thomas,
>>
>>  
>>
>>> Fn+F2 as you suggested really moved me a bit further, unfortunately, 
>>> only to another error message:
>>>
>>> usb 3-1: new full speed USB device using address 2
>>> usb 3-1: control timeout on ep0out
>>>
>>> after this message, cat /proc/bus/usb/devices hangs on forever.
>>> Hm. Probably a kernel bug / unsupported BT device? I tried to do a 
>>> google search, found some similar questions but no answer :/
>>>   
>>
>>
>> try a 2.6.12-rc4 kernel and you should really update the BlueZ packages.
>>
>> Regards
>>
>> Marcel
>>
>>
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by Oracle Space Sweepstakes
>> Want to be the first software developer in space?
>> Enter now for the Oracle Space Sweepstakes!
>> http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>  
>>
>
>


-- 
Tomas Honzak
Configuration Management
Wireless Networks
_________________________________________
LogicaCMG
Na Okraji 335/42
162 00 Praha 6
Czech Republic
T: +420 284 020 936 (direct)
F: +420 284 020 112
E: Tomas.T.Honzak@logicacmg.com
www.logicacmg.com


This e-mail and any attachment is for authorised use by the intended recipient(s) only. It may contain proprietary material, confidential information and/or be subject to legal privilege. It should not be copied, disclosed to, retained or used by, any other party. If you are not an intended recipient then please promptly delete this e-mail and any attachment and all copies and inform the sender. Thank you.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
