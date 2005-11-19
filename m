Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <437ED509.6060607@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] alsaplugin into btsco
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 19 Nov 2005 00:32:25 -0700

Hi

I decided to move the alsa plugin stuff into btsco cvs. Build it with
 ./configure --enable-alsaplugin

I actually think there's something fundamentally wrong about how I'm
trying to make the bluetooth connection. The call that usually fails
looks like:

DEBUG: connect_l2cap: Can't connect to AD:32:30:3C:0D:00 on psm 25.
Interrupted system call(4)

There is something going on with an io signal or something with pthreads
that blows up the l2cap connection. I think we need to do the connection
in another thread or inside a different part of the alsa plugin
handler... any ideas?

Brad


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
