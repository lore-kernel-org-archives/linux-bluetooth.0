Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU141-W404351BCDF08C600D9561AD99E0@phx.gbl>
From: Axel Dine <axel__17@hotmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 1 Jul 2008 05:57:06 -1000
In-Reply-To: <1214889282.11537.115.camel@violet.holtmann.net>
References: <BLU141-W9DECA08385BE097483FADD99E0@phx.gbl>
	<1214889282.11537.115.camel@violet.holtmann.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] FW: hid2hci for the new iMAC
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net



> this is how HID Proxy from Broadcom works. The CSR stuff works
> different, but that's about it. I have to modify the hci_usb driver to
> include a quirk for this device and then we are good.

Do you mean that when the quirk will be included in hci_usb.c I can remove the module load option?

Let me ask you one more thing: in order to let HID correctly identify the Apple keyboard (0x022d)
and the Mighty mouse (0x030c) the corrensponding ID should be included in net/bluetooth/hidp/core.c.
I saw a discussion where someone was proposing the patch: is it already in the loop?

Thanks Marcel.

I will post asap some conclusion on my blog. Let you know...

Regards
AxeL

_________________________________________________________________
Use video conversation to talk face-to-face with Windows Live Messenger.
http://www.windowslive.com/messenger/connect_your_way.html?ocid=TXT_TAGLM_WL_Refresh_messenger_video_072008
-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
