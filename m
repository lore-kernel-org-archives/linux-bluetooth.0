Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1197847760.26210.271.camel@cookie.hadess.net>
References: <8a8adccc0712161331u26260504gfa88aa9f0218dc7@mail.gmail.com>
	<1197841994.8050.45.camel@aeonflux>
	<8a8adccc0712161405l301ad3b4p771bea92d835d070@mail.gmail.com>
	<1197847760.26210.271.camel@cookie.hadess.net>
Date: Mon, 17 Dec 2007 01:52:52 +0100
Message-Id: <1197852772.8050.47.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Use PO Linguas for i18n
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

Hi Bastien,

> > -AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "$GETTEXT_PACKAGE", [The name of
> > the gettext domain])
> > +AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE,"$GETTEXT_PACKAGE", [GETTEXT
> > package name])
> 
> That's unneeded (unless you're fixing errors related to quoting, in
> which case don't change the spacing or the contents).

right, I don't get this one. I skipped it.

> The rest is straight forward and should be applied.

Used my own version, but should work the same.

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
