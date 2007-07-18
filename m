Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20070718T103250-409@post.gmane.org>
References: <469DCBD6.7040005@mojo-working.com>
	<1184746735.6357.3.camel@aeonflux.holtmann.net>
	<loom.20070718T103250-409@post.gmane.org>
Date: Wed, 18 Jul 2007 12:53:26 +0200
Message-Id: <1184756006.6357.9.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] RFCOMM DISC dlci=0
	missing	after	server	closesocket?
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

Hi Art,

> > the Linux kernel 2.6.22 should behave according to the specification.
> 
> Thanks.  That was fast!  My Ubuntu Feisty is at 2.6.20-16.  As far as I can
> tell, Ubuntu packages for 2.6.21 or 2.6.22 are not yet available, and 2.6.22 is
> barely two weeks old.  Are you aware of any distributions that use 2.6.22 yet?

the upcoming Ubuntu Gutsy should be based on 2.6.22. Otherwise you can
test with the latest Maemo kernel if you have a N800. The patch should
be included there.

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
