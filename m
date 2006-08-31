Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F7088F.6090606@palmsource.com>
Date: Thu, 31 Aug 2006 18:04:31 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44EC8877.8050200@palmsource.com> <44F5A472.30003@xmission.com>
In-Reply-To: <44F5A472.30003@xmission.com>
Content-Type: multipart/mixed; boundary="------------020704070906020804060602"
Subject: [Bluez-devel]  Big patch to a2dpd
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
--------------020704070906020804060602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Brad,
>
> I looked over Matthew's patches and applied them. I applied your "small
> patch" which turns out to be bigger than it sounds :)
>  =20
This one is more than bigger!
Reindent,
Alsa output redirection,
New on-the-fly in-play switch from bt to alsa and reverse
Changing bdaddr in play too.
More options described in sample.a2dprc

I removed the line LIBS=3D from Makefile.am as suggested. This line was=20
making tons of compilation problems. As a2dpd finally links to alsa, it=20
is no longer needed.
Please give it a try before submitting (Matthew and RUI if you read that)=
.

Wrote a doc : http://fdalleau.free.fr/a2dp_doc.pdf ideas welcome!

Fr=E9d=E9ric


--------------020704070906020804060602
Content-Type: text/plain;
 name="patch_btsco_alsaredirect"
Content-Disposition: inline;
 filename="patch_btsco_alsaredirect"
Content-Transfer-Encoding: quoted-printable

? Doxyfile
? Makefile.in
? aclocal.m4
? autom4te.cache
? btsco.kdevelop
? btsco.kdevelop.pcs
? btsco.kdevses
? compile
? config.guess
? config.h.in
? config.sub
? configure
? depcomp
? install-sh
? missing
? alsa-plugins/Makefile.in
? avdtp/Makefile.in
? sbc/Makefile.in
Index: alsa-plugins/BUILD
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/BUILD,v
retrieving revision 1.2
diff -u -r1.2 BUILD
--- alsa-plugins/BUILD	12 Aug 2006 01:51:54 -0000	1.2
+++ alsa-plugins/BUILD	31 Aug 2006 15:58:56 -0000
@@ -26,4 +26,3 @@
 Note that this device will not automatically appear in the list of alsa =
devices.
 The alsa folks did this by design but they added a new api for clients t=
o=20
 enumerate plugin devices.
-
Index: alsa-plugins/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/Makefile.am,v
retrieving revision 1.6
diff -u -r1.6 Makefile.am
--- alsa-plugins/Makefile.am	6 Aug 2006 05:23:43 -0000	1.6
+++ alsa-plugins/Makefile.am	31 Aug 2006 15:58:56 -0000
@@ -4,8 +4,6 @@
=20
 if ALSAPLUGIN
=20
-#LIBS =3D=20
-
 alsadir =3D $(libdir)/alsa-lib
=20
 alsa_LTLIBRARIES =3D libasound_module_pcm_a2dp.la libasound_module_pcm_a=
2dpd.la libasound_module_ctl_a2dpd.la libasound_module_pcm_sco.la libasou=
nd_module_ctl_sco.la
@@ -31,9 +29,10 @@
 libasound_module_ctl_sco_la_LIBADD =3D @ALSA_LIBS@
=20
 bin_PROGRAMS =3D a2dpd
-a2dpd_SOURCES =3D a2dpd.c a2dplib.c=20
+a2dpd_SOURCES =3D a2dpd.c a2dplib.c alsalib.c
+a2dpd_CFLAGS =3D $(AM_CFLAGS)
 #a2dp_timer.c a2dp_ipc.c
-a2dpd_LDADD =3D a2dp_timer.o a2dp_ipc.o @BLUEZ_LIBS@ -lsbc -lpthread -lr=
t
+a2dpd_LDADD =3D a2dp_timer.o a2dp_ipc.o @ALSA_LIBS@ @BLUEZ_LIBS@ -lsbc -=
lpthread -lrt
=20
 AM_CFLAGS =3D @ALSA_CFLAGS@ @BLUEZ_CFLAGS@ -pthread
 AM_LDFLAGS =3D -module -avoid-version -export-dynamic
Index: alsa-plugins/a2dp_ipc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dp_ipc.c,v
retrieving revision 1.3
diff -u -r1.3 a2dp_ipc.c
--- alsa-plugins/a2dp_ipc.c	17 Aug 2006 14:06:27 -0000	1.3
+++ alsa-plugins/a2dp_ipc.c	31 Aug 2006 15:58:56 -0000
@@ -36,7 +36,11 @@
=20
 void close_socket(int sockfd)
 {
-        if(sockfd>0) close(sockfd);
+        if(sockfd>0)
+        {
+        	shutdown(sockfd, SHUT_RDWR);
+        	close(sockfd);
+        }
 }
=20
 int make_udp_socket()
