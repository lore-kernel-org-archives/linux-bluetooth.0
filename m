Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f84803c0712170754n14d401a7l225d3d9b2f413850@mail.gmail.com>
References: <5f84803c0712030733q38350283m77e8930dfcca4162@mail.gmail.com>
	<1196699122.12292.113.camel@violet>
	<5f84803c0712030850k5810ee43na4a13f5e74657388@mail.gmail.com>
	<1196701181.12292.128.camel@violet>
	<5f84803c0712060959n6db58e78y4adfa1b4a212df71@mail.gmail.com>
	<1197870459.8050.80.camel@aeonflux>
	<5f84803c0712170754n14d401a7l225d3d9b2f413850@mail.gmail.com>
Date: Mon, 17 Dec 2007 19:53:03 +0100
Message-Id: <1197917583.8050.87.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] [RESEND] make bluez GNOME UIs singletons
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Chris,

> Updated patches attached.

I added the generic singleton instance patch to the CVS. I did some
minor modifications. The interface name is org.bluez.Instance. No need
to duplicate the word Bluetooth here. And I removed the retval parameter
from the register function. It is useless. Use the return value for it.
If it is TRUE, everything is okay. If FALSE, cleanup and exit(1).

Please update the application patches and resend them. And double check
the whitespace stuff. I had to fix some of them in your other patch. Use
an editor that has a visual representation of tabs and whitespaces. It
really helps.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
