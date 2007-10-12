Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Kai Vehmanen" <kai.vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Fri, 12 Oct 2007 15:25:12 +0300
Message-ID: <000001c80cca$eff9ed00$c72915ac@NOE.Nokia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0001_01C80CE4.15499600"
Subject: [Bluez-devel] PATCH1/2: bluez-utils - fix-a2dp-buffer-constraints
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

------=_NextPart_000_0001_01C80CE4.15499600
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

I've been having some problems in using the Bluez ALSA/A2DP plugin
with applications that use the ALSA API in event driven fashion (so
'write samples at last possible moment' instead of 'write samples when 
there is free room in the buffer'). One test application I've used is
Pulseaudio. 

Here're couple of patches (against CVS HEAD) that solve the 
problems for me (for instance pulseaudio starts working with
the plugin, less CPU usage with other apps). If you think these
changes are ok, please include them to the upstream codebase.

This first modifies the buffering constraints as exposed by
the A2DP ALSA plugin:
  - increased max overall buffer size to 16384 bytes (~93msecs
    of CD quality audio, so a reasonable max size)
  - allow applications to specify buffer size
  - allow applications to use bigger periods (less wakeup
    load -> the previous limit of 128 is heavy for apps)

I'll submit the other patch as a separate mail, so it's easier
to discuss about the patch contents separately.

This is my first patch to bluez-utils, so please be kind. :)

Br,
-- 
first.surname@nokia.com (Kai Vehmanen)

------=_NextPart_000_0001_01C80CE4.15499600
Content-Type: text/plain;
	name="patch-kv-bluez-utils-fix-a2dp-buffer-constraints-20071012.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-kv-bluez-utils-fix-a2dp-buffer-constraints-20071012.txt"

diff -ruN bluez-utils.orig/audio/pcm_bluetooth.c =
bluez-utils/audio/pcm_bluetooth.c=0A=
--- bluez-utils.orig/audio/pcm_bluetooth.c	2007-10-12 12:57:28.000000000 =
+0300=0A=
+++ bluez-utils/audio/pcm_bluetooth.c	2007-10-12 15:04:49.000000000 +0300=0A=
@@ -45,7 +45,8 @@=0A=
 =0A=
 #define MIN_PERIOD_TIME 1=0A=
 =0A=
-#define BUFFER_SIZE 2048=0A=
+#define MIN_BUFFER_SIZE 256    /* minimum size of buffer */=0A=
+#define MAX_BUFFER_SIZE 16384  /* allocated RAM for buffer */=0A=
 =0A=
 #ifdef ENABLE_DEBUG=0A=
 #define DBG(fmt, arg...)  printf("DEBUG: %s: " fmt "\n" , __FUNCTION__ =
, ## arg)=0A=
@@ -123,7 +124,7 @@=0A=
 	sbc_t sbc;			/* Codec data */=0A=
 	int codesize;			/* SBC codesize */=0A=
 	int samples;			/* Number of encoded samples */=0A=
-	uint8_t buffer[BUFFER_SIZE];	/* Codec transfer buffer */=0A=
+	uint8_t buffer[MAX_BUFFER_SIZE];/* Codec transfer buffer */=0A=
 	int count;			/* Codec transfer buffer counter */=0A=
 =0A=
 	int nsamples;			/* Cumulative number of codec samples */=0A=
@@ -137,7 +138,7 @@=0A=
 	struct ipc_data_cfg cfg;	/* Bluetooth device config */=0A=
 	struct pollfd stream;		/* Audio stream filedescriptor */=0A=
 	struct pollfd server;		/* Audio daemon filedescriptor */=0A=
-	uint8_t buffer[BUFFER_SIZE];	/* Encoded transfer buffer */=0A=
+	uint8_t buffer[MAX_BUFFER_SIZE];/* Encoded transfer buffer */=0A=
 	int count;			/* Transfer buffer counter */=0A=
 	struct bluetooth_a2dp a2dp;	/* A2DP data */=0A=
 =0A=
@@ -932,14 +933,24 @@=0A=
 	if (err < 0)=0A=
 		return err;=0A=
 =0A=
-	/* supported block size */=0A=
+	/* supported block sizes:=0A=
+	 *   - lower limit is A2DP codec size=0A=
+	 *   - total buffer size is the upper limit (with two periods) */=0A=
 	err =3D snd_pcm_ioplug_set_param_minmax(io, =
SND_PCM_IOPLUG_HW_PERIOD_BYTES,=0A=
-						a2dp->codesize, a2dp->codesize);=0A=
+					      a2dp->codesize, MAX_BUFFER_SIZE / 2);=0A=
+	if (err < 0)=0A=
+		return err;=0A=
+=0A=
+	/* supported buffer sizes */=0A=
+	err =3D snd_pcm_ioplug_set_param_minmax(io, =
SND_PCM_IOPLUG_HW_BUFFER_BYTES,=0A=
+					      MIN_BUFFER_SIZE, MAX_BUFFER_SIZE);=0A=
 	if (err < 0)=0A=
 		return err;=0A=
 =0A=
+	/* supported period count: =0A=
+	 *   - derived from max buffer size and minimum period size */=0A=
 	err =3D snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS,=0A=
-									2, 50);=0A=
+					      2, MAX_BUFFER_SIZE / a2dp->codesize);=0A=
 	if (err < 0)=0A=
 		return err;=0A=
 =0A=

------=_NextPart_000_0001_01C80CE4.15499600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
------=_NextPart_000_0001_01C80CE4.15499600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0001_01C80CE4.15499600--