@@ -98,7 +102,7 @@
         {
                 if(bind(sockfd, (struct sockaddr *)&my_addr, sizeof(stru=
ct sockaddr))=3D=3D0)
                 {
-                        if(listen(sockfd, 10)=3D=3D0)
+                        if(listen(sockfd, 0)=3D=3D0)
                         {
                                 // No error
                         }
Index: alsa-plugins/a2dp_timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dp_timer.c,v
retrieving revision 1.2
diff -u -r1.2 a2dp_timer.c
--- alsa-plugins/a2dp_timer.c	17 Aug 2006 14:06:27 -0000	1.2
+++ alsa-plugins/a2dp_timer.c	31 Aug 2006 15:58:56 -0000
@@ -26,104 +26,93 @@
 #include <unistd.h>
 #include <syslog.h>
=20
-void sleeptodate(LPTIMERINFO lpTimerInfo, struct timeval* date, int pred=
elay)
+void sleeptodate(LPTIMERINFO lpTimerInfo, struct timeval *date, int pred=
elay)
 {
-        struct timeval now;
-        struct timeval resolutionval=3D{0, predelay + (int)(lpTimerInfo-=
>timer_resolution.tv_nsec/1000)};
+	struct timeval now;
+	struct timeval resolutionval =3D { 0, predelay + (int) (lpTimerInfo->ti=
mer_resolution.tv_nsec / 1000) };
=20
-        // See if we have time to wait
-        timeradd(&lpTimerInfo->timeofday, &resolutionval, &now);
-        if (timercmp(date, &now, >))
-        {
-                // Synchronise with usleep 20 ms cycle
-                usleep(1);
-                // See if we must wait again
-                gettimeofday(&now, NULL);
-                timeradd(&now, &resolutionval, &now);
-                if (timercmp(date, &now, >))
-                {
-                        struct timeval interval =3D { 0, 0 };
-                        timersub(date, &now, &interval);
-                        // sleep
-                        usleep(interval.tv_usec);
-                }
-        }
-        else
-        {
-                // We're late, do not wait
-        }
+	// See if we have time to wait
+	timeradd(&lpTimerInfo->timeofday, &resolutionval, &now);
+	if (timercmp(date, &now, >)) {
+		// Synchronise with usleep 20 ms cycle
+		usleep(1);
+		// See if we must wait again
+		gettimeofday(&now, NULL);
+		timeradd(&now, &resolutionval, &now);
+		if (timercmp(date, &now, >)) {
+			struct timeval interval =3D { 0, 0 };
+			timersub(date, &now, &interval);
+			// sleep
+			usleep(interval.tv_usec);
+		}
+	} else {
+		// We're late, do not wait
+	}
 }
=20
 // This version uses values never reset
 void keepfreqtotal(LPTIMERINFO lpTimerInfo, int predelay)
 {
-        struct timeval playtime, theoricaldate;
+	struct timeval playtime, theoricaldate;
=20
-        //FIXME It is not necessary to use unsigned long if we reset per=
iodically the value of itotalcount (see MAXTOTALCOUNT)
-        // if MAXTOTALCOUNT < 700000, we will fit in signed 32bit and re=
set no more than every 36 mins.
-        // Resetting that value might cause a small sound break.
-        // Setting MAXTOTALCOUNT to lpTimerInfo->fps will reset every se=
cond (useful for testing purposes)
-        playtime.tv_sec=3D((unsigned long)((1.0*(lpTimerInfo->itotalcoun=
t)/lpTimerInfo->fps)));
-        playtime.tv_usec=3D((unsigned long)((1.0*1000.0*1000.0/lpTimerIn=
fo->fps)*(lpTimerInfo->itotalcount)))%1000000;
-        timeradd(&lpTimerInfo->totalcounter, &playtime, &theoricaldate);
-
-        // Si la date th=C3=A9orique est sup=C3=A9rieure =C3=A0 la date =
actuelle
-        if(timercmp(&theoricaldate, &lpTimerInfo->timeofday, >))
-        {
-                sleeptodate(lpTimerInfo, &theoricaldate, predelay);
-        }
+	//FIXME It is not necessary to use unsigned long if we reset periodical=
ly the value of itotalcount (see MAXTOTALCOUNT)
+	// if MAXTOTALCOUNT < 700000, we will fit in signed 32bit and reset no =
more than every 36 mins.
+	// Resetting that value might cause a small sound break.
+	// Setting MAXTOTALCOUNT to lpTimerInfo->fps will reset every second (u=
seful for testing purposes)
+	playtime.tv_sec =3D ((unsigned long) ((1.0 * (lpTimerInfo->itotalcount)=
 / lpTimerInfo->fps)));
+	playtime.tv_usec =3D ((unsigned long) ((1.0 * 1000.0 * 1000.0 / lpTimer=
Info->fps) * (lpTimerInfo->itotalcount))) % 1000000;
+	timeradd(&lpTimerInfo->totalcounter, &playtime, &theoricaldate);
+
+	// If calculated date is higher than current date
+	if (timercmp(&theoricaldate, &lpTimerInfo->timeofday, >)) {
+		sleeptodate(lpTimerInfo, &theoricaldate, predelay);
+	}
 }
=20
 void a2dp_timer_notifyframe(LPTIMERINFO lpTimerInfo)
 {
-        struct timeval lastframe_interval =3D {0,0};
-        struct timeval maxallowed_interval =3D {0,200*1000};
-        gettimeofday(&lpTimerInfo->timeofday, NULL);
-        timersub(&lpTimerInfo->timeofday, &lpTimerInfo->lastframe, &last=
frame_interval);
-        // Previous frames older than 1 second, reset counters
-        if(timercmp(&lastframe_interval, &maxallowed_interval, >))
-        {
-                // We must reset the total counter because else, we will=
 believe the date is late
-                gettimeofday(&lpTimerInfo->totalcounter, NULL);
-                lpTimerInfo->itotalcount=3D0;
-        }
-        gettimeofday(&lpTimerInfo->lastframe, NULL);
+	struct timeval lastframe_interval =3D { 0, 0 };
+	struct timeval maxallowed_interval =3D { 0, 200 * 1000 };
+	gettimeofday(&lpTimerInfo->timeofday, NULL);
+	timersub(&lpTimerInfo->timeofday, &lpTimerInfo->lastframe, &lastframe_i=
nterval);
+	// Previous frames older than 1 second, reset counters
+	if (timercmp(&lastframe_interval, &maxallowed_interval, >)) {
+		// We must reset the total counter because else, we will believe the d=
ate is late
+		gettimeofday(&lpTimerInfo->totalcounter, NULL);
+		lpTimerInfo->itotalcount =3D 0;
+	}
+	gettimeofday(&lpTimerInfo->lastframe, NULL);
 }
=20
 void a2dp_timer_sleep(LPTIMERINFO lpTimerInfo, int predelay)
 {
-        gettimeofday(&lpTimerInfo->timeofday, NULL);
+	gettimeofday(&lpTimerInfo->timeofday, NULL);
=20
-        // Initialize timers
-        if(lpTimerInfo->staticcounter.tv_sec=3D=3D0)
-                gettimeofday(&lpTimerInfo->staticcounter, NULL);
-        if(lpTimerInfo->totalcounter.tv_sec=3D=3D0 || lpTimerInfo->itota=
lcount>MAXTOTALCOUNT)
-        {
-                gettimeofday(&lpTimerInfo->totalcounter, NULL);
-                lpTimerInfo->itotalcount=3D0;
-        }
-        if(lpTimerInfo->timer_resolution.tv_nsec =3D=3D 0)
-                clock_getres(CLOCK_REALTIME, &lpTimerInfo->timer_resolut=
ion);
-
-        // Duration since last call
-        timersub(&lpTimerInfo->timeofday, &lpTimerInfo->staticcounter, &=
lpTimerInfo->duration);
-
-        // Display data once per second
-        if(lpTimerInfo->duration.tv_sec>0)
-        {
-                // Reset all statistics
-                gettimeofday(&lpTimerInfo->staticcounter, NULL);
-                lpTimerInfo->display=3DlpTimerInfo->icount;
-                lpTimerInfo->icount=3D0;
-        }
-        else
-        {
-                lpTimerInfo->display=3D0;
-        }
+	// Initialize timers
+	if (lpTimerInfo->staticcounter.tv_sec =3D=3D 0)
+		gettimeofday(&lpTimerInfo->staticcounter, NULL);
+	if (lpTimerInfo->totalcounter.tv_sec =3D=3D 0 || lpTimerInfo->itotalcou=
nt > MAXTOTALCOUNT) {
+		gettimeofday(&lpTimerInfo->totalcounter, NULL);
+		lpTimerInfo->itotalcount =3D 0;
+	}
+	if (lpTimerInfo->timer_resolution.tv_nsec =3D=3D 0)
+		clock_getres(CLOCK_REALTIME, &lpTimerInfo->timer_resolution);
+
+	// Duration since last call
+	timersub(&lpTimerInfo->timeofday, &lpTimerInfo->staticcounter, &lpTimer=
Info->duration);
+
+	// Display data once per second
+	if (lpTimerInfo->duration.tv_sec > 0) {
+		// Reset all statistics
+		gettimeofday(&lpTimerInfo->staticcounter, NULL);
+		lpTimerInfo->display =3D lpTimerInfo->icount;
+		lpTimerInfo->icount =3D 0;
+	} else {
+		lpTimerInfo->display =3D 0;
+	}
=20
-        keepfreqtotal(lpTimerInfo, predelay);
+	keepfreqtotal(lpTimerInfo, predelay);
=20
-        lpTimerInfo->icount++;
-        lpTimerInfo->itotalcount++;
+	lpTimerInfo->icount++;
+	lpTimerInfo->itotalcount++;
 }
-
Index: alsa-plugins/a2dpair
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/a2dpair
diff -N alsa-plugins/a2dpair
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/a2dpair	31 Aug 2006 15:58:57 -0000
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+#
+# Discovery
+#
+echo "Discovery in progress..."
+I=3D0
+SCANFILE=3D/tmp/hci_scan
+declare -a ARRAYADDR
+declare -a ARRAYNAME
+
+# We need this file because else there is a problem with arrays in shell
+# The while loop is run in a subshell
+hcitool scan > $SCANFILE
+
+while read BTADDR BTDESC ; do
+	if expr match "$BTADDR" "..:..:..:..:..:.." > /dev/null ; then
+		# Truc
+		echo "$I) [$BTADDR] $BTDESC"=20
+		I=3D`expr $I + 1`
+		ARRAYADDR[$I]=3D"$BTADDR"
+		ARRAYNAME[$I]=3D"$BTDESC"
+	fi
+done < $SCANFILE
+rm -f $SCANFILE
+
+if [ $I -le 0 ] ; then
+	echo "Found $I devices"
+	exit -1
+fi
+
+#
+# Device selection
+#
+SELECTION=3D
+I=3D`expr $I - 1`
+while [ -z $SELECTION ] || [ $SELECTION -gt $I ] ; do
+	echo "Choose device (0-$I)"
+	read SELECTION
+done
+# sh uses 1 based arrays
+SELECTION=3D`expr $SELECTION + 1`
+ADDRESS=3D${ARRAYADDR[$SELECTION]}
+NAME=3D${ARRAYNAME[$SELECTION]}
+#
+# Pairing
+#
+echo "Pair device $NAME (y/N)?"
+read CANPAIR
+
+if [ "$CANPAIR" =3D "y" ] ; then
+=09
+	# Device passkey
+	SELECTION=3D
+	while [ -z $SELECTION ] ; do
+		echo "Enter passkey for $NAME"
+		read SELECTION
+	done
+	PASSKEY=3D$SELECTION
+=09
+	# Prefetch password
+	sudo echo "Pairing in progress..."
+=09
+	# passkey agent
+	if sudo passkey-agent --default $PASSKEY & PASSPID=3D$! ; then
+=09
+		#echo "Registered passkey-agent pid=3D$PASSPID"
+=09
+		# pairing
+		ANYTEXTISFAILURE=3D`sudo hcitool cc $ADDRESS 2>&1`
+=09
+		if [ -z "$ANYTEXTISFAILURE" ] ; then
+			echo "Pairing successfull"
+			RESULT=3D0
+		else
+			echo "$ANYTEXTISFAILURE"
+			echo "Pairing failed"
+		fi
+=09
+		#echo "Killing pid=3D$PASSPID"
+		# Kill bg process
+		sudo kill $PASSPID
+	fi
+fi
+
+#
+# A2DP Setting
+#
+echo "Select device for a2dp (y/N)?"
+read A2PARAM
+
+if [ "$A2PARAM" =3D "y" ] ; then
+	echo "Writing ~/.a2dprc"
+	if [ -f ~/.a2dprc ] ; then
+		mv -f ~/.a2dprc ~/.a2dprc~
+		cat ~/.a2dprc~ | while read LINE ; do
+			# Address line
+			if expr "$LINE" : "address=3D.*" > /dev/null; then
+				echo "address=3D$ADDRESS" >> ~/.a2dprc
+			else
+				echo "$LINE" >> ~/.a2dprc
+			fi
+		done
+	else
+		echo "[A2DPD]" > ~/.a2dprc
+		echo "address=3D$ADDRESS" >> ~/.a2dprc
+	fi
+fi
+
+
+#
+# A2DP Daemon
+#
+echo "Start a2dp daemon (y/N)?"
+read A2DAEMON
+if [ "$A2DAEMON" =3D "y" ] ; then
+	while killall a2dpd 2> /dev/null ; do
+		echo -n .
+		sleep 1
+	done
+	a2dpd -d +v
+fi
+
+#
+# Ending
+#
+exit 0
+
+############
Index: alsa-plugins/a2dpd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd.c,v
retrieving revision 1.7
diff -u -r1.7 a2dpd.c
--- alsa-plugins/a2dpd.c	30 Aug 2006 14:43:21 -0000	1.7
+++ alsa-plugins/a2dpd.c	31 Aug 2006 15:58:57 -0000
@@ -37,6 +37,7 @@
 #include <linux/uinput.h>
=20
 #include "a2dplib.h"
+#include "alsalib.h"
 #include "a2dpd_protocol.h"
 #include "a2dp_timer.h"
 #include "a2dp_ipc.h"
@@ -51,16 +52,18 @@
 #define UINPUT_DEVICE          "/dev/input/uinput"
 #define A2DPD_CONFIG_FILE       ".a2dpdrc"
=20
-
-static char     g_sOutputFilename       [512];
-static char     g_srcfilename           [512];
-static char     g_sCmdPlay              [512];
-static char     g_sCmdPause             [512];
-static char     g_sCmdPrev              [512];
-static char     g_sCmdNext              [512];
-static char     g_sCmdNew               [512];
-static int      g_nbdeviceconnected     =3D 0;
-static int      uinput_fd               =3D -1;
+static char g_sOutputFilename[512];
+static char g_srcfilename[512];
+static char g_sCmdPlay[512];
+static char g_sCmdPause[512];
+static char g_sCmdPrev[512];
+static char g_sCmdNext[512];
+static char g_sCmdNew[512];
+static int g_nbdeviceconnected =3D 0;
+static int uinput_fd =3D -1;
+static int g_bavrcp =3D 0;
+static int g_brereadconfig =3D 0;
+static int g_breversestereo =3D 0;
=20
 // This function is needed to destroy zombies processes
 // On Unix, any forked process which terminate before its parent create =
a zombie until parent call waitpid()
@@ -69,56 +72,49 @@
 // http://www.erlenstar.demon.co.uk/unix/faq_2.html
 void ignore_child_processes_return_values()
 {
-        struct sigaction sa;
-        sa.sa_handler =3D SIG_IGN;
-        #ifdef SA_NOCLDWAIT
-        sa.sa_flags =3D SA_NOCLDWAIT;
-        #else
-        sa.sa_flags =3D 0;
-        #endif
-        sigemptyset(&sa.sa_mask);
-        sigaction(SIGCHLD, &sa, NULL);
+	struct sigaction sa;
+	sa.sa_handler =3D SIG_IGN;
+#ifdef SA_NOCLDWAIT
+	sa.sa_flags =3D SA_NOCLDWAIT;
+#else
+	sa.sa_flags =3D 0;
+#endif
+	sigemptyset(&sa.sa_mask);
+	sigaction(SIGCHLD, &sa, NULL);
 }
=20
-void make_daemon_process(int bFork, int bVerbose, char*output_file_name)
+void make_daemon_process(int bFork, int bVerbose, char *output_file_name=
)
 {
-        // Fork to background process if needed
-        if (bFork =3D=3D 1)
-        {
-                switch (fork())
-                {
-                        case -1:
-                                exit(-1);
-                        case 0:
-				break;
-                        default:
-                                exit(0);
-                }
-
-                setsid();
-                chdir("/");
-        }
-
-        // Redirect output to file (default /dev/null) in silent mode, v=
erbose will print output to stdin/out/err
-        if(!bVerbose)
-        {
-                int fd;
-                if ((fd =3D open(output_file_name, O_CREAT|O_APPEND|O_RD=
WR, 0)) !=3D -1)
-                {
-                        fchmod(fd, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IRO=
TH|S_IWOTH);
-                        (void) dup2(fd, STDIN_FILENO);
-                        (void) dup2(fd, STDOUT_FILENO);
-                        (void) dup2(fd, STDERR_FILENO);
-                        if (fd > 2)
-                                (void) close(fd);
-                }
-                else
-                {
-                        printf("a2dpd: Couldn't redirect output to '%s' =
(errno=3D%d:%s)", output_file_name, errno, strerror(errno));
-                }
-        }
+	// Fork to background process if needed
+	if (bFork =3D=3D 1) {
+		switch (fork()) {
+		case -1:
+			exit(-1);
+		case 0:
+			break;
+		default:
+			exit(0);
+		}
=20
-        printf("a2dpd [%s %s] starting ...", __DATE__, __TIME__);
+		setsid();
+		chdir("/");
+	}
+	// Redirect output to file (default /dev/null) in silent mode, verbose =
will print output to stdin/out/err
+	if (!bVerbose) {
+		int fd;
+		if ((fd =3D open(output_file_name, O_CREAT | O_APPEND | O_RDWR, 0)) !=3D=
 -1) {
+			fchmod(fd, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH)=
;
+			(void) dup2(fd, STDIN_FILENO);
+			(void) dup2(fd, STDOUT_FILENO);
+			(void) dup2(fd, STDERR_FILENO);
+			if (fd > 2)
+				(void) close(fd);
+		} else {
+			printf("a2dpd: Couldn't redirect output to '%s' (errno=3D%d:%s)", out=
put_file_name, errno, strerror(errno));
+		}
+	}
+
+	printf("a2dpd [%s %s] starting ...", __DATE__, __TIME__);
 }
=20
 static int lock_fd(int fd)
@@ -141,54 +137,52 @@
 // Prepare packet headers
 static void init_response(struct avctp_header *header)
 {
-        header->ipid =3D 0;
-        header->cr =3D AVCTP_RESPONSE_FRAME;
-        header->packet_type =3D PACKET_TYPE_SINGLE;
+	header->ipid =3D 0;
+	header->cr =3D AVCTP_RESPONSE_FRAME;
+	header->packet_type =3D PACKET_TYPE_SINGLE;
 }
=20
=20
-static int init_uinput ()
+static int init_uinput()
 {
 	int fd, i;
 	struct uinput_user_dev dev =3D {
 		.id =3D {
-			.bustype =3D BUS_BLUETOOTH,
-			.version =3D 0x0001,
-		}
+		       .bustype =3D BUS_BLUETOOTH,
+		       .version =3D 0x0001,
+		       }
 	};
=20
-	if((fd =3D open(UINPUT_DEVICE, O_WRONLY)) < 0)
-	{
+	if ((fd =3D open(UINPUT_DEVICE, O_WRONLY)) < 0) {
 		perror("Cannot open " UINPUT_DEVICE);
 		goto shutdown;
 	}
=20
-	if(write(fd, &dev, sizeof(dev)) < sizeof(dev))
-	{
+	if (write(fd, &dev, sizeof(dev)) < sizeof(dev)) {
 		perror("Cannot create a uinput device");
 		goto release;
 	}
=20
-	if(ioctl(fd, UI_SET_EVBIT, EV_KEY))
+	if (ioctl(fd, UI_SET_EVBIT, EV_KEY))
 		goto release;
=20
-	for(i =3D 0; i <=3D KEY_MAX; i++)
-		if(ioctl(fd, UI_SET_KEYBIT, i))
+	for (i =3D 0; i <=3D KEY_MAX; i++)
+		if (ioctl(fd, UI_SET_KEYBIT, i))
 			goto release;
-	if(ioctl(fd, UI_DEV_CREATE))
+	if (ioctl(fd, UI_DEV_CREATE))
 		goto release;
=20
 	uinput_fd =3D fd;
=20
 	return 0;
- release:
+      release:
 	ioctl(fd, UI_DEV_DESTROY);
- shutdown:
+      shutdown:
 	close(fd);
 	return 1;
 }
=20
-static void kill_uinput ()
+static void kill_uinput()
 {
 	if (uinput_fd =3D=3D -1)
 		return;
@@ -197,99 +191,93 @@
 	close(uinput_fd);
 }
=20
-static void send_key (unsigned short code)
+static void send_key(unsigned short code)
 {
 	struct input_event ev =3D {
 		.type =3D EV_KEY,
 		.code =3D code,
-		.time =3D {0, }
+		.time =3D {0,}
 	};
=20
 	if (uinput_fd =3D=3D -1)
 		return;
=20
-	if(code > KEY_MAX)
+	if (code > KEY_MAX)
 		return;
- =20
-	ev.value =3D 1; // press...
+
+	ev.value =3D 1;		// press...
 	write(uinput_fd, &ev, sizeof(ev));
=20
-	ev.value =3D 0; // then release
+	ev.value =3D 0;		// then release
 	write(uinput_fd, &ev, sizeof(ev));
 }
=20
 // This function handle the bluetooth connection
 int a2dp_handle_avrcp_message(int sockfd)
 {
-        char lpFrame [A2DPMAXIMUMTRANSFERUNITSIZE];
-        int iReceived =3D recv(sockfd, lpFrame, sizeof(lpFrame), 0);
-        if(iReceived>0)
-        {
-                struct avc_frame frame =3D *((struct avc_frame*)lpFrame)=
;
-
-                // Handle message
-                if(frame.ctype =3D=3D CMD_PASSTHROUGH)
-                {
-                        switch (frame.operand0)
-                        {
-                        case PLAY_OP:
-                                printf("[play] %s\n", g_sCmdPlay);
-                                if(g_sCmdPlay[0]) async_run_process(g_sC=
mdPlay);
-				send_key (KEY_PLAY);
-                                break;
-                        case PAUSE_OP:
-                                printf("[pause] %s\n", g_sCmdPause);
-                                if(g_sCmdPause[0]) async_run_process(g_s=
CmdPause);
-				send_key (KEY_PAUSE);
-                                break;
-                        case NEXT_OP:
-                                printf("[next] %s\n", g_sCmdNext);
-                                if(g_sCmdNext[0]) async_run_process(g_sC=
mdNext);
-				send_key (KEY_NEXTSONG);
-                                break;
-                        case PREV_OP:
-                                printf("[previous] %s\n", g_sCmdPrev);
-                                if(g_sCmdPrev[0]) async_run_process(g_sC=
mdPrev);
-				send_key (KEY_PREVIOUSSONG);
-                                break;
-                        default:
-                                printf("received passthrough %d bytes:\n=
", iReceived);
-                                //dump_packet(&frame, iReceived);
-                        }
-                }
-                else
-                {
-                        printf("received %d bytes:\n", iReceived);
-                        //dump_packet(&frame, iReceived);
-                }
-                // Send response
-                if(iReceived > 0)
-                {
-                        if(frame.ctype =3D=3D CMD_ACCEPTED)
-                        {
-                                printf("(ack)\n");
-                        }
-                        else
-                        if(frame.ctype =3D=3D CMD_PASSTHROUGH)
-                        {
-                                init_response(&frame.header);
-                                frame.ctype =3D CMD_ACCEPTED;
-                                write(sockfd, &frame, iReceived);
-                        }
-                        else
-                        {
-                                printf("only passthrough ctype command i=
s implemented. doh!\n");
-                                // ierk!!! exit(0);
-                        }
-                }
-        }
-        else
-        {
-                if(errno!=3DEAGAIN)
-                        printf("socket %d: Receive failed %d (error %d:%=
s)\n", sockfd, iReceived, errno, strerror(errno));
-        }
+	char lpFrame[A2DPMAXIMUMTRANSFERUNITSIZE];
+	int iReceived =3D recv(sockfd, lpFrame, sizeof(lpFrame), 0);
+	if (iReceived > 0) {
+		struct avc_frame frame =3D *((struct avc_frame *) lpFrame);
+
+		// Handle message
+		if (frame.ctype =3D=3D CMD_PASSTHROUGH) {
+			switch (frame.operand0) {
+			case PLAY_OP:
+				printf("[play] %s\n", g_sCmdPlay);
+				if (g_sCmdPlay[0])
+					async_run_process(g_sCmdPlay);
+				else
+					send_key(KEY_PLAY);
+				break;
+			case PAUSE_OP:
+				printf("[pause] %s\n", g_sCmdPause);
+				if (g_sCmdPause[0])
+					async_run_process(g_sCmdPause);
+				else
+					send_key(KEY_PAUSE);
+				break;
+			case NEXT_OP:
+				printf("[next] %s\n", g_sCmdNext);
+				if (g_sCmdNext[0])
+					async_run_process(g_sCmdNext);
+				else
+					send_key(KEY_NEXTSONG);
+				break;
+			case PREV_OP:
+				printf("[previous] %s\n", g_sCmdPrev);
+				if (g_sCmdPrev[0])
+					async_run_process(g_sCmdPrev);
+				else
+					send_key(KEY_PREVIOUSSONG);
+				break;
+			default:
+				printf("received passthrough %d bytes:\n", iReceived);
+				//dump_packet(&frame, iReceived);
+			}
+		} else {
+			printf("received %d bytes:\n", iReceived);
+			//dump_packet(&frame, iReceived);
+		}
+		// Send response
+		if (iReceived > 0) {
+			if (frame.ctype =3D=3D CMD_ACCEPTED) {
+				printf("(ack)\n");
+			} else if (frame.ctype =3D=3D CMD_PASSTHROUGH) {
+				init_response(&frame.header);
+				frame.ctype =3D CMD_ACCEPTED;
+				write(sockfd, &frame, iReceived);
+			} else {
+				printf("only passthrough ctype command is implemented. doh!\n");
+				// ierk!!! exit(0);
+			}
+		}
+	} else {
+		if (errno !=3D EAGAIN)
+			printf("socket %d: Receive failed %d (error %d:%s)\n", sockfd, iRecei=
ved, errno, strerror(errno));
+	}
=20
-        return iReceived;
+	return iReceived;
 }
=20
 //////////////////////////////////////////
@@ -306,738 +294,709 @@
=20
 #define max(x,y) ((x)>(y)?(x):(y))
=20
-char* pool_pop()
+char *pool_pop()
 {
-        return malloc(POOLENTRYSIZE);
+	return malloc(POOLENTRYSIZE);
 }
=20
-void pool_push(char* pool)
+void pool_push(char *pool)
 {
-        free(pool);
+	free(pool);
 }
=20
 // Data used to mix audio
-typedef struct
-{
-        int                     lives;
-        pthread_mutex_t         mutex;
-        int                     ring_in;
-        int                     ring_out;
-        int                     ring_len[MAXCLIENTSRINGSIZE];
-        char*                   ring[MAXCLIENTSRINGSIZE];
+typedef struct {
+	int lives;
+	pthread_mutex_t mutex;
+	int ring_in;
+	int ring_out;
+	int ring_len[MAXCLIENTSRINGSIZE];
+	char *ring[MAXCLIENTSRINGSIZE];
 } BTA2DPPERCLIENTDATA;
=20
 // Data to keep per Bluetooth device
-typedef struct
-{
-        char                    addr[20];
-        pthread_t               thread;
-        pthread_t               receiverthread;
-        pthread_mutex_t         mutex;
-        AUDIOMIXERDATA          mixer;
-        int                     nb_clients;
-        BTA2DPPERCLIENTDATA     clients[MAXCLIENTSPERDEVICE];
+typedef struct {
+	char addr[20];
+	char plug[20];
+	pthread_t thread;
+	pthread_t receiverthread;
+	pthread_mutex_t mutex;
+	AUDIOMIXERDATA mixer;
+	int nb_clients;
+	int bredirectalsa;
+	BTA2DPPERCLIENTDATA clients[MAXCLIENTSPERDEVICE];
 } BTA2DPPERDEVICEDATA, *LPBTA2DPPERDEVICEDATA;
=20
 // Data needed per Audio Streaming Client
-typedef struct
-{
-        LPBTA2DPPERDEVICEDATA   lpDevice;
-        int                     sockfd;
-        pthread_t               thread;
+typedef struct {
+	LPBTA2DPPERDEVICEDATA lpDevice;
+	int sockfd;
+	pthread_t thread;
 } A2DPDCLIENT, *LPA2DPDCLIENT;
=20
 // Allocate a new device
-LPBTA2DPPERDEVICEDATA bta2dpdevicenew(char* addr)
+LPBTA2DPPERDEVICEDATA bta2dpdevicenew(char *addr)
 {
-        int i =3D 0;
-        LPBTA2DPPERDEVICEDATA lpDevice =3D malloc(sizeof(BTA2DPPERDEVICE=
DATA));
-        if(lpDevice)
-        {
-                memset(lpDevice, 0, sizeof(BTA2DPPERDEVICEDATA));
-                strncpy(lpDevice->addr, addr, sizeof(lpDevice->addr)); l=
pDevice->addr[sizeof(lpDevice->addr)-1] =3D 0;
-                lpDevice->mixer.volume_speaker_left =3D A2DPD_VOLUME_MAX=
;
-                lpDevice->mixer.volume_speaker_right =3D A2DPD_VOLUME_MA=
X;
-                lpDevice->mixer.volume_micro_left =3D A2DPD_VOLUME_MAX;
-                lpDevice->mixer.volume_micro_right =3D A2DPD_VOLUME_MAX;
-                pthread_mutex_init(&lpDevice->mutex, NULL);
-                for(i=3D0;i<MAXCLIENTSPERDEVICE; i++)
-                {
-                        pthread_mutex_init(&lpDevice->clients[i].mutex, =
NULL);
-                }
-        }
-        return lpDevice;
+	int i =3D 0;
+	LPBTA2DPPERDEVICEDATA lpDevice =3D malloc(sizeof(BTA2DPPERDEVICEDATA));
+	if (lpDevice) {
+		memset(lpDevice, 0, sizeof(BTA2DPPERDEVICEDATA));
+		strncpy(lpDevice->addr, addr, sizeof(lpDevice->addr));
+		lpDevice->addr[sizeof(lpDevice->addr) - 1] =3D 0;
+		lpDevice->mixer.volume_speaker_left =3D A2DPD_VOLUME_MAX;
+		lpDevice->mixer.volume_speaker_right =3D A2DPD_VOLUME_MAX;
+		lpDevice->mixer.volume_micro_left =3D A2DPD_VOLUME_MAX;
+		lpDevice->mixer.volume_micro_right =3D A2DPD_VOLUME_MAX;
+		pthread_mutex_init(&lpDevice->mutex, NULL);
+		for (i =3D 0; i < MAXCLIENTSPERDEVICE; i++) {
+			pthread_mutex_init(&lpDevice->clients[i].mutex, NULL);
+		}
+	}
+	return lpDevice;
 }
=20
 // Free a device
 void bta2dpdevicefree(LPBTA2DPPERDEVICEDATA lpDevice)
 {
-        int i =3D 0;
-        if(lpDevice)
-        {
-                for(i=3D0;i<MAXCLIENTSPERDEVICE; i++)
-                {
-                        pthread_mutex_destroy(&lpDevice->clients[i].mute=
x);
-                }
-                pthread_mutex_destroy(&lpDevice->mutex);
-                free(lpDevice);
-        }
+	int i =3D 0;
+	if (lpDevice) {
+		for (i =3D 0; i < MAXCLIENTSPERDEVICE; i++) {
+			pthread_mutex_destroy(&lpDevice->clients[i].mutex);
+		}
+		pthread_mutex_destroy(&lpDevice->mutex);
+		free(lpDevice);
+	}
 }
=20
 // handle sigterm to terminate properly
 void sigint_handler(int sig)
 {
-        // User wants to force quit
-        if(bSigINTReceived=3D=3D1)=20
-        {
-                printf("handling SIGINT again: exit forced\n");
-                exit(0);
-        }
-        else
-        {
-                // Now we must quit properly
-                bSigINTReceived =3D 1;
-                printf("handling SIGINT\n");
-       =20
-                // Dummy connection to unlock server (currently acceptin=
g)
-                close_socket(make_client_socket());
-        }
+	// User wants to force quit
+	if (bSigINTReceived =3D=3D 1) {
+		printf("handling SIGINT again: exit forced\n");
+		exit(0);
+	} else {
+		// Now we must quit properly
+		bSigINTReceived =3D 1;
+		printf("handling SIGINT\n");
+
+		// Dummy connection to unlock server (currently accepting)
+		close_socket(make_client_socket());
+	}
 }
=20
 // This function handles a client
-void* client_handler(void* param)
+void *client_handler(void *param)
 {
-        int bError =3D 0;
-        int client_index =3D -1;
-        int32_t client_type =3D INVALID_CLIENT_TYPE;
-        int result;
-        LPA2DPDCLIENT lpClient =3D (LPA2DPDCLIENT)param;
-        AUDIOMIXERDATA AudioMixerData =3D INVALIDAUDIOMIXERDATA;
-
-        // We should not terminate the process if clients are still runn=
ing
-        iThreadsRunning ++;
-
-        pthread_detach(lpClient->thread);
-
-        setup_socket(lpClient->sockfd);
-
-        // Receive type of client
-        result =3D recv_socket(lpClient->sockfd, &client_type, sizeof(cl=
ient_type));
-
-        // This client wants to send us pcm control data
-        if(client_type=3D=3DA2DPD_PLUGIN_CTL_WRITE)
-        {
-                printf("CTL WRITE thread %d.%d started\n", client_index,=
 lpClient->sockfd);
-
-                if(recv_socket(lpClient->sockfd, &AudioMixerData, sizeof=
(AudioMixerData))=3D=3Dsizeof(AudioMixerData))
-                {
-                        pthread_mutex_lock(&lpClient->lpDevice->mutex);
-                        if(AudioMixerData.volume_speaker_left !=3D -1)
-                                lpClient->lpDevice->mixer.volume_speaker=
_left =3D AudioMixerData.volume_speaker_left;
-                        if(AudioMixerData.volume_speaker_left !=3D -1)
-                                lpClient->lpDevice->mixer.volume_speaker=
_right=3D AudioMixerData.volume_speaker_right;
-                        if(AudioMixerData.volume_micro_left !=3D -1)
-                                lpClient->lpDevice->mixer.volume_micro_l=
eft =3D AudioMixerData.volume_micro_left;
-                        if(AudioMixerData.volume_micro_left !=3D -1)
-                                lpClient->lpDevice->mixer.volume_micro_r=
ight=3D AudioMixerData.volume_micro_right;
-                        pthread_mutex_unlock(&lpClient->lpDevice->mutex)=
;
-                        // Notify other clients
-                        int notifyfd =3D make_udp_socket();
-                        int i=3Dsend_socket(notifyfd, &AudioMixerData, s=
izeof(AudioMixerData));
-                        printf("Notify return %d\n", i);
-                        close_socket(notifyfd);
-                }
-        }
-
-        // This client wants to read our control status
-        if(client_type=3D=3DA2DPD_PLUGIN_CTL_READ)
-        {
-                printf("CTL READ thread %d.%d started\n", client_index, =
lpClient->sockfd);
-
-                pthread_mutex_lock(&lpClient->lpDevice->mutex);
-                AudioMixerData =3D lpClient->lpDevice->mixer;
-                pthread_mutex_unlock(&lpClient->lpDevice->mutex);
-
-                send_socket(lpClient->sockfd, &AudioMixerData, sizeof(Au=
dioMixerData));
-        }
-
-        // This client wants to send us pcm stream
-        if(client_type=3D=3DA2DPD_PLUGIN_PCM_WRITE)
-        {
-                // Find an index in clients table for the mixer
-                pthread_mutex_lock(&lpClient->lpDevice->mutex);
-                for(client_index=3D0; client_index<MAXCLIENTSPERDEVICE; =
client_index++)
-                {
-                        if(lpClient->lpDevice->clients[client_index].liv=
es=3D=3D0)
-                        {
-                                lpClient->lpDevice->clients[client_index=
].lives =3D 1;
-                                lpClient->lpDevice->clients[client_index=
].ring_in =3D 0;
-                                lpClient->lpDevice->clients[client_index=
].ring_out =3D 0;
-                                break;
-                        }
-                }
-                pthread_mutex_unlock(&lpClient->lpDevice->mutex);
-
-                printf("PCM thread %d.%d started\n", client_index, lpCli=
ent->sockfd);
-
-                if(client_index>=3DMAXCLIENTSPERDEVICE)
-                {
-                        printf("Client thread %d cannot start (too many =
clients already connected)\n", client_index);
-                        return 0;
-                }
-
-                // Loop while we receive data
-                while(!bSigINTReceived && !bError)
-                {
-                        // Receive data
-                        int32_t pcm_buffer_size =3D 0;
-                        result =3D recv_socket(lpClient->sockfd, &pcm_bu=
ffer_size, sizeof(pcm_buffer_size));
-                        if(result =3D=3D sizeof(pcm_buffer_size) && pcm_=
buffer_size<=3DPOOLENTRYSIZE)
-                        {
-                                char* pcm_buffer =3D pool_pop();
-                                result =3D recv_socket(lpClient->sockfd,=
 pcm_buffer, pcm_buffer_size);
-
-                                if(result=3D=3Dpcm_buffer_size)
-                                {
-                                        // Enqueue in bluetooth headset =
if we can else loose packet
-                                        pthread_mutex_lock(&lpClient->lp=
Device->clients[client_index].mutex);
-
-                                        // Append data to ring
-                                        int this_ring =3D lpClient->lpDe=
vice->clients[client_index].ring_in;
-                                        int next_ring =3D ((this_ring+1)=
%MAXCLIENTSRINGSIZE);
-
-                                        if(next_ring !=3D lpClient->lpDe=
vice->clients[client_index].ring_out)
-                                        {
-                                                lpClient->lpDevice->clie=
nts[client_index].ring[this_ring] =3D pcm_buffer;
-                                                lpClient->lpDevice->clie=
nts[client_index].ring_len[this_ring] =3D pcm_buffer_size;
-                                                lpClient->lpDevice->clie=
nts[client_index].ring_in =3D next_ring;
-                                                // We will not free that=
 buffer, it's the bthandler thread which will do it
-                                                pcm_buffer =3D NULL;
-                                        }
-
-                                        pthread_mutex_unlock(&lpClient->=
lpDevice->clients[client_index].mutex);
-
-                                        // Reintegrate data in pool
-                                        if(pcm_buffer) pool_push(pcm_buf=
fer);
-                                }
-                                else
-                                {
-                                        printf("[2] Receiving failed on =
socket %d.%d error (%d/%d bytes)\n", client_index, lpClient->sockfd, resu=
lt, pcm_buffer_size);
-                                        bError =3D 1;
-                                }
-                        }
-                        else
-                        {
-                                if(result=3D=3Dsizeof(pcm_buffer_size))
-                                {
-                                        printf("[1] Receiving will not f=
it pool (poolentrysize=3D%d !=3D pcm_buffer_size=3D%d)\n", POOLENTRYSIZE,=
 pcm_buffer_size);
-                                }
-                                else
-                                {
-                                        printf("[1] Receiving failed on =
socket %d.%d error (%d/%d bytes) errno=3D%d:%s\n", client_index, lpClient=
->sockfd, result, sizeof(pcm_buffer_size), errno, strerror(errno));
-                                }
-                                bError =3D 1;
-                        }
-                }
-
-                pthread_mutex_lock(&lpClient->lpDevice->mutex);
-                if(client_index>=3D0) lpClient->lpDevice->clients[client=
_index].lives=3D0;
-                pthread_mutex_unlock(&lpClient->lpDevice->mutex);
-        }
-
-        // Say goodbye
-        pthread_mutex_lock(&lpClient->lpDevice->mutex);
-        lpClient->lpDevice->nb_clients--;
-        pthread_mutex_unlock(&lpClient->lpDevice->mutex);
-
-        // Close socket
-        printf("Client thread %d.%d ending: %s\n", client_index, lpClien=
t->sockfd, (bError?(errno=3D=3DEAGAIN?"timeout":"error"):"no error"));
-        close_socket(lpClient->sockfd);
+	int bError =3D 0;
+	int client_index =3D -1;
+	int32_t client_type =3D INVALID_CLIENT_TYPE;
+	int result;
+	LPA2DPDCLIENT lpClient =3D (LPA2DPDCLIENT) param;
+	AUDIOMIXERDATA AudioMixerData =3D INVALIDAUDIOMIXERDATA;
+
+	// We should not terminate the process if clients are still running
+	iThreadsRunning++;
+
+	pthread_detach(lpClient->thread);
+
+	setup_socket(lpClient->sockfd);
+
+	// Receive type of client
+	result =3D recv_socket(lpClient->sockfd, &client_type, sizeof(client_ty=
pe));
+
+	// This client wants to send us pcm control data
+	if (client_type =3D=3D A2DPD_PLUGIN_CTL_WRITE) {
+		printf("CTL WRITE thread %d.%d started\n", client_index, lpClient->soc=
kfd);
+
+		if (recv_socket(lpClient->sockfd, &AudioMixerData, sizeof(AudioMixerDa=
ta)) =3D=3D sizeof(AudioMixerData)) {
+			pthread_mutex_lock(&lpClient->lpDevice->mutex);
+			if (AudioMixerData.volume_speaker_left !=3D -1)
+				lpClient->lpDevice->mixer.volume_speaker_left =3D AudioMixerData.vol=
ume_speaker_left;
+			if (AudioMixerData.volume_speaker_left !=3D -1)
+				lpClient->lpDevice->mixer.volume_speaker_right =3D AudioMixerData.vo=
lume_speaker_right;
+			if (AudioMixerData.volume_micro_left !=3D -1)
+				lpClient->lpDevice->mixer.volume_micro_left =3D AudioMixerData.volum=
e_micro_left;
+			if (AudioMixerData.volume_micro_left !=3D -1)
+				lpClient->lpDevice->mixer.volume_micro_right =3D AudioMixerData.volu=
me_micro_right;
+			pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+			// Notify other clients
+			int notifyfd =3D make_udp_socket();
+			int i =3D send_socket(notifyfd, &AudioMixerData,
+					    sizeof(AudioMixerData));
+			printf("Notify return %d\n", i);
+			close_socket(notifyfd);
+		}
+	}
+	// This client wants to read our control status
+	if (client_type =3D=3D A2DPD_PLUGIN_CTL_READ) {
+		printf("CTL READ thread %d.%d started\n", client_index, lpClient->sock=
fd);
+
+		pthread_mutex_lock(&lpClient->lpDevice->mutex);
+		AudioMixerData =3D lpClient->lpDevice->mixer;
+		pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+
+		send_socket(lpClient->sockfd, &AudioMixerData, sizeof(AudioMixerData))=
;
+	}
+	// This client wants to send us pcm stream
+	if (client_type =3D=3D A2DPD_PLUGIN_PCM_WRITE) {
+		// Find an index in clients table for the mixer
+		pthread_mutex_lock(&lpClient->lpDevice->mutex);
+		for (client_index =3D 0; client_index < MAXCLIENTSPERDEVICE; client_in=
dex++) {
+			if (lpClient->lpDevice->clients[client_index].lives =3D=3D 0) {
+				lpClient->lpDevice->clients[client_index].lives =3D 1;
+				lpClient->lpDevice->clients[client_index].ring_in =3D 0;
+				lpClient->lpDevice->clients[client_index].ring_out =3D 0;
+				break;
+			}
+		}
+		pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+
+		printf("PCM thread %d.%d started\n", client_index, lpClient->sockfd);
+
+		if (client_index >=3D MAXCLIENTSPERDEVICE) {
+			printf("Client thread %d cannot start (too many clients already conne=
cted)\n", client_index);
+			return 0;
+		}
+		// Loop while we receive data
+		while (!bSigINTReceived && !bError) {
+			// Receive data
+			int32_t pcm_buffer_size =3D 0;
+			result =3D recv_socket(lpClient->sockfd, &pcm_buffer_size, sizeof(pcm=
_buffer_size));
+			if (result =3D=3D sizeof(pcm_buffer_size)
+			    && pcm_buffer_size <=3D POOLENTRYSIZE) {
+				char *pcm_buffer =3D pool_pop();
+				result =3D recv_socket(lpClient->sockfd, pcm_buffer, pcm_buffer_size=
);
+
+				if (result =3D=3D pcm_buffer_size) {
+					// Enqueue in bluetooth headset if we can else loose packet
+					pthread_mutex_lock(&lpClient->lpDevice->clients[client_index].mutex=
);
+
+					// Append data to ring
+					int this_ring =3D lpClient->lpDevice->clients[client_index].ring_in=
;
+					int next_ring =3D ((this_ring + 1) % MAXCLIENTSRINGSIZE);
+
+					if (next_ring !=3D lpClient->lpDevice->clients[client_index].ring_o=
ut) {
+						lpClient->lpDevice->clients[client_index].ring[this_ring] =3D pcm_=
buffer;
+						lpClient->lpDevice->clients[client_index].ring_len[this_ring] =3D =
pcm_buffer_size;
+						lpClient->lpDevice->clients[client_index].ring_in =3D next_ring;
+						// We will not free that buffer, it's the bthandler thread which w=
ill do it
+						pcm_buffer =3D NULL;
+					}
+
+					pthread_mutex_unlock(&lpClient->lpDevice->clients[client_index].mut=
ex);
+
+					// Reintegrate data in pool
+					if (pcm_buffer)
+						pool_push(pcm_buffer);
+				} else {
+					printf("[2] Receiving failed on socket %d.%d error (%d/%d bytes)\n"=
, client_index, lpClient->sockfd, result, pcm_buffer_size);
+					bError =3D 1;
+				}
+			} else {
+				if (result =3D=3D sizeof(pcm_buffer_size)) {
+					printf("[1] Receiving will not fit pool (poolentrysize=3D%d !=3D pc=
m_buffer_size=3D%d)\n", POOLENTRYSIZE, pcm_buffer_size);
+				} else {
+					printf("[1] Receiving failed on socket %d.%d error (%d/%d bytes) er=
rno=3D%d:%s\n", client_index, lpClient->sockfd, result, sizeof(pcm_buffer=
_size), errno,
+					       strerror(errno));
+				}
+				bError =3D 1;
+			}
+		}
+
+		pthread_mutex_lock(&lpClient->lpDevice->mutex);
+		if (client_index >=3D 0)
+			lpClient->lpDevice->clients[client_index].lives =3D 0;
+		pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+	}
+	// Say goodbye
+	pthread_mutex_lock(&lpClient->lpDevice->mutex);
+	lpClient->lpDevice->nb_clients--;
+	pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+
+	// Close socket
+	printf("Client thread %d.%d ending: %s\n", client_index, lpClient->sock=
fd, (bError ? (errno =3D=3D EAGAIN ? "timeout" : "error") : "no error"));
+	close_socket(lpClient->sockfd);
+
+	// Free client data
+	free(lpClient);
+
+	// Decrease thread count
+	iThreadsRunning--;
=20
-        // Free client data
-        free(lpClient);
+	return 0;
+}
=20
-        // Decrease thread count
-        iThreadsRunning --;
+/////////////////////////////////
+int audio_mixer(void *pcm_buffer, char **pcm_buffers, int *pcm_buffers_s=
ize, int vol_left, int vol_right)
+/////////////////////////////////
+{
+	int i, j;
+	int satured =3D 0;
+
+	// Mix audio streams 16 bits stereo channels
+	// We require little endianness here
+	int pcm_buffer_filed_size =3D 0;
+	for (j =3D 0; j < POOLENTRYSIZE / 4; j++) {
+		int32_t *pBuffer =3D (int32_t *) pcm_buffer;
+		int32_t channel_1 =3D 0;
+		int32_t channel_2 =3D 0;
+		for (i =3D 0; i < MAXCLIENTSPERDEVICE; i++) {
+			int32_t *pBuffers =3D (int32_t *) (pcm_buffers[i]);
+			if (pBuffers !=3D NULL && (j < pcm_buffers_size[i] / 4)) {
+				int16_t i1 =3D *(((int16_t *) (pBuffers + j)) + 0);
+				int16_t i2 =3D *(((int16_t *) (pBuffers + j)) + 1);
+				channel_1 +=3D i1;
+				channel_2 +=3D i2;
+				pcm_buffer_filed_size =3D max(pcm_buffer_filed_size, pcm_buffers_siz=
e[i]);
+			}
+		}
+		//printf("Value %08X|%08X %d|%d\n", channel_1, channel_2, channel_1, c=
hannel_2);
+		// Stay within 16 bits per channel range
+		if (channel_1 > +32767) {
+			channel_1 =3D +32767;
+			satured++;
+		}
+		if (channel_1 < -32768) {
+			channel_1 =3D -32768;
+			satured++;
+		}
+		if (channel_2 > +32767) {
+			channel_2 =3D +32767;
+			satured++;
+		}
+		if (channel_2 < -32768) {
+			channel_2 =3D -32768;
+			satured++;
+		}
=20
-        return 0;
+		channel_1 *=3D vol_left;
+		channel_2 *=3D vol_right;
+		// yes this can be rewritten with << if we consider max volume of 2^x
+		// Isn't it already done by compiler?
+		channel_1 /=3D A2DPD_VOLUME_MAX;
+		channel_2 /=3D A2DPD_VOLUME_MAX;
+		if(g_breversestereo) {
+			pBuffer[j] =3D (((channel_1 & 0x0000FFFF) << 16) | (channel_2 & 0x000=
0FFFF));
+		} else {
+			//FIXME We have a reverse stereo I don't know why
+			// The following line corrects the problem but I miss the cause so
+			pBuffer[j] =3D (((channel_2&0x0000FFFF)<<16)|(channel_1&0x0000FFFF));
+			pBuffer[j] =3D ( (channel_1 & 0xFFFF0000) | (channel_2 & 0x0000FFFF) =
);
+		}
+	}
+	return pcm_buffer_filed_size;
 }
=20
 // This function handle the bluetooth connection
-void* bt_handler(void* param)
+void *bt_handler(void *param)
 {
-        int i,j;
-        // We should not terminate the process if clients are still runn=
ing
-        iThreadsRunning ++;
-
-        LPBTA2DPPERDEVICEDATA lpDevice =3D (LPBTA2DPPERDEVICEDATA)param;
-        pthread_detach(lpDevice->thread);
-
-        // As long as daemon is running
-        while(!bSigINTReceived)
-        {
-                int bError =3D 0;
-                int destroy_count =3D 0;
-                int satured =3D 0;
-                int ibytespersecond =3D 0;
-
-                // Connect to the A2DP device
-                LPA2DP lpA2dp =3D NULL;
-                char* pcm_buffer =3D pool_pop();
-                enum { NOSOUND, SOUND };
-                int state_previous =3D NOSOUND;
-                TIMERINFO TimerInfos;
-                int rate =3D read_config_int(g_srcfilename, "a2dpd", "ra=
te", A2DPD_FRAME_RATE);
-                memset(&TimerInfos, 0, sizeof(TimerInfos));
-                TimerInfos.fps =3D (float)((((float)rate)*((float)A2DPD_=
FRAME_BYTES)/((float)A2DPD_BLOCK_SIZE))/1.0);
-                printf("New connection to bluetooth [%d hz]\n", rate);
-
-                // As long as we can send sound
-                while(!bSigINTReceived && !bError)
-                {
-                        int pcm_buffer_filed_size =3D 0;
-                        char* pcm_buffers[MAXCLIENTSPERDEVICE];
-                        int pcm_buffers_size[MAXCLIENTSPERDEVICE];
-                        int state_current =3D NOSOUND;
-                        memset(pcm_buffers,      0, sizeof(pcm_buffers))=
;
-                        memset(pcm_buffers_size, 0, sizeof(pcm_buffers_s=
ize));
-
-                        // If there are BT data, send them
-                        //FIXME Since we read nb_clients, we should lock=
 mutex, but it may create timer issues
-                        // pthread_mutex_lock(&lpDevice->mutex);
-
-                        if(lpDevice->nb_clients>0)
-                        {
-                                // Retrieve data for client where it is =
available
-                                for(i=3D0; i<MAXCLIENTSPERDEVICE; i++)
-                                {
-                                        if(lpDevice->clients[i].lives)
-                                        {
-                                                pthread_mutex_lock(&lpDe=
vice->clients[i].mutex);
-                               =20
-                                                if(lpDevice->clients[i].=
ring_in !=3D lpDevice->clients[i].ring_out)
-                                                {
-                                                        // Get ring buff=
er
-                                                        pcm_buffers[i] =3D=
 lpDevice->clients[i].ring[lpDevice->clients[i].ring_out];
-                                                        pcm_buffers_size=
[i] =3D lpDevice->clients[i].ring_len[lpDevice->clients[i].ring_out];
-                                                        // Tell client w=
e got them
-                                                        lpDevice->client=
s[i].ring[lpDevice->clients[i].ring_out] =3D NULL;
-                                                        lpDevice->client=
s[i].ring_len[lpDevice->clients[i].ring_out] =3D 0;
-
-                                                        // Move to next =
ring
-                                                        int next_ring =3D=
 ((lpDevice->clients[i].ring_out+1)%MAXCLIENTSRINGSIZE);
-                                                       =20
-                                                        //printf("Readin=
g pool %d[ %d] =3D %p\n", i, lpDevice->clients[i].ring_out, pcm_buffers[i=
]);
-                                                       =20
-                                                        lpDevice->client=
s[i].ring_out =3D next_ring;
-                                                       =20
-                                                        // Remember we g=
ot some sound
-                                                        state_current =3D=
 SOUND;
-                                                }
-                                               =20
-                                                pthread_mutex_unlock(&lp=
Device->clients[i].mutex);
-                                        }
-                                }
-                        }
-                        //FIXME=20
-                        // pthread_mutex_unlock(&lpDevice->mutex);
-
-                        // Send mixed audio stream to clients
-                        switch(state_current)
-                        {
-                                case SOUND:
-                                {
-                                        ////////////////////////////////=
/
-                                        // Mix what we got
-                                        ////////////////////////////////=
/
-
-                                        static int frames =3D 0;
-                                        frames ++;
-                                       =20
-                                        // Mix audio streams 16 bits ste=
reo channels
-                                        // We require little endianness =
here
-                                        pcm_buffer_filed_size =3D 0;
-                                        for(j=3D0; j<POOLENTRYSIZE/4; j+=
+)
-                                        {
-                                                int32_t* pBuffer =3D (in=
t32_t*)pcm_buffer;
-                                                int32_t channel_1 =3D 0;
-                                                int32_t channel_2 =3D 0;
-                                                for(i=3D0; i<MAXCLIENTSP=
ERDEVICE; i++)
-                                                {
-                                                        int32_t* pBuffer=
s =3D (int32_t*)(pcm_buffers[i]);
-                                                        if(pBuffers !=3D=
 NULL && (j<pcm_buffers_size[i]/4))
-                                                        {
-                                                                int16_t =
i1 =3D *(((int16_t*)(pBuffers+j))+0);
-                                                                int16_t =
i2 =3D *(((int16_t*)(pBuffers+j))+1);
-                                                                channel_=
1 +=3D i1;
-                                                                channel_=
2 +=3D i2;
-                                                                pcm_buff=
er_filed_size =3D max(pcm_buffer_filed_size, pcm_buffers_size[i]);
-                                                        }
-                                                }
-                                                //printf("Value %08X|%08=
X %d|%d\n", channel_1, channel_2, channel_1, channel_2);
-                                                // Stay within 16 bits p=
er channel range
-                                                if(channel_1>+32767) { c=
hannel_1 =3D +32767; satured++; }
-                                                if(channel_1<-32768) { c=
hannel_1 =3D -32768; satured++; }
-                                                if(channel_2>+32767) { c=
hannel_2 =3D +32767; satured++; }
-                                                if(channel_2<-32768) { c=
hannel_2 =3D -32768; satured++; }
-                                               =20
-                                                channel_1 *=3D lpDevice-=
>mixer.volume_speaker_left;
-                                                channel_2 *=3D lpDevice-=
>mixer.volume_speaker_right;
-                                                // yes this can be rewri=
tten with << if we consider max volume of 2^x
-                                                // Isn't it already done=
 by compiler
-                                                channel_1 /=3D A2DPD_VOL=
UME_MAX;
-                                                channel_2 /=3D A2DPD_VOL=
UME_MAX;
-                                                pBuffer[j] =3D (((channe=
l_1&0x0000FFFF)<<16)|(channel_2&0x0000FFFF));
-                                                //FIXME We have a revers=
e stereo I don't know why
-                                                // The following line co=
rrects the problem but I miss the cause so
-                                                // Do not uncomment it
-                                                //pBuffer[j] =3D (((chan=
nel_2&0x0000FFFF)<<16)|(channel_1&0x0000FFFF));
-                                                //pBuffer[j] =3D ( (chan=
nel_1 & 0xFFFF0000) | (channel_2 & 0x0000FFFF) );
-                                        }
-
-                                        // Free no longer used audio blo=
cks
-                                        for(i=3D0; i<MAXCLIENTSPERDEVICE=
; i++)
-                                        {
-                                                if(pcm_buffers[i])
-                                                {
-                                                        // Reintegrate d=
ata where they come from
-                                                        pool_push(pcm_bu=
ffers[i]);
-                                                }
-                                        }
-
-                                        ////////////////////////////////=
/
-                                        // Transfer data to bluetooth
-                                        ////////////////////////////////=
/
-
-                                        if(pcm_buffer && pcm_buffer_file=
d_size>0)
-                                        {
-                                                // Transfer takes place =
by A2DPD_BLOCK_SIZE bytes blocks
-                                                int blockstart =3D 0;
-                                                int blocksize =3D A2DPD_=
BLOCK_SIZE;
-
-                                                // Allocate A2DP if we a=
re not connected
-                                                if(!lpA2dp)
-                                                {
-                                                        lpA2dp =3D a2dp_=
new(lpDevice->addr, rate);
-                                                        g_nbdeviceconnec=
ted++;
-                                                        destroy_count =3D=
 0;
-                                                }
-
-                                                if(lpA2dp)
-                                                {
-                                                        // Send data to =
BT headset
-                                                        while(!bError &&=
 blockstart<pcm_buffer_filed_size)
-                                                        {
-                                                                int tran=
sfer;
-
-                                                                blocksiz=
e =3D (pcm_buffer_filed_size<A2DPD_BLOCK_SIZE)?pcm_buffer_filed_size:A2DP=
D_BLOCK_SIZE;
-
-                                                                transfer=
 =3D a2dp_transfer_raw(lpA2dp, pcm_buffer+blockstart, blocksize);
-
-                                                                if(trans=
fer>=3D0)
-                                                                {
-                                                                        =
destroy_count =3D 0;
-                                                                        =
blockstart +=3D blocksize;
-                                                                        =
ibytespersecond +=3D transfer;
-                                                                        =
a2dp_timer_notifyframe(&TimerInfos);
-                                                                }
-                                                                else
-                                                                {
-                                                                        =
printf("Error in a2dp_transfer_raw\n");
-                                                                        =
bError =3D 1;
-                                                                }
-                                                        }
-                                                }
-                                        }
-                                        break;
-                                }
-                                case NOSOUND:
-                                {
-                                        if(state_previous =3D=3D SOUND)
-                                        {
-                                                //printf("Sound stream r=
an dry!!!\n");
-                                        }
-                                        break;
-                                }
-                        }
-
-                        // Free the A2DP device if needed
-                        // When destroy_count reaches 2000 we will destr=
oy the A2DP link
-                        // However, destroy_count is reset whenever data=
 are sent
-                        destroy_count++;
-                        if(lpA2dp && destroy_count>2000)
-                        {
-                                printf("Destroying lpA2dp, destroy_count=
 is %d\n", destroy_count);
-                                g_nbdeviceconnected--;
-                                a2dp_destroy(lpA2dp);
-                                lpA2dp =3D NULL;
-                        }
-
-                        // Wait must take place after sending a packet
-                        // This way, you will allow the plugin to send i=
t's data
-                        // And you will collect the new data
-                        // Time reference floating because of 44100/1000=
 error in integer calculation
-                        a2dp_timer_sleep(&TimerInfos, A2DPTIMERPREDELAY)=
;
-
-                        // Display infos each second
-                        if(TimerInfos.display>0)
-                        {
-                                /*
-                                char* lpszFormat =3D "A2DPD: [%d,%d|%d,%=
d] %s %s clients=3D%d freq=3D%d[%d b/s] sleep=3D%d satur=3D%d\n";
-                                if(satured=3D=3D0) lpszFormat =3D "A2DPD=
: [%d,%d|%d,%d] %s %s clients=3D%d freq=3D%d[%d b/s]\n";
-                                printf(lpszFormat,=20
-                                lpDevice->mixer.volume_speaker_left,
-                                lpDevice->mixer.volume_speaker_right,
-                                lpDevice->mixer.volume_micro_left,
-                                lpDevice->mixer.volume_micro_right,
-                                (state_current=3D=3DSOUND)?"playing":"si=
lent",
-                                lpA2dp?"connected":"disconnected", lpDev=
ice->nb_clients, TimerInfos.display,
-                                ibytespersecond,
-                                satured);
-                                // Reset all variables used
-                                ibytespersecond=3D0;
-                                satured=3D0;
-                                */
-                        }
-
-                        state_previous =3D state_current;
-                }
-                pool_push(pcm_buffer);
-
-                // Sleep a little bit before retrying
-                if(!bSigINTReceived)
-                        sleep(1);
-
-                // Free A2DP
-                if(lpA2dp)
-                {
-                        printf("Destroying lpA2dp, end of loop\n");
-                        g_nbdeviceconnected--;
-                        a2dp_destroy(lpA2dp);
-                        lpA2dp =3D NULL;
-                }
-        }
+	int i;
+	// We should not terminate the process if clients are still running
+	iThreadsRunning++;
+
+	LPBTA2DPPERDEVICEDATA lpDevice =3D (LPBTA2DPPERDEVICEDATA) param;
+	pthread_detach(lpDevice->thread);
+
+	// As long as daemon is running
+	while (!bSigINTReceived) {
+		int bError =3D 0;
+		int destroy_count =3D 0;
+		int ibytespersecond =3D 0;
+
+		// Connect to the A2DP device
+		void *lpA2dp =3D NULL;
+		char *pcm_buffer =3D pool_pop();
+		enum { NOSOUND, SOUND };
+		int state_previous =3D NOSOUND;
+		TIMERINFO TimerInfos;
+		int rate =3D read_config_int(g_srcfilename, "a2dpd", "rate",
+					   A2DPD_FRAME_RATE);
+		memset(&TimerInfos, 0, sizeof(TimerInfos));
+		TimerInfos.fps =3D (float) ((((float) rate) * ((float) A2DPD_FRAME_BYT=
ES) / ((float) A2DPD_BLOCK_SIZE)) / 1.0);
+		printf("New connection to bluetooth [%d hz]\n", rate);
+
+		// As long as we can send sound
+		while (!bSigINTReceived && !bError) {
+			int pcm_buffer_filed_size =3D 0;
+			char *pcm_buffers[MAXCLIENTSPERDEVICE];
+			int pcm_buffers_size[MAXCLIENTSPERDEVICE];
+			int state_current =3D NOSOUND;
+			memset(pcm_buffers, 0, sizeof(pcm_buffers));
+			memset(pcm_buffers_size, 0, sizeof(pcm_buffers_size));
+
+			// If there are BT data, send them
+			//FIXME Since we read nb_clients, we should lock mutex, but it may cr=
eate timer issues
+			// degrading sound
+			// pthread_mutex_lock(&lpDevice->mutex);
+
+			if (lpDevice->nb_clients > 0) {
+				// Retrieve data for client where it is available
+				for (i =3D 0; i < MAXCLIENTSPERDEVICE; i++) {
+					if (lpDevice->clients[i].lives) {
+						pthread_mutex_lock(&lpDevice->clients[i].mutex);
+
+						if (lpDevice->clients[i].ring_in !=3D lpDevice->clients[i].ring_ou=
t) {
+							// Get ring buffer
+							pcm_buffers[i] =3D lpDevice->clients[i].ring[lpDevice->clients[i]=
.ring_out];
+							pcm_buffers_size[i] =3D lpDevice->clients[i].ring_len[lpDevice->c=
lients[i].ring_out];
+							// Tell client we got them
+							lpDevice->clients[i].ring[lpDevice->clients[i].ring_out] =3D NULL=
;
+							lpDevice->clients[i].ring_len[lpDevice->clients[i].ring_out] =3D =
0;
+
+							// Move to next ring
+							int next_ring =3D ((lpDevice->clients[i].ring_out + 1) % MAXCLIEN=
TSRINGSIZE);
+
+							//printf("Reading pool %d[ %d] =3D %p\n", i, lpDevice->clients[i]=
.ring_out, pcm_buffers[i]);
+
+							lpDevice->clients[i].ring_out =3D next_ring;
+
+							// Remember we got some sound
+							state_current =3D SOUND;
+						}
+
+						pthread_mutex_unlock(&lpDevice->clients[i].mutex);
+					}
+				}
+			}
+			//FIXME=20
+			// pthread_mutex_unlock(&lpDevice->mutex);
+
+			// Send mixed audio stream to clients
+			switch (state_current) {
+			case SOUND:
+				pcm_buffer_filed_size =3D audio_mixer(pcm_buffer, pcm_buffers, pcm_b=
uffers_size, lpDevice->mixer.volume_speaker_left, lpDevice->mixer.volume_=
speaker_right);
+
+				// Free no longer used audio blocks
+				for (i =3D 0; i < MAXCLIENTSPERDEVICE; i++) {
+					if (pcm_buffers[i]) {
+						// Reintegrate data where they come from
+						pool_push(pcm_buffers[i]);
+					}
+				}
+
+				/////////////////////////////////
+				// Transfer data to bluetooth
+				/////////////////////////////////
+
+				if (pcm_buffer && pcm_buffer_filed_size > 0) {
+					// Transfer takes place by A2DPD_BLOCK_SIZE bytes blocks
+					int blockstart =3D 0;
+					int blocksize =3D A2DPD_BLOCK_SIZE;
+
+					// Allocate A2DP if we are not connected
+					if (!lpA2dp) {
+						// Select the good device
+						lpDevice->bredirectalsa =3D read_config_int(g_srcfilename, "a2dpd"=
, "enableredirectalsa", 0);
+						read_config_string(g_srcfilename, "a2dpd", "address", lpDevice->ad=
dr, sizeof(lpDevice->addr), "");
+						read_config_string(g_srcfilename, "a2dpd", "alsaoutput", lpDevice-=
>plug, sizeof(lpDevice->plug), "");
+						// Allocate it
+						if (lpDevice->bredirectalsa)
+							lpA2dp =3D alsa_new(lpDevice->plug, rate);
+						else
+							lpA2dp =3D a2dp_new(lpDevice->addr, rate);
+						g_nbdeviceconnected++;
+						destroy_count =3D 0;
+					}
+
+					if (lpA2dp) {
+						// Send data to BT headset
+						while (!bError && blockstart < pcm_buffer_filed_size) {
+							int transfer;
+
+							blocksize =3D (pcm_buffer_filed_size < A2DPD_BLOCK_SIZE) ? pcm_bu=
ffer_filed_size : A2DPD_BLOCK_SIZE;
+
+							if (lpDevice->bredirectalsa)
+								transfer =3D alsa_transfer_raw(lpA2dp, pcm_buffer + blockstart, =
blocksize);
+							else
+								transfer =3D a2dp_transfer_raw(lpA2dp, pcm_buffer + blockstart, =
blocksize);
+
+							if (transfer >=3D 0) {
+								destroy_count =3D 0;
+								blockstart +=3D blocksize;
+								ibytespersecond +=3D transfer;
+								a2dp_timer_notifyframe(&TimerInfos);
+							} else {
+								printf("Error in a2dp_transfer_raw\n");
+								bError =3D 1;
+							}
+						}
+					}
+				}
+				break;
+			case NOSOUND:
+				if (state_previous =3D=3D SOUND) {
+					//printf("Sound stream ran dry!!!\n");
+				}
+				break;
+			}
+
+			// Wait must take place after sending a packet
+			// This way, you will allow the plugin to send it's data
+			// And you will collect the new data
+			// Time reference floating because of 44100/1000 error in integer cal=
culation
+			a2dp_timer_sleep(&TimerInfos, A2DPTIMERPREDELAY);
+
+			// Read config file changes each second
+			if (TimerInfos.display > 0) {
+				if(g_brereadconfig) {
+					char addr[20];
+					char plug[20];
+					int bredirectalsa =3D read_config_int(g_srcfilename, "a2dpd", "enab=
leredirectalsa", 0);
+					read_config_string(g_srcfilename, "a2dpd", "address", addr, sizeof(=
addr), "");
+					read_config_string(g_srcfilename, "a2dpd", "alsaoutput", plug, size=
of(plug), "");
+					if((strcmp(addr, lpDevice->addr) !=3D 0) || (strcmp(plug, lpDevice-=
>plug) !=3D 0) || (bredirectalsa !=3D lpDevice->bredirectalsa)) {
+						// Force destroy, device will be recreated upon audio incoming
+						destroy_count=3D10000;
+					}
+				}
+				/*
+				   char* lpszFormat =3D "A2DPD: [%d,%d|%d,%d] %s %s clients=3D%d fre=
q=3D%d[%d b/s] sleep=3D%d satur=3D%d\n";
+				   if(satured=3D=3D0) lpszFormat =3D "A2DPD: [%d,%d|%d,%d] %s %s cli=
ents=3D%d freq=3D%d[%d b/s]\n";
+				   printf(lpszFormat,=20
+				   lpDevice->mixer.volume_speaker_left,
+				   lpDevice->mixer.volume_speaker_right,
+				   lpDevice->mixer.volume_micro_left,
+				   lpDevice->mixer.volume_micro_right,
+				   (state_current=3D=3DSOUND)?"playing":"silent",
+				   lpA2dp?"connected":"disconnected", lpDevice->nb_clients, TimerInf=
os.display,
+				   ibytespersecond,
+				   satured);
+				   // Reset all variables used
+				   ibytespersecond=3D0;
+				   satured=3D0;
+				 */
+			}
+
+			// Free the A2DP device if needed
+			// When destroy_count reaches 2000 we will destroy the A2DP link
+			// However, destroy_count is reset whenever data are sent
+			destroy_count++;
+			if (lpA2dp && destroy_count > 2000) {
+				printf("Destroying lpA2dp, destroy_count is %d\n", destroy_count);
+				g_nbdeviceconnected--;
+				if (lpDevice->bredirectalsa)
+					alsa_destroy(lpA2dp);
+				else
+					a2dp_destroy(lpA2dp);
+				lpA2dp =3D NULL;
+			}
+
+			state_previous =3D state_current;
+		}
+		pool_push(pcm_buffer);
+
+		// Sleep a little bit before retrying
+		if (!bSigINTReceived)
+			sleep(1);
+
+		// Free A2DP
+		if (lpA2dp) {
+			printf("Destroying lpA2dp, end of loop\n");
+			g_nbdeviceconnected--;
+			if (lpDevice->bredirectalsa)
+				alsa_destroy(lpA2dp);
+			else
+				a2dp_destroy(lpA2dp);
+			lpA2dp =3D NULL;
+		}
+	}
=20
-        iThreadsRunning --;
+	iThreadsRunning--;
=20
-        return 0;
+	return 0;
 }
