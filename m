Return-Path: <cyrus@holtmann.org>
From: "Andrew Kohlsmith (lists)" <aklists@mixdown.ca>
To: bluez-devel@lists.sourceforge.net
Date: Sun, 22 Jun 2008 21:02:49 -0400
References: <485C7396.8090208@gmail.com>
	<200806221724.03009.aklists@mixdown.ca>
	<1214172458.7046.15.camel@violet>
In-Reply-To: <1214172458.7046.15.camel@violet>
MIME-Version: 1.0
Message-Id: <200806222102.49872.aklists@mixdown.ca>
Subject: Re: [Bluez-devel] RSSI value in floating point
Reply-To: akohlsmith-lists@mixdown.ca,
	BlueZ development <bluez-devel@lists.sourceforge.net>
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

On June 22, 2008 06:07:38 pm Marcel Holtmann wrote:
> so and that gives you anything because? The hardware returns a signed
> integer and converting that into float is useless.

I did not say it would be any more useful; I merely asked him why he can't 
convert it to float on his own instead of demanding the stack do it.

> Also the RSSI value retrieved from an already established connection is
> different than the one you get during inquiry.

Interesting; is the RF PA AGC set differently during inquiry?

-A.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
