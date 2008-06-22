Return-Path: <cyrus@holtmann.org>
From: "Andrew Kohlsmith (lists)" <aklists@mixdown.ca>
To: bluez-devel@lists.sourceforge.net
Date: Sun, 22 Jun 2008 17:24:02 -0400
References: <485C7396.8090208@gmail.com> <1214024240.25820.66.camel@violet>
	<485DB200.7000509@gmail.com>
In-Reply-To: <485DB200.7000509@gmail.com>
MIME-Version: 1.0
Message-Id: <200806221724.03009.aklists@mixdown.ca>
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

On June 21, 2008 09:59:28 pm Khairulmizam Samsudin wrote:
>  1. Thanks. That saved me a lot of time
>  2. Assuming that I purchase a development kit. Would it be possible to
> modify bluetooth stack to achieve the objective?

Why?  Is it so difficult to say floatrssi = (float)intrssi/(float)INT_MAX?

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
