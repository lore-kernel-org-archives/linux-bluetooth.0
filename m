Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Keeping hci interface powered
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <m3tx04kat2.fsf@carbon.jhcloos.org>
Date: Mon, 5 Jan 2015 17:32:56 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FC3579EF-F5AF-4B28-9E70-97080FA6DD2C@holtmann.org>
References: <m3oaqfl79f.fsf@carbon.jhcloos.org> <D043D131-E9F8-43C1-8671-0EACAE810420@holtmann.org> <m361cklxwo.fsf@carbon.jhcloos.org> <C5CDA647-8415-44F3-9F89-0D596D76498F@holtmann.org> <m3zj9wkfsw.fsf@carbon.jhcloos.org> <FFFB52BA-6CC2-4E9E-ACA3-C3D2099BAA9B@holtmann.org> <m3tx04kat2.fsf@carbon.jhcloos.org>
To: James Cloos <cloos@jhcloos.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

>>> link_keys has the line:
>>> 
>>> 90:7f:xx:xx:xx:xx 4 eaxxxxxxxxxxxxxxxxxxxxxxxxxxxx1e 0
> 
> MH> this is an unauthenticated link key from SSP. Surprising to me that
> MH> you do not have an authenticated link key. That is odd.
> 
>>> ,----< debug/bluetooth/hci0/features >
>>> |  0: 0xff 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
> 
> MH> The features page 1 should list at least 0x01 to indicate Secure
> MH> Simple Pairing support. Can you run hciconfig hci0 features
> 
> That reports the same hex string, which it decodes as:
> 
> 	<3-slot packets> <5-slot packets> <encryption> <slot offset> 
> 	<timing accuracy> <role switch> <hold mode> <sniff mode> 
> 	<RSSI> <channel quality> <SCO link> <HV2 packets> 
> 	<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
> 	<power control> <transparent SCO> <EDR ACL 2 Mbps> 
> 	<EDR ACL 3 Mbps> <enhanced iscan> <interlaced iscan> 
> 	<interlaced pscan> <inquiry with RSSI> <extended SCO> 
> 	<EV4 packets> <EV5 packets> <AFH cap. slave> 
> 	<AFH class. slave> <LE support> <3-slot EDR ACL> 
> 	<5-slot EDR ACL> <sniff subrating> <pause encryption> 
> 	<AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps> 
> 	<EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended inquiry> 
> 	<LE and BR/EDR> <simple pairing> <encapsulated PDU> 
> 	<err. data report> <non-flush flag> <LSTO> <inquiry TX power> 
> 	<EPC> <extended features> 
> 
> MH> and btmgmt info
> 
> Built, but not installed by the ebuild....
> 
> hci0:	addr 80:86:F2:xx:xx:xx version 6 manufacturer 2 class 0x000104
> 	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising debug-keys privacy configuration 
> 	current settings: powered bondable ssp br/edr le 
> 	name BlueZ 5.27
> 	short name 
> 
> I also found:
> 
>  :; hciconfig hci0 sspmode
>  hci0:	Type: BR/EDR  Bus: USB
>  	BD Address: 80:86:F2:xx:xx:xx  ACL MTU: 1021:5  SCO MTU: 96:5
>  	Simple Pairing mode: Disabled

these two do not match. btmgmt clearly says that SSP is enabled while the controller thinks otherwise. Something is wrong here. I think the only way to check would be to run btmon before the adapter is powered on.

