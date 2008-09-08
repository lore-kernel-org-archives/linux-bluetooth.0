Return-Path: <cyrus@holtmann.org>
Message-ID: <48C58092.7060103@free.fr>
Date: Mon, 08 Sep 2008 21:44:18 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@nokia.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: multipart/mixed; boundary="------------070702050502060002000003"
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Crash bug in bluez-4.4
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070702050502060002000003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Just found a funny bug, steps to reproduce below:

1) make sure you have no headset whatsoever configured in bluez (fresh
empty setup)

2) Configure your asoundrc with empty bluetooth parameters

pcm.bluetooth {
         type bluetooth
}

ctl.bluetooth {
         type bluetooth
}

3)Launch your favourite ALSA base player, configure "bluetooth" as
output device

4) Hit play.

5) *BANG*
bluetoothd[17227]: Parsing
/usr/local/stow/bluez-4.4/etc/bluetooth/audio.conf failed: No such file
or directory
bluetoothd[17227]: Unix socket created: 13
bluetoothd[17227]: Telephony plugin initialized
bluetoothd[17227]: HFP AG features: (none)
bluetoothd[17227]: Accepted new client connection on unix socket (fd=10)
bluetoothd[17227]: Audio API: received BT_GETCAPABILITIES_REQ
Erreur de segmentation
palomino:/usr/local/stow#


Path attached fixes the bug... by removing three lines of code that seem 
to me not only a premature, but also bogus optimization :-(, that 
prevent us to trying to return the first element of an empty gslist.

However i'm not that familiar with that manager stuff and might be 
wrong, so please double check that ;-)

Cheers,

Fabien



--------------070702050502060002000003
Content-Type: text/plain;
 name="audio-plugin-crashbug-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audio-plugin-crashbug-fix.diff"

--- manager.c.orig	2008-09-08 21:22:06.000000000 +0200
+++ manager.c	2008-09-08 21:22:11.000000000 +0200
@@ -999,9 +999,6 @@
 {
 	GSList *l;
 
-	if (!bacmp(bda, BDADDR_ANY) && !interface && !connected)
-		return devices->data;
-
 	for (l = devices; l != NULL; l = l->next) {
 		struct audio_device *dev = l->data;
 

--------------070702050502060002000003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------070702050502060002000003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------070702050502060002000003--
