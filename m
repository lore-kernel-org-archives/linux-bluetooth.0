Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214804856.7011.8.camel@peura.elisa-laajakaista.fi>
References: <1214310088.6643.87.camel@peura.elisa-laajakaista.fi>
	<1214527364.4435.14.camel@cookie.hadess.net>
	<1214548448.6624.61.camel@peura.elisa-laajakaista.fi>
	<1214804856.7011.8.camel@peura.elisa-laajakaista.fi>
Date: Mon, 30 Jun 2008 08:18:21 +0200
Message-Id: <1214806701.11537.14.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Making library out of bluez-gnome
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

Hi Antti,

> > Yes, true. thanks! I thought that g_value_set_string() would not make a
> > copy of the string. I just adapted the "device-selected" property so I
> > suppose it's also leaking memory. 
> 
> patch attached.
> It's against clean CVS without my other modifications.

please resend all patches and make sure that you use the exact same
coding style that is used in the file you modify.

Regards

Marcel



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
