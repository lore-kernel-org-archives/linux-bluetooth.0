Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Jesse Guardiani <jesse@wingnet.net>
Message-ID: <pan.2005.04.13.19.52.58.815123@wingnet.net>
References: <pan.2005.04.13.14.52.16.599459@wingnet.net> <1113405322.9061.36.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Re: bluetooth 1.2 - how do I know it's working?
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
Date: Wed, 13 Apr 2005 15:53:01 -0400

On Wed, 13 Apr 2005 17:15:22 +0200, Marcel Holtmann wrote:

> Hi Jesse,
> 
>> I just bought a D-Link DBT 120 rev B3 from ebay and flashed
>> it with the latest Apple dfu firmware using btdfu. (Thanks
>> for the advice, Marcel!)
>> 
>> Before the firmware upgrade, it talked to my Logitech Mobile
>> Freedom headset fine (Logitech HS02-V07) using btsco, but
>> the connection cracked and popped a lot. I run an 802.11b
>> network, so I figured the BT 1.1 might be getting interference
>> from the 802.11b net, thus causing the sound artifacts.
>> 
>> After the successful upgrade, it sounds a little better, I
>> think, but how do I make sure that the USB adapter AND the
>> headset are using BT 1.2's AFH features?
>> 
>> Here's my adapter:
>> 
>> hci0:   Type: USB
>>         BD Address: 00:0D:88:93:FC:3E ACL MTU: 192:8  SCO MTU: 64:8
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:576034 acl:30 sco:11266 events:88 errors:0
>>         TX bytes:569989 acl:26 sco:11157 commands:40 errors:0
>>         Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>>         Name: 'BlueZ (0)'
>>         Class: 0xff0100
>>         Service Classes: Positioning, Networking, Rendering, Capturing, Object Transfer, Audio, Telephony, Information
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 1.2 (0x2) HCI Rev: 0x632 LMP Ver: 1.2 (0x2) LMP Subver: 0x632
>>         Manufacturer: Cambridge Silicon Radio (10)
>> 
>> And here's my Mobile Freedom Headset:
>> 
>> # hcitool info 00:0D:44:36:E6:F4
>> Requesting information ...
>>         BD Address:  00:0D:44:36:E6:F4
>>         Device Name: Logitech HS02-V07
>>         LMP Version: 1.2 (0x2) LMP Subversion: 0x611
>>         Manufacturer: Cambridge Silicon Radio (10)
>>         Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
>>                 <encryption> <slot offset> <timing accuracy> <role switch>
>>                 <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
>>                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
>>                 <paging scheme> <power control> <transparent SCO>
>>                 <AFH cap. slave> <AFH cap. master>
>> 
>> # hcitool afh 00:0D:44:36:E6:F4
>> AFH map: 0xffffffffffffffffff7f
>> 
>> Does this indicate that both devices are using AFH correctly?
> 
> monitor the "hcitool afh" call and if the value changes then AFH is
> working.

No, they don't change. Even after a reboot it yields the same result.

What should I do to get it working?

-- 
Jesse Guardiani, Systems Administrator
WingNET Internet Services,
P.O. Box 2605 // Cleveland, TN 37320-2605
423-559-LINK (v)  423-559-5145 (f)
http://www.wingnet.net





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