=20
 // This function handle the bluetooth connection
-void* avdtp_listener(void* param)
+void *avdtp_listener(void *param)
 {
-        // We should not terminate the process if clients are still runn=
ing
-        iThreadsRunning ++;
+	// We should not terminate the process if clients are still running
+	iThreadsRunning++;
=20
-        LPBTA2DPPERDEVICEDATA lpDevice =3D (LPBTA2DPPERDEVICEDATA)param;
-        pthread_detach(lpDevice->thread);
+	LPBTA2DPPERDEVICEDATA lpDevice =3D (LPBTA2DPPERDEVICEDATA) param;
+	pthread_detach(lpDevice->thread);
=20
-        // As long as daemon is running
-        printf("avdtp: Accepting incoming connection\n");
-        while(!bSigINTReceived)
-        {
-                int sockfd =3D a2dp_make_listen_socket( 25);
-                if(sockfd>=3D0)
-                {
-                        while(!bSigINTReceived)
-                        {
-                                // Wait for incoming connections
-                                char szRemote[64];
-                                uint16_t iMTU =3D 0;
-
-                                int new_fd =3D a2dp_wait_connection(sock=
fd, szRemote, sizeof(szRemote), &iMTU);
-
-                                if(new_fd>0)
-                                {
-                                        printf("avdtp: socket %d: Connec=
tion from %s, mtu=3D%d\n", new_fd, szRemote, iMTU);
-
-                                        // Loop and manage what the clie=
nt sends
-                                        setup_socket(new_fd);
-                                        int iReceived =3D 0;
-                                        int play =3D 0;
-                                        int count =3D 0;
-                                        do
-                                        {
-                                                iReceived =3D a2dp_handl=
e_avdtp_message(NULL, new_fd, NULL, NULL, 0);
-                                                if(iReceived=3D=3D0)
-                                                {
-                                                        printf("avdtp: s=
ocket %d: Received frame, start %s\n", new_fd, g_sCmdNew);
-                                                        play=3D1;
-                                                        count=3D0;
-                                                        break;
-                                                }
-                                                else if(iReceived<0)
-                                                {
-                                                        if(errno!=3DEAGA=
IN)
-                                                                printf("=
avdtp: socket %d: Received failed result=3D%d (errno=3D%d:%s)\n", new_fd,=
 iReceived, errno, strerror(errno));
-                                                }
-                                                count++;
-                                        }
-                                        // AVDTP do not need to have a d=
evice connected, since it can establish device connection
-                                        while(!bSigINTReceived && (iRece=
ived>=3D0 || errno=3D=3DEAGAIN) && count<10);
-                                        printf("avdtp: socket %d: timed =
out\n", new_fd);
-                                        close_socket(new_fd);
-
-                                        if(play&&g_sCmdNew[0])
-                                        {
-                                                async_run_process(g_sCmd=
New);
-                                        }
-                                }
-                                else
-                                {
-                                        if(errno!=3DEAGAIN)
-                                        {
-                                                printf("a2dp_wait_connec=
tion failed (AVDTP socket) : %d (errno=3D%d:%s)\n", new_fd, errno, strerr=
or(errno));
-                                                break;
-                                        }
-                                }
-                        }
-
-                        close_socket(sockfd);
-                }
-
-                // Sleep a little bit if we must retry
-                sleep(bSigINTReceived?1:0);
-        }
+	// As long as daemon is running
+	printf("avdtp: Accepting incoming connection\n");
+	while (!bSigINTReceived) {
+		int sockfd =3D a2dp_make_listen_socket(25);
+		if (sockfd >=3D 0) {
+			while (!bSigINTReceived) {
+				// Wait for incoming connections
+				char szRemote[64];
+				uint16_t iMTU =3D 0;
+
+				int new_fd =3D a2dp_wait_connection(sockfd, szRemote, sizeof(szRemot=
e), &iMTU);
+
+				if (new_fd > 0) {
+					printf("avdtp: socket %d: Connection from %s, mtu=3D%d\n", new_fd, =
szRemote, iMTU);
+
+					// Loop and manage what the client sends
+					setup_socket(new_fd);
+					int iReceived =3D 0;
+					int play =3D 0;
+					int count =3D 0;
+					do {
+						iReceived =3D a2dp_handle_avdtp_message(NULL, new_fd, NULL, NULL, =
0);
+						if (iReceived =3D=3D 0) {
+							printf("avdtp: socket %d: Received frame, start %s\n", new_fd, g_=
sCmdNew);
+							play =3D 1;
+							count =3D 0;
+							break;
+						} else if (iReceived < 0) {
+							if (errno !=3D EAGAIN)
+								printf("avdtp: socket %d: Received failed result=3D%d (errno=3D%=
d:%s)\n", new_fd, iReceived, errno, strerror(errno));
+						}
+						count++;
+					}
+					// AVDTP do not need to have a device connected, since it can estab=
lish device connection
+					while (!bSigINTReceived && (iReceived >=3D 0 || errno =3D=3D EAGAIN=
)
+					       && count < 10);
+					printf("avdtp: socket %d: timed out\n", new_fd);
+					close_socket(new_fd);
+
+					if (play && g_sCmdNew[0]) {
+						async_run_process(g_sCmdNew);
+					}
+				} else {
+					if (errno !=3D EAGAIN) {
+						printf("a2dp_wait_connection failed (AVDTP socket) : %d (errno=3D%=
d:%s)\n", new_fd, errno, strerror(errno));
+						break;
+					}
+				}
+			}
=20
-        iThreadsRunning --;
+			close_socket(sockfd);
+		}
+		// Sleep a little bit if we must retry
+		sleep(bSigINTReceived ? 1 : 0);
+	}
=20
-        return 0;
+	iThreadsRunning--;
+
+	return 0;
 }
=20
 // This function handle the bluetooth connection
-void* avrcp_listener(void* param)
+void *avrcp_listener(void *param)
 {
-        // We should not terminate the process if clients are still runn=
ing
-        iThreadsRunning ++;
+	// We should not terminate the process if clients are still running
+	iThreadsRunning++;
+
+	LPBTA2DPPERDEVICEDATA lpDevice =3D (LPBTA2DPPERDEVICEDATA) param;
+	pthread_detach(lpDevice->thread);
=20
-        LPBTA2DPPERDEVICEDATA lpDevice =3D (LPBTA2DPPERDEVICEDATA)param;
-        pthread_detach(lpDevice->thread);
+	// As long as daemon is running
+	printf("avrcp: Accepting incoming connection\n");
+	while (!bSigINTReceived) {
+		int sockfd =3D a2dp_make_listen_socket(23);
+		if (sockfd >=3D 0) {
+			while (!bSigINTReceived) {
+				// Wait for incoming connections
+				char szRemote[64];
+				uint16_t iMTU =3D 0;
+
+				int new_fd =3D a2dp_wait_connection(sockfd, szRemote,
+								  sizeof(szRemote),
+								  &iMTU);
+
+				if (new_fd > 0) {
+					printf("avrcp: socket %d: Connection from %s, mtu=3D%d\n", new_fd, =
szRemote, iMTU);
+					// Loop and manage what the client sends
+					setup_socket(new_fd);
+					int iReceived =3D 0;
+					do {
+						printf("avrcp: socket %d: Reading from %s, mtu=3D%d\n", new_fd, sz=
Remote, iMTU);
+						errno =3D 0;
+						iReceived =3D a2dp_handle_avrcp_message(new_fd);
+					}
+					// AVRCP need device connected
+					while (g_nbdeviceconnected && !bSigINTReceived && (iReceived > 0 ||=
 errno =3D=3D EAGAIN));
+					printf("avrcp: socket %d: timed out\n", new_fd);
+					close_socket(new_fd);
+				} else if (errno !=3D EAGAIN) {
+					printf("a2dp_wait_connection failed (AVRCP socket) : %d (errno=3D%d=
:%s)\n", new_fd, errno, strerror(errno));
+					break;
+				}
+			}
=20
-        // As long as daemon is running
-        printf("avrcp: Accepting incoming connection\n");
-        while(!bSigINTReceived)
-        {
-                int sockfd =3D a2dp_make_listen_socket( 23);
-                if(sockfd>=3D0)
-                {
-                        while(!bSigINTReceived)
-                        {
-                                // Wait for incoming connections
-                                char szRemote[64];
-                                uint16_t iMTU =3D 0;
-
-                                int new_fd =3D a2dp_wait_connection(sock=
fd, szRemote, sizeof(szRemote), &iMTU);
-
-                                if(new_fd>0)
-                                {
-                                        printf("avrcp: socket %d: Connec=
tion from %s, mtu=3D%d\n", new_fd, szRemote, iMTU);
-                                        // Loop and manage what the clie=
nt sends
-                                        setup_socket(new_fd);
-                                        int iReceived =3D 0;
-                                        do
-                                        {
-                                                iReceived =3D a2dp_handl=
e_avrcp_message(new_fd);
-                                        }
-                                        // AVRCP need device connected
-                                        while(g_nbdeviceconnected && !bS=
igINTReceived && (iReceived>0 || errno=3D=3DEAGAIN));
-                                        printf("avrcp: socket %d: timed =
out\n", new_fd);
-                                        close_socket(new_fd);
-                                }
-                                else
-                                {
-                                        if(errno!=3DEAGAIN)
-                                        {
-                                                printf("a2dp_wait_connec=
tion failed (AVRCP socket) : %d (errno=3D%d:%s)\n", new_fd, errno, strerr=
or(errno));
-                                                break;
-                                        }
-                                }
-                        }
-
-                        close_socket(sockfd);
-                }
-
-                // Sleep a little bit if we must retry
-                sleep(bSigINTReceived?1:0);
-        }
+			close_socket(sockfd);
+		}
+		// Sleep a little bit if we must retry
+		sleep(bSigINTReceived ? 1 : 0);
+	}
=20
-        iThreadsRunning --;
+	iThreadsRunning--;
=20
-        return 0;
+	return 0;
 }
=20
 // server processing loop
-void main_loop(char* addr)
+void main_loop(char *addr)
 {
-        while(!bSigINTReceived)
-        {
-                // Master socket
-                int sockfd =3D make_server_socket();
-
-                if(sockfd>0)
-                {
-                        LPBTA2DPPERDEVICEDATA lpDevice =3D bta2dpdevicen=
ew(addr);
-                        // Set pthread stack size to decrease unused mem=
ory usage
-                        pthread_attr_t tattr;
-                        size_t size =3D PTHREAD_STACK_MIN;
-                        int ret =3D pthread_attr_init(&tattr);
-                        ret =3D pthread_attr_setstacksize(&tattr, size);
-                        pthread_create(&lpDevice->thread, &tattr, bt_han=
dler,  lpDevice);
-                        pthread_create(&lpDevice->thread, &tattr, avrcp_=
listener, lpDevice);
-                        pthread_create(&lpDevice->thread, &tattr, avdtp_=
listener, lpDevice);
-
-                        while(!bSigINTReceived)
-                        {
-                                int new_fd =3D -1;
-                                printf("Accepting incoming tcp stream co=
nnection\n");
-                                new_fd=3Daccept_socket(sockfd);
-                                printf("Accepted %d\n", new_fd);
-
-                                // Handle connection if it is not the fi=
nal dummy client
-                                if(!bSigINTReceived)
-                                {
-                                        LPA2DPDCLIENT lpClient =3D mallo=
c(sizeof(A2DPDCLIENT));
-                                        lpClient->lpDevice =3D lpDevice;
-                                        lpClient->sockfd =3D new_fd;
-                                       =20
-                                        pthread_mutex_lock(&lpClient->lp=
Device->mutex);
-                                        lpClient->lpDevice->nb_clients++=
;
-                                        pthread_mutex_unlock(&lpClient->=
lpDevice->mutex);
-                                       =20
-                                        pthread_create(&lpClient->thread=
, &tattr, client_handler, lpClient);
-                                }
-                                else
-                                {
-                                        close_socket(new_fd);
-                                }
-                                usleep(10000);
-                        }
-       =20
-                        close_socket(sockfd);
-       =20
-                        // Very minor race condition here
-                        // No dramatic consequences
-                        // But we Must wait all client termination
-                        // We will pthread_join one day
-                        int icount =3D 0;
-                        while(iThreadsRunning>0 && icount<30)
-                        {
-                                printf("A2DPD still %d clients running\n=
", iThreadsRunning);
-                                icount++;
-                                sleep(1);
-                        }
-       =20
-                        // Free informations on the device
-                        bta2dpdevicefree(lpDevice);
-                        pthread_attr_destroy(&tattr);
-                }
-                else
-                {
-                        printf("Error %d: cannot get the socket errno=3D=
%d (%s)\n", sockfd, errno, strerror(errno));
-                }
+	while (!bSigINTReceived) {
+		// Master socket
+		int sockfd =3D make_server_socket();
+
+		if (sockfd > 0) {
+			LPBTA2DPPERDEVICEDATA lpDevice =3D bta2dpdevicenew(addr);
+			// Set pthread stack size to decrease unused memory usage
+			pthread_attr_t tattr;
+			pthread_t havrcp, havdtp;
+			size_t size =3D PTHREAD_STACK_MIN;
+			int ret =3D pthread_attr_init(&tattr);
+			ret =3D pthread_attr_setstacksize(&tattr, size);
+			pthread_create(&lpDevice->thread, &tattr, bt_handler, lpDevice);
+			if (g_bavrcp)
+				pthread_create(&havrcp, &tattr, avrcp_listener, lpDevice);
+			if (g_bavrcp)
+				pthread_create(&havdtp, &tattr, avdtp_listener, lpDevice);
+
+			while (!bSigINTReceived) {
+				int new_fd =3D -1;
+				printf("main_thread:Accepting incoming tcp stream connection\n");
+				new_fd =3D accept_socket(sockfd);
+				printf("main_thread: Accepted %d\n", new_fd);
+
+				// Handle connection if it is not the final dummy client
+				if (!bSigINTReceived && new_fd > 0) {
+					LPA2DPDCLIENT lpClient =3D malloc(sizeof(A2DPDCLIENT));
+					lpClient->lpDevice =3D lpDevice;
+					lpClient->sockfd =3D new_fd;
+
+					pthread_mutex_lock(&lpClient->lpDevice->mutex);
+					lpClient->lpDevice->nb_clients++;
+					pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+
+					pthread_create(&lpClient->thread, &tattr, client_handler, lpClient)=
;
+				} else if (new_fd > 0) {
+					close_socket(new_fd);
+				}
+				usleep(10000);
+			}
+
+			close_socket(sockfd);
+
+			// Very minor race condition here
+			// No dramatic consequences
+			// But we Must wait all client termination
+			// We will pthread_join one day
+			int icount =3D 0;
+			while (iThreadsRunning > 0 && icount < 30) {
+				printf("A2DPD still %d clients running\n", iThreadsRunning);
+				icount++;
+				sleep(1);
+			}
+
+			// Free informations on the device
+			bta2dpdevicefree(lpDevice);
+			pthread_attr_destroy(&tattr);
+		} else {
+			printf("Error %d: cannot get the socket errno=3D%d (%s)\n", sockfd, e=
rrno, strerror(errno));
+		}
=20
-                sleep(1);
-        }
+		sleep(1);
+	}
 }
=20
=20
@@ -1045,90 +1004,73 @@
 // main function
 int main(int argc, char *argv[])
 {
-        int i =3D 0;
-	int fd;
-        struct timespec timer_resolution =3D { 0, 0 };
-        char address[256] =3D "";
-        char* addr =3D &address[0];
-        char* sonorix=3D"00:0A:56:00:C0:C2";
-        //char* iphono420=3D "C2:00:08:F4:30:07:64";
-        //char* hpheadphone=3D "00:0D:44:2A:17:C7";
-        struct sched_param schedparam =3D { sched_get_priority_max(SCHED=
_FIFO) };
-        int res=3D0,  bFork=3D0, bVerbose=3D1, bKill=3D0;
+	int i =3D 0;
+	struct timespec timer_resolution =3D { 0, 0 };
+	char address[256] =3D "";
+	char *addr =3D &address[0];
+	char *sonorix =3D "00:0A:56:00:C0:C2";
+	//char* iphono420=3D "C2:00:08:F4:30:07:64";
+	//char* hpheadphone=3D "00:0D:44:2A:17:C7";
+	struct sched_param schedparam =3D { sched_get_priority_max(SCHED_FIFO) =
};
+	int res =3D 0, bFork =3D 0, bVerbose =3D 1, bKill =3D 0, fd =3D 0;
 	FILE *fp;
 	pid_t pid;
=20
-        // Read config values from config file
-        get_config_filename(g_srcfilename, sizeof(g_srcfilename));
-        read_config_string(g_srcfilename, "a2dpd", "address",  address, =
    sizeof(address),     sonorix);
-        read_config_string(g_srcfilename, "a2dpd", "cmdplay",  g_sCmdPla=
y,  sizeof(g_sCmdPlay),  "");
-        read_config_string(g_srcfilename, "a2dpd", "cmdpause", g_sCmdPau=
se, sizeof(g_sCmdPause), "");
-        read_config_string(g_srcfilename, "a2dpd", "cmdprev",  g_sCmdPre=
v,  sizeof(g_sCmdPrev),  "");
-        read_config_string(g_srcfilename, "a2dpd", "cmdnext",  g_sCmdNex=
t,  sizeof(g_sCmdNext),  "");
-        read_config_string(g_srcfilename, "a2dpd", "cmdnew",   g_sCmdNew=
,   sizeof(g_sCmdNew),  "");
-        read_config_string(g_srcfilename, "a2dpd", "logfile",  g_sOutput=
Filename,  sizeof(g_sOutputFilename),  "/dev/null");
-
-        // Parse command line parameters
-        for(i=3D1; i<argc && argv[i]!=3DNULL; i++)
-        {
-                char c;
-                // Search a bluetooth addr
-                if(sscanf(argv[i], "%c%c:%c%c:%c%c:%c%c:%c%c:%c%c", &c, =
&c, &c, &c, &c, &c, &c, &c, &c, &c, &c, &c)=3D=3D12)
-                {
-                        addr=3Dargv[i];
-                }
-                else if(!strcmp(argv[i], "-n"))
-                {
-                        bFork=3D0;
-                }
-                else if(!strcmp(argv[i], "-d"))
-                {
-                        bFork=3D1;
-                }
-                else if(!strcmp(argv[i], "-v"))
-                {
-                        bVerbose=3D1;
-                }
-		else if(!strcmp(argv[i], "-k"))
-		{
-			bKill=3D1;
-		}
-                else if(!strcmp(argv[i], "+n"))
-                {
-                        bFork=3D1;
-                }
-                else if(!strcmp(argv[i], "+d"))
-                {
-                        bFork=3D0;
-                }
-                else if(!strcmp(argv[i], "+v"))
-                {
-                        bVerbose=3D0;
-                }
-                else
-                {
-                        printf("Parameter not handled: %s\r\n", argv[i])=
;
-                }
-        }
-        clock_getres(CLOCK_REALTIME, &timer_resolution);
-
-	init_uinput ();
-
-        ignore_child_processes_return_values();
-       =20
-        // Redirect outputs
-        make_daemon_process(bFork, bVerbose, g_sOutputFilename);
+	// Read config values from config file
+	get_config_filename(g_srcfilename, sizeof(g_srcfilename));
+	read_config_string(g_srcfilename, "a2dpd", "address", address, sizeof(a=
ddress), sonorix);
+	read_config_string(g_srcfilename, "a2dpd", "cmdplay", g_sCmdPlay, sizeo=
f(g_sCmdPlay), "");
+	read_config_string(g_srcfilename, "a2dpd", "cmdpause", g_sCmdPause, siz=
eof(g_sCmdPause), "");
+	read_config_string(g_srcfilename, "a2dpd", "cmdprev", g_sCmdPrev, sizeo=
f(g_sCmdPrev), "");
+	read_config_string(g_srcfilename, "a2dpd", "cmdnext", g_sCmdNext, sizeo=
f(g_sCmdNext), "");
+	read_config_string(g_srcfilename, "a2dpd", "cmdnew", g_sCmdNew, sizeof(=
g_sCmdNew), "");
+	read_config_string(g_srcfilename, "a2dpd", "logfile", g_sOutputFilename=
, sizeof(g_sOutputFilename), "/dev/null");
+	g_brereadconfig =3D read_config_int(g_srcfilename, "a2dpd", "enablerere=
adconfig", 1);
+	g_breversestereo =3D read_config_int(g_srcfilename, "a2dpd", "enablerev=
ersestereo", 0);
+	g_bavrcp =3D read_config_int(g_srcfilename, "a2dpd", "enableavrcp", 1);
+
+	// Parse command line parameters
+	for (i =3D 1; i < argc && argv[i] !=3D NULL; i++) {
+		char c;
+		// Search a bluetooth addr
+		if (sscanf(argv[i], "%c%c:%c%c:%c%c:%c%c:%c%c:%c%c", &c, &c, &c, &c, &=
c, &c, &c, &c, &c, &c, &c, &c) =3D=3D 12) {
+			addr =3D argv[i];
+		} else if (!strcmp(argv[i], "-n")) {
+			bFork =3D 0;
+		} else if (!strcmp(argv[i], "-d")) {
+			bFork =3D 1;
+		} else if (!strcmp(argv[i], "-v")) {
+			bVerbose =3D 1;
+		} else if (!strcmp(argv[i], "-k")) {
+			bKill =3D 1;
+		} else if (!strcmp(argv[i], "+n")) {
+			bFork =3D 1;
+		} else if (!strcmp(argv[i], "+d")) {
+			bFork =3D 0;
+		} else if (!strcmp(argv[i], "+v")) {
+			bVerbose =3D 0;
+		} else {
+			printf("Parameter not handled: %s\r\n", argv[i]);
+		}
+	}
+	clock_getres(CLOCK_REALTIME, &timer_resolution);
+
+	init_uinput();
=20
+	ignore_child_processes_return_values();
+
+	// Redirect outputs
+	make_daemon_process(bFork, bVerbose, g_sOutputFilename);
 	// Generate the lockfile
 	fd =3D open(PIDFILE, O_RDWR | O_CREAT | O_EXCL, S_IWUSR | S_IRUSR | S_I=
RGRP | S_IROTH);
=20
 	if (fd =3D=3D -1) {
-		if (errno !=3D EEXIST) // If we can't write the lock, then ignore
+		if (errno !=3D EEXIST)	// If we can't write the lock, then ignore
 			goto post_lock;
-	=09
+
 		if ((fd =3D open(PIDFILE, O_RDWR)) < 0)
 			goto post_lock;
-	=09
+
 		fp =3D fdopen(fd, "rw");
 		if (fp =3D=3D NULL)
 			goto post_lock;
@@ -1136,25 +1078,24 @@
 		pid =3D -1;
 		if ((fscanf(fp, "%d", &pid) !=3D 1) || (pid =3D=3D getpid())
 		    || (lock_fd(fileno(fp)) =3D=3D 0)) {
-			unlink (PIDFILE);
+			unlink(PIDFILE);
 		} else {
 			if (bKill) {
-				kill (pid, 15);
-				sleep (5); // let the other daemon die
+				kill(pid, 15);
+				sleep(5);	// let the other daemon die
 			} else
 				goto shutdown;
 		}
 		fclose(fp);
=20
 		unlink(PIDFILE);
-		fd =3D open(PIDFILE, O_RDWR | O_CREAT | O_EXCL,
-			  S_IWUSR | S_IRUSR | S_IRGRP | S_IROTH);
+		fd =3D open(PIDFILE, O_RDWR | O_CREAT | O_EXCL, S_IWUSR | S_IRUSR | S_=
IRGRP | S_IROTH);
=20
 		if (fd =3D=3D -1)
 			goto post_lock;
-	=09
+
 	}
-=09
+
 	lock_fd(fd);
=20
 	fp =3D fdopen(fd, "w");
@@ -1162,31 +1103,30 @@
 	fflush(fp);
 	fcntl(fd, F_SETFD, (long) 1);
=20
- post_lock:
-        printf("%s addr=3D%s timer=3D%d us [%s %s]\n", argv[0], addr, (i=
nt)(timer_resolution.tv_nsec/1000), __DATE__, __TIME__);
+      post_lock:
+	printf("%s addr=3D%s timer=3D%d us [%s %s]\n", argv[0], addr, (int) (ti=
mer_resolution.tv_nsec / 1000), __DATE__, __TIME__);
=20
-        // If we can be realtime it will be better
-        res =3D sched_setscheduler(0, SCHED_FIFO, &schedparam);=20
-        printf("setscheduler returns %d (errno=3D%d:%s)\n", res, errno, =
strerror(errno));
+	// If we can be realtime it will be better
+	res =3D sched_setscheduler(0, SCHED_FIFO, &schedparam);
+	printf("setscheduler returns %d (errno=3D%d:%s)\n", res, errno, strerro=
r(errno));
=20
-        // set up the handler
-        signal(SIGINT, sigint_handler);
-        signal(SIGTERM, sigint_handler);
+	// set up the handler
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
=20
-        // global initialisations
-        a2dp_init();
+	// global initialisations
+	a2dp_init();
=20
-        // Run main loop
-        main_loop(addr);
+	// Run main loop
+	main_loop(addr);
=20
-        // global free
-        a2dp_exit();
+	// global free
+	a2dp_exit();
=20
 	kill_uinput();
=20
-shutdown:
-        printf("A2DPD terminated succesfully\n");
+      shutdown:
+	printf("A2DPD terminated succesfully\n");
=20
-        return 0;
+	return 0;
 }
-
Index: alsa-plugins/a2dpd_protocol.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd_protocol.h,v
retrieving revision 1.3
diff -u -r1.3 a2dpd_protocol.h
--- alsa-plugins/a2dpd_protocol.h	17 Aug 2006 14:06:27 -0000	1.3
+++ alsa-plugins/a2dpd_protocol.h	31 Aug 2006 15:58:57 -0000
@@ -26,12 +26,11 @@
=20
=20
 // parameters used to describe device state
-typedef struct
-{
-        int16_t                     volume_speaker_right;
-        int16_t                     volume_speaker_left;
-        int16_t                     volume_micro_right;
-        int16_t                     volume_micro_left;
+typedef struct {
+	int16_t volume_speaker_right;
+	int16_t volume_speaker_left;
+	int16_t volume_micro_right;
+	int16_t volume_micro_left;
 } AUDIOMIXERDATA;
=20
 #define INVALIDAUDIOMIXERDATA   { -1, -1, -1, -1 }
@@ -44,8 +43,8 @@
 #define A2DPD_VOLUME_MIN        0
 #define A2DPD_VOLUME_MAX        15
=20
-#define A2DPD_FRAME_BYTES       4 // 16bits * 2 channels
-#define A2DPD_FRAME_RATE        44100 // Can be 32000, tested with HP, i=
Phono and needed Sonorix, but quality decreases, 48000 nearly never works
+#define A2DPD_FRAME_BYTES       4	// 16bits * 2 channels
+#define A2DPD_FRAME_RATE        44100	// Can be 32000, tested with HP, i=
Phono and needed Sonorix, but quality decreases, 48000 nearly never works
 // a2dp->sbc.channels*44100*2/(size*a2dp->frame_bytes);
 // 344.53125=3Dchannels*freq*16 bits/sizeof(buf)
 #define A2DPD_BLOCK_SIZE        (512*1)
Index: alsa-plugins/a2dplib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dplib.c,v
retrieving revision 1.5
diff -u -r1.5 a2dplib.c
--- alsa-plugins/a2dplib.c	30 Aug 2006 14:43:21 -0000	1.5
+++ alsa-plugins/a2dplib.c	31 Aug 2006 15:58:57 -0000
@@ -79,7 +79,7 @@
 #define A2DP_SERVICE_NAME	"A2DP Audio Source"
 #define A2DP_VERSION        0x0100
=20
-static struct sigaction        actions;
+static struct sigaction actions;
 /*
 sdp_record_t* a2dp_advertise_sdp(sdp_session_t* sdpSessionP)
 {
@@ -158,1128 +158,1026 @@
 void a2dp_init(void) __attribute__ ((constructor));
 void a2dp_exit(void) __attribute__ ((destructor));
 */
-void memcpy_changeendian( void* dst, const void *src, int size)
+void memcpy_changeendian(void *dst, const void *src, int size)
 {
-        int i;
-        const uint16_t* ptrsrc=3Dsrc;
-        uint16_t* ptrdst=3Ddst;
-        for(i =3D 0; i < size/2; i ++)
-        {
-                *ptrdst++ =3D htons(*ptrsrc++);
-        }
+	int i;
+	const uint16_t *ptrsrc =3D src;
+	uint16_t *ptrdst =3D dst;
+	for (i =3D 0; i < size / 2; i++) {
+		*ptrdst++ =3D htons(*ptrsrc++);
+	}
 }
=20
 // Prepare packet headers
-void init_request(struct avdtp_header * header, int request_id)
+void init_request(struct avdtp_header *header, int request_id)
 {
-        static int transaction =3D 0;
+	static int transaction =3D 0;
=20
-        header->packet_type =3D PACKET_TYPE_SINGLE;
-        header->message_type =3D MESSAGE_TYPE_COMMAND;
-        header->transaction_label =3D transaction;
-        header->signal_id =3D request_id;
+	header->packet_type =3D PACKET_TYPE_SINGLE;
+	header->message_type =3D MESSAGE_TYPE_COMMAND;
+	header->transaction_label =3D transaction;
+	header->signal_id =3D request_id;
=20
-        // clear rfa bits
-        header->rfa0 =3D 0;
+	// clear rfa bits
+	header->rfa0 =3D 0;
=20
-        transaction =3D (transaction + 1) & 0xf;
+	transaction =3D (transaction + 1) & 0xf;
 }
=20
 // Analyse the SEIDs the sink has sent to us
-int process_seid(int s, struct acp_seid_info * get_seid_resp, unsigned s=
hort *psm, sbc_t *sbc)
+int process_seid(int s, struct acp_seid_info *get_seid_resp, unsigned sh=
ort *psm, sbc_t * sbc)
 {
-        int v, size;
-        int seid =3D get_seid_resp->acp_seid;
-        struct getcap_req put_req;
-        struct getcap_resp cap_resp;
-        struct set_config s_config;
-        struct set_config_resp s_resp;
-        struct stream_cmd open_stream;
-        struct open_stream_rsp open_resp;
-
-        memset(&put_req, 0, sizeof(put_req));
-        init_request(&put_req.header, AVDTP_GET_CAPABILITIES);
-        put_req.acp_seid =3D seid;
+	int v, size;
+	int seid =3D get_seid_resp->acp_seid;
+	struct getcap_req put_req;
+	struct getcap_resp cap_resp;
+	struct set_config s_config;
+	struct set_config_resp s_resp;
+	struct stream_cmd open_stream;
+	struct open_stream_rsp open_resp;
+
+	memset(&put_req, 0, sizeof(put_req));
+	init_request(&put_req.header, AVDTP_GET_CAPABILITIES);
+	put_req.acp_seid =3D seid;
+
+	if (write(s, &put_req, sizeof(put_req)) !=3D sizeof(put_req)) {
+		DBG("Couldn't request capabilities for SEID =3D %d", seid);
+		return (-1);
+	}
=20
-        if (write(s, &put_req, sizeof(put_req)) !=3D sizeof(put_req))
-        {
-                DBG("Couldn't request capabilities for SEID =3D %d", sei=
d);
-                return (-1);
-        }
+	if (read(s, &cap_resp, sizeof(cap_resp)) < sizeof(cap_resp) ||
+	    cap_resp.header.message_type =3D=3D MESSAGE_TYPE_REJECT || cap_resp=
.media_type !=3D AUDIO_MEDIA_TYPE || cap_resp.media_codec_type !=3D SBC_M=
EDIA_CODEC_TYPE) {
+		DBG("Didn't receive SBC codec parameters (first) for SEID =3D %d", sei=
d);
+		return (-1);
+	}
=20
-        if (read(s, &cap_resp, sizeof(cap_resp)) < sizeof(cap_resp) ||
-                        cap_resp.header.message_type =3D=3D MESSAGE_TYPE=
_REJECT ||
-                        cap_resp.media_type !=3D AUDIO_MEDIA_TYPE ||
-                        cap_resp.media_codec_type !=3D SBC_MEDIA_CODEC_T=
YPE) {
-                DBG("Didn't receive SBC codec parameters (first) for SEI=
D =3D %d", seid);
-                return (-1);
-        }
+	DBG("Got capabilities response:\nservcap_cap=3D%d, servcap_len=3D%d,\nc=
ap_type=3D%d, length=3D%d, media_type=3D%d, codec=3D%d",
+	    cap_resp.serv_cap, cap_resp.serv_cap_len, cap_resp.cap_type, cap_re=
sp.length, cap_resp.media_type, cap_resp.media_codec_type);
=20
-        DBG("Got capabilities response:\nservcap_cap=3D%d, servcap_len=3D=
%d,\ncap_type=3D%d, length=3D%d, media_type=3D%d, codec=3D%d",
-                cap_resp.serv_cap,
-                cap_resp.serv_cap_len,
-                cap_resp.cap_type,
-                cap_resp.length,
-                cap_resp.media_type,
-                cap_resp.media_codec_type
-        );
-
-        memset(&s_config, 0, sizeof(s_config));
-        init_request(&s_config.header, AVDTP_SET_CONFIGURATION);
-        s_config.serv_cap =3D MEDIA_TRANSPORT_CATEGORY;
-        s_config.acp_seid =3D seid;
-        s_config.int_seid =3D 1;	//FIXME how should I choose the int_sei=
d??
-        s_config.cap_type =3D MEDIA_CODEC;
-        s_config.length =3D 6;
-        s_config.media_type =3D AUDIO_MEDIA_TYPE;
-        s_config.media_codec_type =3D SBC_MEDIA_CODEC_TYPE;
-
-        switch(sbc->channels) {
-        case 1:
-                v =3D 8;
-                break;
-        case 2:
-        default:
-                v =3D 2;
-                break;
-        }
-        s_config.codec_elements.sbc_elements.channel_mode =3D v;
+	memset(&s_config, 0, sizeof(s_config));
+	init_request(&s_config.header, AVDTP_SET_CONFIGURATION);
+	s_config.serv_cap =3D MEDIA_TRANSPORT_CATEGORY;
+	s_config.acp_seid =3D seid;
+	s_config.int_seid =3D 1;	//FIXME how should I choose the int_seid??
+	s_config.cap_type =3D MEDIA_CODEC;
+	s_config.length =3D 6;
+	s_config.media_type =3D AUDIO_MEDIA_TYPE;
+	s_config.media_codec_type =3D SBC_MEDIA_CODEC_TYPE;
+
+	switch (sbc->channels) {
+	case 1:
+		v =3D 8;
+		break;
+	case 2:
+	default:
+		v =3D 2;
+		break;
+	}
+	s_config.codec_elements.sbc_elements.channel_mode =3D v;
=20
-        switch(sbc->rate) {
-        case 16000:
-                v =3D 8;
-                break;
-        case 32000:
-                v =3D 4;
-                break;
-        case 48000:
-                v =3D 1;
-                break;
-        case 44100:
-        default:
-                v =3D 2;=20
-                break;
-        }
-        s_config.codec_elements.sbc_elements.frequency =3D v;
-        s_config.codec_elements.sbc_elements.allocation_method =3D 1 << =
1;
+	switch (sbc->rate) {
+	case 16000:
+		v =3D 8;
+		break;
+	case 32000:
+		v =3D 4;
+		break;
+	case 48000:
+		v =3D 1;
+		break;
+	case 44100:
+	default:
+		v =3D 2;
+		break;
+	}
+	s_config.codec_elements.sbc_elements.frequency =3D v;
+	s_config.codec_elements.sbc_elements.allocation_method =3D 1 << 1;
=20
-        switch(sbc->subbands) {
-        case 4:
-                v =3D 2;
-                break;
-        case 8:
-        default:
-                v =3D 1;
-                break;
-        }
-        s_config.codec_elements.sbc_elements.subbands =3D v;
+	switch (sbc->subbands) {
+	case 4:
+		v =3D 2;
+		break;
+	case 8:
+	default:
+		v =3D 1;
+		break;
+	}
+	s_config.codec_elements.sbc_elements.subbands =3D v;
=20
-        switch(sbc->blocks) {
-        case 4:
-                v =3D 8;
-                break;
-        case 8:
-                v =3D 4;
-                break;
-        case 12:
-                v =3D 2;
-                break;
-        case 16:
-        default:
-                v =3D 1;
-                break;
-        }
-        s_config.codec_elements.sbc_elements.block_length =3D v;
-        s_config.codec_elements.sbc_elements.min_bitpool =3D cap_resp.co=
dec_elements.sbc_elements.min_bitpool;
-        s_config.codec_elements.sbc_elements.max_bitpool =3D cap_resp.co=
dec_elements.sbc_elements.max_bitpool;
+	switch (sbc->blocks) {
+	case 4:
+		v =3D 8;
+		break;
+	case 8:
+		v =3D 4;
+		break;
+	case 12:
+		v =3D 2;
+		break;
+	case 16:
+	default:
+		v =3D 1;
+		break;
+	}
+	s_config.codec_elements.sbc_elements.block_length =3D v;
+	s_config.codec_elements.sbc_elements.min_bitpool =3D cap_resp.codec_ele=
ments.sbc_elements.min_bitpool;
+	s_config.codec_elements.sbc_elements.max_bitpool =3D cap_resp.codec_ele=
ments.sbc_elements.max_bitpool;
=20
-        if (!(cap_resp.codec_elements.sbc_elements.channel_mode & s_conf=
ig.codec_elements.sbc_elements.channel_mode)) {
-                DBG("headset does not support this channel mode");
-        }
+	if (!(cap_resp.codec_elements.sbc_elements.channel_mode & s_config.code=
c_elements.sbc_elements.channel_mode)) {
+		DBG("headset does not support this channel mode");
+	}
=20
-        if (!(cap_resp.codec_elements.sbc_elements.frequency & s_config.=
codec_elements.sbc_elements.frequency)) {
-                DBG("headset does not support this frequency");
-        }
+	if (!(cap_resp.codec_elements.sbc_elements.frequency & s_config.codec_e=
lements.sbc_elements.frequency)) {
+		DBG("headset does not support this frequency");
+	}
=20
-        if (!(cap_resp.codec_elements.sbc_elements.allocation_method & s=
_config.codec_elements.sbc_elements.allocation_method)) {
-                DBG("headset does not support this allocation_method");
-        }
+	if (!(cap_resp.codec_elements.sbc_elements.allocation_method & s_config=
.codec_elements.sbc_elements.allocation_method)) {
+		DBG("headset does not support this allocation_method");
+	}
=20
-        if (!(cap_resp.codec_elements.sbc_elements.subbands & s_config.c=
odec_elements.sbc_elements.subbands)) {
-                DBG("headset does not support this subbands setting");
-        }
+	if (!(cap_resp.codec_elements.sbc_elements.subbands & s_config.codec_el=
ements.sbc_elements.subbands)) {
+		DBG("headset does not support this subbands setting");
+	}
=20
-        if (write(s, &s_config, sizeof(s_config)) !=3D sizeof(s_config))=
 {
-                DBG("couldn't set config seid =3D %d", seid);
-                return (-1);
-        }
+	if (write(s, &s_config, sizeof(s_config)) !=3D sizeof(s_config)) {
+		DBG("couldn't set config seid =3D %d", seid);
+		return (-1);
+	}
=20
-        size =3D read(s, &s_resp, sizeof(s_resp));
-        DBG("Got Set Configurations Response (%d bytes:msgtype=3D%d,pktt=
ype=3D%d,lbl=3D%d,sig=3D%d,rfa=3D%d)",=20
-                size,
-                s_resp.header.message_type,
-                s_resp.header.packet_type,
-                s_resp.header.transaction_label,
-                s_resp.header.signal_id,
-                s_resp.header.rfa0);
-       =20
-        memset(&open_stream, 0, sizeof(open_stream));
-        init_request(&open_stream.header, AVDTP_OPEN);
-        open_stream.acp_seid =3D seid;
-
-        if (write(s, &open_stream, sizeof(open_stream)) !=3D sizeof(open=
_stream)) {
-                DBG("Couldn't open stream SEID =3D %d", seid);
-                return (-1);
-        }
+	size =3D read(s, &s_resp, sizeof(s_resp));
+	DBG("Got Set Configurations Response (%d bytes:msgtype=3D%d,pkttype=3D%=
d,lbl=3D%d,sig=3D%d,rfa=3D%d)",
+	    size, s_resp.header.message_type, s_resp.header.packet_type, s_resp=
.header.transaction_label, s_resp.header.signal_id, s_resp.header.rfa0);
+
+	memset(&open_stream, 0, sizeof(open_stream));
+	init_request(&open_stream.header, AVDTP_OPEN);
+	open_stream.acp_seid =3D seid;
+
+	if (write(s, &open_stream, sizeof(open_stream)) !=3D sizeof(open_stream=
)) {
+		DBG("Couldn't open stream SEID =3D %d", seid);
+		return (-1);
+	}
=20
-        if (read(s, &open_resp, sizeof(open_resp)) < sizeof(open_resp) -=
 1 ||
-                        open_resp.header.message_type =3D=3D MESSAGE_TYP=
E_REJECT) {
-                DBG("Didn't receive open response confirm for SEID =3D %=
d", seid);
-                return (-1);
-        }
+	if (read(s, &open_resp, sizeof(open_resp)) < sizeof(open_resp) - 1 || o=
pen_resp.header.message_type =3D=3D MESSAGE_TYPE_REJECT) {
+		DBG("Didn't receive open response confirm for SEID =3D %d", seid);
+		return (-1);
+	}
=20
-        *psm =3D 25;
-        return 0;
+	*psm =3D 25;
+	return 0;
 }
=20
 int test_sdp(dst)
 {
 	int result =3D 0;
-=09
+
 	return result;
 }
=20
 // Connecting on PSM 25
-int do_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm, uint16_=
t *mtu)
+int do_connect(bdaddr_t * src, bdaddr_t * dst, unsigned short psm, uint1=
6_t * mtu)
 {
-        struct sockaddr_l2 addr;
-        struct l2cap_options opts;
-        int sk;
-        unsigned int opt;
-        int tries;
-
-        sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
-        if (sk < 0) {
-                DBG( "Can't create socket. %s(%d)",
-                        strerror(errno), errno);
-                return -1;
-        }
-
-        // Set connection timeout
-        struct timeval t =3D { 3, 0 };
-        setsockopt( sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
-        setsockopt( sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
-
-        memset(&addr, 0, sizeof(addr));
-        addr.l2_family =3D AF_BLUETOOTH;
-        bacpy(&addr.l2_bdaddr, src);
-        if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-                DBG( "Can't bind socket. %s(%d)",
-                                                strerror(errno), errno);
-                return -1;
-        }
-
-        /* Get default options */
-        opt =3D sizeof(opts);
-        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
-                DBG( "Can't get default L2CAP options. %s(%d)",
-                                                strerror(errno), errno);
-                return -1;
-        }
+	struct sockaddr_l2 addr;
+	struct l2cap_options opts;
+	int sk;
+	unsigned int opt;
+	int tries;
+
+	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	if (sk < 0) {
+		DBG("Can't create socket. %s(%d)", strerror(errno), errno);
+		return -1;
+	}
+	// Set connection timeout
+	struct timeval t =3D { 3, 0 };
+	setsockopt(sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
+	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.l2_family =3D AF_BLUETOOTH;
+	bacpy(&addr.l2_bdaddr, src);
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		DBG("Can't bind socket. %s(%d)", strerror(errno), errno);
+		return -1;
+	}
=20
-        /* Set new options */
-        if(mtu && *mtu) {
-                opts.omtu =3D *mtu;
-                //opts.imtu =3D *mtu;
-        }
-        if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
-                DBG( "Can't set L2CAP options. %s(%d)",
-                                                strerror(errno), errno);
-                return -1;
-        }
+	/* Get default options */
+	opt =3D sizeof(opts);
+	if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
+		DBG("Can't get default L2CAP options. %s(%d)", strerror(errno), errno)=
;
+		return -1;
+	}
=20
-        memset(&addr, 0, sizeof(addr));
-        addr.l2_family =3D AF_BLUETOOTH;
-        bacpy(&addr.l2_bdaddr, dst);
-        addr.l2_psm =3D htobs(psm);
-
-        tries =3D 0;
-        while (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0)=
 {
-                DBG("Can't connect to %s on psm %d. %s(%d)",
-                                batostr(&addr.l2_bdaddr), psm, strerror(=
errno), errno);
-                if(++tries > NBSDPRETRIESMAX) {
-                        close(sk);
-                        return -1;
-                }
-                sleep(1);
-        }
-        opt =3D sizeof(opts);
-        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
-                DBG( "Can't get L2CAP options. %s(%d)",
-                                                strerror(errno), errno);
-                close(sk);
-                return -1;
-        }
+	/* Set new options */
+	if (mtu && *mtu) {
+		opts.omtu =3D *mtu;
+		//opts.imtu =3D *mtu;
+	}
+	if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
+		DBG("Can't set L2CAP options. %s(%d)", strerror(errno), errno);
+		return -1;
+	}
=20
-        //DBG( "Connected psm=3D%d sk=3D%d [imtu %d, omtu %d, flush_to %=
d]", psm, sk, opts.imtu, opts.omtu, opts.flush_to);
+	memset(&addr, 0, sizeof(addr));
+	addr.l2_family =3D AF_BLUETOOTH;
+	bacpy(&addr.l2_bdaddr, dst);
+	addr.l2_psm =3D htobs(psm);
+
+	tries =3D 0;
+	while (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		DBG("Can't connect to %s on psm %d. %s(%d)", batostr(&addr.l2_bdaddr),=
 psm, strerror(errno), errno);
+		if (++tries > NBSDPRETRIESMAX) {
+			close(sk);
+			return -1;
+		}
+		sleep(1);
+	}
+	opt =3D sizeof(opts);
+	if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
+		DBG("Can't get L2CAP options. %s(%d)", strerror(errno), errno);
+		close(sk);
+		return -1;
+	}
+	//DBG( "Connected psm=3D%d sk=3D%d [imtu %d, omtu %d, flush_to %d]", ps=
m, sk, opts.imtu, opts.omtu, opts.flush_to);
=20
-        if (mtu)
-                *mtu =3D opts.omtu;
+	if (mtu)
+		*mtu =3D opts.omtu;
=20
-        return sk;
+	return sk;
 }
=20
 // Detect whether A2DP Sink is present at the destination or not
-int detect_a2dp(bdaddr_t *src, bdaddr_t *dst, unsigned short *psm, unsig=
ned long *flags)
+int detect_a2dp(bdaddr_t * src, bdaddr_t * dst, unsigned short *psm, uns=
igned long *flags)
 {
-        sdp_session_t *sess;
-        sdp_list_t *attrid, *search, *seq, *next;
-        sdp_data_t *pdlist;
-        uuid_t group;
-        uint32_t range =3D 0x0000ffff;
-        int err;
-        int tries;
+	sdp_session_t *sess;
+	sdp_list_t *attrid, *search, *seq, *next;
+	sdp_data_t *pdlist;
+	uuid_t group;
+	uint32_t range =3D 0x0000ffff;
+	int err;
+	int tries;
=20
 	// Try to connect an L2CAP socket to the sdp psm with short timeout for=
 user interaction
 	int tmpsk =3D do_connect(src, dst, 1, NULL);
-	if(tmpsk>0)
-	{
+	if (tmpsk > 0) {
 		close(tmpsk);
-	}
-	else
-	{
-                DBG( "Warning: failed to connect to SDP server");
+	} else {
+		DBG("Warning: failed to connect to SDP server");
 		return -1;
 	}
=20
-        tries =3D 0;
-        while(!(sess =3D sdp_connect(src, dst, SDP_RETRY_IF_BUSY))) {
-                DBG("retrying sdp connect: %s", strerror(errno));
-                if(++tries > NBSDPRETRIESMAX) {
-                        break;
-			}
-                sleep(1);
-        }
-        if (!sess) {
-                DBG( "Warning: failed to connect to SDP server");
-                if(psm) *psm =3D 25;
-                if(flags) *flags =3D 0;
-                return 0;
-        }
-
-        /* 0x1108->all? 0x1101->rf sink 0x111e->handsfree 0x1108->headse=
t */
-        sdp_uuid16_create(&group, 0x110d);
-        search =3D sdp_list_append(0, &group);
-        attrid =3D sdp_list_append(0, &range);
-        err =3D sdp_service_search_attr_req(sess, search,
-                                        SDP_ATTR_REQ_RANGE, attrid, &seq=
);
-        sdp_list_free(search, 0);
-        sdp_list_free(attrid, 0);
-
-        if (err) {
-                DBG( "Service Search failed: %s", strerror(errno));
-                sdp_close(sess);
-                return -1;
-        }
-
-        for (; seq; seq =3D next) {
-                sdp_record_t *rec =3D (sdp_record_t *) seq->data;
+	tries =3D 0;
+	while (!(sess =3D sdp_connect(src, dst, SDP_RETRY_IF_BUSY))) {
+		DBG("retrying sdp connect: %s", strerror(errno));
+		if (++tries > NBSDPRETRIESMAX) {
+			break;
+		}
+		sleep(1);
+	}
+	if (!sess) {
+		DBG("Warning: failed to connect to SDP server");
+		if (psm)
+			*psm =3D 25;
+		if (flags)
+			*flags =3D 0;
+		return 0;
+	}
=20
-                DBG( "Found A2DP Sink");
-                if (psm)
-                        *psm =3D 25;
-
-                next =3D seq->next;
-                free(seq);
-                sdp_record_free(rec);
-        }
+	/* 0x1108->all? 0x1101->rf sink 0x111e->handsfree 0x1108->headset */
+	sdp_uuid16_create(&group, 0x110d);
+	search =3D sdp_list_append(0, &group);
+	attrid =3D sdp_list_append(0, &range);
+	err =3D sdp_service_search_attr_req(sess, search, SDP_ATTR_REQ_RANGE, a=
ttrid, &seq);
+	sdp_list_free(search, 0);
+	sdp_list_free(attrid, 0);
+
+	if (err) {
+		DBG("Service Search failed: %s", strerror(errno));
+		sdp_close(sess);
+		return -1;
+	}
=20
-        sdp_uuid16_create(&group, PNP_INFO_SVCLASS_ID);
-        search =3D sdp_list_append(0, &group);
-        attrid =3D sdp_list_append(0, &range);
-        err =3D sdp_service_search_attr_req(sess, search,
-                                        SDP_ATTR_REQ_RANGE, attrid, &seq=
);
-        sdp_list_free(search, 0);
-        sdp_list_free(attrid, 0);
-
-        if (err)
-                goto done;
-
-        if (flags)
-                *flags =3D 0;
-
-        for (; seq; seq =3D next) {
-                sdp_record_t *rec =3D (sdp_record_t *) seq->data;
-                uint16_t vendor, product, version;
-
-                pdlist =3D sdp_data_get(rec, 0x0201);
-                vendor =3D pdlist ? pdlist->val.uint16 : 0x0000;
-
-                pdlist =3D sdp_data_get(rec, 0x0202);
-                product =3D pdlist ? pdlist->val.uint16 : 0x0000;
-
-                pdlist =3D sdp_data_get(rec, 0x0203);
-                version =3D pdlist ? pdlist->val.uint16 : 0x0000;
-
-                DBG( "Product ID %04x:%04x:%04x", vendor, product, versi=
on);
-
-                if (vendor =3D=3D 0x1310 && product =3D=3D 0x0100 && ver=
sion =3D=3D 0x0104) {
-                        DBG( "Enabling GCT media payload workaround");
-                        if (flags)
-                                *flags |=3D NONSPECAUDIO;
-                }
+	for (; seq; seq =3D next) {
+		sdp_record_t *rec =3D (sdp_record_t *) seq->data;
=20
-                next =3D seq->next;
-                free(seq);
-                sdp_record_free(rec);
-        }
+		DBG("Found A2DP Sink");
+		if (psm)
+			*psm =3D 25;
+
+		next =3D seq->next;
+		free(seq);
+		sdp_record_free(rec);
+	}
=20
-done:
-        sdp_close(sess);
-        return 0;
-}
-
-int connect_stream(bdaddr_t *src, bdaddr_t *dst, int *cmdfd_return, sbc_=
t *sbc, int* seid_return, int* omtu)
-{
-        int cmdfd=3D-1;
-        struct sepd_req discover_req;
-        struct sepd_resp discover_resp;
-        struct stream_cmd start_stream;
-        struct start_stream_rsp start_resp;
-        int seid, nb_seid;
-        int size;
-        int i;
-        unsigned short psm_cmd,psm_stream=3D25;
-        unsigned long flags =3D 0;
-        int streamfd =3D -1;
-        uint16_t mtu =3D 0;
-        int tries, res;
-
-        if (detect_a2dp(src, dst, &psm_cmd, &flags) < 0) {
-                DBG( "could not find A2DP services on device %s", batost=
r(dst));
-                return -1;
-        }
-        else {
-                DBG( "Found A2DP Sink at the destination (psm_cmd=3D%d)"=
, psm_cmd);
-        }
+	sdp_uuid16_create(&group, PNP_INFO_SVCLASS_ID);
+	search =3D sdp_list_append(0, &group);
+	attrid =3D sdp_list_append(0, &range);
+	err =3D sdp_service_search_attr_req(sess, search, SDP_ATTR_REQ_RANGE, a=
ttrid, &seq);
+	sdp_list_free(search, 0);
+	sdp_list_free(attrid, 0);
+
+	if (err)
+		goto done;
+
+	if (flags)
+		*flags =3D 0;
+
+	for (; seq; seq =3D next) {
+		sdp_record_t *rec =3D (sdp_record_t *) seq->data;
+		uint16_t vendor, product, version;
+
+		pdlist =3D sdp_data_get(rec, 0x0201);
+		vendor =3D pdlist ? pdlist->val.uint16 : 0x0000;
+
+		pdlist =3D sdp_data_get(rec, 0x0202);
+		product =3D pdlist ? pdlist->val.uint16 : 0x0000;
+
+		pdlist =3D sdp_data_get(rec, 0x0203);
+		version =3D pdlist ? pdlist->val.uint16 : 0x0000;
+
+		DBG("Product ID %04x:%04x:%04x", vendor, product, version);
+
+		if (vendor =3D=3D 0x1310 && product =3D=3D 0x0100 && version =3D=3D 0x=
0104) {
+			DBG("Enabling GCT media payload workaround");
+			if (flags)
+				*flags |=3D NONSPECAUDIO;
+		}
+
+		next =3D seq->next;
+		free(seq);
+		sdp_record_free(rec);
+	}
=20
-        psm_cmd=3D25;=09
-        cmdfd =3D do_connect(src, dst, psm_cmd, &mtu);
-        if (cmdfd < 0) {
-                DBG( "cannot open psm_cmd =3D %d", psm_cmd);
-                return -1;
-        }
+      done:
+	sdp_close(sess);
+	return 0;
+}
+
+int connect_stream(bdaddr_t * src, bdaddr_t * dst, int *cmdfd_return, sb=
c_t * sbc, int *seid_return, int *omtu)
+{
+	int cmdfd =3D -1;
+	struct sepd_req discover_req;
+	struct sepd_resp discover_resp;
+	struct stream_cmd start_stream;
+	struct start_stream_rsp start_resp;
+	int seid, nb_seid;
+	int size;
+	int i;
+	unsigned short psm_cmd, psm_stream =3D 25;
+	unsigned long flags =3D 0;
+	int streamfd =3D -1;
+	uint16_t mtu =3D 0;
+	int tries, res;
=20
-        // avdt_discover_req
-        memset(&discover_req, 0, sizeof(discover_req));
-        init_request(&discover_req.header, AVDTP_DISCOVER);
-
-        res=3Dwrite(cmdfd, &discover_req, sizeof(discover_req));
-        if (res !=3D sizeof(discover_req)) {
-                DBG("couldn't send avdtp_discover (res=3D%d)", res);
-                close(cmdfd);
-                return -1;
-        }
-        else {
-                DBG("Sent the Stream End Point Discovery Command");
-        }
-        tries =3D 0;
-        memset(&discover_resp, 0, sizeof(discover_resp));
+	if (detect_a2dp(src, dst, &psm_cmd, &flags) < 0) {
+		DBG("could not find A2DP services on device %s", batostr(dst));
+		return -1;
+	} else {
+		DBG("Found A2DP Sink at the destination (psm_cmd=3D%d)", psm_cmd);
+	}
=20
-        // SONORIX sends us a discover signal we should answer but we wi=
ll discard
-        while(tries<10)
-        {
-                size=3Da2dp_handle_avdtp_message(NULL, cmdfd, &discover_=
req.header, &discover_resp.header, sizeof(discover_resp));
-                if(size>0)
-                {
-                        // Answer to what we send
-                        break;
-                }
-                else
-                {
-                        // Not answer
-                        usleep(100);
-                        tries++;
-                }
-        }
+	psm_cmd =3D 25;
+	cmdfd =3D do_connect(src, dst, psm_cmd, &mtu);
+	if (cmdfd < 0) {
+		DBG("cannot open psm_cmd =3D %d", psm_cmd);
+		return -1;
+	}
+	// avdt_discover_req
+	memset(&discover_req, 0, sizeof(discover_req));
+	init_request(&discover_req.header, AVDTP_DISCOVER);
+
+	res =3D write(cmdfd, &discover_req, sizeof(discover_req));
+	if (res !=3D sizeof(discover_req)) {
+		DBG("couldn't send avdtp_discover (res=3D%d)", res);
+		close(cmdfd);
+		return -1;
+	} else {
+		DBG("Sent the Stream End Point Discovery Command");
+	}
+	tries =3D 0;
+	memset(&discover_resp, 0, sizeof(discover_resp));
=20
-        if (size > sizeof(discover_resp.header))
-        {
-                DBG("Got a Stream End Point Discovery (%d bytes) Respons=
e (msgtype=3D%d,pkttype=3D%d,lbl=3D%d,sig=3D%d,rfa=3D%d)",=20
-                size,
-                discover_resp.header.message_type,
-                discover_resp.header.packet_type,
-                discover_resp.header.transaction_label,
-                discover_resp.header.signal_id,
-                discover_resp.header.rfa0);
-                for(i=3D0; i<size; i++)
-                        printf("%02X", (int)(*(((char*)&discover_resp)+i=
)));
-                printf("\n");
-        }
-        else
-        {
-                DBG("couldn't get avdtp_discover (size=3D%d, min=3D%d, m=
ax=3D%d)", size, sizeof(discover_resp.header), sizeof(discover_resp));
-                close(cmdfd);
-                return -1;
-        }
+	// SONORIX sends us a discover signal we should answer but we will disc=
ard
+	while (tries < 10) {
+		size =3D a2dp_handle_avdtp_message(NULL, cmdfd, &discover_req.header, =
&discover_resp.header, sizeof(discover_resp));
+		if (size > 0) {
+			// Answer to what we send
+			break;
+		} else {
+			// Not answer
+			usleep(100);
+			tries++;
+		}
+	}
=20
-        seid =3D -1;
-        nb_seid =3D (size-sizeof(discover_resp.header))/sizeof(struct ac=
p_seid_info);
+	if (size > sizeof(discover_resp.header)) {
+		DBG("Got a Stream End Point Discovery (%d bytes) Response (msgtype=3D%=
d,pkttype=3D%d,lbl=3D%d,sig=3D%d,rfa=3D%d)",
+		    size, discover_resp.header.message_type, discover_resp.header.pack=
et_type, discover_resp.header.transaction_label, discover_resp.header.sig=
nal_id, discover_resp.header.rfa0);
+		for (i =3D 0; i < size; i++)
+			printf("%02X", (int) (*(((char *) &discover_resp) + i)));
+		printf("\n");
+	} else {
+		DBG("couldn't get avdtp_discover (size=3D%d, min=3D%d, max=3D%d)", siz=
e, sizeof(discover_resp.header), sizeof(discover_resp));
+		close(cmdfd);
+		return -1;
+	}
=20
-        DBG("received %d capabilities", nb_seid);
+	seid =3D -1;
+	nb_seid =3D (size - sizeof(discover_resp.header)) / sizeof(struct acp_s=
eid_info);
=20
-        for(i=3D0; i < nb_seid; i++)
-        {
-                if (process_seid(cmdfd, &discover_resp.infos[i], &psm_st=
ream, sbc) =3D=3D 0)
-                {
-                        seid =3D discover_resp.infos[i].acp_seid;
-                        break;
-                }
-        }
+	DBG("received %d capabilities", nb_seid);
=20
-        if(seid =3D=3D -1) {
-                //We have not found the seid that we want
-                DBG("couldn't locate the correct seid");
-                return -1;
-        }
+	for (i =3D 0; i < nb_seid; i++) {
+		if (process_seid(cmdfd, &discover_resp.infos[i], &psm_stream, sbc) =3D=
=3D 0) {
+			seid =3D discover_resp.infos[i].acp_seid;
+			break;
+		}
+	}
=20
-        // open the stream
-        streamfd =3D do_connect(src, dst, psm_stream, &mtu);
-        if (streamfd < 0) {
-                DBG("cannot open psm_stream =3D %d", psm_stream);
-                return -1;
-        }
+	if (seid =3D=3D -1) {
+		//We have not found the seid that we want
+		DBG("couldn't locate the correct seid");
+		return -1;
+	}
+	// open the stream
+	streamfd =3D do_connect(src, dst, psm_stream, &mtu);
+	if (streamfd < 0) {
+		DBG("cannot open psm_stream =3D %d", psm_stream);
+		return -1;
+	}
+	// start the stream
=20
-        // start the stream
+	memset(&start_stream, 0, sizeof(start_stream));
+	init_request(&start_stream.header, AVDTP_START);
+	start_stream.acp_seid =3D seid;
+
+	if (write(cmdfd, &start_stream, sizeof(start_stream)) !=3D sizeof(start=
_stream)) {
+		DBG("couldn't send start_stream");
+		close(streamfd);
+		close(cmdfd);
+		return -1;
+	}
=20
-        memset(&start_stream, 0, sizeof(start_stream));
-        init_request(&start_stream.header, AVDTP_START);
-        start_stream.acp_seid =3D seid;
-
-        if (write(cmdfd, &start_stream, sizeof(start_stream)) !=3D sizeo=
f(start_stream)) {
-                DBG("couldn't send start_stream");
-                close(streamfd);
-                close(cmdfd);
-                return -1;
-        }
+	DBG("Sent stream start(seid=3D%d)", seid);
=20
-        DBG("Sent stream start(seid=3D%d)", seid);
+	if (read(cmdfd, &start_resp, sizeof(start_resp)) < sizeof(start_resp) -=
 2 || start_resp.header.message_type =3D=3D MESSAGE_TYPE_REJECT) {
+		DBG("didn't receive start_resp confirm for seid =3D %d", seid);
+		close(streamfd);
+		close(cmdfd);
+		return (-1);
+	}
=20
-        if (read(cmdfd, &start_resp, sizeof(start_resp)) < sizeof(start_=
resp) - 2 ||start_resp.header.message_type =3D=3D MESSAGE_TYPE_REJECT) {
-                DBG("didn't receive start_resp confirm for seid =3D %d",=
 seid);
-                close(streamfd);
-                close(cmdfd);
-                return (-1);
-        }
+	DBG("Got start stream confirm");
=20
-        DBG("Got start stream confirm");
+	*omtu =3D A2DPMAXIMUMTRANSFERUNITSIZE;	//mtu;
+	*seid_return =3D seid;
+	*cmdfd_return =3D cmdfd;
+	return streamfd;
+}
+
+typedef struct snd_pcm_a2dp {
+	bdaddr_t src;
+	bdaddr_t dst;
+	int sk;
+	int control_sk;
+	sbc_t sbc;
+	unsigned char buf[1024];	// contain sbc encoded data, incrementally fil=
led
+	unsigned int len;	// number of valid bytes in buf
+	unsigned int frame_bytes;	// fixed when initializing
+
+	char bufe[BUFS];	// temporary encoding buffer
+	int lenbufe;		//=3D0;
+
+	time_t timestamp;	//=3D0;
+	uint16_t seq_num;	//=3D1;
+	int frame_count;	//=3D0; // Number of sbc frames in one AVDTP packet
+
+	int mtu;		//=3DA2DPMAXIMUMTRANSFERUNITSIZE
+	int seid;
+
+	// Used to control stream from headset
+	int stop_writing;	// =3D 0;
+	int pause_writing;	// =3D 0;
+	pthread_t hListenThread;
=20
-        *omtu =3D A2DPMAXIMUMTRANSFERUNITSIZE; //mtu;
-        *seid_return =3D seid;
-        *cmdfd_return =3D cmdfd;
-        return streamfd;
-}
-
-typedef struct snd_pcm_a2dp
-{
-        bdaddr_t src;
-        bdaddr_t dst;
-        int sk;
-        int control_sk;
-        sbc_t sbc;
-        unsigned char buf[1024]; // contain sbc encoded data, incrementa=
lly filled
-        unsigned int len; // number of valid bytes in buf
-        unsigned int frame_bytes; // fixed when initializing
-       =20
-        char bufe[BUFS]; // temporary encoding buffer
-        int lenbufe;//=3D0;
-=20
-        time_t timestamp;//=3D0;
-        uint16_t seq_num;//=3D1;
-        int frame_count;//=3D0; // Number of sbc frames in one AVDTP pac=
ket
-=20
-        int mtu;//=3DA2DPMAXIMUMTRANSFERUNITSIZE
-        int seid;
-
-        // Used to control stream from headset
-        int stop_writing;// =3D 0;
-        int pause_writing;// =3D 0;
-        pthread_t hListenThread;
-       =20
 } snd_pcm_a2dp_t;
=20
 // We have pcm data to send through bluetooth
-int a2dp_transfer_raw(LPA2DP a2dp, const char* pcm_buffer, int pcm_buffe=
r_size)
+int a2dp_transfer_raw(LPA2DP a2dp, const char *pcm_buffer, int pcm_buffe=
r_size)
 {
-        // No error
-        int result =3D 0;
-        struct media_packet_header packet_header;
-        struct media_payload_header payload_header;
-        int codesize,datatoread;
-        int written;
-
-        // Check parameter
-        if(a2dp=3D=3D0 || pcm_buffer=3D=3D0 || pcm_buffer_size=3D=3D0) r=
eturn EINVAL;
-
-        // How much data can be encoded by sbc at a time?
-        // 16 bits * 2 channels * 16 blocks * 8 subbands =3D 4096bits =3D=
 512 o
-        codesize=3Da2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.channel=
s*2;
-        // 44 bitpool?
-        //codesize=3Da2dp->sbc.bitpool*a2dp->sbc.subbands*a2dp->sbc.bloc=
ks/8;
-        datatoread=3Dmin(codesize,pcm_buffer_size);
-
-        // Enqueue data in bufe
-        if(a2dp->lenbufe+datatoread < BUFS)
-        {
-                // Append data to bufe, for sbc encoding
-                memcpy_changeendian(a2dp->bufe+a2dp->lenbufe, pcm_buffer=
, datatoread);
-                a2dp->lenbufe+=3Ddatatoread;
-        }
-        else
-        {
-                datatoread=3D0;
-        }
-
-
-        // If bufe is full, encode
-        if(a2dp->lenbufe>=3Dcodesize)
-        {
-                // Enough data to encode (sbc wants 1k blocks)
-                int encoded;
-                encoded =3D sbc_encode(&(a2dp->sbc), a2dp->bufe, codesiz=
e); //encode
-
-                if (encoded <=3D 0)
-                        return encoded;
-
-                memmove(a2dp->bufe, a2dp->bufe + encoded, a2dp->lenbufe =
- encoded); // Shift the bufe
-                a2dp->lenbufe -=3D encoded;
-
-                // Send data through bluetooth
-                if(a2dp->len + a2dp->sbc.len >=3D a2dp->mtu)
-                {
-                        // time to prepare and send the packet
-                        memset(&payload_header, 0, sizeof(payload_header=
));
-                        memset(&packet_header, 0, sizeof(packet_header))=
;
-                        payload_header.frame_count=3Da2dp->frame_count;
-                        packet_header.v =3D 2;
-                        packet_header.pt =3D 1;
-                        packet_header.cc =3D 0;
-                        packet_header.sequence_number =3D htons(a2dp->se=
q_num);
-                        packet_header.timestamp =3D htonl(a2dp->timestam=
p);
-                        packet_header.ssrc =3D htonl(1);
-
-                        a2dp->timestamp +=3D (a2dp->sbc.blocks+1)*4 * (a=
2dp->sbc.subbands+1)*4;
-                        memcpy(a2dp->buf, &packet_header, sizeof(packet_=
header));
-                        memcpy(a2dp->buf + sizeof(packet_header), &paylo=
ad_header, sizeof(payload_header));
-                        if(a2dp->sk>0)
-                        {
-                                // Check if data are to be read
-                                // Not seen a device showing this yet
-                                fd_set readfds;
-                                struct timeval zero_timeout =3D {0,0};
-                                FD_ZERO(&readfds);
-                                FD_SET(a2dp->sk, &readfds);
-                                int iselect=3Dselect(1, &readfds, NULL, =
NULL, &zero_timeout);
-                                if(iselect>0)
-                                {
-                                        if(FD_ISSET(a2dp->sk, &readfds))
-                                        {
-                                                a2dp_handle_avdtp_messag=
e(a2dp, a2dp->sk, NULL, NULL, 0);
-                                        }
-                                }
-                                // Pause?
-                                // The value 0 have never been tested
-                                // However, we may safely simulate a fai=
led write
-                                if(!a2dp->pause_writing)
-                                {
-                                        // Send our data
-                                        if((written =3D write(a2dp->sk,a=
2dp->buf,a2dp->len)) !=3D a2dp->len)
-                                        {
-                                                // Error while sending d=
ata
-                                                DBG("Wrote %d not %d byt=
es; (errno=3D%d:%s)", written, a2dp->len, errno,
-                                                        strerror(errno))=
;
-                                                result =3D written;
-                                        }
-                                        result =3D written;
-                                }
-                                else
-                                {
-                                        // Make the upper layer believe =
we sent data
-                                        result =3D a2dp->len;
-                                }
-                        }
+	// No error
+	int result =3D 0;
+	struct media_packet_header packet_header;
+	struct media_payload_header payload_header;
+	int codesize, datatoread;
+	int written;
+
+	// Check parameter
+	if (a2dp =3D=3D 0 || pcm_buffer =3D=3D 0 || pcm_buffer_size =3D=3D 0)
+		return EINVAL;
+
+	// How much data can be encoded by sbc at a time?
+	// 16 bits * 2 channels * 16 blocks * 8 subbands =3D 4096bits =3D 512 o
+	codesize =3D a2dp->sbc.subbands * a2dp->sbc.blocks * a2dp->sbc.channels=
 * 2;
+	// 44 bitpool?
+	//codesize=3Da2dp->sbc.bitpool*a2dp->sbc.subbands*a2dp->sbc.blocks/8;
+	datatoread =3D min(codesize, pcm_buffer_size);
+
+	// Enqueue data in bufe
+	if (a2dp->lenbufe + datatoread < BUFS) {
+		// Append data to bufe, for sbc encoding
+		memcpy_changeendian(a2dp->bufe + a2dp->lenbufe, pcm_buffer, datatoread=
);
+		a2dp->lenbufe +=3D datatoread;
+	} else {
+		datatoread =3D 0;
+	}
=20
-                        // Reset buffer of data to send
-                        a2dp->len =3D sizeof(struct media_packet_header)=
+sizeof(struct media_payload_header);
-                        a2dp->frame_count=3D0;
-                        a2dp->seq_num++;
-                }
=20
-                // Append sbc encoded data to buf, until buf reaches A2D=
PMAXIMUMTRANSFERUNITSIZE to send
-                a2dp->frame_count++;
-                memcpy(a2dp->buf + a2dp->len, a2dp->sbc.data, a2dp->sbc.=
len);
-                a2dp->len+=3Da2dp->sbc.len;
-        }
+	// If bufe is full, encode
+	if (a2dp->lenbufe >=3D codesize) {
+		// Enough data to encode (sbc wants 1k blocks)
+		int encoded;
+		encoded =3D sbc_encode(&(a2dp->sbc), a2dp->bufe, codesize);	//encode
+
+		if (encoded <=3D 0)
+			return encoded;
+
+		memmove(a2dp->bufe, a2dp->bufe + encoded, a2dp->lenbufe - encoded);	//=
 Shift the bufe
+		a2dp->lenbufe -=3D encoded;
+
+		// Send data through bluetooth
+		if (a2dp->len + a2dp->sbc.len >=3D a2dp->mtu) {
+			// time to prepare and send the packet
+			memset(&payload_header, 0, sizeof(payload_header));
+			memset(&packet_header, 0, sizeof(packet_header));
+			payload_header.frame_count =3D a2dp->frame_count;
+			packet_header.v =3D 2;
+			packet_header.pt =3D 1;
+			packet_header.cc =3D 0;
+			packet_header.sequence_number =3D htons(a2dp->seq_num);
+			packet_header.timestamp =3D htonl(a2dp->timestamp);
+			packet_header.ssrc =3D htonl(1);
+
+			a2dp->timestamp +=3D (a2dp->sbc.blocks + 1) * 4 * (a2dp->sbc.subbands=
 + 1) * 4;
+			memcpy(a2dp->buf, &packet_header, sizeof(packet_header));
+			memcpy(a2dp->buf + sizeof(packet_header), &payload_header, sizeof(pay=
load_header));
+			if (a2dp->sk > 0) {
+				// Check if data are to be read
+				// Not seen a device showing this yet
+				fd_set readfds;
+				struct timeval zero_timeout =3D { 0, 0 };
+				FD_ZERO(&readfds);
+				FD_SET(a2dp->sk, &readfds);
+				int iselect =3D select(1, &readfds, NULL, NULL, &zero_timeout);
+				if (iselect > 0) {
+					if (FD_ISSET(a2dp->sk, &readfds)) {
+						a2dp_handle_avdtp_message(a2dp, a2dp->sk, NULL, NULL, 0);
+					}
+				}
+				// Pause?
+				// The value 0 have never been tested
+				// However, we may safely simulate a failed write
+				if (!a2dp->pause_writing) {
+					// Send our data
+					if ((written =3D write(a2dp->sk, a2dp->buf, a2dp->len)) !=3D a2dp->=
len) {
+						// Error while sending data
+						DBG("Wrote %d not %d bytes; (errno=3D%d:%s)", written, a2dp->len, =
errno, strerror(errno));
+						result =3D written;
+					}
+					result =3D written;
+				} else {
+					// Make the upper layer believe we sent data
+					result =3D a2dp->len;
+				}
+			}
+			// Reset buffer of data to send
+			a2dp->len =3D sizeof(struct media_packet_header) + sizeof(struct medi=
a_payload_header);
+			a2dp->frame_count =3D 0;
+			a2dp->seq_num++;
+		}
+		// Append sbc encoded data to buf, until buf reaches A2DPMAXIMUMTRANSF=
ERUNITSIZE to send
+		a2dp->frame_count++;
+		memcpy(a2dp->buf + a2dp->len, a2dp->sbc.data, a2dp->sbc.len);
+		a2dp->len +=3D a2dp->sbc.len;
+	}
=20
-        return result;
+	return result;
 }
=20
-static void init_response(struct avdtp_header * header, int response_typ=
e)
+static void init_response(struct avdtp_header *header, int response_type=
)
 {
-        // leave signal_id and transaction label since we are reusing th=
e request
-        header->packet_type =3D PACKET_TYPE_SINGLE;
-        header->message_type =3D response_type;
+	// leave signal_id and transaction label since we are reusing the reque=
st
+	header->packet_type =3D PACKET_TYPE_SINGLE;
+	header->message_type =3D response_type;
=20
-        // clear rfa bits
-        header->rfa0 =3D 0;
+	// clear rfa bits
+	header->rfa0 =3D 0;
 }
=20
 // monitor the control connection for pause/play signals from headset
 // note this signaling is in the avdtp core; avrcp signaling is differen=
t
-static void* listen_thread(void* param)
+static void *listen_thread(void *param)
 {
-        snd_pcm_a2dp_t* a2dp =3D (snd_pcm_a2dp_t*)param;
+	snd_pcm_a2dp_t *a2dp =3D (snd_pcm_a2dp_t *) param;
=20
-        if(a2dp->control_sk<0)=20
-        {
-        	DBG("Listen thread not started [control_sk=3D%d]", a2dp->contro=
l_sk);
+	if (a2dp->control_sk < 0) {
+		DBG("Listen thread not started [control_sk=3D%d]", a2dp->control_sk);
 		return NULL;
-        }
-
-        DBG("Listen thread running [control_sk=3D%d]", a2dp->control_sk)=
;
+	}
=20
-        // Set a timeout to close thread
-        struct timeval t =3D { 1, 0 };
-        setsockopt( a2dp->control_sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeo=
f(t));
-        setsockopt( a2dp->control_sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeo=
f(t));
+	DBG("Listen thread running [control_sk=3D%d]", a2dp->control_sk);
=20
-        // Loop until end of writing
-        while(!a2dp->stop_writing)
-        {
-                char szBuffer[A2DPMAXIMUMTRANSFERUNITSIZE];
-                struct stream_cmd* cmd =3D (struct stream_cmd*)szBuffer;
-                if(a2dp_handle_avdtp_message(a2dp, a2dp->control_sk, NUL=
L, NULL, 0)<0)
-                {
-                        // Error
-                        usleep(100*1000);
-                }
-
-                int size =3D read(a2dp->control_sk, szBuffer, sizeof(szB=
uffer));
-                if(size>0)
-                {
-                        if(cmd->header.signal_id =3D=3D AVDTP_SUSPEND)
-                        {
-                                DBG("Received signal AVDTP_SUSPEND(%d) f=
rom set", cmd->header.signal_id);
-                                a2dp->pause_writing =3D 1;
-                        }
-                        else if(cmd->header.signal_id =3D=3D AVDTP_START=
)
-                        {
-                                DBG("Received signal AVDTP_START(%d) fro=
m set", cmd->header.signal_id);
-                                a2dp->pause_writing =3D 0;
-                        }
-                        else
-                        {
-                                DBG("Unexpected headset directive %d", c=
md->header.signal_id);
-                        }
-                        // ack the command regardless
-                        //FIXME take a shortcut and reuse the command st=
ruct (knock one byte off length)
-                        init_response(&cmd->header, MESSAGE_TYPE_ACCEPT)=
;
-                        if (write(a2dp->control_sk, &cmd, sizeof(cmd)-1)=
 !=3D sizeof(cmd)-1)
-                        {
-                                DBG("Couldn't ack %d", cmd->header.signa=
l_id);
-                        }
-                }
-                else
-                {
-                        if(errno!=3DEAGAIN)
-                                DBG("Error while receiving %d (errno=3D%=
d:%s)", size, errno, strerror(errno));
-                        if(errno!=3DEINTR)
-                                break;
-                }
-        }
+	// Set a timeout to close thread
+	struct timeval t =3D { 1, 0 };
+	setsockopt(a2dp->control_sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
+	setsockopt(a2dp->control_sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
+	// Loop until end of writing
+	while (!a2dp->stop_writing) {
+		char szBuffer[A2DPMAXIMUMTRANSFERUNITSIZE];
+		struct stream_cmd *cmd =3D (struct stream_cmd *) szBuffer;
+		if (a2dp_handle_avdtp_message(a2dp, a2dp->control_sk, NULL, NULL, 0) <=
 0) {
+			// Error
+			usleep(100 * 1000);
+		}
+
+		int size =3D read(a2dp->control_sk, szBuffer, sizeof(szBuffer));
+		if (size > 0) {
+			if (cmd->header.signal_id =3D=3D AVDTP_SUSPEND) {
+				DBG("Received signal AVDTP_SUSPEND(%d) from set", cmd->header.signal=
_id);
+				a2dp->pause_writing =3D 1;
+			} else if (cmd->header.signal_id =3D=3D AVDTP_START) {
+				DBG("Received signal AVDTP_START(%d) from set", cmd->header.signal_i=
d);
+				a2dp->pause_writing =3D 0;
+			} else {
+				DBG("Unexpected headset directive %d", cmd->header.signal_id);
+			}
+			// ack the command regardless
+			//FIXME take a shortcut and reuse the command struct (knock one byte =
off length)
+			init_response(&cmd->header, MESSAGE_TYPE_ACCEPT);
+			if (write(a2dp->control_sk, &cmd, sizeof(cmd) - 1) !=3D sizeof(cmd) -=
 1) {
+				DBG("Couldn't ack %d", cmd->header.signal_id);
+			}
+		} else {
+			if (errno !=3D EAGAIN)
+				DBG("Error while receiving %d (errno=3D%d:%s)", size, errno, strerro=
r(errno));
+			if (errno !=3D EINTR)
+				break;
+		}
+	}
=20
-        return NULL;
+	return NULL;
 }
=20
-int a2dp_connect(snd_pcm_a2dp_t *a2dp)
+int a2dp_connect(snd_pcm_a2dp_t * a2dp)
 {
-        //struct sockaddr_rc addr;
-        //socklen_t len;
-        int sk =3D -1;
-        int control_sk =3D -1;
-        errno=3D0;
-        /*
-        if(a2dp->use_rfcomm) {
-                sk =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)=
;
-                if (sk < 0)
-                        return -errno;
-               =20
-                memset(&addr, 0, sizeof(addr));
-                addr.rc_family =3D AF_BLUETOOTH;
-                bacpy(&addr.rc_bdaddr, &a2dp->src);
-               =20
-                if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < =
0) {
-                        close(sk);
-                        return -errno;
-                }
-               =20
-                memset(&addr, 0, sizeof(addr));
-                addr.rc_family =3D AF_BLUETOOTH;
-                bacpy(&addr.rc_bdaddr, &a2dp->dst);
-                addr.rc_channel =3D 1;
-               =20
-                if (connect(sk, (struct sockaddr *) &addr, sizeof(addr))=
 < 0) {
-                        close(sk);
-                        return -errno;
-                }
-
-                memset(&addr, 0, sizeof(addr));
-                len =3D sizeof(addr);
-               =20
-                if (getsockname(sk, (struct sockaddr *) &addr, &len) < 0=
) {
-                        close(sk);
-                        return -errno;
-                }
-
-                bacpy(&a2dp->src, &addr.rc_bdaddr);
+	//struct sockaddr_rc addr;
+	//socklen_t len;
+	int sk =3D -1;
+	int control_sk =3D -1;
+	errno =3D 0;
+	/*
+	   if(a2dp->use_rfcomm) {
+	   sk =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
+	   if (sk < 0)
+	   return -errno;
+
+	   memset(&addr, 0, sizeof(addr));
+	   addr.rc_family =3D AF_BLUETOOTH;
+	   bacpy(&addr.rc_bdaddr, &a2dp->src);
+
+	   if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+	   close(sk);
+	   return -errno;
+	   }
+
+	   memset(&addr, 0, sizeof(addr));
+	   addr.rc_family =3D AF_BLUETOOTH;
+	   bacpy(&addr.rc_bdaddr, &a2dp->dst);
+	   addr.rc_channel =3D 1;
+
+	   if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+	   close(sk);
+	   return -errno;
+	   }
+
+	   memset(&addr, 0, sizeof(addr));
+	   len =3D sizeof(addr);
+
+	   if (getsockname(sk, (struct sockaddr *) &addr, &len) < 0) {
+	   close(sk);
+	   return -errno;
+	   }
+
+	   bacpy(&a2dp->src, &addr.rc_bdaddr);
+
+	   //fcntl(sk, F_SETFL, fcntl(sk, F_GETFL) | O_NONBLOCK);
+	   } else { */
+	sk =3D connect_stream(&a2dp->src, &a2dp->dst, &control_sk, &a2dp->sbc, =
&a2dp->seid, &a2dp->mtu);
+	//}
+
+	a2dp->sk =3D sk;
+	a2dp->control_sk =3D control_sk;
+
+	// Start listen thread
+	a2dp->pause_writing =3D 0;
+	a2dp->stop_writing =3D 0;
=20
-                //fcntl(sk, F_SETFL, fcntl(sk, F_GETFL) | O_NONBLOCK);
-        } else {*/
-                sk =3D connect_stream(&a2dp->src, &a2dp->dst, &control_s=
k, &a2dp->sbc, &a2dp->seid, &a2dp->mtu);
-        //}
-
-        a2dp->sk =3D sk;
-        a2dp->control_sk =3D control_sk;
-
-        // Start listen thread
-        a2dp->pause_writing =3D 0;
-        a2dp->stop_writing =3D 0;
-       =20
-        if(sk>0)
-        {
+	if (sk > 0) {
 		// Set pthread stack size to decrease unused memory usage
 		pthread_attr_t tattr;
 		size_t size =3D PTHREAD_STACK_MIN;
 		int ret =3D pthread_attr_init(&tattr);
 		ret =3D pthread_attr_setstacksize(&tattr, size);
-		pthread_create(&a2dp->hListenThread, &tattr, listen_thread, (void*)a2d=
p);
+		pthread_create(&a2dp->hListenThread, &tattr, listen_thread, (void *) a=
2dp);
 		pthread_attr_destroy(&tattr);
 	}
=20
-        return sk;
+	return sk;
 }
=20
 snd_pcm_a2dp_t *a2dp_alloc(void)
 {
-        snd_pcm_a2dp_t *a2dp;
-        a2dp =3D malloc(sizeof(*a2dp));
-        if (!a2dp)
-                return NULL;
-
-        memset(a2dp, 0, sizeof(*a2dp));
-        a2dp->seq_num =3D 1;
-        a2dp->mtu =3D A2DPMAXIMUMTRANSFERUNITSIZE;
-        a2dp->len =3D sizeof(struct media_packet_header)+sizeof(struct m=
edia_payload_header);
-
-        sbc_init(&a2dp->sbc, 0L);
-        a2dp->sbc.rate =3D A2DPD_FRAME_RATE;
-        a2dp->sbc.subbands =3D 8; // safe default
-        a2dp->sbc.blocks =3D 16; // safe default
-        a2dp->sbc.bitpool =3D 32; // recommended value 53, safe default =
is 32
-        return a2dp;
-}
-
-void a2dp_free(snd_pcm_a2dp_t *a2dp)
-{
-        DBG("");
-        if (a2dp->sk > 0)
-                close(a2dp->sk);
-        if (a2dp->control_sk > 0)
-                close(a2dp->control_sk);
+	snd_pcm_a2dp_t *a2dp;
+	a2dp =3D malloc(sizeof(*a2dp));
+	if (!a2dp)
+		return NULL;
=20
-        sbc_finish(&a2dp->sbc);
+	memset(a2dp, 0, sizeof(*a2dp));
+	a2dp->seq_num =3D 1;
+	a2dp->mtu =3D A2DPMAXIMUMTRANSFERUNITSIZE;
+	a2dp->len =3D sizeof(struct media_packet_header) + sizeof(struct media_=
payload_header);
+
+	sbc_init(&a2dp->sbc, 0L);
+	a2dp->sbc.rate =3D A2DPD_FRAME_RATE;
+	a2dp->sbc.subbands =3D 8;	// safe default
+	a2dp->sbc.blocks =3D 16;	// safe default
+	a2dp->sbc.bitpool =3D 32;	// recommended value 53, safe default is 32
+	return a2dp;
+}
+
+void a2dp_free(snd_pcm_a2dp_t * a2dp)
+{
+	DBG("");
+	if (a2dp->sk > 0)
+		close(a2dp->sk);
+	if (a2dp->control_sk > 0)
+		close(a2dp->control_sk);
=20
-        free(a2dp);
+	sbc_finish(&a2dp->sbc);
+
+	free(a2dp);
 }
=20
 static void sighand(int signo)
 {
-        return;
+	return;
 }
=20
 void a2dp_init(void)
 {
-        // set up thread signal handler
-        memset(&actions, 0, sizeof(actions));
-        sigemptyset(&actions.sa_mask);
-        actions.sa_flags =3D 0;
-        actions.sa_handler =3D sighand;
-        sigaction(SIGALRM,&actions,NULL);
-       =20
-        // Start sdp advertising
-        /*
-        g_sdpSessionP =3D sdp_connect(BDADDR_ANY, BDADDR_LOCAL, SDP_RETR=
Y_IF_BUSY);
-        g_recordP =3D a2dp_advertise_sdp(g_sdpSessionP);
-        */
+	// set up thread signal handler
+	memset(&actions, 0, sizeof(actions));
+	sigemptyset(&actions.sa_mask);
+	actions.sa_flags =3D 0;
+	actions.sa_handler =3D sighand;
+	sigaction(SIGALRM, &actions, NULL);
+
+	// Start sdp advertising
+	/*
+	   g_sdpSessionP =3D sdp_connect(BDADDR_ANY, BDADDR_LOCAL, SDP_RETRY_IF=
_BUSY);
+	   g_recordP =3D a2dp_advertise_sdp(g_sdpSessionP);
+	 */
 }
=20
 void a2dp_exit(void)
 {
 }
=20
-LPA2DP a2dp_new(char* addr, int framerate)
+LPA2DP a2dp_new(char *addr, int framerate)
 {
-        snd_pcm_a2dp_t *a2dp =3D NULL;
-        bdaddr_t src, dst;
-        int err; //, pos =3D -1, use_rfcomm =3D 0;
-
-        DBG("%s, %d", addr, framerate);
-
-        bacpy(&src, BDADDR_ANY);
-        bacpy(&dst, BDADDR_ANY);
-        str2ba(addr, &dst);
-
-        a2dp =3D a2dp_alloc();
-        if (!a2dp) {
-                DBG("Can't allocate");
-                return NULL;
-        }
-        if(a2dp) a2dp->sbc.rate=3Dframerate;
+	snd_pcm_a2dp_t *a2dp =3D NULL;
+	bdaddr_t src, dst;
+	int err;		//, pos =3D -1, use_rfcomm =3D 0;
=20
-        bacpy(&a2dp->src, &src);
-        bacpy(&a2dp->dst, &dst);
-        //a2dp->use_rfcomm =3D use_rfcomm;
-
-        err =3D a2dp_connect(a2dp);
-        if (err < 0) {
-                DBG("Can't connect");
-                goto error;
-        }
+	DBG("%s, %d", addr, framerate);
=20
-        return a2dp;
+	bacpy(&src, BDADDR_ANY);
+	bacpy(&dst, BDADDR_ANY);
+	str2ba(addr, &dst);
=20
-error:
-        a2dp_free(a2dp);
-        return NULL;
-}
+	a2dp =3D a2dp_alloc();
+	if (!a2dp) {
+		DBG("Can't allocate");
+		return NULL;
+	}
+	if (a2dp)
+		a2dp->sbc.rate =3D framerate;
=20
-void a2dp_destroy(LPA2DP a2dp)
-{
-        struct stream_cmd close_stream;
-        struct close_stream_rsp close_resp;
+	bacpy(&a2dp->src, &src);
+	bacpy(&a2dp->dst, &dst);
+	//a2dp->use_rfcomm =3D use_rfcomm;
+
+	err =3D a2dp_connect(a2dp);
+	if (err < 0) {
+		DBG("Can't connect");
+		goto error;
+	}
=20
-        DBG("Begin");
-        a2dp->stop_writing =3D 1;
-        pthread_kill(a2dp->hListenThread, SIGALRM);
-        pthread_join(a2dp->hListenThread, NULL);
-
-        memset(&close_stream, 0, sizeof(close_stream));
-        memset(&close_resp, 0, sizeof(close_resp));
-
-        // the stream-close used to make the iTech headset lock up and r=
equire it to be powercycled
-        // should be tested again now that we drain the queue properly
-
-        init_request(&close_stream.header, AVDTP_CLOSE);
-        close_stream.acp_seid =3D a2dp->seid;
-        // Use control_sk if it is needed
-        if((a2dp->control_sk>0 && (write(a2dp->control_sk, &close_stream=
, sizeof(close_stream)) !=3D sizeof(close_stream)))
-        // Else use sk
-        || (write(a2dp->sk, &close_stream, sizeof(close_stream)) !=3D si=
zeof(close_stream))
-          )
-        {
-                DBG("Couldn't send close_stream (errno=3D%d:%s)", errno,=
 strerror(errno));
-        }
+	return a2dp;
=20
-        a2dp_free(a2dp);
-        DBG("a2dp_destroy(%p) OK", a2dp);
+      error:
+	a2dp_free(a2dp);
+	return NULL;
 }
=20
-int a2dp_make_listen_socket(unsigned short psm)
+void a2dp_destroy(LPA2DP a2dp)
 {
-        char* lpszError =3D NULL;
-        int sockfd =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CA=
P);
-       =20
-        if (sockfd >=3D 0)
-        {
-                struct sockaddr_l2 addr;
-                memset(&addr, 0, sizeof(addr));
-                addr.l2_family =3D AF_BLUETOOTH;
-                bacpy(&addr.l2_bdaddr, BDADDR_ANY);
-                addr.l2_psm=3Dhtobs(psm);
-                if (bind(sockfd, (struct sockaddr *) &addr, sizeof(addr)=
) >=3D 0)
-                {
-                        /*
-                        struct l2cap_options opts;
-                        unsigned int iOptSize =3D sizeof(opts);
-                        // Get default options
-                        if (getsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS,=
 &opts, &opt) >=3D 0)
-                        {
-                                if (setsockopt(sockfd, SOL_L2CAP, L2CAP_=
OPTIONS, &opts, opt) >=3D 0)
-                                {
-                        */
-                                        if(listen(sockfd,5)>=3D0)
-                                        {
-                                        }
-                                        else
-                                        {
-                                                lpszError =3D "Can't lis=
ten.";
-                                        }
-                        /*
-                                }
-                                else
-                                {
-                                        lpszError =3D "Can't get default=
 L2CAP options.";
-                                }
-                        }
-                        else
-                        {
-                                lpszError =3D "Can't set L2CAP options."=
;
-                        }
-                        */
-                }
-                else
-                {
-                        lpszError =3D "Can't bind socket (already used?)=
.";
-                }
-        }
-        else
-        {
-                lpszError =3D "Can't create socket.";
-        }
+	struct stream_cmd close_stream;
+	struct close_stream_rsp close_resp;
=20
-        if(lpszError)
-        {
-                DBG("%s %s(%d)", lpszError, strerror(errno), errno);
-                close(sockfd);
-                sockfd=3D-1;
-        }
-       =20
-        return sockfd;
+	DBG("Begin");
+	a2dp->stop_writing =3D 1;
+	pthread_kill(a2dp->hListenThread, SIGALRM);
+	pthread_join(a2dp->hListenThread, NULL);
+
+	memset(&close_stream, 0, sizeof(close_stream));
+	memset(&close_resp, 0, sizeof(close_resp));
+
+	// the stream-close used to make the iTech headset lock up and require =
it to be powercycled
+	// should be tested again now that we drain the queue properly
+
+	init_request(&close_stream.header, AVDTP_CLOSE);
+	close_stream.acp_seid =3D a2dp->seid;
+	// Use control_sk if it is needed
+	if ((a2dp->control_sk > 0 && (write(a2dp->control_sk, &close_stream, si=
zeof(close_stream)) !=3D sizeof(close_stream)))
+	    // Else use sk
+	    || (write(a2dp->sk, &close_stream, sizeof(close_stream)) !=3D sizeo=
f(close_stream))
+	    ) {
+		DBG("Couldn't send close_stream (errno=3D%d:%s)", errno, strerror(errn=
o));
+	}
+
+	a2dp_free(a2dp);
+	DBG("a2dp_destroy(%p) OK", a2dp);
 }
=20
-int a2dp_wait_connection( int sockfd, char* szRemote, int iRemoteSize, u=
int16_t *mtu)
+int a2dp_make_listen_socket(unsigned short psm)
 {
-        // Wait client connection
-        struct sockaddr_l2 addr;
-        socklen_t addrlen =3D sizeof(addr);
-
-        // Timeouts each second to read variables
-        struct timeval t =3D { 1, 0 };
-        setsockopt( sockfd, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
-        setsockopt( sockfd, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+	char *lpszError =3D NULL;
+	int sockfd =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
=20
-        int new_fd =3D accept(sockfd, (struct sockaddr *) &addr, &addrle=
n);
+	if (sockfd >=3D 0) {
+		struct sockaddr_l2 addr;
+		memset(&addr, 0, sizeof(addr));
+		addr.l2_family =3D AF_BLUETOOTH;
+		bacpy(&addr.l2_bdaddr, BDADDR_ANY);
+		addr.l2_psm =3D htobs(psm);
+		if (bind(sockfd, (struct sockaddr *) &addr, sizeof(addr)) >=3D 0) {
+			/*
+			   struct l2cap_options opts;
+			   unsigned int iOptSize =3D sizeof(opts);
+			   // Get default options
+			   if (getsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) >=3D=
 0)
+			   {
+			   if (setsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) >=3D =
0)
+			   {
+			 */
+			if (listen(sockfd, 5) >=3D 0) {
+			} else {
+				lpszError =3D "Can't listen.";
+			}
+			/*
+			   }
+			   else
+			   {
+			   lpszError =3D "Can't get default L2CAP options.";
+			   }
+			   }
+			   else
+			   {
+			   lpszError =3D "Can't set L2CAP options.";
+			   }
+			 */
+		} else {
+			lpszError =3D "Can't bind socket (already used?).";
+		}
+	} else {
+		lpszError =3D "Can't create socket.";
+	}
=20
-        if (szRemote) *szRemote=3D'\0';
+	if (lpszError) {
+		DBG("%s %s(%d)", lpszError, strerror(errno), errno);
+		close(sockfd);
+		sockfd =3D -1;
+	}
=20
-        if(new_fd >=3D 0)
-        {
-                // Get default options
-                struct l2cap_options opts;
-                unsigned int iOptSize =3D sizeof(opts);
-                if (getsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS, &opts, =
&iOptSize) >=3D 0)
-                {
-                        if (mtu && opts.imtu)
-                                *mtu =3D opts.imtu;
-                        if (mtu && opts.omtu)
-                                *mtu =3D opts.omtu;
-                        if (!(*mtu))
-                                *mtu=3DA2DPMAXIMUMTRANSFERUNITSIZE;
-                }
-                //DBG("Connected [imtu %d, omtu %d, flush_to %d]", opts.=
imtu, opts.omtu, opts.flush_to);
+	return sockfd;
+}
=20
-                if (szRemote)=20
-                {
-                        strncpy(szRemote, batostr(&addr.l2_bdaddr), iRem=
oteSize);
-                        szRemote[iRemoteSize-1] =3D '\0';
-                }
-        }
-        return new_fd;
+int a2dp_wait_connection(int sockfd, char *szRemote, int iRemoteSize, ui=
nt16_t * mtu)
+{
+	// Wait client connection
+	struct sockaddr_l2 addr;
+	socklen_t addrlen =3D sizeof(addr);
+
+	// Timeouts each second to read variables
+	struct timeval t =3D { 1, 0 };
+	setsockopt(sockfd, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
+	setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
+	int new_fd =3D accept(sockfd, (struct sockaddr *) &addr, &addrlen);
+
+	if (szRemote)
+		*szRemote =3D '\0';
+
+	if (new_fd >=3D 0) {
+		// Get default options
+		struct l2cap_options opts;
+		unsigned int iOptSize =3D sizeof(opts);
+		if (getsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS, &opts, &iOptSize) >=3D=
 0) {
+			if (mtu && opts.imtu)
+				*mtu =3D opts.imtu;
+			if (mtu && opts.omtu)
+				*mtu =3D opts.omtu;
+			if (!(*mtu))
+				*mtu =3D A2DPMAXIMUMTRANSFERUNITSIZE;
+		}
+		//DBG("Connected [imtu %d, omtu %d, flush_to %d]", opts.imtu, opts.omt=
u, opts.flush_to);
+
+		if (szRemote) {
+			strncpy(szRemote, batostr(&addr.l2_bdaddr), iRemoteSize);
+			szRemote[iRemoteSize - 1] =3D '\0';
+		}
+	}
+	return new_fd;
 }
=20
 // This function handle the bluetooth connection
-int a2dp_handle_avdtp_message(LPA2DP a2dp, int sockfd, struct avdtp_head=
er* sent_packet, struct avdtp_header* answer, int answer_size)
+int a2dp_handle_avdtp_message(LPA2DP a2dp, int sockfd, struct avdtp_head=
er *sent_packet, struct avdtp_header *answer, int answer_size)
 {
-        int result =3D 0;
-        int wrresult =3D 0;
-
-        char lpFrame [A2DPMAXIMUMTRANSFERUNITSIZE];
-        int iReceived =3D recv(sockfd, lpFrame, sizeof(lpFrame), 0);
-        struct avdtp_header* pkt_hdr =3D (struct avdtp_header*)lpFrame;
-        if(iReceived>0)
-        {
-                // Manage the packet
-                if(sent_packet=3D=3DNULL)
-                {
-                        int i;
-                        printf("socket %d: Received %d bytes\n", sockfd,=
 iReceived);
-                        for(i =3D 0; i<iReceived; i++)
-                        {
-                                char c=3DlpFrame[i];
-                                if(i%16=3D=3D0) printf("%05d: ", i);
-                                printf("%02x ", c);
-                                if(i%16=3D=3D15) printf("\n");
-                        }
-                        printf("\n");
-                        result=3D0;
-                }
-                else if((pkt_hdr->message_type =3D=3D MESSAGE_TYPE_ACCEP=
T)                               &&(pkt_hdr->signal_id =3D=3D sent_packet=
->signal_id)
-                )
-                {
-                        // Got expected answer
-                        memcpy(answer, lpFrame, answer_size>iReceived?an=
swer_size:iReceived);
-                        result=3DiReceived;
-                }
-                else
-                {
-                        // Got bad answer
-                        result=3D0;
-                }
-
-                // Reply to the packet by rejecting it
-                if(pkt_hdr->message_type =3D=3D MESSAGE_TYPE_COMMAND)
-                {
-                        int accepted =3D 0;
-                        if(a2dp && pkt_hdr->signal_id =3D=3D AVDTP_SUSPE=
ND)
-                        {
-                                DBG("Received signal AVDTP_SUSPEND(%d) f=
rom set", pkt_hdr->signal_id);
-                                a2dp->pause_writing =3D 1;
-                                accepted=3D1;
-                        }
-                        else if(a2dp && pkt_hdr->signal_id =3D=3D AVDTP_=
START)
-                        {
-                                DBG("Received signal AVDTP_START(%d) fro=
m set", pkt_hdr->signal_id);
-                                a2dp->pause_writing =3D 0;
-                                accepted=3D1;
-                        }
-                        else
-                        {
-                                DBG("Unexpected headset directive %d", p=
kt_hdr->signal_id);
-                        }
-
-                        DBG("Answering command packet (msgtype=3D%s,sign=
al=3D%d)", accepted?"MESSAGE_TYPE_ACCEPT":"MESSAGE_TYPE_REJECT", pkt_hdr-=
>signal_id);
-                        // Reject a command received
-                        pkt_hdr->message_type =3D accepted?MESSAGE_TYPE_=
ACCEPT:MESSAGE_TYPE_REJECT;
+	int result =3D 0;
+	int wrresult =3D 0;
=20
-                        wrresult =3D write(sockfd, pkt_hdr, sizeof(*pkt_=
hdr));
+	char lpFrame[A2DPMAXIMUMTRANSFERUNITSIZE];
+	int iReceived =3D recv(sockfd, lpFrame, sizeof(lpFrame), 0);
+	struct avdtp_header *pkt_hdr =3D (struct avdtp_header *) lpFrame;
+	if (iReceived > 0) {
+		// Manage the packet
+		if (sent_packet =3D=3D NULL) {
+			int i;
+			printf("socket %d: Received %d bytes\n", sockfd, iReceived);
+			for (i =3D 0; i < iReceived; i++) {
+				char c =3D lpFrame[i];
+				if (i % 16 =3D=3D 0)
+					printf("%05d: ", i);
+				printf("%02x ", c);
+				if (i % 16 =3D=3D 15)
+					printf("\n");
+			}
+			printf("\n");
+			result =3D 0;
+		} else if ((pkt_hdr->message_type =3D=3D MESSAGE_TYPE_ACCEPT) && (pkt_=
hdr->signal_id =3D=3D sent_packet->signal_id)
+		    ) {
+			// Got expected answer
+			memcpy(answer, lpFrame, answer_size > iReceived ? answer_size : iRece=
ived);
+			result =3D iReceived;
+		} else {
+			// Got bad answer
+			result =3D 0;
+		}
+
+		// Reply to the packet by rejecting it
+		if (pkt_hdr->message_type =3D=3D MESSAGE_TYPE_COMMAND) {
+			int accepted =3D 0;
+			if (a2dp && pkt_hdr->signal_id =3D=3D AVDTP_SUSPEND) {
+				DBG("Received signal AVDTP_SUSPEND(%d) from set", pkt_hdr->signal_id=
);
+				a2dp->pause_writing =3D 1;
+				accepted =3D 1;
+			} else if (a2dp && pkt_hdr->signal_id =3D=3D AVDTP_START) {
+				DBG("Received signal AVDTP_START(%d) from set", pkt_hdr->signal_id);
+				a2dp->pause_writing =3D 0;
+				accepted =3D 1;
+			} else {
+				DBG("Unexpected headset directive %d", pkt_hdr->signal_id);
+			}
=20
-                        if(wrresult !=3D sizeof(*pkt_hdr))
-                        {
-                                DBG("FAILED Answering command packet (ms=
gtype=3D%s,signal=3D%d) wrresult=3D%d/%d (errno=3D%d:%s)", accepted?"MESS=
AGE_TYPE_ACCEPT":"MESSAGE_TYPE_REJECT", pkt_hdr->signal_id, wrresult, siz=
eof(*pkt_hdr), errno, strerror(errno));
-                        }
-                }
-                else
-                {
-                        DBG("Read non command packet (msgtype=3D%d,signa=
l=3D%d)", pkt_hdr->message_type, pkt_hdr->signal_id);
-                }
-        }
-        else
-        {
-                result=3DiReceived;
-                if(errno!=3DEAGAIN)
-                        printf("socket %d: Receive failed %d (errno=3D%d=
:%s)\n", sockfd, iReceived, errno, strerror(errno));
-        }
+			DBG("Answering command packet (msgtype=3D%s,signal=3D%d)", accepted ?=
 "MESSAGE_TYPE_ACCEPT" : "MESSAGE_TYPE_REJECT", pkt_hdr->signal_id);
+			// Reject a command received
+			pkt_hdr->message_type =3D accepted ? MESSAGE_TYPE_ACCEPT : MESSAGE_TY=
PE_REJECT;
+
+			wrresult =3D write(sockfd, pkt_hdr, sizeof(*pkt_hdr));
+
+			if (wrresult !=3D sizeof(*pkt_hdr)) {
+				DBG("FAILED Answering command packet (msgtype=3D%s,signal=3D%d) wrre=
sult=3D%d/%d (errno=3D%d:%s)", accepted ? "MESSAGE_TYPE_ACCEPT" : "MESSAG=
E_TYPE_REJECT", pkt_hdr->signal_id,
+				    wrresult, sizeof(*pkt_hdr), errno, strerror(errno));
+			}
+		} else {
+			DBG("Read non command packet (msgtype=3D%d,signal=3D%d)", pkt_hdr->me=
ssage_type, pkt_hdr->signal_id);
+		}
+	} else {
+		result =3D iReceived;
+		if (errno !=3D EAGAIN)
+			printf("socket %d: Receive failed %d (errno=3D%d:%s)\n", sockfd, iRec=
eived, errno, strerror(errno));
+	}
=20
-        return result;
+	return result;
 }
-
Index: alsa-plugins/alsalib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/alsalib.c
diff -N alsa-plugins/alsalib.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/alsalib.c	31 Aug 2006 15:58:57 -0000
@@ -0,0 +1,203 @@
+/*
+*
+*  BlueZ - Bluetooth protocol stack for Linux
+*
+*  Copyright (C) 2004-2005  Marcel Holtmann <marcel@holtmann.org>
+*
+*
+*  This library is free software; you can redistribute it and/or
+*  modify it under the terms of the GNU Lesser General Public
+*  License as published by the Free Software Foundation; either
+*  version 2.1 of the License, or (at your option) any later version.
+*
+*  This library is distributed in the hope that it will be useful,
+*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+*  Lesser General Public License for more details.
+*
+*  You should have received a copy of the GNU Lesser General Public
+*  License along with this library; if not, write to the Free Software
+*  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301=
  USA
+*
+*/
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <malloc.h>
+#include <signal.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/select.h>
+
+#include <netinet/in.h>
+
+#include <pthread.h>
+#include <alsa/asoundlib.h>
+#include "alsalib.h"
+#include "a2dpd_protocol.h"
+
+#define NBSDPRETRIESMAX 0
+#define NONSPECAUDIO 1
+#define BUFS 2048
+
+#define DBG(fmt, arg...) { if(errno!=3D0) printf("DEBUG: %s: (errno=3D%d=
:%s)" fmt "\n" , __FUNCTION__ , errno, strerror(errno), ## arg); else pri=
ntf("DEBUG: %s: " fmt "\n" , __FUNCTION__ , ## arg); errno=3D0; }
+
+//#define DBG(fmt, arg...)  printf("DEBUG: %s: " fmt "\n" , __FUNCTION__=
 , ## arg)
+//#define DBG(D...)
+
+static struct sigaction actions;
+
+typedef struct snd_pcm_alsa {
+	snd_pcm_t *playback_handle;
+} snd_pcm_alsa_t;
+
+/*
+*   Underrun and suspend recovery
+*/
+
+static int xrun_recovery(snd_pcm_t * handle, int err)
+{
+	if (err =3D=3D -EPIPE) {	/* under-run */
+		err =3D snd_pcm_prepare(handle);
+		if (err < 0)
+			printf("Can't recovery from underrun, prepare failed: %s\n", snd_stre=
rror(err));
+		return 0;
+	} else if (err =3D=3D -ESTRPIPE) {
+		while ((err =3D snd_pcm_resume(handle)) =3D=3D -EAGAIN)
+			sleep(1);	/* wait until the suspend flag is released */
+		if (err < 0) {
+			err =3D snd_pcm_prepare(handle);
+			if (err < 0)
+				printf("Can't recovery from suspend, prepare failed: %s\n", snd_stre=
rror(err));
+		}
+		return 0;
+	}
+	return err;
+}
+
+int alsa_transfer_raw(LPALSA alsa, const char *pcm_buffer, int pcm_buffe=
r_size)
+{
+	int result =3D 0;
+
+	result =3D snd_pcm_writei(alsa->playback_handle, pcm_buffer, pcm_buffer=
_size / A2DPD_FRAME_BYTES);
+	switch (result) {
+	case -EBADFD:
+		DBG("EBADFD(%d)", result);
+		break;
+	case -EPIPE:
+		// To manage underrun, we will try to ignore
+		xrun_recovery(alsa->playback_handle, result);
+		//result =3D 0;
+		DBG("EPIPE(%d)", result);
+		break;
+	case -ESTRPIPE:
+		xrun_recovery(alsa->playback_handle, result);
+		//result=3D0;
+		DBG("ESTRPIPE(%d)", result);
+		break;
+	}
+
+	return result;
+}
+
+snd_pcm_alsa_t *alsa_alloc(void)
+{
+	snd_pcm_alsa_t *alsa;
+	alsa =3D malloc(sizeof(*alsa));
+	if (!alsa)
+		return NULL;
+
+	memset(alsa, 0, sizeof(*alsa));
+	return alsa;
+}
+
+void alsa_free(snd_pcm_alsa_t * alsa)
+{
+	free(alsa);
+}
+
+static void sighand(int signo)
+{
+	return;
+}
+
+void alsa_init(void)
+{
+	// set up thread signal handler
+	memset(&actions, 0, sizeof(actions));
+	sigemptyset(&actions.sa_mask);
+	actions.sa_flags =3D 0;
+	actions.sa_handler =3D sighand;
+	sigaction(SIGALRM, &actions, NULL);
+}
+
+void alsa_exit(void)
+{
+}
+
+LPALSA alsa_new(char *device, int framerate)
+{
+	DBG("");
+	snd_pcm_alsa_t *alsa =3D NULL;
+	snd_pcm_hw_params_t *hw_params =3D NULL;
+	int bcontinue =3D 1;
+	char *devname =3D (device && device[0]) ? device : "plughw:0,0";
+
+	alsa =3D alsa_alloc();
+	if (!alsa) {
+		DBG("Can't allocate");
+		return NULL;
+	}
+	// Setup alsa
+	bcontinue =3D bcontinue && (snd_pcm_open(&alsa->playback_handle, devnam=
e, SND_PCM_STREAM_PLAYBACK, 0) >=3D 0);
+	DBG("snd_pcm_open()=3D=3D%d", bcontinue);
+	bcontinue =3D bcontinue && (snd_pcm_hw_params_malloc(&hw_params) >=3D 0=
);
+	DBG("snd_pcm_hw_params_malloc()=3D=3D%d", bcontinue);
+	bcontinue =3D bcontinue && (snd_pcm_hw_params_any(alsa->playback_handle=
, hw_params) >=3D 0);
+	DBG("snd_pcm_hw_params_any()=3D=3D%d", bcontinue);
+	bcontinue =3D bcontinue && (snd_pcm_hw_params_set_access(alsa->playback=
_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED) >=3D 0);
+	DBG("snd_pcm_hw_params_set_access()=3D=3D%d", bcontinue);
+	bcontinue =3D bcontinue && (snd_pcm_hw_params_set_format(alsa->playback=
_handle, hw_params, SND_PCM_FORMAT_S16_LE) >=3D 0);
+	DBG("snd_pcm_hw_params_set_format()=3D=3D%d", bcontinue);
+	bcontinue =3D bcontinue && (snd_pcm_hw_params_set_rate(alsa->playback_h=
andle, hw_params, framerate, 0) >=3D 0);
+	DBG("snd_pcm_hw_params_set_rate()=3D=3D%d", bcontinue);
+	bcontinue =3D bcontinue && (snd_pcm_hw_params_set_channels(alsa->playba=
ck_handle, hw_params, 2) >=3D 0);
+	DBG("snd_pcm_hw_params_set_channels()=3D=3D%d", bcontinue);
+	bcontinue =3D bcontinue && (snd_pcm_hw_params(alsa->playback_handle, hw=
_params) >=3D 0);
+	DBG("snd_pcm_hw_params()=3D=3D%d", bcontinue);
+	bcontinue =3D bcontinue && (snd_pcm_prepare(alsa->playback_handle) >=3D=
 0);
+	DBG("snd_pcm_prepare()=3D=3D%d", bcontinue);
+
+	// Free if allocated
+	if (hw_params)
+		snd_pcm_hw_params_free(hw_params);
+
+	if (alsa->playback_handle !=3D NULL) {
+	}
+
+	if (!bcontinue) {
+		alsa_destroy(alsa);
+		alsa =3D NULL;
+	}
+
+	return alsa;
+}
+
+void alsa_destroy(LPALSA alsa)
+{
+	DBG("");
+	if (alsa->playback_handle !=3D NULL) {
+		snd_pcm_close(alsa->playback_handle);
+	}
+	alsa_free(alsa);
+	DBG("OK");
+}
Index: alsa-plugins/alsalib.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/alsalib.h
diff -N alsa-plugins/alsalib.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/alsalib.h	31 Aug 2006 15:58:57 -0000
@@ -0,0 +1,48 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2005  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
+ *
+ */
+
+#ifndef __ALSA_LIB_H__
+#define __ALSA_LIB_H__
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+
+#define A2DPMAXIMUMTRANSFERUNITSIZE 610
+
+typedef struct snd_pcm_alsa* LPALSA;
+
+// Global library initialisation
+extern void alsa_init( void);
+extern void alsa_exit( void);
+
+// Connect to alsa
+extern LPALSA alsa_new( char* device, int framerate);
+extern void alsa_destroy( LPALSA a2dp);
+
+// transfers data
+extern int alsa_transfer_raw( LPALSA a2dp, const char* pcm_buffer, int p=
cm_buffer_size);
+
+#endif
Index: alsa-plugins/pcm_a2dpd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/pcm_a2dpd.c,v
retrieving revision 1.4
diff -u -r1.4 pcm_a2dpd.c
--- alsa-plugins/pcm_a2dpd.c	17 Aug 2006 14:06:27 -0000	1.4
+++ alsa-plugins/pcm_a2dpd.c	31 Aug 2006 15:58:57 -0000
@@ -51,381 +51,358 @@
 #define DBG(fmt, arg...)  printf("DEBUG: %s: (errno=3D%d:%s)" fmt "\n" ,=
 __FUNCTION__ , errno, strerror(errno), ## arg)
 //#define DBG(D...)
=20
-static char     g_srcfilename           [512];
+static char g_srcfilename[512];
=20
 // Signal handler, there is a strange SIGPIPE when the daemon is not run=
ning
 // We catch it to not quit
 void sighand(int signo)
 {
-        printf("A2DPD CTL in signal handler %d\n", signo);
-        return;
+	printf("A2DPD CTL in signal handler %d\n", signo);
+	return;
 }
=20
-typedef struct snd_pcm_a2dp
-{
-        snd_pcm_ioplug_t io;
-        int sk;
-        int rate;
-        int channels;
-        snd_pcm_sframes_t num;
-        unsigned int frame_bytes;
-        TIMERINFO TimerInfos;
+typedef struct snd_pcm_a2dp {
+	snd_pcm_ioplug_t io;
+	int sk;
+	int rate;
+	int channels;
+	snd_pcm_sframes_t num;
+	unsigned int frame_bytes;
+	TIMERINFO TimerInfos;
 } snd_pcm_a2dp_t;
=20
-static int a2dp_disconnect(snd_pcm_a2dp_t *a2dp)
+static int a2dp_disconnect(snd_pcm_a2dp_t * a2dp)
 {
-        close_socket(a2dp->sk);
-        a2dp->sk =3D -1;
-        return 0;
-}
-
-static int a2dp_connect(snd_pcm_a2dp_t *a2dp)
-{
-        if(a2dp->sk <=3D 0)
-        {
-                int sockfd =3D make_client_socket();
-                a2dp->sk =3D -1;
-                if(sockfd>0)
-                {
-                        int32_t client_type =3D A2DPD_PLUGIN_PCM_WRITE;
-                        if(send_socket(sockfd, &client_type, sizeof(clie=
nt_type))=3D=3Dsizeof(client_type))
-                        {
-                                a2dp->sk =3D sockfd;
-                                syslog(LOG_INFO, "Connected a2dp %p, sk =
%d", a2dp, a2dp->sk);
-                        }
-                        else
-                        {
-                                close_socket(sockfd);
-                                syslog(LOG_WARNING, "Connected a2dp %p, =
sk %d, Authorisation failed", a2dp, a2dp->sk);
-                        }
-                }
-                else
-                {
-                        syslog(LOG_ERR, "Socket failed a2dp %p, sk %d", =
a2dp, a2dp->sk);
-                }
-        }
-        return 0;
+	close_socket(a2dp->sk);
+	a2dp->sk =3D -1;
+	return 0;
+}
+
+static int a2dp_connect(snd_pcm_a2dp_t * a2dp)
+{
+	if (a2dp->sk <=3D 0) {
+		int sockfd =3D make_client_socket();
+		a2dp->sk =3D -1;
+		if (sockfd > 0) {
+			int32_t client_type =3D A2DPD_PLUGIN_PCM_WRITE;
+			if (send_socket(sockfd, &client_type, sizeof(client_type)) =3D=3D siz=
eof(client_type)) {
+				a2dp->sk =3D sockfd;
+				syslog(LOG_INFO, "Connected a2dp %p, sk %d", a2dp, a2dp->sk);
+			} else {
+				close_socket(sockfd);
+				syslog(LOG_WARNING, "Connected a2dp %p, sk %d, Authorisation failed"=
, a2dp, a2dp->sk);
+			}
+		} else {
+			syslog(LOG_ERR, "Socket failed a2dp %p, sk %d", a2dp, a2dp->sk);
+		}
+	}
+	return 0;
 }
=20
 static inline snd_pcm_a2dp_t *a2dp_alloc(void)
 {
-        snd_pcm_a2dp_t *a2dp;
-        DBG("Init");
-        a2dp =3D malloc(sizeof(*a2dp));
-        if (!a2dp)
-                return NULL;
-        memset(a2dp, 0, sizeof(*a2dp));
-        a2dp->sk =3D -1;
+	snd_pcm_a2dp_t *a2dp;
+	DBG("Init");
+	a2dp =3D malloc(sizeof(*a2dp));
+	if (!a2dp)
+		return NULL;
+	memset(a2dp, 0, sizeof(*a2dp));
+	a2dp->sk =3D -1;
=20
-        {
-                get_config_filename(g_srcfilename, sizeof(g_srcfilename)=
);
-                int rate =3D read_config_int(g_srcfilename, "a2dpd", "ra=
te", A2DPD_FRAME_RATE);
-                a2dp->TimerInfos.fps =3D (float)((((float)rate)*((float)=
A2DPD_FRAME_BYTES)/((float)A2DPD_BLOCK_SIZE))/1.0);
-        }
-        DBG("OK");
-        return a2dp;
+	{
+		get_config_filename(g_srcfilename, sizeof(g_srcfilename));
+		int rate =3D read_config_int(g_srcfilename, "a2dpd", "rate", A2DPD_FRA=
ME_RATE);
+		a2dp->TimerInfos.fps =3D (float) ((((float) rate) * ((float) A2DPD_FRA=
ME_BYTES) / ((float) A2DPD_BLOCK_SIZE)) / 1.0);
+	}
+	DBG("OK");
+	return a2dp;
 }
=20
-static inline void a2dp_free(snd_pcm_a2dp_t *a2dp)
+static inline void a2dp_free(snd_pcm_a2dp_t * a2dp)
 {
-        DBG("Finishing");
-        a2dp_disconnect(a2dp);
-        free(a2dp);
-        DBG("OK");
+	DBG("Finishing");
+	a2dp_disconnect(a2dp);
+	free(a2dp);
+	DBG("OK");
 }
=20
-static int a2dp_start(snd_pcm_ioplug_t *io)
+static int a2dp_start(snd_pcm_ioplug_t * io)
 {
-        //snd_pcm_a2dp_t *a2dp =3D io->private_data;
-        //FIXME
-        return 0;
+	//snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	//FIXME
+	return 0;
 }
=20
-static int a2dp_stop(snd_pcm_ioplug_t *io)
+static int a2dp_stop(snd_pcm_ioplug_t * io)
 {
-        //snd_pcm_a2dp_t *a2dp =3D io->private_data;
-        return 0;
+	//snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	return 0;
 }
=20
-static snd_pcm_sframes_t a2dp_pointer(snd_pcm_ioplug_t *io)
+static snd_pcm_sframes_t a2dp_pointer(snd_pcm_ioplug_t * io)
 {
-        snd_pcm_a2dp_t *a2dp =3D io->private_data;
-        return a2dp->num;
+	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	return a2dp->num;
 }
=20
 // This is the main transfer func which does the transfer and sleep job
-static snd_pcm_sframes_t a2dp_transfer2(snd_pcm_ioplug_t *io,
-                        char* buf,
-                        int32_t datatoread)
-{
-        snd_pcm_a2dp_t* a2dp =3D io->private_data;
-        int transfer =3D 0;
-
-        // Connect if needed and send
-        a2dp_connect(a2dp);
-        if(transfer>=3D0) transfer=3Dsend_socket(a2dp->sk, &datatoread, =
sizeof(datatoread));
-        if(transfer>=3D0) transfer=3Dsend_socket(a2dp->sk, buf, datatore=
ad);
-
-        // Disconnect if error detected
-        if(transfer<0) a2dp_disconnect(a2dp);
-
-        // The data are sent to the daemon that act as a proxy thus we d=
ouble transfer delay to compensate latency
-        a2dp_timer_notifyframe(&a2dp->TimerInfos);
-        a2dp_timer_sleep(&a2dp->TimerInfos, 4*A2DPTIMERPREDELAY);=20
-
-        // Stats
-        if(a2dp->TimerInfos.display>0)
-        {
-                if(errno !=3D 0 || transfer <=3D 0)
-                {
-                        syslog( LOG_INFO, "send_socket(%d bytes)=3D%d (e=
rrno=3D%d:%s)", datatoread, transfer, errno, strerror(errno));
-                }
-        }
+static snd_pcm_sframes_t a2dp_transfer2(snd_pcm_ioplug_t * io, char *buf=
, int32_t datatoread)
+{
+	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	int transfer =3D 0;
=20
-        // update pointer, tell alsa we're done
-        a2dp->num +=3D datatoread / a2dp->frame_bytes;
+	// Connect if needed and send
+	a2dp_connect(a2dp);
+	if (transfer >=3D 0)
+		transfer =3D send_socket(a2dp->sk, &datatoread, sizeof(datatoread));
+	if (transfer >=3D 0)
+		transfer =3D send_socket(a2dp->sk, buf, datatoread);
+
+	// Disconnect if error detected
+	if (transfer < 0)
+		a2dp_disconnect(a2dp);
+
+	// The data are sent to the daemon that act as a proxy thus we double t=
ransfer delay to compensate latency
+	a2dp_timer_notifyframe(&a2dp->TimerInfos);
+	a2dp_timer_sleep(&a2dp->TimerInfos, 4 * A2DPTIMERPREDELAY);
+
+	// Stats
+	if (a2dp->TimerInfos.display > 0) {
+		if (errno !=3D 0 || transfer <=3D 0) {
+			syslog(LOG_INFO, "send_socket(%d bytes)=3D%d (errno=3D%d:%s)", datato=
read, transfer, errno, strerror(errno));
+		}
+	}
+	// update pointer, tell alsa we're done
+	a2dp->num +=3D datatoread / a2dp->frame_bytes;
=20
-        return datatoread / a2dp->frame_bytes;
+	return datatoread / a2dp->frame_bytes;
 }
=20
 // also works but sleeps between transfers
 // This is the main transfer func which does the transfer and sleep job
-static snd_pcm_sframes_t a2dp_transfer_all(snd_pcm_ioplug_t *io,
-                        const snd_pcm_channel_area_t *areas,
-                        snd_pcm_uframes_t offset, snd_pcm_uframes_t size=
)
+static snd_pcm_sframes_t a2dp_transfer_all(snd_pcm_ioplug_t * io, const =
snd_pcm_channel_area_t * areas, snd_pcm_uframes_t offset, snd_pcm_uframes=
_t size)
 {
-        snd_pcm_a2dp_t* a2dp =3D io->private_data;
-        int i =3D 0;
-        snd_pcm_sframes_t totaltransfered =3D 0;
-        while(i++<1 && totaltransfered < size)
-        {
-                char* buf =3D (char *) areas->addr + (areas->first + are=
as->step * offset) / 8;
-                int datatoread=3Dmin(A2DPD_BLOCK_SIZE,size*a2dp->frame_b=
ytes);
-                snd_pcm_sframes_t transfered =3D a2dp_transfer2(io, buf,=
 datatoread);
-                if(transfered>0)
-                {
-                        offset +=3D transfered;
-                        totaltransfered +=3D transfered;
-                }
-                else
-                {
-                        break;
-                }
-        }
-        return totaltransfered;
+	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	int i =3D 0;
+	snd_pcm_sframes_t totaltransfered =3D 0;
+	while (i++ < 1 && totaltransfered < size) {
+		char *buf =3D (char *) areas->addr + (areas->first + areas->step * off=
set) / 8;
+		int datatoread =3D min(A2DPD_BLOCK_SIZE, size * a2dp->frame_bytes);
+		snd_pcm_sframes_t transfered =3D a2dp_transfer2(io, buf, datatoread);
+		if (transfered > 0) {
+			offset +=3D transfered;
+			totaltransfered +=3D transfered;
+		} else {
+			break;
+		}
+	}
+	return totaltransfered;
 }
=20
-static int a2dp_close(snd_pcm_ioplug_t *io)
+static int a2dp_close(snd_pcm_ioplug_t * io)
 {
-        snd_pcm_a2dp_t *a2dp =3D io->private_data;
-        a2dp_disconnect(a2dp);
-        a2dp_free(a2dp);
-        return 0;
+	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	a2dp_disconnect(a2dp);
+	a2dp_free(a2dp);
+	return 0;
 }
=20
-static int a2dp_params(snd_pcm_ioplug_t *io, snd_pcm_hw_params_t *params=
)
+static int a2dp_params(snd_pcm_ioplug_t * io, snd_pcm_hw_params_t * para=
ms)
 {
-        snd_pcm_a2dp_t *a2dp =3D io->private_data;
-        unsigned int period_bytes;
+	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	unsigned int period_bytes;
=20
-        DBG("a2dp %p", a2dp);
+	DBG("a2dp %p", a2dp);
=20
-        a2dp->frame_bytes =3D (snd_pcm_format_physical_width(io->format)=
 * io->channels) / 8;
+	a2dp->frame_bytes =3D (snd_pcm_format_physical_width(io->format) * io->=
channels) / 8;
=20
-        period_bytes =3D io->period_size * a2dp->frame_bytes;
+	period_bytes =3D io->period_size * a2dp->frame_bytes;
=20
-        DBG("format %s rate %d channels %d", snd_pcm_format_name(io->for=
mat),
-                                        io->rate, io->channels);
+	DBG("format %s rate %d channels %d", snd_pcm_format_name(io->format), i=
o->rate, io->channels);
=20
-        DBG("frame_bytes %d period_bytes %d period_size %ld buffer_size =
%ld",
-                a2dp->frame_bytes, period_bytes, io->period_size, io->bu=
ffer_size);
+	DBG("frame_bytes %d period_bytes %d period_size %ld buffer_size %ld", a=
2dp->frame_bytes, period_bytes, io->period_size, io->buffer_size);
=20
-        return 0;
+	return 0;
 }
=20
-static int a2dp_prepare(snd_pcm_ioplug_t *io)
+static int a2dp_prepare(snd_pcm_ioplug_t * io)
 {
-        snd_pcm_a2dp_t *a2dp =3D io->private_data;
-        DBG("a2dp %p", a2dp);
-        a2dp->num =3D 0;
-        a2dp->rate =3D io->rate;
-        a2dp->channels =3D io->channels;
-        return 0;
+	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	DBG("a2dp %p", a2dp);
+	a2dp->num =3D 0;
+	a2dp->rate =3D io->rate;
+	a2dp->channels =3D io->channels;
+	return 0;
 }
=20
-static int a2dp_drain(snd_pcm_ioplug_t *io)
+static int a2dp_drain(snd_pcm_ioplug_t * io)
 {
-        snd_pcm_a2dp_t *a2dp =3D io->private_data;
-        DBG("a2dp %p", a2dp);
-        return 0;
+	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	DBG("a2dp %p", a2dp);
+	return 0;
 }
=20
-static int a2dp_descriptors_count(snd_pcm_ioplug_t *io)
+static int a2dp_descriptors_count(snd_pcm_ioplug_t * io)
 {
-        return 1;
+	return 1;
 }
=20
-static int a2dp_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfds, u=
nsigned int space)
+static int a2dp_descriptors(snd_pcm_ioplug_t * io, struct pollfd *pfds, =
unsigned int space)
 {
-        if (space < 1)
-        {
-                DBG("Can't fill in descriptors");
-                SNDERR("Can't fill in descriptors");
-                return 0;
-        }
-
-        // Alsa does make sure writing now will not block
-        // So give him an always writable socket!
-        pfds[0].fd =3D fileno(stdout);
-        pfds[0].events =3D POLLOUT;
-        return 1;
+	if (space < 1) {
+		DBG("Can't fill in descriptors");
+		SNDERR("Can't fill in descriptors");
+		return 0;
+	}
+	// Alsa does make sure writing now will not block
+	// So give him an always writable socket!
+	pfds[0].fd =3D fileno(stdout);
+	pfds[0].events =3D POLLOUT;
+	return 1;
 }
=20
-static int a2dp_poll(snd_pcm_ioplug_t *io, struct pollfd *pfds,
-                        unsigned int nfds, unsigned short *revents)
+static int a2dp_poll(snd_pcm_ioplug_t * io, struct pollfd *pfds, unsigne=
d int nfds, unsigned short *revents)
 {
-        snd_pcm_a2dp_t *a2dp =3D io->private_data;
-        *revents =3D pfds[0].revents;
+	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+	*revents =3D pfds[0].revents;
=20
-        if (a2dp->sk<=3D0)
-                return 0;
+	if (a2dp->sk <=3D 0)
+		return 0;
=20
-        if (pfds[0].revents & POLLHUP) {
-                a2dp_disconnect(a2dp);
-                snd_pcm_ioplug_reinit_status(&a2dp->io);
-        }
+	if (pfds[0].revents & POLLHUP) {
+		a2dp_disconnect(a2dp);
+		snd_pcm_ioplug_reinit_status(&a2dp->io);
+	}
=20
-        return 0;
+	return 0;
 }
=20
 static snd_pcm_ioplug_callback_t a2dp_callback =3D {
-        .close			=3D a2dp_close,
-        .start			=3D a2dp_start,
-        .stop			=3D a2dp_stop,
-        .prepare		=3D a2dp_prepare,
-        .transfer		=3D a2dp_transfer_all,
-        .pointer		=3D a2dp_pointer,
-        .hw_params		=3D a2dp_params,
-        .drain			=3D a2dp_drain,
-        .poll_descriptors_count	=3D a2dp_descriptors_count,
-        .poll_descriptors	=3D a2dp_descriptors,
-        .poll_revents		=3D a2dp_poll,
+	.close =3D a2dp_close,
+	.start =3D a2dp_start,
+	.stop =3D a2dp_stop,
+	.prepare =3D a2dp_prepare,
+	.transfer =3D a2dp_transfer_all,
+	.pointer =3D a2dp_pointer,
+	.hw_params =3D a2dp_params,
+	.drain =3D a2dp_drain,
+	.poll_descriptors_count =3D a2dp_descriptors_count,
+	.poll_descriptors =3D a2dp_descriptors,
+	.poll_revents =3D a2dp_poll,
 };
=20
 // Force alsa to give use the 44100 hz sound
 // Or say alsa we will accept only 44100hz?
-static int a2dp_constraint(snd_pcm_a2dp_t *a2dp)
+static int a2dp_constraint(snd_pcm_a2dp_t * a2dp)
 {
-        snd_pcm_ioplug_t *io =3D &a2dp->io;
-        snd_pcm_access_t access_list[] =3D {
-                SND_PCM_ACCESS_RW_INTERLEAVED,
-                SND_PCM_ACCESS_MMAP_INTERLEAVED,
-        };
-        unsigned int format[2], channel[2], rate[2];
-        int err;
+	snd_pcm_ioplug_t *io =3D &a2dp->io;
+	snd_pcm_access_t access_list[] =3D {
+		SND_PCM_ACCESS_RW_INTERLEAVED,
+		SND_PCM_ACCESS_MMAP_INTERLEAVED,
+	};
+	unsigned int format[2], channel[2], rate[2];
+	int err;
=20
-        syslog(LOG_INFO, "[build %s %s] a2dp %p", __DATE__, __TIME__, a2=
dp);
+	syslog(LOG_INFO, "[build %s %s] a2dp %p", __DATE__, __TIME__, a2dp);
=20
-        err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCE=
SS, 2, access_list);
-        if (err < 0)
-                return err;
+	err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS, 2, =
access_list);
+	if (err < 0)
+		return err;
=20
-        format[0] =3D SND_PCM_FORMAT_S16_LE;
+	format[0] =3D SND_PCM_FORMAT_S16_LE;
=20
-        err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORM=
AT, 1, format);
-        if (err < 0)
-                return err;
+	err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT, 1, =
format);
+	if (err < 0)
+		return err;
=20
-        channel[0] =3D 1;
-        channel[1] =3D 2;
+	channel[0] =3D 1;
+	channel[1] =3D 2;
=20
-        err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_CHAN=
NELS, 2, channel);
-        if (err < 0)
-                return err;
+	err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_CHANNELS, 2=
, channel);
+	if (err < 0)
+		return err;
=20
-        get_config_filename(g_srcfilename, sizeof(g_srcfilename));
-        rate[0] =3D read_config_int(g_srcfilename, "a2dpd", "rate", A2DP=
D_FRAME_RATE);
-        //rate[1] =3D 48000;
+	get_config_filename(g_srcfilename, sizeof(g_srcfilename));
+	rate[0] =3D read_config_int(g_srcfilename, "a2dpd", "rate", A2DPD_FRAME=
_RATE);
+	//rate[1] =3D 48000;
=20
-        err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_RATE=
, 1, rate);
-        if (err < 0)
-                return err;
+	err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_RATE, 1, ra=
te);
+	if (err < 0)
+		return err;
=20
-        err =3D snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PE=
RIOD_BYTES, 8192, 8192);
-        if (err < 0)
-                return err;
+	err =3D snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIOD_BY=
TES, 8192, 8192);
+	if (err < 0)
+		return err;
=20
-        err =3D snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PE=
RIODS, 2, 2);
-        if (err < 0)
-                return err;
+	err =3D snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS, =
2, 2);
+	if (err < 0)
+		return err;
=20
-        return 0;
+	return 0;
 }
