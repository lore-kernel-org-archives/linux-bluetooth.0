Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "comlicated" setup - known issues for
	hid	and	SCO?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4117BA71.5000800@dark-reality.de>
References: <4117A907.7010006@dark-reality.de>
	 <1092071597.4564.17.camel@pegasus>  <4117B376.3030507@dark-reality.de>
	 <1092073484.4564.32.camel@pegasus>  <4117BA71.5000800@dark-reality.de>
Content-Type: text/plain
Message-Id: <1092090585.4564.51.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 Aug 2004 00:29:46 +0200

Hi Lars,

> | I don't see the hold mode. This can cause problem if they form a
> | scatternet. When both are connect what does "hcitool con" say?
> 
> without SCO connection active:
> Connections:
> ~        < ACL 00:0E:07:33:DE:2B handle 45 state 1 lm MASTER
> ~        > ACL 00:07:61:04:D6:7D handle 41 state 1 lm MASTER
> 
> 
> with active SCO connection:
> Connections:
> ~        < SCO 00:0E:07:33:DE:2B handle 44 state 1 lm SLAVE
> ~        < ACL 00:0E:07:33:DE:2B handle 45 state 1 lm MASTER
> ~        > ACL 00:07:61:04:D6:7D handle 41 state 1 lm MASTER

so both devices are in the same piconet. There should be no problem, but
from my position I can't tell you anything more.

> | Use "hciconfig hci0 revision" as root.
> 
> hci0:   Type: USB
> ~        BD Address: 00:04:61:81:4A:3E ACL MTU: 192:8  SCO MTU: 64:8
> ~        HCI 16.4
> ~        Chip version: BlueCore02
> ~        Max key size: 56 bit
> ~        SCO mapping:  HCI

This is a recent firmware version. So it should be fine.

> BTW, do you know what is the difference between using channel "1" and
> "no" channel for the SCO connection? The btsco client has this option,
> and if it's used as "1" the language for the RFCOMM commands seems to be
> different (i.e. if I press the take/hold button on the headset, I get
> "AT+BVRA=?" when using without "channel", but "AT+CKPD=200" when used
> with channel 1).

I've never used the btsco software.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
