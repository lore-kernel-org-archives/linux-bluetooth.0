Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: michele.puccio@eng.it, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1190705022.6543.5.camel@localhost>
References: <1190642401.6465.20.camel@localhost>
	<1190672239.5133.136.camel@aeonflux.holtmann.net>
	<1190705022.6543.5.camel@localhost>
Date: Tue, 25 Sep 2007 09:57:55 +0200
Message-Id: <1190707075.5133.164.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem pairing device
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

Hi Michele,

> thanks for answering...but how can I "loading hci_usb with reset=1"?

there are millions of howtos that deal with kernel modules/drivers and
how to load them with special options. Also /sys/module/hci_usb can be
used to changed them at runtime. Then however the device needs to be
unplugged and replugged.

> my system don't the recognize bccmd as a valid command; may be I need
> some extra package to install...

Ask your distro. It is part of bluez-utils. Compile it from the sources.

> can you please help me? the bluetooth is the only stuff that doesn't
> work in my linuxbox (dell latitude d610 + ubuntu feisty)

If someone donates a D610 to me, then I can make this easily work, but
until then, you have to play with it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
