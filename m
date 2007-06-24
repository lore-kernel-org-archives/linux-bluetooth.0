Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c1fa8edf0706241404y2471673cwf17b4e7aac86ef29@mail.gmail.com>
Date: Sun, 24 Jun 2007 17:04:40 -0400
From: "Simon Ruggier" <simon80@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] minor quibbles
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

This doesn't seem like a big deal, but I noticed that there are a few
cases where a buffer[PATH_MAX + 1] is allocated, but then snprintf is
used with a size of up to PATH_MAX.  The man page for snprintf on my
system says that "The functions snprintf() and vsnprintf() do not
write  more than size bytes (including the trailing '\0').", which
would seem to imply that snprintf(buf, PATH_MAX + 1, ... ) is more
correct.  Someone please correct me if I'm wrong about this.

I'm also wondering if it's intentional that certain hidd options, like
--no-check, are undocumented?

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
