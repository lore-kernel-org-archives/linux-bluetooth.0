Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "comlicated" setup - known issues for hid
	and	SCO?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4117B376.3030507@dark-reality.de>
References: <4117A907.7010006@dark-reality.de>
	 <1092071597.4564.17.camel@pegasus>  <4117B376.3030507@dark-reality.de>
Content-Type: text/plain
Message-Id: <1092073484.4564.32.camel@pegasus>
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
Date: Mon, 09 Aug 2004 19:44:44 +0200

Hi Lars,

> | what does "hcitool info ..." say about your headset? What is the
> | firmware version of your EPoX dongle?
> |
> |
> Headset:
> ~        BD Address:  00:0E:07:33:DE:2B
> ~        Device Name: HBH-35
> ~        LMP Version: 1.1 (0x1) LMP Subversion: 0x8d40
> ~        Manufacturer: Ericsson Technology Licensing (0)
> ~        Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00
> ~                <encryption> <slot offset> <timing accuracy> <role switch>
> ~                <sniff mode> <SCO link> <HV3 packets> <CVSD>

I don't see the hold mode. This can cause problem if they form a
scatternet. When both are connect what does "hcitool con" say?

> How can I find out what firmware my dongle has? It's a BT-DG03...

Use "hciconfig hci0 revision" as root.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
