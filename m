Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464370B2.40303@xmission.com>
Date: Thu, 10 May 2007 13:21:22 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Fabien Chevalier <fabchevalier@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] combining libalsa & dbus
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

Fabien,

I hope you're having a nice break from your hobby stuff. Can I ask you
to think about it a little bit to work through something? You've worked
with the alsa plugin api well enough to maybe help with a problem...

Marcel wants a reworked alsa plugin to go into bluez utils, but it needs
to be a proper dbus client. That would mean the dbus calls would have to
be self-contained right in the alsa plugin. Do you think we could pull
that off? I'm worried that the nature of the calls into the plugin would
make it impossible to have it also listening to dbus.

On top of everything else, Marcel prefers multiprogramming to be done
via select(), nonblocking calls, etc and not threads.

Any ideas?

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
