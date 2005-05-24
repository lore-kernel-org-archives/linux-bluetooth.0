Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4292E9B9.7080907@logicacmg.com>
From: "Tomas Honzak (WN CZ)" <Tomas.T.Honzak@logicacmg.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Internal Bluetooth on dell latitude d610?
References: <4291DFA9.6010401@logicacmg.com> <1116857742.30044.88.camel@pegasus>
In-Reply-To: <1116857742.30044.88.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 24 May 2005 10:45:45 +0200

Hello Marcel and thanks for quick reply.
Fn+F2 as you suggested really moved me a bit further, unfortunately, 
only to another error message:

usb 3-1: new full speed USB device using address 2
usb 3-1: control timeout on ep0out

after this message, cat /proc/bus/usb/devices hangs on forever.
Hm. Probably a kernel bug / unsupported BT device? I tried to do a 
google search, found some similar questions but no answer :/

Thanks,
Tomas


Marcel Holtmann wrote:

>Hi Thomas,
>
>  
>
>>my company gave me a latitude dell d610 notebook with built-in bluetooth
>>(Dell Wireless 350 Bluetooth Module);
>>unfortunately, I am not able to get it work under linux.
>>
>>I have
>>- centos 4.0, kernel 2.6.9, all modules load correctly,
>># rpm -qa | grep blue
>>bluez-bluefw-1.0-6
>>bluez-hcidump-1.11-1
>>bluez-libs-2.10-2
>>bluez-utils-2.10-2.1
>>
>>/etc/init.d/bluetooth start even makes BT led lid ;) BUT
>>
>>hciconfig -a does nothing, neither hcitool dev (shows empty lines 
>>"Devices:") or hciconfig hci0 (Can't get device info: No such device")
>>
>>google search did not find anything relevant, so I am politely asking 
>>here :)
>>Does anyone have any ideas, please?
>>    
>>
>
>check /proc/bus/usb/devices, but I assume that the module is switched
>off by default. So you need to activate it, because otherwise it will
>not show up on the USB bus and thus it can't picked up by the hci_usb
>driver.
>
>Most Dell notebooks should have a Fn-F2 switch or an extra BIOS option
>for this. Otherwise the only option is to look for a Dell ACPI module to
>modify the Bluetooth switch.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by Oracle Space Sweepstakes
>Want to be the first software developer in space?
>Enter now for the Oracle Space Sweepstakes!
>http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
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
