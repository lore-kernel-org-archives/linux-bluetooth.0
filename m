Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4514131B.4030609@palmsource.com>
Date: Fri, 22 Sep 2006 18:45:15 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------030208080105070906040205"
Subject: [Bluez-devel] a2dpd patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030208080105070906040205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is a small patch to correct the left sound only. It also integrate 
the underrun fix we talked about last day.

Fred.

--------------030208080105070906040205
Content-Type: text/plain;
 name="patch_stereo_underrun"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_stereo_underrun"

? .deps
? .libs
? Doxyfile
? Makefile
? Makefile.in
? a2play
? a2recv
? aclocal.m4
? autom4te.cache
? avrecv
? avsnd
? btsco
? btsco.kdevelop
? btsco.kdevelop.pcs
? btsco.kdevses
? btsco2
? compile
? config.guess
? config.h
? config.h.in
? config.log
? config.status
? config.sub
? configure
? depcomp
? install-sh
? libtool
? missing
? stamp-h1
? alsa-plugins/.deps
? alsa-plugins/.libs
? alsa-plugins/Makefile
? alsa-plugins/Makefile.in
? alsa-plugins/a2dp_ipc.lo
? alsa-plugins/a2dp_timer.lo
? alsa-plugins/a2dpd
? alsa-plugins/ctl_a2dpd.lo
? alsa-plugins/ctl_sco.lo
? alsa-plugins/libasound_module_ctl_a2dpd.la
? alsa-plugins/libasound_module_ctl_sco.la
? alsa-plugins/libasound_module_pcm_a2dp.la
? alsa-plugins/libasound_module_pcm_a2dpd.la
? alsa-plugins/libasound_module_pcm_sco.la
? alsa-plugins/pcm_a2dp.lo
? alsa-plugins/pcm_a2dpd.lo
? alsa-plugins/pcm_sco.lo
? avdtp/.deps
? avdtp/.libs
? avdtp/Makefile
? avdtp/Makefile.in
? avdtp/avtest
? sbc/.deps
? sbc/.libs
? sbc/Makefile
? sbc/Makefile.in
? sbc/rcplay
? sbc/sbcdec
? sbc/sbcenc
? sbc/sbcinfo
Index: alsa-plugins/a2dpd.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd.c,v
retrieving revision 1.8
diff -u -r1.8 a2dpd.c
--- alsa-plugins/a2dpd.c	6 Sep 2006 02:59:43 -0000	1.8
+++ alsa-plugins/a2dpd.c	22 Sep 2006 15:47:45 -0000
@@ -580,9 +580,8 @@
 			pBuffer[j] = (((channel_1 & 0x0000FFFF) << 16) | (channel_2 & 0x0000FFFF));
 		} else {
 			//FIXME We have a reverse stereo I don't know why
-			// The following line corrects the problem but I miss the cause so
-			pBuffer[j] = (((channel_2&0x0000FFFF)<<16)|(channel_1&0x0000FFFF));
-			pBuffer[j] = ( (channel_1 & 0xFFFF0000) | (channel_2 & 0x0000FFFF) );
+			// The following line corrects the problem but I miss the cause so be aware
+			pBuffer[j] = (((channel_2 & 0x0000FFFF) << 16) | (channel_1 & 0x0000FFFF));
 		}
 	}
 	return pcm_buffer_filed_size;
Index: alsa-plugins/alsalib.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/alsalib.c,v
retrieving revision 1.1
diff -u -r1.1 alsalib.c
--- alsa-plugins/alsalib.c	7 Sep 2006 19:46:02 -0000	1.1
+++ alsa-plugins/alsalib.c	22 Sep 2006 15:47:45 -0000
@@ -70,7 +70,7 @@
 		err = snd_pcm_prepare(handle);
 		if (err < 0)
 			printf("Can't recovery from underrun, prepare failed: %s\n", snd_strerror(err));
-		return 0;
+		return err;
 	} else if (err == -ESTRPIPE) {
 		while ((err = snd_pcm_resume(handle)) == -EAGAIN)
 			sleep(1);	/* wait until the suspend flag is released */
@@ -79,7 +79,7 @@
 			if (err < 0)
 				printf("Can't recovery from suspend, prepare failed: %s\n", snd_strerror(err));
 		}
-		return 0;
+		return err;
 	}
 	return err;
 }
@@ -95,13 +95,13 @@
 		break;
 	case -EPIPE:
 		// To manage underrun, we will try to ignore
-		xrun_recovery(alsa->playback_handle, result);
-		//result = 0;
+		if(xrun_recovery(alsa->playback_handle, result) == 0)
+			result = 0;
 		DBG("EPIPE(%d)", result);
 		break;
 	case -ESTRPIPE:
-		xrun_recovery(alsa->playback_handle, result);
-		//result=0;
+		if(xrun_recovery(alsa->playback_handle, result) == 0)
+			result=0;
 		DBG("ESTRPIPE(%d)", result);
 		break;
 	}

--------------030208080105070906040205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------030208080105070906040205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030208080105070906040205--
