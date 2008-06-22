Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: akohlsmith-lists@mixdown.ca,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200806221724.03009.aklists@mixdown.ca>
References: <485C7396.8090208@gmail.com> <1214024240.25820.66.camel@violet>
	<485DB200.7000509@gmail.com>  <200806221724.03009.aklists@mixdown.ca>
Date: Mon, 23 Jun 2008 00:07:38 +0200
Message-Id: <1214172458.7046.15.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] RSSI value in floating point
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

Hi Andrew,

> >  1. Thanks. That saved me a lot of time
> >  2. Assuming that I purchase a development kit. Would it be possible to
> > modify bluetooth stack to achieve the objective?
> 
> Why?  Is it so difficult to say floatrssi = (float)intrssi/(float)INT_MAX?

so and that gives you anything because? The hardware returns a signed
integer and converting that into float is useless.

Also the RSSI value retrieved from an already established connection is
different than the one you get during inquiry.

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
