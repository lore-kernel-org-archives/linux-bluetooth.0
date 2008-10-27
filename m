Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300810271213w53d8d179gc3af2f89c37bea47@mail.gmail.com>
References: <001501c9381a$022b7f40$06827dc0$@de>
	<d89ddf300810271213w53d8d179gc3af2f89c37bea47@mail.gmail.com>
Date: Mon, 27 Oct 2008 20:41:56 +0100
Message-Id: <1225136516.7157.22.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bad encoding performance of Linux SBC audio codec
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Brad,

> > I am sorry to say that the audio quality of the open source version of SBC
> > is far worse than the reference implementation.
> 
> If you are using the standalone "sbc" project at sourceforge, then you
> should try the version inside bluez. The standalone used to simply be
> slower, but we identified & fixed some quality issues too that should
> be backported.

the standalone version should not be used at all at the moment. All
efforts should go into the version included in bluez-4.x.tar.gz.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
