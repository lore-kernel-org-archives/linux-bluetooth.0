Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec0806121252p17878962x186ef28e81b1a86c@mail.gmail.com>
References: <ef9938ec0806121252p17878962x186ef28e81b1a86c@mail.gmail.com>
Date: Mon, 23 Jun 2008 03:12:24 +0200
Message-Id: <1214183544.7046.32.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] sdpd doesn't always collect
	non-persistent	service records
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

Hi Albert,

> When using the libbluetooth SDP API, records registered that do not
> have SDP_RECORD_PERSIST are not always collected by sdpd when the sdp
> session is closed.  I think the attached patch should help.

thanks for the patch. I had to simplify it a little bit, but I finally
got around in committing it.

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
