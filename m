Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "comlicated" setup - known issues for hid and
	SCO?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4117A907.7010006@dark-reality.de>
References: <4117A907.7010006@dark-reality.de>
Content-Type: text/plain
Message-Id: <1092071597.4564.17.camel@pegasus>
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
Date: Mon, 09 Aug 2004 19:13:17 +0200

Hi Lars,

> right now I'm using two BT devices with my Epox dongle, an MX900 mice
> and a Sony Ericcson HBH-35 Headset with snd-bt-sco (voice mode 0x0060,
> before you ask ;)

what does "hcitool info ..." say about your headset? What is the
firmware version of your EPoX dongle?

> both devices work fluently when used without the other, but when I use
> headset and mouse at the same time there are various problems during
> connect, scan and usage.
> 
> The main usage problem was that the sco layer got scrambled audio
> (sounded much like random data) on about every third sco connection.
> After a while, mouse and headset began to block each other, and the
> stack seemed to get more and more, well, muddy. After some more
> connection retries even the mouse, before only "hanging" when the
> headset tried to connect, stopped working fully.
> 
> dmesg only noticed this:
> 
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 76
> 
> When even connection was impossible, I plugged the BT dongle out and put
> it back in. After reloading the hid module and programs the mouse and
> headset worked again.

I think that is a hardware problem. A protocol analyser would help to
track this down ;)

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
