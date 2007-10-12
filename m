Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Kai Vehmanen" <kai.vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Fri, 12 Oct 2007 15:30:21 +0300
Message-ID: <000401c80ccb$a7cb44b0$c72915ac@NOE.Nokia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C80CE4.CD187CB0"
Subject: [Bluez-devel] PATCH2/2: bluez-utils - avoid-unnecessary-polls
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

------=_NextPart_000_0005_01C80CE4.CD187CB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello again,

here's the second patch to ALSA A2DP plugin in bluez-utils
(see my previous mail).

This patch changes the worker thread poll timeout to be 
calculated according to application chosen period size. 
This allows to decrease the CPU load significantly for those 
applications that do not require an ultra small period
size. Without the patch (poll timeout of 1msec), the system 
call load is pretty heavy...

Br,
-- 
first.surname@nokia.com (Kai Vehmanen)

------=_NextPart_000_0005_01C80CE4.CD187CB0
Content-Type: text/plain;
	name="patch-kv-bluez-utils-avoid-unnecessary-polls-20071012.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-kv-bluez-utils-avoid-unnecessary-polls-20071012.txt"

diff -ruN bluez-utils.orig/audio/pcm_bluetooth.c =
bluez-utils/audio/pcm_bluetooth.c=0A=
--- bluez-utils.orig/audio/pcm_bluetooth.c	2007-10-12 15:07:40.000000000 =
+0300=0A=
+++ bluez-utils/audio/pcm_bluetooth.c	2007-10-12 15:04:58.000000000 +0300=0A=
@@ -168,12 +168,17 @@=0A=
 	double period_time;=0A=
 	struct timeval start;=0A=
 	struct pollfd fds[2];=0A=
+	int poll_timeout;=0A=
 =0A=
 	fds[0] =3D data->server;=0A=
 	fds[1] =3D data->stream;=0A=
 =0A=
 	prev_periods =3D 0;=0A=
 	period_time =3D 1000000.0 * data->io.period_size / data->io.rate;=0A=
+	if (period_time > (int)(MIN_PERIOD_TIME * 1000))=0A=
+		poll_timeout =3D (int)(period_time / 1000.0f);=0A=
+	else=0A=
+		poll_timeout =3D MIN_PERIOD_TIME;=0A=
 =0A=
 	gettimeofday(&start, 0);=0A=
 =0A=
@@ -214,7 +219,8 @@=0A=
 		}=0A=
 =0A=
 iter_sleep:=0A=
-		ret =3D poll(fds, 2, MIN_PERIOD_TIME);=0A=
+		/* sleep up to one period interval */=0A=
+		ret =3D poll(fds, 2, poll_timeout);=0A=
 		if (ret < 0) {=0A=
 			SNDERR("poll error: %s (%d)", strerror(errno), errno);=0A=
 			if (errno !=3D EINTR)=0A=

------=_NextPart_000_0005_01C80CE4.CD187CB0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
------=_NextPart_000_0005_01C80CE4.CD187CB0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0005_01C80CE4.CD187CB0--
