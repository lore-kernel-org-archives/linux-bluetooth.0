Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logiteh MX900 / USB Bluetooth "dongle" support?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4114D840.2090609@dark-reality.de>
References: <4114CE58.5070302@dark-reality.de>
	 <1091883214.2773.0.camel@pegasus> <200408071412.54806.puggy@gentoo.org>
	 <4114D840.2090609@dark-reality.de>
Content-Type: text/plain
Message-Id: <1091885932.2773.3.camel@pegasus>
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
Date: Sat, 07 Aug 2004 15:38:52 +0200

Hi Lars,

> Hm I just tried
> | hid2hci -0
> Switching device 046d:c705 to HCI mode failed (no such file or directory)

check that you've compiled a kernel with CONFIG_USB_HIDDEV and check
that the hiddev device nodes are present.

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
