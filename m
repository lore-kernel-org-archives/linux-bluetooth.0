Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200703291123.53675.denis.kenzior@trolltech.com>
References: <200703291123.53675.denis.kenzior@trolltech.com>
Date: Sat, 31 Mar 2007 15:50:56 +0200
Message-Id: <1175349056.5815.265.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] STLC2500 Baud Rate & Address Setting
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

Hi Denis,

> The following patch does two things:
> 
> - Adds support for setting the baud rate on the STLC2500.
> - Adds another optional argument to hciattach for use with stlc2500/bgb2xx 
> devices that require initialization of the bdaddr.  Basically if you specify 
> this option on the command line, the address specified will be used during 
> stlc2500/bgb2xx initialization.  Otherwise a default will be used.  The 
> manpage has been updated as well.
> 
> Let me know if there are any issues!

the patch looks good. However please swap these two:

        int  (*init) (int fd, struct uart_t *u, struct termios *ti);
+       char *bdaddr;

The callbacks should come always last in a structure.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
