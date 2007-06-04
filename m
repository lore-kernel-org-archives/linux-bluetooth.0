Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ville Tervo <ville.tervo@nokia.com>
In-Reply-To: <20070604115532.GI6310@null.research.nokia.com>
References: <20070601111156.GB6310@null.research.nokia.com>
	<1180711261.6726.6.camel@aeonflux.holtmann.net>
	<20070604083531.GF6310@null.research.nokia.com>
	<1180946944.13429.21.camel@violet>
	<20070604103256.GH6310@null.research.nokia.com>
	<1180953879.13429.25.camel@violet>
	<20070604115532.GI6310@null.research.nokia.com>
Date: Mon, 04 Jun 2007 14:24:16 +0200
Message-Id: <1180959856.13429.33.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [Patch] Keep rfcomm device in list until it's
	freed
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

Hi Ville,

> > do you have a simple re-producer for it. I need to test this on my Quad
> > G5 before pushing this upstream.
> 
> Nope. Claudio said that he had some way to reproduce the bug with some
> cvs version. I haven't tried that yet. I need to install some distro to
> test machine first. However I tested this with N800 and it works fine on
> arm.

but I need to make sure that this is also working on SMP systems and all
other desktops.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
