Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Sep 2008 12:44:27 -0700 (PDT)
From: hong zhang <henryzhang62@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <496701.86720.qm@web57915.mail.re3.yahoo.com>
Subject: [Bluez-users] why my laptop with fedora 8 cannot be discoverred?
Reply-To: henryzhang62@yahoo.com,
	BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

List,

I have a USB dongle with CSR chip. 
"iscan enable;pscan enable" are in hcid.conf.
It can send file to my cell phone using gnome-obex-send.
even l2ping to my cell phone returns 0 bytes.

It can discover my cell phone and other BT devices.
But my cell phone could not discover my USB dongle.

I add discovto 0 in hcid.conf and mode discoverable in /var/lib/.../config. Both are not help.

Any clue?

Thanks.

---henry


      

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
