Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Jesse Guardiani <jesse@wingnet.net>
Message-ID: <ctonm5$814$1@sea.gmane.org>
References: <cteadv$tbe$1@sea.gmane.org> <1106961349.10580.7.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Anycom USB-240 & firmware
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
Date: Tue, 01 Feb 2005 15:10:03 -0500

Marcel Holtmann wrote:

> Hi Jesse,
> 
>> I recently bought an Anycom USB-240. It ships
>> with BT 1.1 firmware, as depicted below, but
>> it *should* be BT 1.2 capable hardware.
>> 
>> % hciconfig -a
>> hci0:   Type: USB
>>         BD Address: 00:0B:0D:34:1F:E0 ACL MTU: 120:20  SCO MTU: 64:0
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:254 acl:0 sco:0 events:43 errors:0
>>         TX bytes:416 acl:0 sco:0 commands:30 errors:0
>>         Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>>         Name: 'BlueZ (0)'
>>         Class: 0x100100
>>         Service Classes: Object Transfer
>>         Device Class: Computer, Uncategorized
>>         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver:
>>         0x757 Manufacturer: Silicon Wave (11)
>> 
>> My interest in Bluetooth is primarily tied to
>> audio right now. I've been doing a lot of work
>> with SIP phones lately so I've ordered a BT 1.2
>> Logitech Mobile Freedom Headset to play with.
>> It should arrive in a week or two.
>> 
>> Anyway, the Logitech headset is BT 1.2 capable
>> so I'd like to upgrade my USB-240 firmware to
>> 1.2 also (freq hopping to avoid my 802.11b nets,
>> etc...), but this post on the Anycom website
>> claims that the USB-240's headset and handsfree
>> profiles don't work well under Linux with BT
>> 1.2 firmware:
>>     http://tinyurl.com/5pqnm
>> 
>> So in the interest of NOT frying my shiny new
>> USB-240, does anyone on this list currently use
>> a USB-240 with a headset or handsfree profile
>> device? Which firmware do you use?
> 
> if you wanna play with audio then you should better buy a dongle with a
> CSR chip.

Well, my headset arrived today and is currently in it's 4 hour
charge cycle. We'll see if the Anycom is Anygood for audio. :)


>> Also, if I *do* decide to upgrade the adapter's
>> firmware, am I likely to have better luck with
>> Anycom's firmware via a Win32 install? Or with
>> Bluez supplied firmware? Does the Bluez firmware
>> even work with my Silicon Wave chipset?
> 
> As far as I know these Silicon Wave chips are ROM only version and so
> you can't update the firmware. However I don't even know of any firmware
> updates for Silicon Wave.

Unfortunately, according to Jens in this thread:
     http://tinyurl.com/5pqnm

You are correct. I'm interested in playing with this
device, so maybe they'll have some documentation
available.

-- 
Jesse Guardiani, Systems Administrator
WingNET Internet Services,
P.O. Box 2605 // Cleveland, TN 37320-2605
423-559-LINK (v)  423-559-5145 (f)
http://www.wingnet.net




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
