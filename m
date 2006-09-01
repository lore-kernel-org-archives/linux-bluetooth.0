Return-Path: <Linux@feline-soul.com>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
Reply-To: Linux@feline-soul.com
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] How do I reset a pairing?
Date: Thu, 31 Aug 2006 18:29:31 -0600
Cc: bluez-users@lists.sourceforge.net
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com> <200608311150.38005.Linux@feline-soul.com> <1157062113.4026.145.camel@aeonflux.holtmann.net>
In-Reply-To: <1157062113.4026.145.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200608311829.31921.Linux@feline-soul.com>
List-ID: <bluez-users.lists.sourceforge.net>

I killed kdebluetooth and made sure no traces of it were running. I get the 
same errors.

Here is the hcidump -X -V with kdebluetooth off:
18:23:48 root@linux:/home/bearcat# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:44:4F:37:72 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:0D:44:4F:37:72 type ACL encrypt 0x00
    Error: Page Timeout
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:44:4F:37:72 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:0D:44:4F:37:72 type ACL encrypt 0x00
    Error: Page Timeout

At the command line 
18:21:36 bearcat@linux:~$ btsco 00:0D:44:4F:37:72
Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable
18:23:07 bearcat@linux:~$ btsco 00:0D:44:4F:37:72
Error: Failed to connect to SDP server: Host is down
Assuming channel 2

Can't connect RFCOMM channel: Host is down


Thanks, 

Bearcat

On Thursday 31 August 2006 16:08 in an email titled "Re: [Bluez-users] How do 
I reset a pairing?" Marcel Holtmann wrote:
>Hi Bearcat,
>
>> Thank you. Here is the output from hcidump -X -V:
>>
>> 11:46:21 root@linux:/home/bearcat# hcidump -X -V
>> HCI sniffer - Bluetooth packet analyzer ver 1.31
>> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
>> < HCI Command: Create Connection (0x01|0x0005) plen 13
>>     bdaddr 00:0D:44:4F:37:72 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>>
>> > HCI Event: Command Status (0x0f) plen 4
>>
>>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
>>
>> > HCI Event: PIN Code Request (0x16) plen 6
>>
>>     bdaddr 00:0D:44:4F:37:72
>>
>> > HCI Event: Mode Change (0x14) plen 6
>>
>>     status 0x00 handle 41 mode 0x00 interval 0
>>     Mode: Active
>>
>> > HCI Event: Mode Change (0x14) plen 6
>>
>>     status 0x00 handle 41 mode 0x02 interval 126
>>     Mode: Sniff
>>
>> > HCI Event: Connect Complete (0x03) plen 11
>>
>>     status 0x22 handle 44 bdaddr 00:0D:44:4F:37:72 type ACL encrypt 0x00
>>     Error: LMP Response Timeout
>> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
>>
>> > HCI Event: Command Complete (0x0e) plen 6
>>
>>     Read Voice Setting (0x03|0x0025) ncmd 1
>>     status 0x00 voice setting 0x0060
>> < HCI Command: Create Connection (0x01|0x0005) plen 13
>>     bdaddr 00:0D:44:4F:37:72 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>>
>> > HCI Event: Command Status (0x0f) plen 4
>>
>>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
>>
>> > HCI Event: PIN Code Request (0x16) plen 6
>>
>>     bdaddr 00:0D:44:4F:37:72
>> < HCI Command: Inquiry (0x01|0x0001) plen 5
>>     lap 0x9e8b33 len 6 num 0
>>
>> > HCI Event: Command Status (0x0f) plen 4
>>
>>     Inquiry (0x01|0x0001) status 0x00 ncmd 1
>>
>> > HCI Event: Inquiry Result (0x02) plen 15
>>
>>     bdaddr 00:0D:44:4F:37:72 mode 1 clkoffset 0x50a7 class 0x200404
>>
>> > HCI Event: Inquiry Complete (0x01) plen 1
>>
>>     status 0x00
>>
>> > HCI Event: Connect Complete (0x03) plen 11
>>
>>     status 0x22 handle 45 bdaddr 00:0D:44:4F:37:72 type ACL encrypt 0x00
>>     Error: LMP Response Timeout
>
>this looks like you have the KDE Bluetooth thingy running and it
>interferes when trying to connect. They always did this scanning thing
>without actually checking if the HCI controller is in use. I would
>advise you to not use KDE Bluetooth unless they switched to using the
>new D-Bus driven API.
>
>Regards
>
>Marcel

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor
