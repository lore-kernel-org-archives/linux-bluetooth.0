Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20071218233930.2d96a897@neutrino.cosmos.net>
References: <8a8adccc0709020615m38389d6axe49041f8fbe18c4b@mail.gmail.com>
	<1188768824.24968.9.camel@violet>
	<8a8adccc0712161246y3f435aefwdb6c92c464d19f96@mail.gmail.com>
	<1197841752.8050.42.camel@aeonflux>
	<8a8adccc0712161449r135b552ct39f2cb9bcdeb543d@mail.gmail.com>
	<1197853211.8050.55.camel@aeonflux>
	<8a8adccc0712162252v4cabae88md549ef651cbef5ad@mail.gmail.com>
	<1197918404.8050.92.camel@aeonflux>
	<8a8adccc0712181417n6c0b5052i4e37137c24748a6a@mail.gmail.com>
	<20071218233930.2d96a897@neutrino.cosmos.net>
Date: Wed, 19 Dec 2007 00:30:02 +0100
Message-Id: <1198020602.8050.208.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Bluez build system
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

Hi Didier,

> I just see your autogen.sh and I think about autoreconf. This tool can
> rebuild the autotools in a project like your autogen.sh does.
> 
> My project's autogen.sh contains only one line : autoreconf -f

try it on a bare repository from CVS and you will see it fails. It is
not meant for bootstrapping things. And to be quite honest, if it works
for you, you have too many files in your repository that could be
auto-generated.

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
