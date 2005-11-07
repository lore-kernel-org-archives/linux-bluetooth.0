Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17262.45251.127138.103470@waldo.lisle.iphase.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco + aplay produces only silence on headset
From: bbosch@iphase.com
In-Reply-To: <436E46E8.1060201@bglug.it>
References: <17261.23534.882674.809679@waldo.lisle.iphase.com>
	<436DB826.2090406@libero.it>
	<17262.9574.50552.492352@waldo.lisle.iphase.com>
	<436E46E8.1060201@bglug.it>
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
Date: Sun, 6 Nov 2005 19:41:23 -0600

I found my problem.  It seems that somehow I missed the SCO option on
the hci_usb driver the last X times I built the kernel!!  I have no
idea why this didn't show up somewhere as an error message when I
tried to use it.

The kernel ALSA drivers do not need to be built in.  The 2.6.14
ALSA modules work just fine but when I was reconfiguring the kernel to
include non-modular ALSA support, I noticed my error so thanks jimmi!

To summarize, I was just missing CONFIG_BT_HCIUSB_SCO=y in my .config file.

Now aplay works fine so my next step is to get it working with skype.

Thanks again.

--Brad


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
