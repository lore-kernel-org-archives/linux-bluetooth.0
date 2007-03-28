Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1175073408.15698.97.camel@cookie.hadess.net>
References: <1175073408.15698.97.camel@cookie.hadess.net>
Date: Wed, 28 Mar 2007 11:28:39 +0200
Message-Id: <1175074119.5815.118.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid returning "Device or resource busy"?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

> I've been wondering why my devices weren't showing up in
> nautilus-sendto, and it looks like DiscoverDevices doesn't work. Here's
> the snippet of code:
> 
>         dbus_g_proxy_call (object, "DiscoverDevices", &e,
>                            G_TYPE_INVALID, G_TYPE_INVALID);
>         if (e != NULL) {
>                 g_warning ("Couldn't start discovery: %s: %s",
>                            dbus_g_error_get_name (e), e->message);
>                 g_error_free (e);
>         }
> 
> I do a list ListBondings before that on the same object, so I know that
> it works. But I still get that error:
> Couldn't start discovery: org.bluez.Error.Failed: Device or resource busy

please run "hcidump -X -V" to see what happens on the HCI layer. Do you
have running anything else at the same time.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