=20
 SND_PCM_PLUGIN_DEFINE_FUNC(a2dpd)
 {
-        snd_pcm_a2dp_t *a2dp =3D NULL;
-        snd_config_iterator_t i, next;
-        int err =3D 0;
-
-        DBG("name %s mode %d", name, mode);
-
-        // set up thread signal handler
-        signal(SIGPIPE,sighand);
-
-        snd_config_for_each(i, next, conf) {
-                snd_config_t *n =3D snd_config_iterator_entry(i);
-                const char *id;
-
-                if (snd_config_get_id(n, &id) < 0)
-                        continue;
-
-                if (!strcmp(id, "comment") || !strcmp(id, "type"))
-                        continue;
-
-                // Ignore old options
-                if (strstr("ipaddr bdaddr port src dst use_rfcomm", id))
-                        continue;
-
-                SNDERR("Unknown field %s", id);
-                return -EINVAL;
-        }
-
-        a2dp =3D a2dp_alloc();
-        if (!a2dp)
-        {
-                SNDERR("Can't allocate plugin data");
-                return -ENOMEM;
-        }
-
-        // Connect
-        a2dp_connect(a2dp);
-
-        // Notify plugin
-        a2dp->io.version      =3D SND_PCM_IOPLUG_VERSION;
-        a2dp->io.name         =3D "Bluetooth Advanced Audio Distribution=
";
-        a2dp->io.mmap_rw      =3D 0;
-        a2dp->io.callback     =3D &a2dp_callback;
-        a2dp->io.private_data =3D a2dp;
-
-        err =3D snd_pcm_ioplug_create(&a2dp->io, name, stream, mode);
-        if (err < 0)
-                goto error;
-
-        err =3D a2dp_constraint(a2dp);
-        if (err < 0) {
-                snd_pcm_ioplug_delete(&a2dp->io);
-                goto error;
-        }
-
-        *pcmp =3D a2dp->io.pcm;
-        return 0;
-
-error:
-        a2dp_disconnect(a2dp);
-        a2dp_free(a2dp);
+	snd_pcm_a2dp_t *a2dp =3D NULL;
+	snd_config_iterator_t i, next;
+	int err =3D 0;
+
+	DBG("name %s mode %d", name, mode);
+
+	// set up thread signal handler
+	signal(SIGPIPE, sighand);
+
+	snd_config_for_each(i, next, conf) {
+		snd_config_t *n =3D snd_config_iterator_entry(i);
+		const char *id;
+
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		if (!strcmp(id, "comment") || !strcmp(id, "type"))
+			continue;
+
+		// Ignore old options
+		if (strstr("ipaddr bdaddr port src dst use_rfcomm", id))
+			continue;
+
+		SNDERR("Unknown field %s", id);
+		return -EINVAL;
+	}
+
+	a2dp =3D a2dp_alloc();
+	if (!a2dp) {
+		SNDERR("Can't allocate plugin data");
+		return -ENOMEM;
+	}
+	// Connect
+	a2dp_connect(a2dp);
+
+	// Notify plugin
+	a2dp->io.version =3D SND_PCM_IOPLUG_VERSION;
+	a2dp->io.name =3D "Bluetooth Advanced Audio Distribution";
+	a2dp->io.mmap_rw =3D 0;
+	a2dp->io.callback =3D &a2dp_callback;
+	a2dp->io.private_data =3D a2dp;
+
+	err =3D snd_pcm_ioplug_create(&a2dp->io, name, stream, mode);
+	if (err < 0)
+		goto error;
+
+	err =3D a2dp_constraint(a2dp);
+	if (err < 0) {
+		snd_pcm_ioplug_delete(&a2dp->io);
+		goto error;
+	}
+
+	*pcmp =3D a2dp->io.pcm;
+	return 0;
+
+      error:
+	a2dp_disconnect(a2dp);
+	a2dp_free(a2dp);
=20
-        return err;
+	return err;
 }
