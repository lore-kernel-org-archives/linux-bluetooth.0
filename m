Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <48713.80.146.12.98.1103017007.squirrel@schrell.de>
In-Reply-To: <1102968114.2143.13.camel@pegasus>
References: <35275.80.146.4.18.1102802831.squirrel@schrell.de>
    <1102804861.8750.2.camel@pegasus>
    <50745.80.146.4.18.1102837718.squirrel@schrell.de>
    <1102838764.8750.32.camel@pegasus>
    <33016.80.146.4.18.1102847912.squirrel@schrell.de>
    <1102851736.8750.34.camel@pegasus>
    <51140.80.146.12.98.1102958276.squirrel@schrell.de>
    <1102968114.2143.13.camel@pegasus>
Subject: Re: [Bluez-users] SOLVED: Dell Inspiron 8600 was: 'hciconfig -a'  
     ok, but 'hcitools scan' shows no devices
From: "Andreas Schrell" <as@schrell.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
Date: Tue, 14 Dec 2004 10:36:47 +0100 (CET)


Marcel,

no I used Windows sometimes. And as far as I rember I disabled the
Bluetooth in the taskbar. Perhaps some Dell-specific code. Is there a
Windows tool like hcidump? Maybe I can trace what happens when disabling
or enabling it under Win.

Andreas

> Hi Andreas,
>
>> here is the actual dump from "hcitool scan":
>>
>> delli:~# hcidump -a
>> HCIDump - HCI packet analyzer ver 1.12
>> device: hci0 snap_len: 1028 filter: 0xffffffff
>> < HCI Command: Inquiry (0x01|0x0001) plen 5
>>   3 . . . d
>> > HCI Event: Command Status (0x0f) plen 4
>>   . . . .
>> > HCI Event: Inquiry Result (0x02) plen 15
>>   . . . C . . . . . . . . r H .
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>   .
>> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>>   . . C . . . . . . .
>> > HCI Event: Command Status (0x0f) plen 4
>>   . . . .
>> > HCI Event: Remote Name Req Complete (0x07) plen 255
>>   . . . C . . . A . S c h r e l l . S 6 5
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . . . . . . .
>>   . . . . . . . . . . . . . . .
>>
>> On Windows I used the preinstalled Windows XP with the Bluetooth
>> applications from dell I think. Notebook is normally only used under
>> Linux. But if you give me some instruction where to look under Windows -
>> I
>> can give you appnames and version info etc.
>
> was this the first time you used Windows on that machine? Maybe your
> Bluetooth module was in an undefined state and the Windows stack send
> the HCI Reset (which we don't send normally) do reset it. However what
> do I know about the Windows operating system ;)
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
