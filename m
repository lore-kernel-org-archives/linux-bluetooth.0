Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <33016.80.146.4.18.1102847912.squirrel@schrell.de>
In-Reply-To: <1102838764.8750.32.camel@pegasus>
References: <35275.80.146.4.18.1102802831.squirrel@schrell.de>
    <1102804861.8750.2.camel@pegasus>
    <50745.80.146.4.18.1102837718.squirrel@schrell.de>
    <1102838764.8750.32.camel@pegasus>
From: "Andreas Schrell" <as@schrell.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] SOLVED: Dell Inspiron 8600 was: 'hciconfig -a' ok,
 but 'hcitools scan' shows no devices
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
Date: Sun, 12 Dec 2004 11:38:32 +0100 (CET)


Marcel,

thanks a lot for your help.

SUMMARY:

hciconfig -a         looked right
hcitool scan         did not show any devices

RESOLUTION:

Bluetooth was diabled under Windows!
There was no way to start it from Linux as far as I know.

After booting Windows and activation Bluetooth (right click on icon in
task bar, then activate) it works under Linux. Nothing to do with <FN-F2>.
Now the blue Bluetooth LED is on even on Linux startup.

Thank You, Marcel, for your help!

Andreas


> Hi Andreas,
>
>> And hcidump -X from "hciconfig -a" and "hcitool scan":
>>
>> HCIDump - HCI packet analyzer ver 1.12
>> device: hci0 snap_len: 1028 filter: 0xffffffff
>> < HCI Command: Read Local Name (0x03|0x0014) plen 0
>> > HCI Event: Command Complete (0x0e) plen 252
>>   0000: 01 14 0c 00 64 65 6c 6c  69 2d 30 00 00 00 00 00
>> ....delli-0.....
>>   0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>> ................
>>   00f0: 00 00 00 00 00 00 00 00  00 00 00 00              ............
>> < HCI Command: Read Class of Device (0x03|0x0023) plen 0
>> > HCI Event: Command Complete (0x0e) plen 7
>>   0000: 01 23 0c 00 00 01 00                              .#.....
>> < HCI Command: Read Local Version Information (0x04|0x0001) plen 0
>> > HCI Event: Command Complete (0x0e) plen 12
>>   0000: 01 01 10 00 02 f2 04 02  0a 00 f2 04              ............
>> < HCI Command: Inquiry (0x01|0x0001) plen 5
>>   0000: 33 8b 9e 08 64                                    3...d
>> > HCI Event: Command Status (0x0f) plen 4
>>   0000: 00 01 01 04                                       ....
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Vendor (0xff) plen 7
>>     CSR: VM (channel 13)
>>     0000: 03 00 04 00 00 00                                 ......
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>   0000: 00                                                .
>
> this looks not good, because you shouldn't get any vendor events from
> your Bluetooth chip. Is Bluetooth working for you under Windows?
>
>> I can switch Bluetooth off and on. If I press the button I get
>>
>> < HCI Command: Reset (0x03|0x0003) plen 0
>> Receive failed: Broken pipe
>>
>> and in syslog
>>
>> Dec 12 08:44:57 localhost kernel: atkbd.c: Unknown key pressed
>> (translated
>> set 2, code 0x88 on isa0060/serio0).
>> Dec 12 08:44:57 localhost kernel: atkbd.c: Use 'setkeycodes e008
>> <keycode>' to make it known.
>> Dec 12 08:44:57 localhost kernel: usb 1-2: USB disconnect, address 6
>> Dec 12 08:44:57 localhost hcid[9862]: HCI dev 0 down
>> Dec 12 08:44:57 localhost hcid[9862]: Stoping security manager 0
>> Dec 12 08:44:57 localhost hcid[9862]: HCI dev 0 unregistered
>>
>> next time I get
>> Dec 12 08:46:06 localhost hcid[9862]: HCI dev 0 up
>> Dec 12 08:46:06 localhost hcid[9862]: Starting security manager 0
>> Dec 12 08:46:09 localhost usb.agent[25983]:      hci_usb: already loaded
>> Dec 12 08:46:09 localhost usb.agent[25988]:      hci_usb: already loaded
>> Dec 12 08:46:09 localhost usb.agent[25993]:      hci_usb: already loaded
>>
>> Look ok for me.
>
> This is exactly how it should be. The complete Bluetooth module is
> physically connected/disconnected from the USB bus.
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