=20
 SND_PCM_PLUGIN_SYMBOL(a2dpd);
Index: alsa-plugins/sample.a2dprc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/sample.a2dprc,v
retrieving revision 1.2
diff -u -r1.2 sample.a2dprc
--- alsa-plugins/sample.a2dprc	17 Aug 2006 14:06:27 -0000	1.2
+++ alsa-plugins/sample.a2dprc	31 Aug 2006 15:58:57 -0000
@@ -1,10 +1,38 @@
 [a2dpd]
+#
+# Rate
+# use 32000 if your headset seems to not support 44100 (HP works well at=
 44100, Sonorix at 32000)
+# Alsa output may not work depending on your graphics card
+# Very few players supports it (xmms does, but not amarok/gxine engine)
+#
 rate=3D44100
 #rate=3D32000
-address=3D00:0D:44:2A:17:C7
+enablereversestereo=3D0
+
+#
+# AVRCP Commands to run
+#
 cmdplay=3Dxmms --play
 cmdpause=3Dxmms --pause
 cmdprev=3Dxmms --rew
 cmdnext=3Dxmms --fwd
 cmdnew=3Dxmms --play
+# Put to 0 to ignore AVRCP (if your computer freezes when commands are r=
eceived)
+enableavrcp=3D1
+
+#
+# Audio routing
+#
+# If set to 1 (at a2dp startup only) a2dp will reread configuration file
+#=C2=A0for audio routing changes each second
+enablerereadconfig=3D1
+
+# 0 =3D> Bluetooth A2DP Sink
+# 1 =3D> Alsa
+enableredirectalsa=3D0
+
+# Your bluetooth headset address
+address=3D00:08:F4:30:07:64
=20
+# Address of your alsa output (default : plughw:0,0) you have to know wh=
at to do
+alsaoutput=3D

--------------020704070906020804060602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------020704070906020804060602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020704070906020804060602--
