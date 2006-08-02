Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200608011823.37945.thermal@o2.pl>
References: <200607312232.58278.thermal@o2.pl>
	<1154385676.4982.39.camel@aeonflux.holtmann.net>
	<200608011823.37945.thermal@o2.pl>
Date: Wed, 02 Aug 2006 03:13:38 +0200
Message-Id: <1154481218.3905.1.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] inline keyword & ansi-C compilers
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

Hi,

> > > Recently when I`ve tried to compile KDE (ktnef to be exact) I came
> > > upon an error in your include files:
> >
> > no idea what ktnef has to do with BlueZ. This seems to be the main
> > problem here.
> >
> 
> Yes, this may look a bit weird but ktnef is a part of the kdepim source 
> bundle which contains addressbook, organizer, etc. and thus can make 
> use of Bluetooth.
> 
> >
> > #ifdef __STRICT_ANSI__
> > #define inline
> > #endif
> >
> 
> You`re right, that will be much better.

and why not including this into the ktnef source. I personally don't
like this hack to be in bluez-libs.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
