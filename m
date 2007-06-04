Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ville Tervo <ville.tervo@nokia.com>
In-Reply-To: <20070604103256.GH6310@null.research.nokia.com>
References: <20070601111156.GB6310@null.research.nokia.com>
	<1180711261.6726.6.camel@aeonflux.holtmann.net>
	<20070604083531.GF6310@null.research.nokia.com>
	<1180946944.13429.21.camel@violet>
	<20070604103256.GH6310@null.research.nokia.com>
Date: Mon, 04 Jun 2007 12:44:38 +0200
Message-Id: <1180953879.13429.25.camel@violet>
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

> > > > > Here is patch for rfcomm to keep rfcomm device in list until it's really
> > > > > unused.
> > > > 
> > > >         dev = __rfcomm_dev_get(id);
> > > > +
> > > > +       if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
> > > > +               dev = NULL;
> > > > +
> > > >         if (dev)
> > > >                 rfcomm_dev_hold(dev);
> > > > 
> > > > a test_bit() and then return NULL at the beginning makes more sense. No
> > > > need to take the lock since test_bit() is atomic anyway.
> > > 
> > > How do I get flags then? Function only gets device id.
> > 
> > good point. I overlooked that part.
> > 
> > > I noticed another bug. If __rfcomm_dev_get returns null we end up using
> > > NULL pointer. Fixed version attached.
> > 
> > Please remove this part:
> > 
> > -#ifndef CONFIG_BT_RFCOMM_DEBUG
> > +#ifdef CONFIG_BT_RFCOMM_DEBUG
> 
> Removed.
> 
> > 
> > And use this code:
> > 
> > 	if (dev) {
> > 		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
> > 			dev = NULL;
> > 		else
> > 	                rfcomm_dev_hold(dev);
> > 	}
> > 
> > It makes it a little bit more readable and easier to understand what we
> > are doing there.
> 
> Agreed. New version attached.

do you have a simple re-producer for it. I need to test this on my Quad
G5 before pushing this upstream.

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
