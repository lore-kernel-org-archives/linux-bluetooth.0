Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20070714143356.GC25097@esaurito.net>
References: <20070714143356.GC25097@esaurito.net>
Date: Sat, 14 Jul 2007 16:52:48 +0200
Message-Id: <1184424768.4889.43.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net, 433080-forwarded@bugs.debian.org
Subject: Re: [Bluez-devel] [madduck@debian.org:
	[Pkg-bluetooth-maintainers]	Bug#433080: pand:	erroneous log
	message, %d not substituted]
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

Hi Filippo,

> my best guess about this is to use devname instead of netdev in pand/main.c
> 
> 275             syslog(LOG_INFO, "New connection from %s %s",
> 276                                 str, netdev);
> 
> comments?

already fixed that.

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
