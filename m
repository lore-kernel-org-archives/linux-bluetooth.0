Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco: help with autoconf cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4193B453.50005@xmission.com>
References: <4193B453.50005@xmission.com>
Content-Type: text/plain
Message-Id: <1100199408.12168.24.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 Nov 2004 19:56:48 +0100

Hi Brad,

> Can someone tell me which of these files shouldn't be in our btsco cvs 
> module?
> 
> acinclude.m4
> aclocal.m4
> config.status
> configure
> configure.in
> Makefile
> Makefile.am
> Makefile.in
> missing
> mkinstalldirs
> 
> I know some projects even make you generate "configure" but I'm not sure 
> I want to go that far.

look at the BlueZ libs and utils CVS repository. I spent quite some time
to clean up this autoconf/automake mess. Basically what I do is:

	./bootstrap
	./configure
	make
	==> modify files, compile again, test etc.
	make maintainer-clean

This keeps your CVS repository clean.

> btw, I added a sort of placeholder "a2play.c" to the project for sending 
> preencoded audio to an a2dp player. I want to make sure our autoconf 
> mess is cleaned up before putting it in the build.

This is great. Does it work for you already. Do you hear any sound?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