> MH> This is odd. It should show also features page 1. Run btmon while
> MH> executing this command and I can tell you what is going on.
> 
> Bluetooth monitor ver 5.27
> = New Index: 80:86:F2:xx:xx:xx (BR/EDR,USB,hci0)                                [hci0] 0.590153
> 
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10                        [hci0] 4.074510
>        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
>        Page scan repetition mode: R2 (0x02)
>        Page scan mode: Mandatory (0x00)
>        Clock offset: 0x0000
>> HCI Event: Command Status (0x0f) plen 4                                       [hci0] 4.076607
>      Remote Name Request (0x01|0x0019) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Remote Name Req Complete (0x07) plen 255                           [hci0] 5.924745
>        Status: Success (0x00)
>        Address: 90:7F:61:xx:xx:xx (Chicony Electronics Co., Ltd.)
>        Name: ThinkPad Compact Bluetooth Keyboard with TrackPoint
> < HCI Command: Read Remote Version Information (0x01|0x001d) plen 2             [hci0] 5.925091
>        Handle: 256
>> HCI Event: Command Status (0x0f) plen 4                                       [hci0] 5.926589
>      Read Remote Version Information (0x01|0x001d) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Read Remote Version Complete (0x0c) plen 8                         [hci0] 6.434751
>        Status: Success (0x00)
>        Handle: 256
>        LMP version: Bluetooth 3.0 (0x05) - Subversion 8721 (0x2211)
>        Manufacturer: Broadcom Corporation (15)
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2              [hci0] 6.435093
>        Handle: 256
>> HCI Event: Command Status (0x0f) plen 4                                       [hci0] 6.436677
>      Read Remote Supported Features (0x01|0x001b) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Read Remote Supported Features (0x0b) plen 11                      [hci0] 6.951761
>        Status: Success (0x00)
>        Handle: 256
>        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
>          3 slot packets
>          5 slot packets
>          Encryption
>          Slot offset
>          Timing accuracy
>          Role switch
>          Sniff mode
>          Power control requests
>          Channel quality driven data rate (CQDDR)
>          Paging parameter negotiation
>          Power control
>          Broadcast Encryption
>          Enhanced inquiry scan
>          Interlaced inquiry scan
>          Interlaced page scan
>          RSSI with inquiry results
>          AFH capable slave
>          AFH classification slave
>          Sniff subrating
>          Pause encryption
>          AFH capable master
>          AFH classification master
>          Extended Inquiry Response
>          Secure Simple Pairing
>          Encapsulated PDU
>          Non-flushable Packet Boundary Flag
>          Link Supervision Timeout Changed Event
>          Inquiry TX Power Level
>          Enhanced Power Control
>          Extended features
> < HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3               [hci0] 6.952067
>        Handle: 256
>        Page: 0
>> HCI Event: Command Status (0x0f) plen 4                                       [hci0] 6.953595
>      Read Remote Extended Features (0x01|0x001c) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Read Remote Extended Features (0x23) plen 13                       [hci0] 7.469753
>        Status: Success (0x00)
>        Handle: 256
>        Page: 0/0
>        Features: 0xbf 0x06 0x86 0x78 0x18 0x1e 0x59 0x87
>          3 slot packets
>          5 slot packets
>          Encryption
>          Slot offset
>          Timing accuracy
>          Role switch
>          Sniff mode
>          Power control requests
>          Channel quality driven data rate (CQDDR)
>          Paging parameter negotiation
>          Power control
>          Broadcast Encryption
>          Enhanced inquiry scan
>          Interlaced inquiry scan
>          Interlaced page scan
>          RSSI with inquiry results
>          AFH capable slave
>          AFH classification slave
>          Sniff subrating
>          Pause encryption
>          AFH capable master
>          AFH classification master
>          Extended Inquiry Response
>          Secure Simple Pairing
>          Encapsulated PDU
>          Non-flushable Packet Boundary Flag
>          Link Supervision Timeout Changed Event
>          Inquiry TX Power Level
>          Enhanced Power Control
>          Extended features

So the max_page value is 0, but it should be 1 for this controller. I think that is what is tripping up the command and not reading page 1. The page is clearly available as the other trace shows. And yes, the keyboard has Secure Simple Pairing enabled.

> MH> The LegacyPairing: no is not a 100% indication, but I assume your
> MH> keyboard is actually a Bluetooth 2.1 keyboard with Secure Simple
> MH> Pairing.
>>> 
> MH> Do you have an exact model number or link? We might have to buy one
> MH> of these keyboards.
>>> 
>>> Lenovo's pages are:
>>> 
>>> http://shop.lenovo.com/us/en/itemdetails/0B47189/460/60AC6A0372B14F5BA7B12F1FF88E33C7
>>> http://support.lenovo.com/en/documents/pd026744
>>> 
>>> I got that one to support my trackpoint addiction. :^/
>>> 
>>> Are there any good tech specs for bt available w/o cost?
> 
> MH> Can you capture a pairing procedure with your keyboard with btmon?
> MH> Then I can tell what is actually going on between these two devices.
> 
> After unpairing, it refuses to re-pair at all.  So now no keyboard
> whatsoever......

Most likely it has a button that you need to press or hold to make it forgot the current key.

And when in bluetoothctl, make sure you start an agent. That is the piece that will ask you for the passkey.

Regards

Marcel

