Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44C9E670.70105@palmsource.com>
Date: Fri, 28 Jul 2006 12:26:56 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------080308020201040705090508"
Subject: [Bluez-devel] New A2DP related progress
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
--------------080308020201040705090508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi all, Brad, Matthew, Fabien,

My latest work on a2dp daemon. I got good sound on both pc and arm!!=20
Features a volume control plugin.

Stereo stream is still inverted.
There is also a parasite sound that you hear when silence is sent. Both=20
are certainly related!
minor cracks when starting a stream.

Matthew, bmp does work well if esd is selected as output. This is due to=20
difference in alsa data transfer (SND_PCM_ACCESS_RW_INTERLEAVED vs=20
SND_PCM_ACCESS_MMAP_INTERLEAVED). I will have a look later.

Fabien, I successfully used alsamixer to configure volume on my device.=20
Do you know of other software that would allow mixing for any control=20
device? I cannot tell xmms to use the device.

Brad, as usual tarball :D available :=20
http://fdalleau.free.fr/btsco.tar.gz, and a patch attached.

Hope you like it!
Fr=E9d=E9ric


--------------080308020201040705090508
Content-Type: text/x-patch;
 name="btsco-diff-cvs-2006-07-28.patch"
Content-Disposition: inline;
 filename="btsco-diff-cvs-2006-07-28.patch"
Content-Transfer-Encoding: quoted-printable

? .deps
? Makefile
? Makefile.in
? aclocal.m4
? autom4te.cache
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
? mkinstalldirs
? stamp-h
? stamp-h.in
? alsa-plugins/.deps
? alsa-plugins/Makefile
? alsa-plugins/Makefile.in
? avdtp/.deps
? avdtp/Makefile
? avdtp/Makefile.in
? sbc/.deps
? sbc/Makefile
? sbc/Makefile.in
Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/configure.in,v
retrieving revision 1.11
diff -u -r1.11 configure.in
--- configure.in	5 Jan 2006 22:51:06 -0000	1.11
+++ configure.in	28 Jul 2006 09:48:08 -0000
@@ -5,7 +5,7 @@
 AC_PREREQ(2.50)
 AC_INIT()
=20
-AM_INIT_AUTOMAKE(btsco, 0.2)
+AM_INIT_AUTOMAKE(btsco, 0.42)
 AM_CONFIG_HEADER(config.h)
=20
 if (test "${CFLAGS}" =3D ""); then
Index: alsa-plugins/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/Makefile.am,v
retrieving revision 1.3
diff -u -r1.3 Makefile.am
--- alsa-plugins/Makefile.am	12 Jul 2006 05:47:06 -0000	1.3
+++ alsa-plugins/Makefile.am	28 Jul 2006 09:48:08 -0000
@@ -1,5 +1,6 @@
 libasound_module_pcm_a2dp_la_LDFLAGS =3D -module -avoid-version -export-=
dynamic
 libasound_module_pcm_a2dpd_la_LDFLAGS =3D -module -avoid-version -export=
-dynamic
+libasound_module_ctl_a2dpd_la_LDFLAGS =3D -module -avoid-version -export=
-dynamic
 libasound_module_pcm_headset_la_LDFLAGS =3D -module -avoid-version -expo=
rt-dynamic
=20
 if ALSAPLUGIN
@@ -8,20 +9,23 @@
=20
 alsadir =3D $(libdir)/alsa-lib
=20
-alsa_LTLIBRARIES =3D libasound_module_pcm_a2dp.la libasound_module_pcm_a=
2dpd.la libasound_module_pcm_headset.la
+alsa_LTLIBRARIES =3D libasound_module_pcm_a2dp.la libasound_module_pcm_a=
2dpd.la libasound_module_ctl_a2dpd.la libasound_module_pcm_headset.la
=20
 libasound_module_pcm_a2dp_la_SOURCES =3D pcm_a2dp.c
 libasound_module_pcm_a2dp_la_LIBADD =3D @ALSA_LIBS@ @BLUEZ_LIBS@ -lsbc -=
lpthread
=20
-libasound_module_pcm_a2dpd_la_SOURCES =3D pcm_a2dpd.c
-libasound_module_pcm_a2dpd_la_LIBADD =3D @ALSA_LIBS@ @BLUEZ_LIBS@ -lsbc =
-lpthread
+libasound_module_pcm_a2dpd_la_SOURCES =3D pcm_a2dpd.c a2dp_timer.c a2dp_=
ipc.c
+libasound_module_pcm_a2dpd_la_LIBADD =3D @ALSA_LIBS@ -lrt
+
+libasound_module_ctl_a2dpd_la_SOURCES =3D ctl_a2dpd.c a2dp_ipc.c
+libasound_module_ctl_a2dpd_la_LIBADD =3D @ALSA_LIBS@
=20
 libasound_module_pcm_headset_la_SOURCES =3D pcm_headset.c
 libasound_module_pcm_headset_la_LIBADD =3D @ALSA_LIBS@ @BLUEZ_LIBS@ -lpt=
hread
=20
-noinst_PROGRAMS =3D a2dpd
-a2dpd_SOURCES =3D a2dpd.c a2dplib.c
-a2dpd_LDADD =3D @BLUEZ_LIBS@ -lsbc -lpthread
+bin_PROGRAMS =3D a2dpd
+a2dpd_SOURCES =3D a2dpd.c a2dplib.c a2dp_timer.c a2dp_ipc.c
+a2dpd_LDADD =3D @BLUEZ_LIBS@ -lsbc -lpthread -lrt
=20
 AM_CFLAGS =3D @ALSA_CFLAGS@ @BLUEZ_CFLAGS@ -pthread
=20
Index: alsa-plugins/a2dp_ipc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/a2dp_ipc.c
diff -N alsa-plugins/a2dp_ipc.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/a2dp_ipc.c	28 Jul 2006 09:48:08 -0000
@@ -0,0 +1,173 @@
+/*
+*
+*  A2DPD - Bluetooth A2DP daemon for Linux
+*
+*  Copyright (C) 2006  Fr=C3=A9d=C3=A9ric DALLEAU <frederic.dalleau@palm=
source.com>
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; either version 2 of the License, or
+*  (at your option) any later version.
+*
+*  This program is distributed in the hope that it will be useful,
+*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+*  GNU General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License
+*  along with this program; if not, write to the Free Software
+*  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+*/
+
+#include "a2dp_ipc.h"
+#include <unistd.h>
+#include <string.h>
+#include <syslog.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#define DEFAULTIP    "127.0.0.1"
+#define DEFAULTPORT  21453
+#define BROADCASTIP  "127.0.0.255"
+
+void close_socket(int sockfd)
+{
+        if(sockfd>0) close(sockfd);
+}
+
+int make_udp_socket()
+{
+        int sockfd =3D socket(PF_INET, SOCK_DGRAM, 0);
+        if(sockfd>0)
+        {
+                int broadcast=3D1;
+                if(setsockopt(sockfd, SOL_SOCKET, SO_BROADCAST, &broadca=
st, sizeof(broadcast)) =3D=3D 0)
+                {
+                        struct sockaddr_in peer_addr;
+                        peer_addr.sin_family =3D AF_INET;
+                        peer_addr.sin_port =3D htons(DEFAULTPORT);
+                        peer_addr.sin_addr.s_addr =3D inet_addr(BROADCAS=
TIP);
+                        // Connect on a datagram socket simulate recvfro=
m with the address specified
+                        bind(sockfd, (struct sockaddr *)&peer_addr, size=
of(peer_addr));
+                        if(connect(sockfd, (struct sockaddr*)&peer_addr,=
 sizeof(peer_addr)) =3D=3D 0)
+                        {
+                        }
+                        else
+                        {
+                                close(sockfd);
+                                sockfd=3D-1;
+                        }
+               }
+               else
+               {
+                       close(sockfd);
+                       sockfd=3D-1;
+               }
+        }
+        return sockfd;
+}
+
+int make_client_socket()
+{
+        int sockfd =3D socket(PF_INET, SOCK_STREAM, 0);
+        if(sockfd>0)
+        {
+                struct sockaddr_in peer_addr;
+                peer_addr.sin_family =3D AF_INET;
+                peer_addr.sin_port =3D htons(DEFAULTPORT);
+                peer_addr.sin_addr.s_addr =3D inet_addr(DEFAULTIP);
+                connect(sockfd, (struct sockaddr*)&peer_addr, sizeof(pee=
r_addr));
+        }
+        return sockfd;
+}
+
+int make_server_socket()
+{
+        int sockfd =3D socket(PF_INET, SOCK_STREAM, 0);
+        struct sockaddr_in my_addr;
+        memset(&my_addr, 0, sizeof(my_addr));
+        my_addr.sin_family =3D AF_INET;
+        my_addr.sin_port =3D htons(DEFAULTPORT);
+        my_addr.sin_addr.s_addr =3D INADDR_ANY;
+
+        if(sockfd>0)
+        {
+                if(bind(sockfd, (struct sockaddr *)&my_addr, sizeof(stru=
ct sockaddr))=3D=3D0)
+                {
+                        if(listen(sockfd, 10)=3D=3D0)
+                        {
+                                // No error
+                        }
+                        else
+                        {
+                                close(sockfd);
+                                sockfd =3D -3;
+                        }
+                }
+                else
+                {
+                        close(sockfd);
+                        sockfd =3D -2;
+                }
+        }
+
+        return sockfd;
+}
+
+int accept_socket(int sockfd)
+{
+        // Block until connections
+        struct sockaddr_in peer_addr;
+        int sin_size =3D sizeof(peer_addr);
+        int new_fd =3D accept(sockfd, (struct sockaddr *)&peer_addr, &si=
n_size);
+        return new_fd;
+}
+
+void setup_socket(int sockfd)
+{
+        // Timeouts
+        struct timeval t =3D { 2, 100 };
+        setsockopt( sockfd, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
+        setsockopt( sockfd, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+}
+
+
+int send_socket(int sockfd, void* buffer, int size)
+{
+        int result =3D -1;
+        int ioffset =3D 0;
+        while(sockfd>0 && ioffset<size)
+        {
+                result=3Dsend(sockfd, ((char*)buffer)+ioffset, size-ioff=
set, MSG_NOSIGNAL);
+                if(result>0)
+                {
+                        ioffset +=3D result;
+                }
+                else
+                {
+                        break;
+                }
+        }
+        return result;
+
+}
+
+int recv_socket(int sockfd, void* buffer, int size)
+{
+        int received =3D 0;
+        while(buffer && received<size)
+        {
+                int result =3D recv(sockfd, buffer+received, size-receiv=
ed, MSG_NOSIGNAL);
+                if(result>0)
+                {
+                        received +=3D result;
+                }
+                else
+                {
+                        received=3Dresult;
+                        break;
+                }
+        }
+        return received;
+}
Index: alsa-plugins/a2dp_ipc.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/a2dp_ipc.h
diff -N alsa-plugins/a2dp_ipc.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/a2dp_ipc.h	28 Jul 2006 09:48:08 -0000
@@ -0,0 +1,39 @@
+/*
+*
+*  A2DPD - Bluetooth A2DP daemon for Linux
+*
+*  Copyright (C) 2006  Fr=C3=A9d=C3=A9ric DALLEAU <frederic.dalleau@palm=
source.com>
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; either version 2 of the License, or
+*  (at your option) any later version.
+*
+*  This program is distributed in the hope that it will be useful,
+*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+*  GNU General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License
+*  along with this program; if not, write to the Free Software
+*  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+*/
+
+
+#ifndef __A2DP_IPC_H__
+#define __A2DP_IPC_H__
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+int make_udp_socket();
+int make_client_socket();
+int make_server_socket();
+void setup_socket(int sockfd);
+void close_socket(int sockfd);
+int accept_socket(int sockfd);
+int send_socket(int sockfd, void* buffer, int size);
+int recv_socket(int sockfd, void* buffer, int size);
+
+#endif
Index: alsa-plugins/a2dp_timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/a2dp_timer.c
diff -N alsa-plugins/a2dp_timer.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/a2dp_timer.c	28 Jul 2006 09:48:08 -0000
@@ -0,0 +1,122 @@
+/*
+*
+*  A2DPD - Bluetooth A2DP daemon for Linux
+*
+*  Copyright (C) 2006  Fr=C3=A9d=C3=A9ric DALLEAU <frederic.dalleau@palm=
source.com>
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; either version 2 of the License, or
+*  (at your option) any later version.
+*
+*  This program is distributed in the hope that it will be useful,
+*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+*  GNU General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License
+*  along with this program; if not, write to the Free Software
+*  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+*/
+
+#include "a2dp_timer.h"
+#include <time.h>
+#include <unistd.h>
+#include <syslog.h>
+
+void sleeptodate(LPTIMERINFO lpTimerInfo, struct timeval* date, int pred=
elay)
+{
+        struct timeval now;
+        struct timeval resolutionval=3D{0, predelay + (int)(lpTimerInfo-=
>timer_resolution.tv_nsec/1000)};
+
+        // See if we have time to wait
+        timeradd(&lpTimerInfo->timeofday, &resolutionval, &now);
+        if (timercmp(date, &now, >))
+        {
+                // Synchronise with usleep 20 ms cycle
+                usleep(1);
+                // See if we must wait again
+                gettimeofday(&now, NULL);
+                timeradd(&now, &resolutionval, &now);
+                if (timercmp(date, &now, >))
+                {
+                        struct timeval interval =3D { 0, 0 };
+                        timersub(date, &now, &interval);
+                        // sleep
+                        usleep(interval.tv_usec);
+                }
+        }
+        else
+        {
+                // We're late, do not wait
+        }
+}
+
+// This version uses values never reset
+void keepfreqtotal(LPTIMERINFO lpTimerInfo, LPKEEPFREQ lpKeepFreq, int p=
redelay)
+{
+        struct timeval playtime, theoricaldate;
+
+        playtime.tv_sec=3D((int)(1.0*1000.0*1000.0*lpTimerInfo->itotalco=
unt/lpTimerInfo->fps))/1000000;
+        playtime.tv_usec=3D((int)(1.0*1000.0*1000.0*lpTimerInfo->itotalc=
ount/lpTimerInfo->fps))%1000000;
+        timeradd(&lpTimerInfo->totalcounter, &playtime, &theoricaldate);
+        // Si la date th=C3=A9orique est sup=C3=A9rieure =C3=A0 la date =
actuelle
+        if(timercmp(&theoricaldate, &lpTimerInfo->timeofday, >))
+        {
+                sleeptodate(lpTimerInfo, &theoricaldate, predelay);
+        }
+}
+
+void a2dp_timer_notifyframe(LPTIMERINFO lpTimerInfo)
+{
+        struct timeval lastframe_interval =3D {0,0};
+        struct timeval maxallowed_interval =3D {0,200*1000};
+        gettimeofday(&lpTimerInfo->timeofday, NULL);
+        timersub(&lpTimerInfo->timeofday, &lpTimerInfo->lastframe, &last=
frame_interval);
+        // Previous frames older than 1 second, reset counters
+        if(timercmp(&lastframe_interval, &maxallowed_interval, >))
+        {
+                // We must reset the total counter because else, we will=
 believe the date is late
+                gettimeofday(&lpTimerInfo->totalcounter, NULL);
+                lpTimerInfo->itotalcount=3D0;
+        }
+        gettimeofday(&lpTimerInfo->lastframe, NULL);
+}
+
+void a2dp_timer_sleep(LPTIMERINFO lpTimerInfo, int predelay)
+{
+        gettimeofday(&lpTimerInfo->timeofday, NULL);
+
+        // Initialize timers
+        if(lpTimerInfo->staticcounter.tv_sec=3D=3D0)
+                gettimeofday(&lpTimerInfo->staticcounter, NULL);
+        if(lpTimerInfo->totalcounter.tv_sec=3D=3D0)
+        {
+                gettimeofday(&lpTimerInfo->totalcounter, NULL);
+                lpTimerInfo->itotalcount=3D0;
+        }
+        if(lpTimerInfo->timer_resolution.tv_nsec =3D=3D 0)
+                clock_getres(CLOCK_REALTIME, &lpTimerInfo->timer_resolut=
ion);
+
+        // Duration since last call
+        timersub(&lpTimerInfo->timeofday, &lpTimerInfo->staticcounter, &=
lpTimerInfo->duration);
+
+        // Display data once per second
+        if(lpTimerInfo->duration.tv_sec>0)
+        {
+                // Reset all statistics
+                gettimeofday(&lpTimerInfo->staticcounter, NULL);
+                lpTimerInfo->display=3DlpTimerInfo->icount;
+                lpTimerInfo->icount=3D0;
+        }
+        else
+        {
+                lpTimerInfo->display=3D0;
+        }
+
+        keepfreqtotal(lpTimerInfo, &lpTimerInfo->k, predelay);
+
+        lpTimerInfo->icount++;
+        lpTimerInfo->itotalcount++;
+}
+
Index: alsa-plugins/a2dp_timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/a2dp_timer.h
diff -N alsa-plugins/a2dp_timer.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/a2dp_timer.h	28 Jul 2006 09:48:08 -0000
@@ -0,0 +1,75 @@
+/*
+*
+*  A2DPD - Bluetooth A2DP daemon for Linux
+*
+*  Copyright (C) 2006  Fr=C3=A9d=C3=A9ric DALLEAU <frederic.dalleau@palm=
source.com>
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; either version 2 of the License, or
+*  (at your option) any later version.
+*
+*  This program is distributed in the hope that it will be useful,
+*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+*  GNU General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License
+*  along with this program; if not, write to the Free Software
+*  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+*/
+
+
+#ifndef __A2DP_TIMER_H__
+#define __A2DP_TIMER_H__
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sys/time.h>
+
+#define A2DPTIMERPREDELAY       2000
+#define CUMULATIVESLEEPDELAY    10000
+
+typedef struct
+{
+        struct timeval t;
+} SLEEPTILL, *LPSLEEPTILL;
+
+
+typedef struct
+{
+        struct timeval t;
+} KEEPFREQ, *LPKEEPFREQ;
+
+//=20
+typedef struct=20
+{
+        float fps;                              // Number of frames per =
second to achieve
+
+        union
+        {
+                SLEEPTILL s;
+                KEEPFREQ  k;
+        };
+
+        struct timespec timer_resolution;       // Resolution of the tim=
er in nanoseconds
+        struct timeval timeofday;               // Date of this frame
+        struct timeval lastframe;               // Date of last frame
+        struct timeval staticcounter;           // Date of frame 0 (icou=
nt=3D0) reseted each second
+        struct timeval totalcounter;            // Date of frame 0 (itot=
alcount=3D0)
+        struct timeval duration;                // Time since last frame
+        int icount;                             // Count of frames for t=
his second
+        int itotalcount;                        // Count of frames since=
 startup
+        int display;                            // non z=C3=A9ro if a se=
cond has just ended
+} TIMERINFO, *LPTIMERINFO;
+
+// Use notify frame when some data is sent
+void a2dp_timer_notifyframe(LPTIMERINFO lpTimerInfo);
+
+// Use sleep in your upper level loop
+// When no calls to notify_frame are done, internal statistics counter w=
ill be reseted
+void a2dp_timer_sleep(LPTIMERINFO lpTimerInfo, int predelay);
+
+#endif
Index: alsa-plugins/a2dpd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd.c,v
retrieving revision 1.1
diff -u -r1.1 a2dpd.c
--- alsa-plugins/a2dpd.c	12 Jul 2006 05:47:06 -0000	1.1
+++ alsa-plugins/a2dpd.c	28 Jul 2006 09:48:08 -0000
@@ -27,26 +27,26 @@
 #include <errno.h>
 #include <signal.h>
 #include <pthread.h>
+#include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/time.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
=20
 #include "a2dplib.h"
+#include "a2dpd_protocol.h"
+#include "a2dp_timer.h"
+#include "a2dp_ipc.h"
=20
 #define BLUETOOTHSOUNDFIFOSIZE (16*1024)
 #define MAXBLUETOOTHDEVICES    3
-#define MYPORT                 21453
 #define MAXCLIENTSPERDEVICE    8
-#define MAXCLIENTSRINGSIZE     8
-#define POOLENTRYSIZE          512
+#define MAXCLIENTSRINGSIZE     64
+#define POOLENTRYSIZE          A2DPD_BLOCK_SIZE
=20
 // if 1 then quit gently
-static int bSigINTReceived =3D 0;
+static sig_atomic_t bSigINTReceived =3D 0;
=20
 // count the number of client running
-static int iThreadsRunning =3D 0;
+static sig_atomic_t iThreadsRunning =3D 0;
=20
 #define max(x,y) ((x)>(y)?(x):(y))
=20
@@ -59,35 +59,35 @@
 {
         free(pool);
 }
-
 // Data used to mix audio
 typedef struct
 {
-        int     lives;
-        pthread_mutex_t mutex;
-        int     ring_in;
-        int     ring_out;
-        int     ring_len[MAXCLIENTSRINGSIZE];
-        char*   ring[MAXCLIENTSRINGSIZE];
+        int                     lives;
+        pthread_mutex_t         mutex;
+        int                     ring_in;
+        int                     ring_out;
+        int                     ring_len[MAXCLIENTSRINGSIZE];
+        char*                   ring[MAXCLIENTSRINGSIZE];
 } BTA2DPPERCLIENTDATA;
=20
 // Data to keep per Bluetooth device
 typedef struct
 {
-        char 				addr[20];
-        pthread_t 			thread;
-        pthread_t 			receiverthread;
-        pthread_mutex_t 		mutex;
-        int				nb_clients;
-        BTA2DPPERCLIENTDATA             clients[MAXCLIENTSPERDEVICE];
+        char                    addr[20];
+        pthread_t               thread;
+        pthread_t               receiverthread;
+        pthread_mutex_t         mutex;
+        AUDIOMIXERDATA          mixer;
+        int                     nb_clients;
+        BTA2DPPERCLIENTDATA     clients[MAXCLIENTSPERDEVICE];
 } BTA2DPPERDEVICEDATA, *LPBTA2DPPERDEVICEDATA;
=20
 // Data needed per Audio Streaming Client
 typedef struct
 {
-        LPBTA2DPPERDEVICEDATA 		lpDevice;
-        int 				sockfd;
-        pthread_t 	    		thread;
+        LPBTA2DPPERDEVICEDATA   lpDevice;
+        int                     sockfd;
+        pthread_t               thread;
 } A2DPDCLIENT, *LPA2DPDCLIENT;
=20
 // Allocate a new device
@@ -99,6 +99,10 @@
         {
                 memset(lpDevice, 0, sizeof(BTA2DPPERDEVICEDATA));
                 strncpy(lpDevice->addr, addr, sizeof(lpDevice->addr)); l=
pDevice->addr[sizeof(lpDevice->addr)-1] =3D 0;
+                lpDevice->mixer.volume_speaker_left =3D A2DPD_VOLUME_MAX=
;
+                lpDevice->mixer.volume_speaker_right =3D A2DPD_VOLUME_MA=
X;
+                lpDevice->mixer.volume_micro_left =3D A2DPD_VOLUME_MAX;
+                lpDevice->mixer.volume_micro_right =3D A2DPD_VOLUME_MAX;
                 pthread_mutex_init(&lpDevice->mutex, NULL);
                 for(i=3D0;i<MAXCLIENTSPERDEVICE; i++)
                 {
@@ -139,53 +143,8 @@
                 printf("handling SIGINT\n");
        =20
                 // Dummy connection to unlock server (currently acceptin=
g)
-                {
-                        int sockfd =3D socket(PF_INET, SOCK_STREAM, 0);
-                        if(sockfd>0)
-                        {
-                                struct sockaddr_in peer_addr;
-                                peer_addr.sin_family =3D AF_INET;
-                                peer_addr.sin_port =3D htons(MYPORT);
-                                peer_addr.sin_addr.s_addr =3D inet_addr(=
"127.0.0.1");
-                                connect(sockfd, (struct sockaddr*)&peer_=
addr, sizeof(peer_addr));
-                                close(sockfd);
-                        }
-                }
-        }
-}
-
-// Create server socket
-int make_the_socket()
-{
-        int sockfd =3D socket(PF_INET, SOCK_STREAM, 0);
-        struct sockaddr_in my_addr;
-        memset(&my_addr, 0, sizeof(my_addr));
-        my_addr.sin_family =3D AF_INET;
-        my_addr.sin_port =3D htons(MYPORT);
-        my_addr.sin_addr.s_addr =3D INADDR_ANY;
-
-        if(sockfd>0)
-        {
-                if(bind(sockfd, (struct sockaddr *)&my_addr, sizeof(stru=
ct sockaddr))=3D=3D0)
-                {
-                        if(listen(sockfd, 10)=3D=3D0)
-                        {
-                                // No error
-                        }
-                        else
-                        {
-                                close(sockfd);
-                                sockfd =3D -3;
-                        }
-                }
-                else
-                {
-                        close(sockfd);
-                        sockfd =3D -2;
-                }
+                close_socket(make_client_socket());
         }
-
-        return sockfd;
 }
=20
 // This function handles a client
@@ -193,121 +152,151 @@
 {
         int bError =3D 0;
         int client_index =3D -1;
-       =20
+        int32_t client_type =3D INVALID_CLIENT_TYPE;
+        int result;
+        LPA2DPDCLIENT lpClient =3D (LPA2DPDCLIENT)param;
+        AUDIOMIXERDATA AudioMixerData =3D INVALIDAUDIOMIXERDATA;
+
         // We should not terminate the process if clients are still runn=
ing
         iThreadsRunning ++;
=20
-        LPA2DPDCLIENT lpClient =3D (LPA2DPDCLIENT)param;
         pthread_detach(lpClient->thread);
=20
-        // Find an index in clients table
-        pthread_mutex_lock(&lpClient->lpDevice->mutex);
-        for(client_index=3D0; client_index<MAXCLIENTSPERDEVICE; client_i=
ndex++)
+        setup_socket(lpClient->sockfd);
+
+        // Receive type of client
+        result =3D recv_socket(lpClient->sockfd, &client_type, sizeof(cl=
ient_type));
+
+        // This client wants to send us pcm control data
+        if(client_type=3D=3DA2DPD_PLUGIN_CTL_WRITE)
         {
-                if(lpClient->lpDevice->clients[client_index].lives=3D=3D=
0)
+                printf("CTL WRITE thread %d.%d started\n", client_index,=
 lpClient->sockfd);
+
+                if(recv_socket(lpClient->sockfd, &AudioMixerData, sizeof=
(AudioMixerData))=3D=3Dsizeof(AudioMixerData))
                 {
-                        lpClient->lpDevice->clients[client_index].lives =
=3D 1;
-                        lpClient->lpDevice->clients[client_index].ring_i=
n =3D 0;
-                        lpClient->lpDevice->clients[client_index].ring_o=
ut =3D 0;
-                        break;
+                        pthread_mutex_lock(&lpClient->lpDevice->mutex);
+                        if(AudioMixerData.volume_speaker_left !=3D -1)
+                                lpClient->lpDevice->mixer.volume_speaker=
_left =3D AudioMixerData.volume_speaker_left;
+                        if(AudioMixerData.volume_speaker_left !=3D -1)
+                                lpClient->lpDevice->mixer.volume_speaker=
_right=3D AudioMixerData.volume_speaker_right;
+                        if(AudioMixerData.volume_micro_left !=3D -1)
+                                lpClient->lpDevice->mixer.volume_micro_l=
eft =3D AudioMixerData.volume_micro_left;
+                        if(AudioMixerData.volume_micro_left !=3D -1)
+                                lpClient->lpDevice->mixer.volume_micro_r=
ight=3D AudioMixerData.volume_micro_right;
+                        pthread_mutex_unlock(&lpClient->lpDevice->mutex)=
;
+                        // Notify other clients
+                        int notifyfd =3D make_udp_socket();
+                        int i=3Dsend_socket(notifyfd, &AudioMixerData, s=
izeof(AudioMixerData));
+                        printf("Notify return %d\n", i);
+                        close_socket(notifyfd);
                 }
         }
-        pthread_mutex_unlock(&lpClient->lpDevice->mutex);
-       =20
-        if(client_index>=3DMAXCLIENTSPERDEVICE)
+
+        // This client wants to read our control status
+        if(client_type=3D=3DA2DPD_PLUGIN_CTL_READ)
         {
-                printf("Client thread %d cannot start (too many clients =
already connected)\n", client_index);
-                return 0;
-        }
+                printf("CTL READ thread %d.%d started\n", client_index, =
lpClient->sockfd);
=20
-        // Allocate buffer
-        printf("Client thread %d.%d started\n", client_index, lpClient->=
sockfd);
+                pthread_mutex_lock(&lpClient->lpDevice->mutex);
+                AudioMixerData =3D lpClient->lpDevice->mixer;
+                pthread_mutex_unlock(&lpClient->lpDevice->mutex);
=20
-        struct timeval t =3D { 1, 0 };
-        setsockopt( lpClient->sockfd, SOL_SOCKET, SO_SNDTIMEO, &t, sizeo=
f(t));
-        setsockopt( lpClient->sockfd, SOL_SOCKET, SO_RCVTIMEO, &t, sizeo=
f(t));
+                send_socket(lpClient->sockfd, &AudioMixerData, sizeof(Au=
dioMixerData));
+        }
=20
-        // Loop while we receive data
-        while(!bSigINTReceived && !bError)
+        // This client wants to send us pcm stream
+        if(client_type=3D=3DA2DPD_PLUGIN_PCM_WRITE)
         {
-                // Receive data
-                int pcm_buffer_size =3D 0;
-                int result =3D recv(lpClient->sockfd, &pcm_buffer_size, =
sizeof(pcm_buffer_size), 0);
-                if(result =3D=3D sizeof(pcm_buffer_size) && pcm_buffer_s=
ize<=3DPOOLENTRYSIZE)
-                {
-                        int received =3D 0;
-                        char* pcm_buffer =3D pool_pop();
-                       =20
-                        while(pcm_buffer && received<pcm_buffer_size)
+                // Find an index in clients table for the mixer
+                pthread_mutex_lock(&lpClient->lpDevice->mutex);
+                for(client_index=3D0; client_index<MAXCLIENTSPERDEVICE; =
client_index++)
+                {
+                        if(lpClient->lpDevice->clients[client_index].liv=
es=3D=3D0)
                         {
-                                result =3D recv(lpClient->sockfd, pcm_bu=
ffer+received, pcm_buffer_size-received, 0);
-                                if(result>0)
-                                {
-                                        //if(result<pcm_buffer_size) pri=
ntf("PART : Received %d bytes of data\n", result);
-                                        received +=3D result;
-                                }
-                                else
-                                {
-                                        break;
-                                }
+                                lpClient->lpDevice->clients[client_index=
].lives =3D 1;
+                                lpClient->lpDevice->clients[client_index=
].ring_in =3D 0;
+                                lpClient->lpDevice->clients[client_index=
].ring_out =3D 0;
+                                break;
                         }
+                }
+                pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+
+                printf("PCM thread %d.%d started\n", client_index, lpCli=
ent->sockfd);
=20
-                        if(received=3D=3Dpcm_buffer_size)
+                if(client_index>=3DMAXCLIENTSPERDEVICE)
+                {
+                        printf("Client thread %d cannot start (too many =
clients already connected)\n", client_index);
+                        return 0;
+                }
+
+                // Loop while we receive data
+                while(!bSigINTReceived && !bError)
+                {
+                        // Receive data
+                        int32_t pcm_buffer_size =3D 0;
+                        result =3D recv_socket(lpClient->sockfd, &pcm_bu=
ffer_size, sizeof(pcm_buffer_size));
+                        if(result =3D=3D sizeof(pcm_buffer_size) && pcm_=
buffer_size<=3DPOOLENTRYSIZE)
                         {
-                                // Enqueue in bluetooth headset if we ca=
n else loose packet
-                                pthread_mutex_lock(&lpClient->lpDevice->=
clients[client_index].mutex);
+                                char* pcm_buffer =3D pool_pop();
+                                result =3D recv_socket(lpClient->sockfd,=
 pcm_buffer, pcm_buffer_size);
+
+                                if(result=3D=3Dpcm_buffer_size)
+                                {
+                                        // Enqueue in bluetooth headset =
if we can else loose packet
+                                        pthread_mutex_lock(&lpClient->lp=
Device->clients[client_index].mutex);
+
+                                        // Append data to ring
+                                        int this_ring =3D lpClient->lpDe=
vice->clients[client_index].ring_in;
+                                        int next_ring =3D ((this_ring+1)=
%MAXCLIENTSRINGSIZE);
+
+                                        if(next_ring !=3D lpClient->lpDe=
vice->clients[client_index].ring_out)
+                                        {
+                                                lpClient->lpDevice->clie=
nts[client_index].ring[this_ring] =3D pcm_buffer;
+                                                lpClient->lpDevice->clie=
nts[client_index].ring_len[this_ring] =3D pcm_buffer_size;
+                                                lpClient->lpDevice->clie=
nts[client_index].ring_in =3D next_ring;
+                                                // We will not free that=
 buffer, it's the bthandler thread which will do it
+                                                pcm_buffer =3D NULL;
+                                        }
=20
-                                // Append data to ring
-                                int next_ring =3D ((lpClient->lpDevice->=
clients[client_index].ring_in+1)%MAXCLIENTSRINGSIZE);
-                                if(next_ring !=3D lpClient->lpDevice->cl=
ients[client_index].ring_out)
-                                {
-                                        //printf("Writing pool %d[%d ] =3D=
 %p\n", client_index, lpClient->lpDevice->clients[client_index].ring_in, =
pcm_buffer);
-                                        lpClient->lpDevice->clients[clie=
nt_index].ring[lpClient->lpDevice->clients[client_index].ring_in] =3D pcm=
_buffer;
-                                        lpClient->lpDevice->clients[clie=
nt_index].ring_len[lpClient->lpDevice->clients[client_index].ring_in] =3D=
 pcm_buffer_size;
-                                        lpClient->lpDevice->clients[clie=
nt_index].ring_in =3D next_ring;
-                                        pcm_buffer =3D NULL;
+                                        pthread_mutex_unlock(&lpClient->=
lpDevice->clients[client_index].mutex);
+
+                                        // Reintegrate data in pool
+                                        if(pcm_buffer) pool_push(pcm_buf=
fer);
                                 }
                                 else
                                 {
-                                        //printf("Client thread %d.%d ri=
ng is full (ring_in=3D%d, next_ring=3D%d, ring_out=3D%d)\n", client_index=
, lpClient->sockfd, lpClient->lpDevice->clients[client_index].ring_in, ne=
xt_ring, lpClient->lpDevice->clients[client_index].ring_out);
+                                        printf("[2] Receiving failed on =
socket %d.%d error (%d/%d bytes)\n", client_index, lpClient->sockfd, resu=
lt, pcm_buffer_size);
+                                        bError =3D 1;
                                 }
-
-                                pthread_mutex_unlock(&lpClient->lpDevice=
->clients[client_index].mutex);
-
-                                // Reintegrate data in pool
-                                if(pcm_buffer) pool_push(pcm_buffer);
                         }
                         else
                         {
-                                printf("[2] Receiving failed on socket %=
d.%d error (%d/%d bytes)\n", client_index, lpClient->sockfd, result, pcm_=
buffer_size);
+                                if(result=3D=3Dsizeof(pcm_buffer_size))
+                                {
+                                        printf("[1] Receiving will not f=
it pool (poolentrysize=3D%d !=3D pcm_buffer_size=3D%d)\n", POOLENTRYSIZE,=
 pcm_buffer_size);
+                                }
+                                else
+                                {
+                                        printf("[1] Receiving failed on =
socket %d.%d error (%d/%d bytes) errno=3D%d:%s\n", client_index, lpClient=
->sockfd, result, sizeof(pcm_buffer_size), errno, strerror(errno));
+                                }
                                 bError =3D 1;
                         }
                 }
-                else
-                {
-                        if(result=3D=3Dsizeof(pcm_buffer_size))
-                        {
-                                printf("[1] Receiving will not fit pool =
(poolentrysize=3D%d !=3D pcm_buffer_size=3D%d)\n", POOLENTRYSIZE, pcm_buf=
fer_size);
-                        }
-                        else
-                        {
-                                printf("[1] Receiving failed on socket %=
d.%d error (%d/%d bytes) \n", client_index, lpClient->sockfd, result, siz=
eof(pcm_buffer_size));
-                        }
-                        bError =3D 1;
-                }
-        }
=20
-        // Close socket
-        printf("Client thread %d.%d ending %s error\n", client_index, lp=
Client->sockfd, bError?"with":"without");
-        close(lpClient->sockfd);
+                pthread_mutex_lock(&lpClient->lpDevice->mutex);
+                if(client_index>=3D0) lpClient->lpDevice->clients[client=
_index].lives=3D0;
+                pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+        }
=20
         // Say goodbye
-
         pthread_mutex_lock(&lpClient->lpDevice->mutex);
-        if(client_index>=3D0) lpClient->lpDevice->clients[client_index].=
lives=3D0;
         lpClient->lpDevice->nb_clients--;
         pthread_mutex_unlock(&lpClient->lpDevice->mutex);
=20
+        // Close socket
+        printf("Client thread %d.%d ending: %s\n", client_index, lpClien=
t->sockfd, (bError?(errno=3D=3DEAGAIN?"timeout":"error"):"no error"));
+        close_socket(lpClient->sockfd);
+
         // Free client data
         free(lpClient);
=20
@@ -332,28 +321,32 @@
         {
                 int bError =3D 0;
                 int destroy_count =3D 0;
+                int satured =3D 0;
+                int ibytespersecond =3D 0;
+
                 // Connect to the A2DP device
                 LPA2DP lpA2dp =3D NULL;
                 char* pcm_buffer =3D pool_pop();
                 enum { NOSOUND, SOUND };
                 int state_previous =3D NOSOUND;
-
+                TIMERINFO TimerInfos;
+                memset(&TimerInfos, 0, sizeof(TimerInfos));
+                TimerInfos.fps =3D A2DPD_BLOCK_FREQUENCY;
                 printf("New connection to bluetooth\n");
=20
                 // As long as we can send sound
                 while(!bSigINTReceived && !bError)
                 {
-                        static int ibytespersecond =3D 0;
                         int pcm_buffer_filed_size =3D 0;
-                        int sleepDelay =3D 1000;
                         char* pcm_buffers[MAXCLIENTSPERDEVICE];
                         int pcm_buffers_size[MAXCLIENTSPERDEVICE];
-                        int  state_current =3D NOSOUND;
+                        int state_current =3D NOSOUND;
                         memset(pcm_buffers,      0, sizeof(pcm_buffers))=
;
                         memset(pcm_buffers_size, 0, sizeof(pcm_buffers_s=
ize));
=20
                         // If there are BT data, send them
-                        //FIXME pthread_mutex_lock(&lpDevice->mutex);
+                        //FIXME=20
+                        // pthread_mutex_lock(&lpDevice->mutex);
=20
                         if(lpDevice->nb_clients>0)
                         {
@@ -372,7 +365,7 @@
                                                         // Tell client w=
e got them
                                                         lpDevice->client=
s[i].ring[lpDevice->clients[i].ring_out] =3D NULL;
                                                         lpDevice->client=
s[i].ring_len[lpDevice->clients[i].ring_out] =3D 0;
-                                                       =20
+
                                                         // Move to next =
ring
                                                         int next_ring =3D=
 ((lpDevice->clients[i].ring_out+1)%MAXCLIENTSRINGSIZE);
                                                        =20
@@ -388,32 +381,8 @@
                                         }
                                 }
                         }
-                        //FIXME pthread_mutex_unlock(&lpDevice->mutex);
-
-                        // Display some informations while running
-                        static int iframespersecond =3D 0;
-                        static struct timeval staticcounter =3D { 0, 0 }=
;
-                        if(staticcounter.tv_usec=3D=3D0 && staticcounter=
.tv_sec=3D=3D0)
-                                gettimeofday(&staticcounter, NULL);
-                       =20
-                        // Calculate interval
-                        struct timeval timeofday, duration;
-                        gettimeofday(&timeofday, NULL);
-                        timersub(&timeofday, &staticcounter, &duration);
-                       =20
-                        // Display infos each second=20
-                        if(duration.tv_sec>0)
-                        {
-                                printf("A2DPD: state=3D%s %s clients=3D%=
d freq=3D%d[%d ko/s]\n", (state_current=3D=3DSOUND)?"playing":"silent", l=
pA2dp?"connected":"disconnected", lpDevice->nb_clients, iframespersecond,=
 ibytespersecond);
-                               =20
-                                // Reset all variables used
-                                ibytespersecond=3D0;
-                                iframespersecond=3D0;
-                                gettimeofday(&staticcounter, NULL);
-                        }
-                       =20
-                        // Count this frame
-                        iframespersecond++;
+                        //FIXME=20
+                        // pthread_mutex_unlock(&lpDevice->mutex);
=20
                         // Send mixed audio stream to clients
                         switch(state_current)
@@ -421,41 +390,6 @@
                                 case SOUND:
                                 {
                                         ////////////////////////////////=
/
-                                        // Try to synchronize sound to a=
 344blocks/s
-                                        ////////////////////////////////=
/
-                                        struct timeval playtime, theoric=
aldate;
-                               =20
-                                        // sleeps a little bit to synchr=
onize sound
-                                        // a2dp->sbc.channels*44100*2/(s=
ize*a2dp->frame_bytes);
-                                        // 344.53125=3Dchannels*freq*16 =
bits/sizeof(buf)
-                                        float fps=3D344.53125;
-                                        playtime.tv_sec=3D0;
-                                        playtime.tv_usec=3D(int)(1.0*100=
0.0*1000.0*iframespersecond/fps);
-                                        timeradd(&staticcounter, &playti=
me, &theoricaldate);
-                               =20
-                                        // Si la date th=C3=A9orique est=
 sup=C3=A9rieure =C3=A0 la date actuelle
-                                        if((theoricaldate.tv_sec>timeofd=
ay.tv_sec)
-                                                || (theoricaldate.tv_sec=
=3D=3Dtimeofday.tv_sec && theoricaldate.tv_usec>timeofday.tv_usec)
-                                                )
-                                        {
-                                                // We're in advance, wai=
t a little bit
-                                                timersub(&theoricaldate,=
 &timeofday, &duration);
-                                                if(duration.tv_sec>0)
-                                                {
-                                                        printf("ERROR du=
ration calculed more than one sec : { %d, %d }", (int)duration.tv_sec, (i=
nt)duration.tv_usec);
-                                                }
-                                                else
-                                                {
-                                                        sleepDelay =3D d=
uration.tv_usec;
-                                                }
-                                        }
-                                        else
-                                        {
-                                                // We're late, do nothin=
g
-                                                sleepDelay=3D0;
-                                        }
-
-                                        ////////////////////////////////=
/
                                         // Mix what we got
                                         ////////////////////////////////=
/
=20
@@ -484,14 +418,25 @@
                                                 }
                                                 //printf("Value %08X|%08=
X %d|%d\n", channel_1, channel_2, channel_1, channel_2);
                                                 // Stay within 16 bits p=
er channel range
-                                                if(channel_1>+32767) cha=
nnel_1 =3D +32767;
-                                                if(channel_1<-32768) cha=
nnel_1 =3D -32768;
-                                                if(channel_2>+32767) cha=
nnel_2 =3D +32767;
-                                                if(channel_2<-32768) cha=
nnel_2 =3D -32768;
+                                                if(channel_1>+32767) { c=
hannel_1 =3D +32767; satured++; }
+                                                if(channel_1<-32768) { c=
hannel_1 =3D -32768; satured++; }
+                                                if(channel_2>+32767) { c=
hannel_2 =3D +32767; satured++; }
+                                                if(channel_2<-32768) { c=
hannel_2 =3D -32768; satured++; }
+                                               =20
+                                                channel_1 *=3D lpDevice-=
>mixer.volume_speaker_left;
+                                                channel_2 *=3D lpDevice-=
>mixer.volume_speaker_right;
+                                                // yes this can be rewri=
tten with << if we consider max volume of 2^x
+                                                // Isn't it already done=
 by compiler
+                                                channel_1 /=3D A2DPD_VOL=
UME_MAX;
+                                                channel_2 /=3D A2DPD_VOL=
UME_MAX;
                                                 pBuffer[j] =3D (((channe=
l_1&0x0000FFFF)<<16)|(channel_2&0x0000FFFF));
+                                                //FIXME We have a revers=
e stereo I don't know why
+                                                // The following line co=
rrects the problem but I miss the cause so
+                                                // Do not uncomment it
+                                                //pBuffer[j] =3D (((chan=
nel_2&0x0000FFFF)<<16)|(channel_1&0x0000FFFF));
                                                 //pBuffer[j] =3D ( (chan=
nel_1 & 0xFFFF0000) | (channel_2 & 0x0000FFFF) );
                                         }
-                                       =20
+
                                         // Free no longer used audio blo=
cks
                                         for(i=3D0; i<MAXCLIENTSPERDEVICE=
; i++)
                                         {
@@ -501,17 +446,17 @@
                                                         pool_push(pcm_bu=
ffers[i]);
                                                 }
                                         }
-                                       =20
+
                                         ////////////////////////////////=
/
                                         // Transfer data to bluetooth
                                         ////////////////////////////////=
/
=20
                                         if(pcm_buffer && pcm_buffer_file=
d_size>0)
                                         {
-                                                // Transfer takes place =
by 512 bytes blocks
+                                                // Transfer takes place =
by A2DPD_BLOCK_SIZE bytes blocks
                                                 int blockstart =3D 0;
-                                                int blocksize =3D 512;
-                                               =20
+                                                int blocksize =3D A2DPD_=
BLOCK_SIZE;
+
                                                 // Allocate A2DP if we a=
re not connected
                                                 if(!lpA2dp)
                                                 {
@@ -526,15 +471,16 @@
                                                         {
                                                                 int tran=
sfer;
=20
-                                                                blocksiz=
e =3D (pcm_buffer_filed_size<512)?pcm_buffer_filed_size:512;
+                                                                blocksiz=
e =3D (pcm_buffer_filed_size<A2DPD_BLOCK_SIZE)?pcm_buffer_filed_size:A2DP=
D_BLOCK_SIZE;
=20
                                                                 transfer=
 =3D a2dp_transfer_raw(lpA2dp, pcm_buffer+blockstart, blocksize);
-                                                               =20
+
                                                                 if(trans=
fer>=3D0)
                                                                 {
                                                                         =
destroy_count =3D 0;
                                                                         =
blockstart +=3D blocksize;
                                                                         =
ibytespersecond +=3D transfer;
+                                                                        =
a2dp_timer_notifyframe(&TimerInfos);
                                                                 }
                                                                 else
                                                                 {
@@ -548,24 +494,51 @@
                                 }
                                 case NOSOUND:
                                 {
+                                        if(state_previous =3D=3D SOUND)
+                                        {
+                                                //printf("Sound stream r=
an dry!!!\n");
+                                        }
                                         break;
                                 }
                         }
=20
                         // Free the A2DP device if needed
-                        if(lpA2dp && destroy_count>1000)
+                        // When destroy_count reaches 5000 we will destr=
oy the A2DP link
+                        // However, destroy_count is reset whenever data=
 are sent
+                        destroy_count++;
+                        if(lpA2dp && destroy_count>5000)
                         {
                                 printf("Destroying lpA2dp, destroy_count=
 is %d\n", destroy_count);
                                 a2dp_destroy(lpA2dp);
                                 lpA2dp =3D NULL;
                         }
=20
-                        // When destroy_count reaches 1000 we will destr=
oy the A2DP link
-                        // However, destroy_count is reset whenever data=
 are sent
-                        destroy_count++;
-
-                        if(sleepDelay)
-                                usleep(sleepDelay);
+                        // Wait must take place after sending a packet
+                        // This way, you will allow the plugin to send i=
t's data
+                        // And you will collect the new data
+                        // Time reference floating because of 44100/1000=
 error in integer calculation
+                        a2dp_timer_sleep(&TimerInfos, A2DPTIMERPREDELAY)=
;
+
+                        // Display infos each second
+                        if(TimerInfos.display>0)
+                        {
+                                /*
+                                char* lpszFormat =3D "A2DPD: [%d,%d|%d,%=
d] %s %s clients=3D%d freq=3D%d[%d b/s] sleep=3D%d satur=3D%d\n";
+                                if(satured=3D=3D0) lpszFormat =3D "A2DPD=
: [%d,%d|%d,%d] %s %s clients=3D%d freq=3D%d[%d b/s]\n";
+                                printf(lpszFormat,=20
+                                lpDevice->mixer.volume_speaker_left,
+                                lpDevice->mixer.volume_speaker_right,
+                                lpDevice->mixer.volume_micro_left,
+                                lpDevice->mixer.volume_micro_right,
+                                (state_current=3D=3DSOUND)?"playing":"si=
lent",
+                                lpA2dp?"connected":"disconnected", lpDev=
ice->nb_clients, TimerInfos.display,
+                                ibytespersecond,
+                                satured);
+                                // Reset all variables used
+                                ibytespersecond=3D0;
+                                satured=3D0;
+                                */
+                        }
=20
                         state_previous =3D state_current;
                 }
@@ -618,11 +591,7 @@
=20
                                 printf("socket %d: Connection from %s, m=
tu=3D%d\n", new_fd, szRemote, iMTU);
=20
-                                struct timeval t;
-                                t.tv_sec=3D0;
-                                t.tv_usec=3D10*1000; // ms
-                                setsockopt( new_fd, SOL_SOCKET, SO_SNDTI=
MEO, &t, sizeof(t));
-                                setsockopt( new_fd, SOL_SOCKET, SO_RCVTI=
MEO, &t, sizeof(t));
+                                setup_socket(new_fd);
=20
                                 if(new_fd>0)
                                 {
@@ -656,7 +625,7 @@
                                                 while(iReceived>=3D0 || =
errno=3D=3DEAGAIN);
                                                 free(lpFrame);
                                         }
-                                        close(new_fd);
+                                        close_socket(new_fd);
                                 }
                                 else
                                 {
@@ -664,7 +633,7 @@
                                 }
                         }
=20
-                        close(sockfd);
+                        close_socket(sockfd);
                 }
=20
                 // Sleep a little bit if we must retry
@@ -679,67 +648,73 @@
 // server processing loop
 void main_loop(char* addr)
 {
-        // Master socket
-        int sockfd =3D make_the_socket();
-
-        if(sockfd>0)
+        while(!bSigINTReceived)
         {
-                LPBTA2DPPERDEVICEDATA lpDevice =3D bta2dpdevicenew(addr)=
;
-                // Set pthread stack size to decrease unused memory usag=
e
-                pthread_attr_t tattr;
-                size_t size =3D PTHREAD_STACK_MIN;
-                int ret =3D pthread_attr_init(&tattr);
-                ret =3D pthread_attr_setstacksize(&tattr, size);
-                pthread_create(&lpDevice->thread, &tattr, bt_handler,  l=
pDevice);
-                pthread_create(&lpDevice->thread, &tattr, bt_receiver, l=
pDevice);
-
-                while(!bSigINTReceived)
-                {
-                        // Block until connections
-                        struct sockaddr_in peer_addr;
-                        int sin_size =3D sizeof(peer_addr);
-                        printf("Accepting incoming stream connection\n")=
;
-                        int new_fd =3D accept(sockfd, (struct sockaddr *=
)&peer_addr, &sin_size);
-                        printf("Accepted %d\n", new_fd);
-
-                        // Handle connection if it is not the final dumm=
y client
-                        if(!bSigINTReceived)
+                // Master socket
+                int sockfd =3D make_server_socket();
+       =20
+                if(sockfd>0)
+                {
+                        LPBTA2DPPERDEVICEDATA lpDevice =3D bta2dpdevicen=
ew(addr);
+                        // Set pthread stack size to decrease unused mem=
ory usage
+                        pthread_attr_t tattr;
+                        size_t size =3D PTHREAD_STACK_MIN;
+                        int ret =3D pthread_attr_init(&tattr);
+                        ret =3D pthread_attr_setstacksize(&tattr, size);
+                        pthread_create(&lpDevice->thread, &tattr, bt_han=
dler,  lpDevice);
+                        pthread_create(&lpDevice->thread, &tattr, bt_rec=
eiver, lpDevice);
+       =20
+                        while(!bSigINTReceived)
                         {
-                                LPA2DPDCLIENT lpClient =3D malloc(sizeof=
(A2DPDCLIENT));
-                                lpClient->lpDevice =3D lpDevice;
-                                lpClient->sockfd =3D new_fd;
-                               =20
-                                pthread_mutex_lock(&lpClient->lpDevice->=
mutex);
-                                lpClient->lpDevice->nb_clients++;
-                                pthread_mutex_unlock(&lpClient->lpDevice=
->mutex);
-                               =20
-                                pthread_create(&lpClient->thread, &tattr=
, client_handler, lpClient);
+                                int new_fd =3D -1;
+                                printf("Accepting incoming stream connec=
tion\n");
+                                new_fd=3Daccept_socket(sockfd);
+                                printf("Accepted %d\n", new_fd);
+       =20
+                                // Handle connection if it is not the fi=
nal dummy client
+                                if(!bSigINTReceived)
+                                {
+                                        LPA2DPDCLIENT lpClient =3D mallo=
c(sizeof(A2DPDCLIENT));
+                                        lpClient->lpDevice =3D lpDevice;
+                                        lpClient->sockfd =3D new_fd;
+                                       =20
+                                        pthread_mutex_lock(&lpClient->lp=
Device->mutex);
+                                        lpClient->lpDevice->nb_clients++=
;
+                                        pthread_mutex_unlock(&lpClient->=
lpDevice->mutex);
+                                       =20
+                                        pthread_create(&lpClient->thread=
, &tattr, client_handler, lpClient);
+                                }
+                                else
+                                {
+                                        close_socket(new_fd);
+                                }
+                                usleep(10000);
                         }
-                        usleep(10000);
+       =20
+                        close_socket(sockfd);
+       =20
+                        // Very minor race condition here
+                        // No dramatic consequences
+                        // But we Must wait all client termination
+                        // We will pthread_join one day
+                        int icount =3D 0;
+                        while(iThreadsRunning>0 && icount<30)
+                        {
+                                printf("A2DPD still %d clients running\n=
", iThreadsRunning);
+                                icount++;
+                                sleep(1);
+                        }
+       =20
+                        // Free informations on the device
+                        bta2dpdevicefree(lpDevice);
+                        pthread_attr_destroy(&tattr);
                 }
-
-                close(sockfd);
-                close(sockfd);
-
-                // Very minor race condition here
-                // No dramatic consequences
-                // But we Must wait all client termination
-                // We will pthread_join one day
-                int icount =3D 0;
-                while(iThreadsRunning>0 && icount<30)
+                else
                 {
-                        printf("A2DPD still %d clients running\n", iThre=
adsRunning);
-                        icount++;
-                        sleep(1);
+                        printf("Error %d: cannot get the socket errno=3D=
%d (%s)\n", sockfd, errno, strerror(errno));
                 }
=20
-                // Free informations on the device
-                bta2dpdevicefree(lpDevice);
-                pthread_attr_destroy(&tattr);
-        }
-        else
-        {
-                printf("Error %d: cannot get the socket errno=3D%d (%s)\=
n", sockfd, errno, strerror(errno));
+                sleep(1);
         }
 }
=20
@@ -748,12 +723,38 @@
 // main function
 int main(int argc, char *argv[])
 {
-        char* addr =3D "00:0D:44:2A:17:C7 [Default Address]";
-       =20
-        // Read command line argument
-        if(argc>1) addr =3D argv[1];
-        printf("%s addr=3D%s [%s %s]\n", argv[0], addr, __DATE__, __TIME=
__);
-
+        int i =3D 0;
+        struct timespec timer_resolution =3D { 0, 0 };
+        char* addr =3D "00:0A:56:00:C0:C2 Sonorix";
+        // C2:00:08:F4:30:07:64 IPhono
+        // 00:0D:44:2A:17:C7 HP
+        // If we can be realtime it will be better
+        struct sched_param schedparam =3D { sched_get_priority_max(SCHED=
_FIFO) };
+        int res =3D sched_setscheduler(0, SCHED_FIFO, &schedparam);=20
+        int bTestThread =3D 0;
+        printf("setscheduler returns %d (errno=3D%d:%s)\n", res, errno, =
strerror(errno));
+=09
+	// Parse command line parameters
+	for(i=3D1; i<argc && argv[i]!=3DNULL; i++)
+	{
+	       char c;
+	       // Search a glade file
+	       if(0=3D=3Dstrcmp(argv[i], "-t"))
+	       {
+	               bTestThread =3D 1;
+	       }
+	       // Search a bluetooth addr
+	       else if(sscanf(argv[i], "%c%c:%c%c:%c%c:%c%c:%c%c:%c%c", &c, &c,=
 &c, &c, &c, &c, &c, &c, &c, &c, &c, &c)=3D=3D12)
+	       {
+	               addr=3Dargv[i];
+	       }
+	       else
+	       {
+	               printf("Parameter not handled: %s\r\n", argv[i]);
+	       }
+	}
+        clock_getres(CLOCK_REALTIME, &timer_resolution);
+        printf("%s addr=3D%s timer=3D%d us [%s %s]\n", argv[0], addr, (i=
nt)(timer_resolution.tv_nsec/1000), __DATE__, __TIME__);
         // set up the handler
         signal(SIGINT, sigint_handler);
         signal(SIGTERM, sigint_handler);
Index: alsa-plugins/a2dpd_protocol.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/a2dpd_protocol.h
diff -N alsa-plugins/a2dpd_protocol.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/a2dpd_protocol.h	28 Jul 2006 09:48:08 -0000
@@ -0,0 +1,54 @@
+/*
+*
+*  A2DPD - Bluetooth A2DP daemon for Linux
+*
+*  Copyright (C) 2006  Fr=C3=A9d=C3=A9ric DALLEAU <frederic.dalleau@palm=
source.com>
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; either version 2 of the License, or
+*  (at your option) any later version.
+*
+*  This program is distributed in the hope that it will be useful,
+*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+*  GNU General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License
+*  along with this program; if not, write to the Free Software
+*  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+*/
+
+#ifndef __A2DPD_PROTOCOL_H__
+#define __A2DPD_PROTOCOL_H__
+
+#include <stdint.h>
+
+
+// parameters used to describe device state
+typedef struct
+{
+        int16_t                     volume_speaker_right;
+        int16_t                     volume_speaker_left;
+        int16_t                     volume_micro_right;
+        int16_t                     volume_micro_left;
+} AUDIOMIXERDATA;
+
+#define INVALIDAUDIOMIXERDATA   { -1, -1, -1, -1 }
+
+// Different types of client plugin for the daemon
+#define INVALID_CLIENT_TYPE     0xFFFFFFFF
+#define A2DPD_PLUGIN_CTL_WRITE  0x00000001
+#define A2DPD_PLUGIN_CTL_READ   0x00000002
+#define A2DPD_PLUGIN_PCM_WRITE  0x00000003
+#define A2DPD_VOLUME_MIN        0
+#define A2DPD_VOLUME_MAX        15
+
+// a2dp->sbc.channels*44100*2/(size*a2dp->frame_bytes);
+// 344.53125=3Dchannels*freq*16 bits/sizeof(buf)
+#define A2DPD_BLOCK_FREQUENCY   (344.53125/1)
+#define A2DPD_BLOCK_SIZE        (512*1)
+#define A2DPD_FRAME_BYTES       4 // 16bits * 2 channels
+#define A2DPD_FRAME_RATE        44100
+
+#endif
Index: alsa-plugins/a2dplib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dplib.c,v
retrieving revision 1.1
diff -u -r1.1 a2dplib.c
--- alsa-plugins/a2dplib.c	12 Jul 2006 05:47:06 -0000	1.1
+++ alsa-plugins/a2dplib.c	28 Jul 2006 09:48:08 -0000
@@ -1,25 +1,25 @@
 /*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2005  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
- *
- */
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
=20
 #ifdef HAVE_CONFIG_H
 #include <config.h>
@@ -45,16 +45,27 @@
=20
 #include <pthread.h>
=20
+
 #include "a2dplib.h"
+#include "a2dp_timer.h"
+#include "a2dp_ipc.h"
 #include "sbc.h"
 #include "../a2dp.h"
=20
 #define NONSPECAUDIO 1
 #define BUFS 1024
+#define A2DPMAXIMUMTRANSFERUNITSIZE 678
+// In fact sbc blocks are 76 bytes long, so a group of them is either 60=
8 or 684 bytes
+// So 650 or 678 makes no differences!
+// However some devices may have longer transfer unit up to I saw omtu=3D=
733?
=20
 #define min(X, Y)  ((X) < (Y) ? (X) : (Y))
-#define DBG(fmt, arg...)  printf("DEBUG: %s: " fmt "\n" , __FUNCTION__ ,=
 ## arg)
+#define DBG(fmt, arg...) { if(errno!=3D0) printf("DEBUG: %s: (errno=3D%d=
:%s)" fmt "\n" , __FUNCTION__ , errno, strerror(errno), ## arg);\
+        else printf("DEBUG: %s: " fmt "\n" , __FUNCTION__ , ## arg); err=
no=3D0;}
+
+//#define DBG(fmt, arg...)  printf("DEBUG: %s: " fmt "\n" , __FUNCTION__=
 , ## arg)
 //#define DBG(D...)
+
 /*
 sdp_record_t*  g_recordP     =3D NULL;
 sdp_session_t* g_sdpSessionP =3D NULL;
@@ -69,74 +80,74 @@
 /*
 sdp_record_t* a2dp_advertise_sdp(sdp_session_t* sdpSessionP)
 {
-	sdp_record_t *recordP=3DNULL;
-	sdp_list_t *svclass=3DNULL, *rootlist=3DNULL, *protolist=3DNULL, *l2cap=
list=3DNULL, *avdtplist=3DNULL, *profileslist=3DNULL;
-	uuid_t rootuuid, svcuuid, l2capuuid, avdtpuuid;
-	sdp_profile_desc_t a2dpprofile;
-	int error =3D 0;
-
-	if(sdpSessionP)
-	{
-		// Generic service informations
-		recordP =3D sdp_record_alloc();
-		if (recordP)
-		{
-			sdp_set_info_attr(recordP, A2DP_SERVICE_NAME, NULL, NULL);
-
-			// Add to Public Browse Group
-			sdp_uuid16_create(&rootuuid, PUBLIC_BROWSE_GROUP);
-			rootlist =3D sdp_list_append(NULL, &rootuuid);
-			sdp_set_browse_groups(recordP, rootlist);
-
-			// Set service class
-			sdp_uuid16_create(&svcuuid, AUDIO_SOURCE_SVCLASS_ID);
-			svclass =3D sdp_list_append(NULL, &svcuuid);
-			sdp_set_service_classes(recordP, svclass);
-
-			// Set protocols informations
-			// L2CAP
-			sdp_uuid16_create(&l2capuuid, L2CAP_UUID);
-			l2caplist =3D sdp_list_append(NULL, &l2capuuid);
-
-			// AVDTP
-			sdp_uuid16_create(&avdtpuuid, AVDTP_UUID);
-			avdtplist =3D sdp_list_append(NULL, &avdtpuuid);
-
-			// add protocols
-			protolist =3D sdp_list_append(NULL, l2caplist);
-			sdp_list_append(protolist, avdtplist);
-			protolist =3D sdp_list_append(NULL, protolist);
-			sdp_set_access_protos(recordP, protolist);
-
-			// Set profiles informations
-			// A2DP
-			sdp_uuid16_create(&a2dpprofile.uuid, AUDIO_SOURCE_PROFILE_ID);
-			a2dpprofile.version =3D A2DP_VERSION;
-			profileslist =3D sdp_list_append(NULL, &a2dpprofile);
-
-			// add profiles
-			sdp_set_profile_descs(recordP, profileslist);
-
-			// Register the record in the sdp session
-			error =3D sdp_record_register(sdpSessionP, recordP, 0);
-			if (error)
-			{
-				DBG("Unable to advertise service (0x%04hX)", error);
-				sdp_record_free(recordP);
-				recordP =3D NULL;
-			}
-		}
-		else
-		{
-			DBG("Allocate for service description failed");
-		}
-	}
-	else
-	{
-		DBG("No local sdp session available");
-	}
+        sdp_record_t *recordP=3DNULL;
+        sdp_list_t *svclass=3DNULL, *rootlist=3DNULL, *protolist=3DNULL,=
 *l2caplist=3DNULL, *avdtplist=3DNULL, *profileslist=3DNULL;
+        uuid_t rootuuid, svcuuid, l2capuuid, avdtpuuid;
+        sdp_profile_desc_t a2dpprofile;
+        int error =3D 0;
+
+        if(sdpSessionP)
+        {
+                // Generic service informations
+                recordP =3D sdp_record_alloc();
+                if (recordP)
+                {
+                        sdp_set_info_attr(recordP, A2DP_SERVICE_NAME, NU=
LL, NULL);
+
+                        // Add to Public Browse Group
+                        sdp_uuid16_create(&rootuuid, PUBLIC_BROWSE_GROUP=
);
+                        rootlist =3D sdp_list_append(NULL, &rootuuid);
+                        sdp_set_browse_groups(recordP, rootlist);
+
+                        // Set service class
+                        sdp_uuid16_create(&svcuuid, AUDIO_SOURCE_SVCLASS=
_ID);
+                        svclass =3D sdp_list_append(NULL, &svcuuid);
+                        sdp_set_service_classes(recordP, svclass);
+
+                        // Set protocols informations
+                        // L2CAP
+                        sdp_uuid16_create(&l2capuuid, L2CAP_UUID);
+                        l2caplist =3D sdp_list_append(NULL, &l2capuuid);
+
+                        // AVDTP
+                        sdp_uuid16_create(&avdtpuuid, AVDTP_UUID);
+                        avdtplist =3D sdp_list_append(NULL, &avdtpuuid);
+
+                        // add protocols
+                        protolist =3D sdp_list_append(NULL, l2caplist);
+                        sdp_list_append(protolist, avdtplist);
+                        protolist =3D sdp_list_append(NULL, protolist);
+                        sdp_set_access_protos(recordP, protolist);
+
+                        // Set profiles informations
+                        // A2DP
+                        sdp_uuid16_create(&a2dpprofile.uuid, AUDIO_SOURC=
E_PROFILE_ID);
+                        a2dpprofile.version =3D A2DP_VERSION;
+                        profileslist =3D sdp_list_append(NULL, &a2dpprof=
ile);
+
+                        // add profiles
+                        sdp_set_profile_descs(recordP, profileslist);
+
+                        // Register the record in the sdp session
+                        error =3D sdp_record_register(sdpSessionP, recor=
dP, 0);
+                        if (error)
+                        {
+                                DBG("Unable to advertise service (0x%04h=
X)", error);
+                                sdp_record_free(recordP);
+                                recordP =3D NULL;
+                        }
+                }
+                else
+                {
+                        DBG("Allocate for service description failed");
+                }
+        }
+        else
+        {
+                DBG("No local sdp session available");
+        }
=20
-	return recordP;
+        return recordP;
 }
 */
=20
@@ -144,777 +155,578 @@
 void a2dp_init(void) __attribute__ ((constructor));
 void a2dp_exit(void) __attribute__ ((destructor));
 */
-void change_endian( void *buf, int size)
+void memcpy_changeendian( void* dst, const void *src, int size)
 {
-	int i;
-	char c;
-	char *ptr;
-
-	ptr =3D buf;
-	for(i =3D 0; i < size; i +=3D 2) {
-		c =3D ptr[i];
-		ptr[i] =3D ptr[i+1];
-		ptr[i+1] =3D c;
-	}
+        int i;
+        uint16_t* ptrsrc=3Dsrc;
+        uint16_t* ptrdst=3Ddst;
+        for(i =3D 0; i < size/2; i ++)
+        {
+                *ptrdst++ =3D htons(*ptrsrc++);
+        }
 }
=20
 // Prepare packet headers
 void init_request(struct avdtp_header * header, int request_id)
 {
-	static int transaction =3D 0;
+        static int transaction =3D 0;
=20
-	header->packet_type =3D PACKET_TYPE_SINGLE;
-	header->message_type =3D MESSAGE_TYPE_COMMAND;
-	header->transaction_label =3D transaction;
-	header->signal_id =3D request_id;
+        header->packet_type =3D PACKET_TYPE_SINGLE;
+        header->message_type =3D MESSAGE_TYPE_COMMAND;
+        header->transaction_label =3D transaction;
+        header->signal_id =3D request_id;
=20
-	// clear rfa bits
-	header->rfa0 =3D 0;
+        // clear rfa bits
+        header->rfa0 =3D 0;
=20
-	transaction =3D (transaction + 1) & 0xf;
+        transaction =3D (transaction + 1) & 0xf;
 }
=20
 // Analyse the SEIDs the sink has sent to us
 int process_seid(int s, struct acp_seid_info * get_seid_resp, unsigned s=
hort *psm, sbc_t *sbc)
 {
-	int v, size;
-	int seid =3D get_seid_resp->acp_seid;
-	struct getcap_req put_req;
-	struct getcap_resp cap_resp;
-	struct set_config s_config;
-	struct set_config_resp s_resp;
-	struct stream_cmd open_stream;
-	struct open_stream_rsp open_resp;
-	DBG("Begin");
-	DBG("SEID =3D %d", seid);
-
-	memset(&put_req, 0, sizeof(put_req));
-	init_request(&put_req.header, AVDTP_GET_CAPABILITIES);
-	put_req.acp_seid =3D seid;
-
-	if (write(s, &put_req, sizeof(put_req)) !=3D sizeof(put_req)) {
-		DBG("Couldn't request capabilities for SEID =3D %d", seid);
-		return (-1);
-	}
-	else {
-		DBG("Requested Capabilities for SEID =3D %d",seid);
-	}
-	if (read(s, &cap_resp, sizeof(cap_resp)) < sizeof(cap_resp) ||
-			cap_resp.header.message_type =3D=3D MESSAGE_TYPE_REJECT ||
-			cap_resp.media_type !=3D AUDIO_MEDIA_TYPE ||
-			cap_resp.media_codec_type !=3D SBC_MEDIA_CODEC_TYPE) {
-		DBG("Didn't receive SBC codec parameters (first) for SEID =3D %d", sei=
d);
-		return (-1);
-	}
-
-	DBG("Got capabilities response");
-
-	memset(&s_config, 0, sizeof(s_config));
-	init_request(&s_config.header, AVDTP_SET_CONFIGURATION);
-	s_config.serv_cap =3D MEDIA_TRANSPORT_CATEGORY;
-	s_config.acp_seid =3D seid;
-	s_config.int_seid =3D 1;	// how should I choose the int_seid??
-	s_config.cap_type =3D MEDIA_CODEC;
-	s_config.length =3D 6;
-	s_config.media_type =3D AUDIO_MEDIA_TYPE;
-	s_config.media_codec_type =3D SBC_MEDIA_CODEC_TYPE;
-
-	switch(sbc->channels) {
-	case 1:
-		v =3D 8;
-		break;
-	case 2:
-	default:
-		v =3D 2;
-		break;
-	}
-	s_config.codec_elements.sbc_elements.channel_mode =3D v;
-
-	switch(sbc->rate) {
-	case 16000:
-		v =3D 8;
-		break;
-	case 32000:
-		v =3D 4;
-		break;
-	case 48000:
-		v =3D 1;
-		break;
-	case 44100:
-	default:
-		v =3D 2;=20
-		break;
-	}
-	s_config.codec_elements.sbc_elements.frequency =3D v;
-	s_config.codec_elements.sbc_elements.allocation_method =3D 1 << 1;
-
-	switch(sbc->subbands) {
-	case 4:
-		v =3D 2;
-		break;
-	case 8:
-	default:
-		v =3D 1;
-		break;
-	}
-	s_config.codec_elements.sbc_elements.subbands =3D v;
-
-	switch(sbc->blocks) {
-	case 4:
-		v =3D 8;
-		break;
-	case 8:
-		v =3D 4;
-		break;
-	case 12:
-		v =3D 2;
-		break;
-	case 16:
-	default:
-		v =3D 1;
-		break;
-	}
-	s_config.codec_elements.sbc_elements.block_length =3D v;
-	s_config.codec_elements.sbc_elements.min_bitpool =3D cap_resp.codec_ele=
ments.sbc_elements.min_bitpool;
-	s_config.codec_elements.sbc_elements.max_bitpool =3D cap_resp.codec_ele=
ments.sbc_elements.max_bitpool;
-
-	if (!(cap_resp.codec_elements.sbc_elements.channel_mode & s_config.code=
c_elements.sbc_elements.channel_mode)) {
-		DBG("headset does not support this channel mode");
-	}
-
-	if (!(cap_resp.codec_elements.sbc_elements.frequency & s_config.codec_e=
lements.sbc_elements.frequency)) {
-		DBG("headset does not support this frequency");
-	}
-
-	if (!(cap_resp.codec_elements.sbc_elements.allocation_method & s_config=
.codec_elements.sbc_elements.allocation_method)) {
-		DBG("headset does not support this allocation_method");
-	}
-
-	if (!(cap_resp.codec_elements.sbc_elements.subbands & s_config.codec_el=
ements.sbc_elements.subbands)) {
-		DBG("headset does not support this subbands setting");
-	}
-
-	if (write(s, &s_config, sizeof(s_config)) !=3D sizeof(s_config)) {
-		DBG("couldn't set config seid =3D %d", seid);
-		return (-1);
-	}
-
-	DBG("Sent set configurations command");
-=09
-	size =3D read(s, &s_resp, sizeof(s_resp));
-	if (size =3D=3D sizeof(s_resp) - 2) {
-		DBG("Set configurations command accepted");
-	} else {
-		DBG("Set configurations command rejected");
-	}
-=09
-	memset(&open_stream, 0, sizeof(open_stream));
-	init_request(&open_stream.header, AVDTP_OPEN);
-	open_stream.acp_seid =3D seid;
-
-	if (write(s, &open_stream, sizeof(open_stream)) !=3D sizeof(open_stream=
)) {
-		DBG("Couldn't open stream SEID =3D %d", seid);
-		return (-1);
-	}
-
-	DBG("Sent open stream command");
-
-	if (read(s, &open_resp, sizeof(open_resp)) < sizeof(open_resp) - 1 ||
-			open_resp.header.message_type =3D=3D MESSAGE_TYPE_REJECT) {
-		DBG("Didn't receive open response confirm for SEID =3D %d", seid);
-		return (-1);
-	}
+        int v, size;
+        int seid =3D get_seid_resp->acp_seid;
+        struct getcap_req put_req;
+        struct getcap_resp cap_resp;
+        struct set_config s_config;
+        struct set_config_resp s_resp;
+        struct stream_cmd open_stream;
+        struct open_stream_rsp open_resp;
+        DBG("Begin SEID =3D %d", seid);
+
+        memset(&put_req, 0, sizeof(put_req));
+        init_request(&put_req.header, AVDTP_GET_CAPABILITIES);
+        put_req.acp_seid =3D seid;
+
+        if (write(s, &put_req, sizeof(put_req)) !=3D sizeof(put_req)) {
+                DBG("Couldn't request capabilities for SEID =3D %d", sei=
d);
+                return (-1);
+        }
+        else {
+                DBG("Requested Capabilities for SEID =3D %d",seid);
+        }
+        if (read(s, &cap_resp, sizeof(cap_resp)) < sizeof(cap_resp) ||
+                        cap_resp.header.message_type =3D=3D MESSAGE_TYPE=
_REJECT ||
+                        cap_resp.media_type !=3D AUDIO_MEDIA_TYPE ||
+                        cap_resp.media_codec_type !=3D SBC_MEDIA_CODEC_T=
YPE) {
+                DBG("Didn't receive SBC codec parameters (first) for SEI=
D =3D %d", seid);
+                return (-1);
+        }
+
+        DBG("Got capabilities response");
+
+        memset(&s_config, 0, sizeof(s_config));
+        init_request(&s_config.header, AVDTP_SET_CONFIGURATION);
+        s_config.serv_cap =3D MEDIA_TRANSPORT_CATEGORY;
+        s_config.acp_seid =3D seid;
+        s_config.int_seid =3D 1;	// how should I choose the int_seid??
+        s_config.cap_type =3D MEDIA_CODEC;
+        s_config.length =3D 6;
+        s_config.media_type =3D AUDIO_MEDIA_TYPE;
+        s_config.media_codec_type =3D SBC_MEDIA_CODEC_TYPE;
+
+        switch(sbc->channels) {
+        case 1:
+                v =3D 8;
+                break;
+        case 2:
+        default:
+                v =3D 2;
+                break;
+        }
+        s_config.codec_elements.sbc_elements.channel_mode =3D v;
+
+        switch(sbc->rate) {
+        case 16000:
+                v =3D 8;
+                break;
+        case 32000:
+                v =3D 4;
+                break;
+        case 48000:
+                v =3D 1;
+                break;
+        case 44100:
+        default:
+                v =3D 2;=20
+                break;
+        }
+        s_config.codec_elements.sbc_elements.frequency =3D v;
+        s_config.codec_elements.sbc_elements.allocation_method =3D 1 << =
1;
+
+        switch(sbc->subbands) {
+        case 4:
+                v =3D 2;
+                break;
+        case 8:
+        default:
+                v =3D 1;
+                break;
+        }
+        s_config.codec_elements.sbc_elements.subbands =3D v;
+
+        switch(sbc->blocks) {
+        case 4:
+                v =3D 8;
+                break;
+        case 8:
+                v =3D 4;
+                break;
+        case 12:
+                v =3D 2;
+                break;
+        case 16:
+        default:
+                v =3D 1;
+                break;
+        }
+        s_config.codec_elements.sbc_elements.block_length =3D v;
+        s_config.codec_elements.sbc_elements.min_bitpool =3D cap_resp.co=
dec_elements.sbc_elements.min_bitpool;
+        s_config.codec_elements.sbc_elements.max_bitpool =3D cap_resp.co=
dec_elements.sbc_elements.max_bitpool;
+
+        if (!(cap_resp.codec_elements.sbc_elements.channel_mode & s_conf=
ig.codec_elements.sbc_elements.channel_mode)) {
+                DBG("headset does not support this channel mode");
+        }
+
+        if (!(cap_resp.codec_elements.sbc_elements.frequency & s_config.=
codec_elements.sbc_elements.frequency)) {
+                DBG("headset does not support this frequency");
+        }
=20
-	DBG("Got open stream confirm");
+        if (!(cap_resp.codec_elements.sbc_elements.allocation_method & s=
_config.codec_elements.sbc_elements.allocation_method)) {
+                DBG("headset does not support this allocation_method");
+        }
=20
-	*psm =3D 25;
-	return 0;
+        if (!(cap_resp.codec_elements.sbc_elements.subbands & s_config.c=
odec_elements.sbc_elements.subbands)) {
+                DBG("headset does not support this subbands setting");
+        }
+
+        if (write(s, &s_config, sizeof(s_config)) !=3D sizeof(s_config))=
 {
+                DBG("couldn't set config seid =3D %d", seid);
+                return (-1);
+        }
+
+        DBG("Sent set configurations command");
+       =20
+        size =3D read(s, &s_resp, sizeof(s_resp));
+        if (size =3D=3D sizeof(s_resp) - 2) {
+                DBG("Set configurations command accepted");
+        } else {
+                DBG("Set configurations command rejected");
+        }
+       =20
+        memset(&open_stream, 0, sizeof(open_stream));
+        init_request(&open_stream.header, AVDTP_OPEN);
+        open_stream.acp_seid =3D seid;
+
+        if (write(s, &open_stream, sizeof(open_stream)) !=3D sizeof(open=
_stream)) {
+                DBG("Couldn't open stream SEID =3D %d", seid);
+                return (-1);
+        }
+
+        DBG("Sent open stream command");
+
+        if (read(s, &open_resp, sizeof(open_resp)) < sizeof(open_resp) -=
 1 ||
+                        open_resp.header.message_type =3D=3D MESSAGE_TYP=
E_REJECT) {
+                DBG("Didn't receive open response confirm for SEID =3D %=
d", seid);
+                return (-1);
+        }
+
+        DBG("Got open stream confirm");
+
+        *psm =3D 25;
+        return 0;
=20
 }
 // Detect whether A2DP Sink is present at the destination or not
 int detect_a2dp(bdaddr_t *src, bdaddr_t *dst, unsigned short *psm, unsig=
ned long *flags)
 {
-	sdp_session_t *sess;
-	sdp_list_t *attrid, *search, *seq, *next;
-	sdp_data_t *pdlist;
-	uuid_t group;
-	uint32_t range =3D 0x0000ffff;
-	int err;
-	int tries;
-
-	DBG("Begin");
-	tries =3D 0;
-	while(!(sess =3D sdp_connect(src, dst, SDP_RETRY_IF_BUSY))) {
-		DBG("retrying sdp connect: %s", strerror(errno));
-		sleep(1);
-		if(++tries > 10) {
-			break;
-		}
-	}
-	if (!sess) {
-		DBG( "Warning: failed to connect to SDP server: %s", strerror(errno));
-		if(psm) *psm =3D 25;
-		if(flags) *flags =3D 0;
-		return 0;
-	}
-
-	/* 0x1108->all? 0x1101->rf sink 0x111e->handsfree 0x1108->headset */
-	sdp_uuid16_create(&group, 0x110d);
-	search =3D sdp_list_append(0, &group);
-	attrid =3D sdp_list_append(0, &range);
-	err =3D sdp_service_search_attr_req(sess, search,
-					SDP_ATTR_REQ_RANGE, attrid, &seq);
-	sdp_list_free(search, 0);
-	sdp_list_free(attrid, 0);
-
-	if (err) {
-		DBG( "Service Search failed: %s", strerror(errno));
-		sdp_close(sess);
-		return -1;
-	}
-
-	for (; seq; seq =3D next) {
-		sdp_record_t *rec =3D (sdp_record_t *) seq->data;
-
-		DBG( "Found A2DP Sink");
-		if (psm)
-			*psm =3D 25;
-
-		next =3D seq->next;
-		free(seq);
-		sdp_record_free(rec);
-	}
-
-	sdp_uuid16_create(&group, PNP_INFO_SVCLASS_ID);
-	search =3D sdp_list_append(0, &group);
-	attrid =3D sdp_list_append(0, &range);
-	err =3D sdp_service_search_attr_req(sess, search,
-					SDP_ATTR_REQ_RANGE, attrid, &seq);
-	sdp_list_free(search, 0);
-	sdp_list_free(attrid, 0);
-
-	if (err)
-		goto done;
-
-	if (flags)
-		*flags =3D 0;
-
-	for (; seq; seq =3D next) {
-		sdp_record_t *rec =3D (sdp_record_t *) seq->data;
-		uint16_t vendor, product, version;
-
-		pdlist =3D sdp_data_get(rec, 0x0201);
-		vendor =3D pdlist ? pdlist->val.uint16 : 0x0000;
-
-		pdlist =3D sdp_data_get(rec, 0x0202);
-		product =3D pdlist ? pdlist->val.uint16 : 0x0000;
-
-		pdlist =3D sdp_data_get(rec, 0x0203);
-		version =3D pdlist ? pdlist->val.uint16 : 0x0000;
-
-		DBG( "Product ID %04x:%04x:%04x", vendor, product, version);
-
-		if (vendor =3D=3D 0x1310 && product =3D=3D 0x0100 && version =3D=3D 0x=
0104) {
-			DBG( "Enabling GCT media payload workaround");
-			if (flags)
-				*flags |=3D NONSPECAUDIO;
-		}
-
-		next =3D seq->next;
-		free(seq);
-		sdp_record_free(rec);
-	}
+        sdp_session_t *sess;
+        sdp_list_t *attrid, *search, *seq, *next;
+        sdp_data_t *pdlist;
+        uuid_t group;
+        uint32_t range =3D 0x0000ffff;
+        int err;
+        int tries;
+
+        DBG("Begin");
+        tries =3D 0;
+        while(!(sess =3D sdp_connect(src, dst, SDP_RETRY_IF_BUSY))) {
+                DBG("retrying sdp connect: %s", strerror(errno));
+                sleep(1);
+                if(++tries > 2) {
+                        break;
+                }
+        }
+        if (!sess) {
+                DBG( "Warning: failed to connect to SDP server: %s", str=
error(errno));
+                if(psm) *psm =3D 25;
+                if(flags) *flags =3D 0;
+                return 0;
+        }
+
+        /* 0x1108->all? 0x1101->rf sink 0x111e->handsfree 0x1108->headse=
t */
+        sdp_uuid16_create(&group, 0x110d);
+        search =3D sdp_list_append(0, &group);
+        attrid =3D sdp_list_append(0, &range);
+        err =3D sdp_service_search_attr_req(sess, search,
+                                        SDP_ATTR_REQ_RANGE, attrid, &seq=
);
+        sdp_list_free(search, 0);
+        sdp_list_free(attrid, 0);
+
+        if (err) {
+                DBG( "Service Search failed: %s", strerror(errno));
+                sdp_close(sess);
+                return -1;
+        }
+
+        for (; seq; seq =3D next) {
+                sdp_record_t *rec =3D (sdp_record_t *) seq->data;
+
+                DBG( "Found A2DP Sink");
+                if (psm)
+                        *psm =3D 25;
+
+                next =3D seq->next;
+                free(seq);
+                sdp_record_free(rec);
+        }
+
+        sdp_uuid16_create(&group, PNP_INFO_SVCLASS_ID);
+        search =3D sdp_list_append(0, &group);
+        attrid =3D sdp_list_append(0, &range);
+        err =3D sdp_service_search_attr_req(sess, search,
+                                        SDP_ATTR_REQ_RANGE, attrid, &seq=
);
+        sdp_list_free(search, 0);
+        sdp_list_free(attrid, 0);
+
+        if (err)
+                goto done;
+
+        if (flags)
+                *flags =3D 0;
+
+        for (; seq; seq =3D next) {
+                sdp_record_t *rec =3D (sdp_record_t *) seq->data;
+                uint16_t vendor, product, version;
+
+                pdlist =3D sdp_data_get(rec, 0x0201);
+                vendor =3D pdlist ? pdlist->val.uint16 : 0x0000;
+
+                pdlist =3D sdp_data_get(rec, 0x0202);
+                product =3D pdlist ? pdlist->val.uint16 : 0x0000;
+
+                pdlist =3D sdp_data_get(rec, 0x0203);
+                version =3D pdlist ? pdlist->val.uint16 : 0x0000;
+
+                DBG( "Product ID %04x:%04x:%04x", vendor, product, versi=
on);
+
+                if (vendor =3D=3D 0x1310 && product =3D=3D 0x0100 && ver=
sion =3D=3D 0x0104) {
+                        DBG( "Enabling GCT media payload workaround");
+                        if (flags)
+                                *flags |=3D NONSPECAUDIO;
+                }
+
+                next =3D seq->next;
+                free(seq);
+                sdp_record_free(rec);
+        }
=20
 done:
-	sdp_close(sess);
-	return 0;
+        sdp_close(sess);
+        return 0;
 }
 // Connecting on PSM 25
 int do_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm, uint16_=
t *mtu)
 {
-	struct sockaddr_l2 addr;
-	struct l2cap_options opts;
-	int sk;
-	unsigned int opt;
-	int tries;
-=09
-	DBG("Begin");
-	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
-	if (sk < 0) {
-		DBG( "Can't create socket. %s(%d)",
-			strerror(errno), errno);
-		return -1;
-	}
-
-	DBG( "Connecting to bluetooth");
-
-	memset(&addr, 0, sizeof(addr));
-	addr.l2_family =3D AF_BLUETOOTH;
-	bacpy(&addr.l2_bdaddr, src);
-	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		DBG( "Can't bind socket. %s(%d)",
-						strerror(errno), errno);
-		return -1;
-	}
-
-	/* Get default options */
-	opt =3D sizeof(opts);
-	if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
-		DBG( "Can't get default L2CAP options. %s(%d)",
-						strerror(errno), errno);
-		return -1;
-	}
-
-	/* Set new options */
-	if(mtu && *mtu) {
-		opts.omtu =3D *mtu;
-		//opts.imtu =3D *mtu;
-	}
-	if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
-		DBG( "Can't set L2CAP options. %s(%d)",
-						strerror(errno), errno);
-		return -1;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.l2_family =3D AF_BLUETOOTH;
-	bacpy(&addr.l2_bdaddr, dst);
-	addr.l2_psm =3D htobs(psm);
-
-	tries =3D 0;
-	while (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		DBG("Can't connect to %s on psm %d. %s(%d)",
-				batostr(&addr.l2_bdaddr), psm, strerror(errno), errno);
-		sleep(1);
-		++tries;
-		if(++tries > 10) {
-			close(sk);
-			return -1;
-		}
-	}
-	opt =3D sizeof(opts);
-	if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
-		DBG( "Can't get L2CAP options. %s(%d)",
-						strerror(errno), errno);
-		close(sk);
-		return -1;
-	}
+        struct sockaddr_l2 addr;
+        struct l2cap_options opts;
+        int sk;
+        unsigned int opt;
+        int tries;
+       =20
+        DBG("Begin");
+        sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+        if (sk < 0) {
+                DBG( "Can't create socket. %s(%d)",
+                        strerror(errno), errno);
+                return -1;
+        }
=20
-	DBG( "Connected [imtu %d, omtu %d, flush_to %d]",
-					opts.imtu, opts.omtu, opts.flush_to);
+        DBG( "Connecting to bluetooth");
=20
-	if (mtu)
-		*mtu =3D opts.omtu;
+        memset(&addr, 0, sizeof(addr));
+        addr.l2_family =3D AF_BLUETOOTH;
+        bacpy(&addr.l2_bdaddr, src);
+        if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+                DBG( "Can't bind socket. %s(%d)",
+                                                strerror(errno), errno);
+                return -1;
+        }
=20
-	return sk;
-}
+        /* Get default options */
+        opt =3D sizeof(opts);
+        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
+                DBG( "Can't get default L2CAP options. %s(%d)",
+                                                strerror(errno), errno);
+                return -1;
+        }
=20
-int connect_stream(bdaddr_t *src, bdaddr_t *dst, int *cmdfd_return, sbc_=
t *sbc, int* seid_return)
-{
-	int cmdfd=3D-1;
-	struct getcap_req put_req;
-	struct sepd_resp get_resp;
-	struct stream_cmd start_stream;
-	struct start_stream_rsp start_resp;
-	int seid, last_seid_index;
-	int size;
-	int i;
-	unsigned short psm_cmd,psm_stream;
-	unsigned long flags =3D 0;
-	static int streamfd;
-	uint16_t mtu =3D 0;
-	int tries;
-
-	DBG("Begin");
-	DBG( "Using address: %s", batostr(dst));
-
-	if (detect_a2dp(src, dst, &psm_cmd, &flags) < 0) {
-		DBG( "could not find A2DP services on device %s", batostr(dst));
-		return -1;
-	}
-	else {
-		DBG( "Found A2DP Sink at the destination");
-	}
-
-	psm_cmd=3D25;=09
-	cmdfd =3D do_connect(src, dst, psm_cmd, NULL);
-	if (cmdfd < 0) {
-		DBG( "cannot open psm_cmd =3D %d", psm_cmd);
-		return -1;
-	}
-
-	// avdt_discover_req
-	memset(&put_req, 0, sizeof(put_req));
-	init_request(&put_req.header, AVDTP_DISCOVER);
-
-	if (write(cmdfd, &put_req, sizeof(put_req)) !=3D sizeof(put_req)) {
-		DBG("couldn't send avdtp_discover");
-		close(cmdfd);
-		return -1;
-	}
-	else {
-		DBG("Sent the Stream End Point Discovery Command");
-	}
-	tries =3D 0;
-	while((size =3D read(cmdfd, &get_resp, sizeof(get_resp))) < 0) {
-		DBG("retrying discover response read...");
-		sleep(1);
-		if(++tries > 10) {
-			break;
-		}
-	}
-	if (size < sizeof(get_resp) - MAX_ADDITIONAL_CODEC_OCTETS) {
-		DBG("couldn't get avdtp_discover");
-		close(cmdfd);
-		return -1;
-	}
-	else {
-		DBG("Got a Stream End Point Discovery Response");
-	}
-	seid =3D -1;
-	last_seid_index =3D MAX_ADDITIONAL_CODEC - ((sizeof(get_resp)-size)/siz=
eof(struct acp_seid_info));
-
-	DBG("received %d capabilities", last_seid_index + 1);
-
-	for(i=3D0; i <=3D last_seid_index; i++) {
-		if (process_seid(cmdfd, &get_resp.infos[i], &psm_stream, sbc) =3D=3D 0=
) {
-			seid =3D get_resp.infos[i].acp_seid;
-			break;
-		}
-	}
-
-	if(seid =3D=3D -1) {
-		//We have not found the seid that we want
-		DBG("couldn't locate the correct seid");
-		return -1;
-	}
-
-	// open the stream
-
-	streamfd =3D do_connect(src, dst, psm_stream, &mtu);
-	if (streamfd < 0) {
-		DBG("cannot open psm_stream =3D %d", psm_stream);
-		return -1;
-	}
-=09
-	// start the stream
-
-	memset(&start_stream, 0, sizeof(start_stream));
-	init_request(&start_stream.header, AVDTP_START);
-	start_stream.acp_seid =3D seid;
-
-	if (write(cmdfd, &start_stream, sizeof(start_stream)) !=3D sizeof(start=
_stream)) {
-		DBG("couldn't send start_stream");
-		close(streamfd);
-		close(cmdfd);
-		return -1;
-	}
-
-	DBG("Sent stream start");
-
-	if (read(cmdfd, &start_resp, sizeof(start_resp)) < sizeof(start_resp) -=
 2 ||start_resp.header.message_type =3D=3D MESSAGE_TYPE_REJECT) {
-		DBG("didn't receive start_resp confirm for seid =3D %d", seid);
-		close(streamfd);
-		close(cmdfd);
-		return (-1);
-	}
-
-	DBG("Got start stream confirm");
-
-	*seid_return =3D seid;
-	*cmdfd_return =3D cmdfd;
-	return streamfd;
-}
+        /* Set new options */
+        if(mtu && *mtu) {
+                opts.omtu =3D *mtu;
+                //opts.imtu =3D *mtu;
+        }
+        if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
+                DBG( "Can't set L2CAP options. %s(%d)",
+                                                strerror(errno), errno);
+                return -1;
+        }
=20
-typedef struct snd_pcm_a2dp {
-	//snd_pcm_ioplug_t io;
-	int refcnt;
-	int timeout;
-	unsigned long state;
-	bdaddr_t src;
-	bdaddr_t dst;
-	int sk;
-	int control_sk;
-	sbc_t sbc;
-	int/*snd_pcm_sframes_t */num;
-	unsigned char buf[1024]; // contain sbc encoded data, incrementally fil=
led
-	unsigned int len; // number of valid bytes in buf
-	unsigned int frame_bytes; // fixed when initializing
-	int use_rfcomm;
-=09
-	char bufe[BUFS]; // temporary encoding buffer
-	=09
-	int lenbufe;//=3D0;
-	unsigned long nbytes;//=3D0;
-	struct timeval tsend;
-		 =20
-	time_t timestamp;//=3D0;
-	uint16_t seq_num;//=3D1;
-	int frame_count;//=3D0;
-	int transfer_num;
-
-	int seid;
-=09
-	// Used to control stream from headset
-	int stop_writing;// =3D 0;
-	int pause_writing;// =3D 0;
-	pthread_t hListenThread;
-} snd_pcm_a2dp_t;
-/*
-void inline a2dp_get(snd_pcm_a2dp_t *a2dp)
-{
-	a2dp->refcnt++;
-	a2dp->timeout =3D 0;
-}
+        memset(&addr, 0, sizeof(addr));
+        addr.l2_family =3D AF_BLUETOOTH;
+        bacpy(&addr.l2_bdaddr, dst);
+        addr.l2_psm =3D htobs(psm);
+
+        tries =3D 0;
+        while (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0)=
 {
+                DBG("Can't connect to %s on psm %d. %s(%d)",
+                                batostr(&addr.l2_bdaddr), psm, strerror(=
errno), errno);
+                sleep(1);
+                if(++tries > 2) {
+                        close(sk);
+                        return -1;
+                }
+        }
+        opt =3D sizeof(opts);
+        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
+                DBG( "Can't get L2CAP options. %s(%d)",
+                                                strerror(errno), errno);
+                close(sk);
+                return -1;
+        }
=20
-void inline a2dp_put(snd_pcm_a2dp_t *a2dp)
-{
-	a2dp->refcnt--;
+        DBG( "Connected psm=3D%d sk=3D%d [imtu %d, omtu %d, flush_to %d]=
", psm, sk,
+                                        opts.imtu, opts.omtu, opts.flush=
_to);
+
+        if (mtu)
+                *mtu =3D opts.omtu;
=20
-	if (a2dp->refcnt <=3D 0)
-		a2dp->timeout =3D 2;
+        return sk;
 }
=20
-int a2dp_start(snd_pcm_ioplug_t *io)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+int connect_stream(bdaddr_t *src, bdaddr_t *dst, int *cmdfd_return, sbc_=
t *sbc, int* seid_return, int* omtu)
+{
+        int cmdfd=3D-1;
+        struct sepd_req discover_req;
+        struct sepd_resp discover_resp;
+        struct stream_cmd start_stream;
+        struct start_stream_rsp start_resp;
+        int seid, nb_seid;
+        int size;
+        int i;
+        unsigned short psm_cmd,psm_stream=3D25;
+        unsigned long flags =3D 0;
+        int streamfd =3D -1;
+        uint16_t mtu =3D 0;
+        int tries, res;
+
+        DBG("Begin");
+        DBG( "Using address: %s", batostr(dst));
+
+        if (detect_a2dp(src, dst, &psm_cmd, &flags) < 0) {
+                DBG( "could not find A2DP services on device %s", batost=
r(dst));
+                return -1;
+        }
+        else {
+                DBG( "Found A2DP Sink at the destination (psm_cmd=3D%d)"=
, psm_cmd);
+        }
=20
-	DBG("a2dp %p", a2dp);
+        psm_cmd=3D25;=09
+        cmdfd =3D do_connect(src, dst, psm_cmd, &mtu);
+        if (cmdfd < 0) {
+                DBG( "cannot open psm_cmd =3D %d", psm_cmd);
+                return -1;
+        }
=20
-	a2dp->len =3D 13;
+        // avdt_discover_req
+        memset(&discover_req, 0, sizeof(discover_req));
+        init_request(&discover_req.header, AVDTP_DISCOVER);
+
+        res=3Dwrite(cmdfd, &discover_req, sizeof(discover_req));
+        if (res !=3D sizeof(discover_req)) {
+                DBG("couldn't send avdtp_discover (res=3D%d)", res);
+                close(cmdfd);
+                return -1;
+        }
+        else {
+                DBG("Sent the Stream End Point Discovery Command");
+        }
+        tries =3D 0;
+        memset(&discover_resp, 0, sizeof(discover_resp));
=20
-	return 0;
-}
+        // SONORIX sends us a discover signal we should answer but we wi=
ll discard
+        while(tries<10)
+        {
+                size =3D read(cmdfd, &discover_resp, sizeof(discover_res=
p));
+                tries++;
+                if(size>0)
+                {
+                        if((discover_resp.header.message_type =3D=3D MES=
SAGE_TYPE_ACCEPT)
+                         &&(discover_resp.header.signal_id =3D=3D AVDTP_=
DISCOVER)
+                          )
+                        {
+                                break;
+                        }
+                        else
+                        {
+                                DBG("Invalid response read, rejected..."=
);
+                                if(discover_resp.header.message_type =3D=
=3D MESSAGE_TYPE_COMMAND)
+                                {
+                                        discover_resp.header.message_typ=
e =3D MESSAGE_TYPE_REJECT;
+                                        write(cmdfd, &discover_resp, siz=
eof(discover_resp.header));
+                                }
+                               =20
+                                DBG("retrying discover response read..."=
);
+                                // Discard what is not an answer
+                                usleep(100);
+                        }
+                }
+                else
+                {
+                        DBG("retrying discover response read...");
+                        // Discard what is not an answer
+                        usleep(100);
+                }
+        }
=20
-snd_pcm_sframes_t a2dp_pointer(snd_pcm_ioplug_t *io)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
+        if (size > sizeof(discover_resp.header))
+        {
+                DBG("Got a Stream End Point Discovery (%d bytes) Respons=
e (msgtype=3D%d,pkttype=3D%d,lbl=3D%d,sig=3D%d,rfa=3D%d)",=20
+                size,
+                discover_resp.header.message_type,
+                discover_resp.header.packet_type,
+                discover_resp.header.transaction_label,
+                discover_resp.header.signal_id,
+                discover_resp.header.rfa0);
+                for(i=3D0; i<size; i++)
+                        printf("%02X", (int)(*(((char*)&discover_resp)+i=
)));
+                printf("\n");
+        }
+        else
+        {
+                DBG("couldn't get avdtp_discover (size=3D%d, min=3D%d, m=
ax=3D%d)", size, sizeof(discover_resp.header), sizeof(discover_resp));
+                close(cmdfd);
+                return -1;
+        }
=20
-	return a2dp->num;
-}
+        seid =3D -1;
+        nb_seid =3D (size-sizeof(discover_resp.header))/sizeof(struct ac=
p_seid_info);
=20
-void sleeptill(struct timeval *t, struct timeval *dt)
-{
-	struct timeval tc,dtc;
-	struct timezone tz;
-	int i;
-
-   	i=3Dgettimeofday(&tc,&tz);
-	if timercmp(t, &tc, <){ // too late to wait
-		timeradd(&tc, dt, t);
-		return;
-	}
-	usleep(1); //sinchronize with usleep cycle
-   	i=3Dgettimeofday(&tc,&tz);
-	timersub(t, &tc, &dtc);
-	if (dtc.tv_sec=3D=3D0){	timeradd(t, dt, t);}
-	else {timeradd(&tc, dt, t);return; } //more than a second to sleep, pos=
sibly error
-	if (dtc.tv_usec<=3D2000)  return; //too late to sleep
-	usleep(dtc.tv_usec-2000); // wake up somewhere in the middle of 4ms
-	return;
-}
-*/
-/*
-// returns time to wait ie difference between tsend and current time
-// if time has come, advances tsend
-int time_to_wait(struct timeval *tsend, struct timeval *dt)
-{
-	struct timeval tc,dtc,t2,dt2;
-	struct timezone tz;
-	int i;
-	dt2.tv_sec=3D0;
-	dt2.tv_usec=3D2000;// middle of 4ms
-   	i=3Dgettimeofday(&tc,&tz);
-
-	timeradd(&tc, &dt2, &t2);
-=09
-	if timercmp(tsend, &t2, <){ // time has come
-		timeradd(tsend, dt, tsend);
-		if timercmp(tsend, &tc, <)	timeradd(&tc, dt, tsend); //if tsend<tc; ts=
end=3Dtc+dt
-		return 0;
-	}
-	timersub(tsend, &tc, &dtc);
-	return dtc.tv_usec;
-}
+        DBG("received %d capabilities", nb_seid);
=20
-// transfers around correct time postions
-snd_pcm_sframes_t a2dp_transfer(snd_pcm_ioplug_t *io, const snd_pcm_chan=
nel_area_t *areas, snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-	char *buf;
-	int len;
-	struct media_packet_header packet_header;
-	struct media_payload_header payload_header;
-	int codesize,datatoread;
-	unsigned long sleeptime;
-	struct timeval dt;
-=09
-
-	codesize=3Da2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.channels*2; //=
 size of data encoded by sbc_encode in one call
-	datatoread=3Dmin(codesize,size*a2dp->frame_bytes); // amount of data to=
 read
-	buf =3D (char *) areas->addr + (areas->first + areas->step * offset) / =
8;
-    if(a2dp->lenbufe<codesize && a2dp->lenbufe+datatoread<sizeof(a2dp->b=
ufe))
-	{
-		// if not enough data in bufe to encode and there is space in bufe
-		memcpy(a2dp->bufe+a2dp->lenbufe,buf,datatoread);// we read data to buf=
e
-		a2dp->lenbufe+=3Ddatatoread;
-	}
-	else{
-		datatoread=3D0; //nothing has been read
-	}
-
-	// Encode
-	if(a2dp->lenbufe>=3Dcodesize && a2dp->len + a2dp->sbc.len < 678)
-	{
-		// if enough data in bufe to encode and not enough frame to fill up mt=
u: encoding
-		change_endian(a2dp->bufe,codesize); // changing the endianness
-		len =3D sbc_encode(&(a2dp->sbc), a2dp->bufe, codesize); //encode
-		memmove(a2dp->bufe, a2dp->bufe + len, a2dp->lenbufe - len); //shift th=
e bufe                                =20
-		a2dp->lenbufe-=3Dlen;
-		a2dp->nbytes+=3Dlen;
-		sleeptime +=3D a2dp->sbc.duration;
-		if (len <=3D 0)
-			return len;
-		a2dp->frame_count++;
-		memcpy(a2dp->buf + a2dp->len, a2dp->sbc.data, a2dp->sbc.len); // copy =
encoded frames into a2dp->buf
-		a2dp->len+=3Da2dp->sbc.len;
-		if (a2dp->state =3D=3D BT_CONNECTED)
-			a2dp->num +=3D len / a2dp->frame_bytes; //update pointer
-			a2dp->num %=3Dio->buffer_size;
-	}	=09
-
-	// Transfer
-	if(a2dp->len + a2dp->sbc.len > 678)
-	{
-		// if packet is formed
-		dt.tv_usec=3D1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->frame_c=
ount/io->rate; // time interval between transmitions
-		dt.tv_sec=3D0;
-		if(time_to_wait(&a2dp->tsend, &dt)=3D=3D0)
-		{
-			// time to send data
-			memset(&payload_header, 0, sizeof(payload_header)); // fill up the he=
aders
-			memset(&packet_header, 0, sizeof(packet_header)); //---
-			payload_header.frame_count=3Da2dp->frame_count;
-			packet_header.v =3D 2;
-			packet_header.pt =3D 1;
-			packet_header.sequence_number =3D htons(a2dp->seq_num);
-			packet_header.timestamp =3D htonl(a2dp->timestamp);
-			packet_header.ssrc =3D htonl(1);
-			a2dp->timestamp +=3D (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands +=
 1)*4;
-			memcpy(a2dp->buf, &packet_header, sizeof(packet_header)); //copy the =
headers to buf
-			memcpy(a2dp->buf + sizeof(packet_header), &payload_header, sizeof(pay=
load_header));//---
-			write(a2dp->sk,a2dp->buf,a2dp->len); // sending the packet
-			a2dp->len =3D sizeof(packet_header)+sizeof(payload_header); //inital =
position in buf, just after headers
-			a2dp->frame_count=3D0;
-			sleeptime=3D0;
-			a2dp->seq_num++;
-		}
-		else
-		{
-			usleep(1);
-		}
-	}
-	return datatoread / a2dp->frame_bytes;
-}
+        for(i=3D0; i < nb_seid; i++)
+        {
+                if (process_seid(cmdfd, &discover_resp.infos[i], &psm_st=
ream, sbc) =3D=3D 0)
+                {
+                        seid =3D discover_resp.infos[i].acp_seid;
+                        break;
+                }
+        }
+
+        if(seid =3D=3D -1) {
+                //We have not found the seid that we want
+                DBG("couldn't locate the correct seid");
+                return -1;
+        }
+
+        // open the stream
+        streamfd =3D do_connect(src, dst, psm_stream, &mtu);
+        if (streamfd < 0) {
+                DBG("cannot open psm_stream =3D %d", psm_stream);
+                return -1;
+        }
+
+        // start the stream
+
+        memset(&start_stream, 0, sizeof(start_stream));
+        init_request(&start_stream.header, AVDTP_START);
+        start_stream.acp_seid =3D seid;
+
+        if (write(cmdfd, &start_stream, sizeof(start_stream)) !=3D sizeo=
f(start_stream)) {
+                DBG("couldn't send start_stream");
+                close(streamfd);
+                close(cmdfd);
+                return -1;
+        }
+
+        DBG("Sent stream start(seid=3D%d)", seid);
+
+        if (read(cmdfd, &start_resp, sizeof(start_resp)) < sizeof(start_=
resp) - 2 ||start_resp.header.message_type =3D=3D MESSAGE_TYPE_REJECT) {
+                DBG("didn't receive start_resp confirm for seid =3D %d",=
 seid);
+                close(streamfd);
+                close(cmdfd);
+                return (-1);
+        }
+
+        DBG("Got start stream confirm");
+
+        *seid_return =3D seid;
+        *cmdfd_return =3D cmdfd;
+        return streamfd;
+}
+
+typedef struct snd_pcm_a2dp
+{
+        bdaddr_t src;
+        bdaddr_t dst;
+        int sk;
+        int control_sk;
+        sbc_t sbc;
+        unsigned char buf[1024]; // contain sbc encoded data, incrementa=
lly filled
+        unsigned int len; // number of valid bytes in buf
+        unsigned int frame_bytes; // fixed when initializing
+       =20
+        char bufe[BUFS]; // temporary encoding buffer
+        int lenbufe;//=3D0;
+=20
+        time_t timestamp;//=3D0;
+        uint16_t seq_num;//=3D1;
+        int frame_count;//=3D0; // Number of sbc frames in one AVDTP pac=
ket
+=20
+        int mtu;//=3DA2DPMAXIMUMTRANSFERUNITSIZE
+        int seid;
+
+        // Used to control stream from headset
+        int stop_writing;// =3D 0;
+        int pause_writing;// =3D 0;
+        pthread_t hListenThread;
+       =20
+} snd_pcm_a2dp_t;
=20
-// also works but sleeps between transfers
-snd_pcm_sframes_t a2dp_transfer2(snd_pcm_ioplug_t *io, const snd_pcm_cha=
nnel_area_t *areas, snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-	char *buf;
-	int len;
-	struct media_packet_header packet_header;
-	struct media_payload_header payload_header;
-	int codesize,datatoread;
-	unsigned long sleeptime;
-	int written;
-=09
-	struct timeval dt;
-
-	codesize=3Da2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.channels*2;
-	datatoread=3Dmin(codesize,size*a2dp->frame_bytes);
-
-	struct timeval timeofday;
-	gettimeofday(&timeofday, NULL);
-=09
-	buf =3D (char *) areas->addr + (areas->first + areas->step * offset) / =
8;
-    	if(a2dp->lenbufe<codesize){
-		memcpy(a2dp->bufe+a2dp->lenbufe,buf,datatoread);
-		a2dp->lenbufe+=3Ddatatoread;
-	} =20
-	else{datatoread=3D0;}
-
-	if(a2dp->lenbufe>=3Dcodesize){ //enough data to encode
-		change_endian(a2dp->bufe,codesize); // changing the endianness
-		len =3D sbc_encode(&(a2dp->sbc), a2dp->bufe, codesize); //encode
-		memmove(a2dp->bufe, a2dp->bufe + len, a2dp->lenbufe - len); //shift th=
e bufe                                =20
-		a2dp->lenbufe-=3Dlen;
-		a2dp->nbytes+=3Dlen;
-		sleeptime +=3D a2dp->sbc.duration;
-		if (len <=3D 0)
-			return len;
-		if(a2dp->len + a2dp->sbc.len > 678)	{ // time to prepare and send the =
packet
-			dt.tv_sec=3D0;
-			dt.tv_usec=3D1000000*a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->frame_=
count/io->rate;
-			memset(&payload_header, 0, sizeof(payload_header));
-			memset(&packet_header, 0, sizeof(packet_header));
-			payload_header.frame_count=3Da2dp->frame_count;
-			packet_header.v =3D 2;
-			packet_header.pt =3D 1;
-			packet_header.sequence_number =3D htons(a2dp->seq_num);
-			packet_header.timestamp =3D htonl(a2dp->timestamp);
-			packet_header.ssrc =3D htonl(1);
-			a2dp->timestamp +=3D (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands +=
 1)*4;
-			memcpy(a2dp->buf, &packet_header, sizeof(packet_header));
-			memcpy(a2dp->buf + sizeof(packet_header), &payload_header, sizeof(pay=
load_header));
-			sleeptill(&a2dp->tsend, &dt);
-			if((written =3D write(a2dp->sk,a2dp->buf,a2dp->len)) !=3D a2dp->len) =
{
-				DBG("Wrote %d not %d bytes; errno %s(%d)", written, a2dp->len,
-					strerror(errno), errno);
-			}
-			a2dp->len =3D sizeof(packet_header)+sizeof(payload_header);
-			a2dp->frame_count=3D0;
-			sleeptime=3D0;
-			a2dp->seq_num++;
-		}
-		a2dp->frame_count++;
-		memcpy(a2dp->buf + a2dp->len, a2dp->sbc.data, a2dp->sbc.len);
-		a2dp->len+=3Da2dp->sbc.len;
-		if (a2dp->state =3D=3D BT_CONNECTED)
-			a2dp->num +=3D len / a2dp->frame_bytes;
-	}
-	return datatoread / a2dp->frame_bytes;
-}
-*/
 // We have pcm data to send through bluetooth
 int a2dp_transfer_raw(LPA2DP a2dp, const char* pcm_buffer, int pcm_buffe=
r_size)
 {
         // No error
-	int result =3D 0;
-	struct media_packet_header packet_header;
-	struct media_payload_header payload_header;
-	int codesize,datatoread;
-	unsigned long sleeptime;
-	int written;
-	struct timeval dt;
+        int result =3D 0;
+        struct media_packet_header packet_header;
+        struct media_payload_header payload_header;
+        int codesize,datatoread;
+        int written;
=20
         // Check parameter
-	if(a2dp=3D=3D0 || pcm_buffer=3D=3D0 || pcm_buffer_size=3D=3D0) return E=
INVAL;
-
-        //if(a2dp->transfer_num%1000=3D=3D0) DBG("Transfer %d", a2dp->tr=
ansfer_num);
+        if(a2dp=3D=3D0 || pcm_buffer=3D=3D0 || pcm_buffer_size=3D=3D0) r=
eturn EINVAL;
=20
         // How much data can be encoded by sbc at a time?
         codesize=3Da2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.channel=
s*2;
         // 16 bits * 2 channels * 16 blocks * 8 subbands =3D 4096bits =3D=
 512 o
         datatoread=3Dmin(codesize,pcm_buffer_size);
=20
-        //if(a2dp->transfer_num%1000=3D=3D0) DBG("Codec encode blocks of=
 %d bytes, we read %d bytes of %d incoming", codesize, datatoread, pcm_bu=
ffer_size);
-
         // Enqueue data in bufe
-        if(a2dp->lenbufe<codesize)
+        if(a2dp->lenbufe+datatoread < BUFS)
         {
                 // Append data to bufe, for sbc encoding
-                memcpy(a2dp->bufe+a2dp->lenbufe, pcm_buffer, datatoread)=
;
+                memcpy_changeendian(a2dp->bufe+a2dp->lenbufe, pcm_buffer=
, datatoread);
                 a2dp->lenbufe+=3Ddatatoread;
         }
         else
@@ -922,32 +734,24 @@
                 datatoread=3D0;
         }
=20
+
         // If bufe is full, encode
         if(a2dp->lenbufe>=3Dcodesize)
         {
                 // Enough data to encode (sbc wants 1k blocks)
                 int encoded;
-                change_endian(a2dp->bufe,codesize); // changing the endi=
anness
                 encoded =3D sbc_encode(&(a2dp->sbc), a2dp->bufe, codesiz=
e); //encode
=20
                 if (encoded <=3D 0)
                         return encoded;
=20
-                //if(a2dp->transfer_num%1000=3D=3D0) DBG("Compressed SBC=
 %d encoded bytes / %d bytes really encoded / %d bytes wanted", a2dp->sbc=
.len, encoded, codesize);
                 memmove(a2dp->bufe, a2dp->bufe + encoded, a2dp->lenbufe =
- encoded); // Shift the bufe
-                a2dp->lenbufe-=3Dencoded;
-                a2dp->nbytes+=3Dencoded;
-                //if(a2dp->transfer_num%1000=3D=3D0) DBG("Shifted SBC (b=
ufe, bufe+encoded=3D%d, lenbufe=3D%d-encoded=3D%d)", encoded, a2dp->lenbu=
fe, a2dp->lenbufe - encoded);
-
-                sleeptime +=3D a2dp->sbc.duration;
+                a2dp->lenbufe -=3D encoded;
=20
                 // Send data through bluetooth
-                if(a2dp->len + a2dp->sbc.len > 678)
+                if(a2dp->len + a2dp->sbc.len >=3D a2dp->mtu)
                 {
-                        //if(a2dp->transfer_num%1000=3D=3D0) DBG("Ready =
to send a2dp->len =3D %d + a2dp->sbc.len =3D %d =3D %d > 678", a2dp->len,=
 a2dp->sbc.len, a2dp->len + a2dp->sbc.len);
                         // time to prepare and send the packet
-                        dt.tv_sec=3D0;
-                        dt.tv_usec=3D1000000*a2dp->sbc.subbands*a2dp->sb=
c.blocks*a2dp->frame_count/48000;
                         memset(&payload_header, 0, sizeof(payload_header=
));
                         memset(&packet_header, 0, sizeof(packet_header))=
;
                         payload_header.frame_count=3Da2dp->frame_count;
@@ -959,7 +763,7 @@
                         a2dp->timestamp +=3D (a2dp->sbc.blocks + 1)*4 * =
(a2dp->sbc.subbands + 1)*4;
                         memcpy(a2dp->buf, &packet_header, sizeof(packet_=
header));
                         memcpy(a2dp->buf + sizeof(packet_header), &paylo=
ad_header, sizeof(payload_header));
-                        //sleeptill(&a2dp->tsend, &dt);
+                        // Send our data
                         if((written =3D write(a2dp->sk,a2dp->buf,a2dp->l=
en)) !=3D a2dp->len)
                         {
                                 // Error while sending data
@@ -970,662 +774,360 @@
                         result =3D written;
=20
                         // Reset buffer of data to send
-                        a2dp->len =3D sizeof(packet_header)+sizeof(paylo=
ad_header);
+                        a2dp->len =3D sizeof(struct media_packet_header)=
+sizeof(struct media_payload_header);
                         a2dp->frame_count=3D0;
                         a2dp->seq_num++;
-                        sleeptime=3D0;
                 }
=20
-                // Append sbc encoded data to buf, until buf reaches 678=
 to send
+                // Append sbc encoded data to buf, until buf reaches A2D=
PMAXIMUMTRANSFERUNITSIZE to send
                 a2dp->frame_count++;
                 memcpy(a2dp->buf + a2dp->len, a2dp->sbc.data, a2dp->sbc.=
len);
                 a2dp->len+=3Da2dp->sbc.len;
         }
=20
-        a2dp->transfer_num++;
-
-	return result;
-}
-/*
-int a2dp_close(snd_pcm_ioplug_t *io)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-	struct stream_cmd close_stream;
-	struct close_stream_rsp close_resp;
-
-	DBG("a2dp Destroying %p", a2dp);
-	memset(&close_stream, 0, sizeof(close_stream));
-	memset(&close_resp, 0, sizeof(close_resp));
-
-	// the stream-close used to make the iTech headset lock up and require =
it to be powercycled
-	// should be tested again now that we drain the queue properly
-
-	init_request(&close_stream.header, AVDTP_CLOSE);
-	close_stream.acp_seid =3D a2dp->seid;
-	if (write(a2dp->control_sk, &close_stream, sizeof(close_stream)) !=3D s=
izeof(close_stream))
-	{
-		printf("Couldn't send close_stream (errno=3D%d:%s)\n", errno, strerror=
(errno));
-		close(a2dp->control_sk);
-		a2dp->control_sk =3D -1;
-		close(a2dp->sk);
-		a2dp->sk =3D -1;
-	}
-
-	a2dp->len =3D 0;
-	a2dp->len =3D 0;
-
-	a2dp_put(a2dp);
-
-	return 0;
-}
-
-int a2dp_params(snd_pcm_ioplug_t *io, snd_pcm_hw_params_t *params)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-	unsigned int period_bytes;
-
-	DBG("a2dp %p", a2dp);
-
-	a2dp->frame_bytes =3D (snd_pcm_format_physical_width(io->format) * io->=
channels) / 8;
-
-	period_bytes =3D io->period_size * a2dp->frame_bytes;
-
-	DBG("format %s rate %d channels %d", snd_pcm_format_name(io->format), i=
o->rate, io->channels);
-
-	DBG("frame_bytes %d period_bytes %d period_size %ld buffer_size %ld",
-		a2dp->frame_bytes, period_bytes, io->period_size, io->buffer_size);
-
-	return 0;
+        return result;
 }
=20
-int a2dp_prepare(snd_pcm_ioplug_t *io)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-	DBG("a2dp %p", a2dp);
-
-	a2dp->len =3D 13;
-
-	a2dp->num =3D 0;
-
-	a2dp->sbc.rate =3D io->rate;
-	a2dp->sbc.channels =3D io->channels;
-	a2dp->sbc.subbands =3D 8; // safe default
-	a2dp->sbc.blocks =3D 16; // safe default
-	a2dp->sbc.bitpool =3D 32; // recommended value 53, safe default is 32
-
-	return 0;
-}
-
-int a2dp_drain(snd_pcm_ioplug_t *io)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-	DBG("a2dp %p", a2dp);
-
-	a2dp->len =3D 0;
-
-	return 0;
-}
-
-int a2dp_descriptors_count(snd_pcm_ioplug_t *io)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-	if (a2dp->state =3D=3D BT_CLOSED)
-		return 0;
-
-	return 1;
-}
-
-int a2dp_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfds, unsigned=
 int space)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-	if (a2dp->state =3D=3D BT_CLOSED)
-		return 0;
-
-	if (space < 1) {
-		SNDERR("Can't fill in descriptors");
-		return 0;
-	}
-
-	pfds[0].fd =3D a2dp->sk;
-	pfds[0].events =3D POLLOUT;
-
-	return 1;
-}
-
-int a2dp_poll(snd_pcm_ioplug_t *io, struct pollfd *pfds, unsigned int nf=
ds, unsigned short *revents)
-{
-	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-	*revents =3D pfds[0].revents;
-
-	if (a2dp->state =3D=3D BT_CLOSED)
-		return 0;
-
-	if (pfds[0].revents & POLLHUP) {
-		a2dp->state =3D BT_CLOSED;
-		snd_pcm_ioplug_reinit_status(&a2dp->io);
-	}
-
-	return 0;
-}
-*/
 static void init_response(struct avdtp_header * header, int response_typ=
e)
 {
-	// leave signal_id and transaction label since we are reusing the reque=
st
-	header->packet_type =3D PACKET_TYPE_SINGLE;
-	header->message_type =3D response_type;
+        // leave signal_id and transaction label since we are reusing th=
e request
+        header->packet_type =3D PACKET_TYPE_SINGLE;
+        header->message_type =3D response_type;
=20
-	// clear rfa bits
-	header->rfa0 =3D 0;
+        // clear rfa bits
+        header->rfa0 =3D 0;
 }
=20
 // monitor the control connection for pause/play signals from headset
 // note this signaling is in the avdtp core; avrcp signaling is differen=
t
-static void* listen_thread(void* param)=20
+static void* listen_thread(void* param)
 {
-	snd_pcm_a2dp_t* a2dp =3D (snd_pcm_a2dp_t*)param;
+        snd_pcm_a2dp_t* a2dp =3D (snd_pcm_a2dp_t*)param;
=20
-	printf("Listen thread running\n");
+        DBG("Listen thread running\n");
=20
-	// Set a timeout to close thread
-	struct timeval t =3D { 5, 0 };
-	setsockopt( a2dp->control_sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
-	setsockopt( a2dp->control_sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
-
-	// Loop until end of writing
-	while(!a2dp->stop_writing)
-	{
-		struct stream_cmd cmd;
-		int size =3D read(a2dp->control_sk, &cmd, sizeof(cmd));
-		if(size =3D=3D sizeof(cmd))
-		{
-			printf("Received signal %d from set\n", cmd.header.signal_id);
-			if(cmd.header.signal_id =3D=3D AVDTP_SUSPEND)
-			{
-				a2dp->pause_writing =3D 1;
-			}
-			else if(cmd.header.signal_id =3D=3D AVDTP_START)
-			{
-				a2dp->pause_writing =3D 0;
-			}
-			else
-			{
-				printf("Unexpected headset directive %d\n", cmd.header.signal_id);
-			}
-			// ack the command regardless
-			// take a shortcut and reuse the command struct (knock one byte off l=
ength)
-			init_response(&cmd.header, MESSAGE_TYPE_ACCEPT);
-			if (write(a2dp->control_sk, &cmd, sizeof(cmd)-1) !=3D sizeof(cmd)-1)
-			{
-				printf("Couldn't ack %d\n", cmd.header.signal_id);
-			}
-		}
-		else
-		{
-			if(errno!=3DEAGAIN)
-				printf("Error while receiving %d (errno=3D%d:%s)\n", size, errno, st=
rerror(errno));
-			if(errno!=3DEINTR)
-				break;
-		}
-	}
+        // Set a timeout to close thread
+        struct timeval t =3D { 5, 0 };
+        setsockopt( a2dp->control_sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeo=
f(t));
+        setsockopt( a2dp->control_sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeo=
f(t));
=20
-	return NULL;
+        // Loop until end of writing
+        while(!a2dp->stop_writing)
+        {
+                struct stream_cmd cmd;
+                int size =3D read(a2dp->control_sk, &cmd, sizeof(cmd));
+                if(size =3D=3D sizeof(cmd))
+                {
+                        DBG("Received signal %d from set\n", cmd.header.=
signal_id);
+                        if(cmd.header.signal_id =3D=3D AVDTP_SUSPEND)
+                        {
+                                a2dp->pause_writing =3D 1;
+                        }
+                        else if(cmd.header.signal_id =3D=3D AVDTP_START)
+                        {
+                                a2dp->pause_writing =3D 0;
+                        }
+                        else
+                        {
+                                DBG("Unexpected headset directive %d\n",=
 cmd.header.signal_id);
+                        }
+                        // ack the command regardless
+                        // take a shortcut and reuse the command struct =
(knock one byte off length)
+                        init_response(&cmd.header, MESSAGE_TYPE_ACCEPT);
+                        if (write(a2dp->control_sk, &cmd, sizeof(cmd)-1)=
 !=3D sizeof(cmd)-1)
+                        {
+                                DBG("Couldn't ack %d\n", cmd.header.sign=
al_id);
+                        }
+                }
+                else
+                {
+                        if(errno!=3DEAGAIN)
+                                DBG("Error while receiving %d (errno=3D%=
d:%s)\n", size, errno, strerror(errno));
+                        if(errno!=3DEINTR)
+                                break;
+                }
+        }
+
+        return NULL;
 }
=20
 int a2dp_connect(snd_pcm_a2dp_t *a2dp)
 {
-	struct sockaddr_rc addr;
-	socklen_t len;
-	int sk;
-	int control_sk =3D -1;
-
-	DBG("a2dp %p", a2dp);
-
-	if(a2dp->use_rfcomm) {
-		sk =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
-		if (sk < 0)
-			return -errno;
-	=09
-		memset(&addr, 0, sizeof(addr));
-		addr.rc_family =3D AF_BLUETOOTH;
-		bacpy(&addr.rc_bdaddr, &a2dp->src);
-	=09
-		if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-			close(sk);
-			return -errno;
-		}
-	=09
-		memset(&addr, 0, sizeof(addr));
-		addr.rc_family =3D AF_BLUETOOTH;
-		bacpy(&addr.rc_bdaddr, &a2dp->dst);
-		addr.rc_channel =3D 1;
-	=09
-		if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-			close(sk);
-			return -errno;
-		}
-
-		memset(&addr, 0, sizeof(addr));
-		len =3D sizeof(addr);
-	=09
-		if (getsockname(sk, (struct sockaddr *) &addr, &len) < 0) {
-			close(sk);
-			return -errno;
-		}
-
-		bacpy(&a2dp->src, &addr.rc_bdaddr);
-
-		//fcntl(sk, F_SETFL, fcntl(sk, F_GETFL) | O_NONBLOCK);
-	} else {
-		sk =3D connect_stream(&a2dp->src, &a2dp->dst, &control_sk, &a2dp->sbc,=
 &a2dp->seid);
-	}
-
-	a2dp->sk =3D sk;
-	a2dp->control_sk =3D control_sk;
-
-	// Start listen thread
-	a2dp->pause_writing =3D 0;
-	a2dp->stop_writing =3D 0;
+        //struct sockaddr_rc addr;
+        //socklen_t len;
+        int sk =3D -1;
+        int control_sk =3D -1;
+        errno=3D0;
+        DBG("a2dp %p", a2dp);
+        /*
+        if(a2dp->use_rfcomm) {
+                sk =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)=
;
+                if (sk < 0)
+                        return -errno;
+               =20
+                memset(&addr, 0, sizeof(addr));
+                addr.rc_family =3D AF_BLUETOOTH;
+                bacpy(&addr.rc_bdaddr, &a2dp->src);
+               =20
+                if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < =
0) {
+                        close(sk);
+                        return -errno;
+                }
+               =20
+                memset(&addr, 0, sizeof(addr));
+                addr.rc_family =3D AF_BLUETOOTH;
+                bacpy(&addr.rc_bdaddr, &a2dp->dst);
+                addr.rc_channel =3D 1;
+               =20
+                if (connect(sk, (struct sockaddr *) &addr, sizeof(addr))=
 < 0) {
+                        close(sk);
+                        return -errno;
+                }
+
+                memset(&addr, 0, sizeof(addr));
+                len =3D sizeof(addr);
+               =20
+                if (getsockname(sk, (struct sockaddr *) &addr, &len) < 0=
) {
+                        close(sk);
+                        return -errno;
+                }
+
+                bacpy(&a2dp->src, &addr.rc_bdaddr);
+
+                //fcntl(sk, F_SETFL, fcntl(sk, F_GETFL) | O_NONBLOCK);
+        } else {*/
+                sk =3D connect_stream(&a2dp->src, &a2dp->dst, &control_s=
k, &a2dp->sbc, &a2dp->seid, &a2dp->mtu);
+        //}
+
+        a2dp->sk =3D sk;
+        a2dp->control_sk =3D control_sk;
+
+        // Start listen thread
+        a2dp->pause_writing =3D 0;
+        a2dp->stop_writing =3D 0;
        =20
         // Set pthread stack size to decrease unused memory usage
         pthread_attr_t tattr;
         size_t size =3D PTHREAD_STACK_MIN;
         int ret =3D pthread_attr_init(&tattr);
         ret =3D pthread_attr_setstacksize(&tattr, size);
-	pthread_create(&a2dp->hListenThread, &tattr, listen_thread, (void*)a2dp=
);
+        pthread_create(&a2dp->hListenThread, &tattr, listen_thread, (voi=
d*)a2dp);
         pthread_attr_destroy(&tattr);
-	return 0;
+        return 0;
 }
=20
-/*
-#define MAX_CONNECTIONS 10
-
-static snd_pcm_a2dp_t *connections[MAX_CONNECTIONS];
-
-static snd_timer_t *timer =3D NULL;
-
-static volatile sig_atomic_t __locked =3D 0;
-
-void a2dp_lock(void)
-{
-	while (__locked)
-		usleep(100);
-
-	__locked =3D 1;
-}
-
-void a2dp_unlock(void)
-{
-	__locked =3D 0;
-}
-*/
 snd_pcm_a2dp_t *a2dp_alloc(void)
 {
-	snd_pcm_a2dp_t *a2dp;
-	DBG("Begin");
-	a2dp =3D malloc(sizeof(*a2dp));
-	if (!a2dp)
-		return NULL;
-
-	memset(a2dp, 0, sizeof(*a2dp));
-	a2dp->refcnt =3D 1;
-	a2dp->seq_num =3D 1;
-	a2dp->state =3D BT_OPEN;
-	sbc_init(&a2dp->sbc, 0L);
+        snd_pcm_a2dp_t *a2dp;
+        DBG("Begin");
+        a2dp =3D malloc(sizeof(*a2dp));
+        if (!a2dp)
+                return NULL;
+
+        memset(a2dp, 0, sizeof(*a2dp));
+        a2dp->seq_num =3D 1;
+        a2dp->mtu =3D A2DPMAXIMUMTRANSFERUNITSIZE;
+        a2dp->len =3D sizeof(struct media_packet_header)+sizeof(struct m=
edia_payload_header);
+        sbc_init(&a2dp->sbc, 0L);
=20
-	return a2dp;
+        return a2dp;
 }
=20
 void a2dp_free(snd_pcm_a2dp_t *a2dp)
 {
-	DBG("Begin");
-	if (a2dp->sk > fileno(stderr))
-		close(a2dp->sk);
-	if (a2dp->control_sk > fileno(stderr))
-		close(a2dp->control_sk);
+        DBG("Begin");
+        if (a2dp->sk > 0)
+                close(a2dp->sk);
+        if (a2dp->control_sk > 0)
+                close(a2dp->control_sk);
=20
-	sbc_finish(&a2dp->sbc);
+        sbc_finish(&a2dp->sbc);
=20
-	free(a2dp);
+        free(a2dp);
 }
-/*
-void a2dp_timer(snd_async_handler_t *async)
-{
-	snd_timer_t *handle =3D snd_async_handler_get_timer(async);
-	snd_timer_read_t tr;
-	int i, ticks =3D 0;
-
-	while (snd_timer_read(handle, &tr, sizeof(tr)) =3D=3D sizeof(tr))
-		ticks +=3D tr.ticks;
-
-	a2dp_lock();
-
-	for (i =3D 0; i < MAX_CONNECTIONS; i++) {
-		snd_pcm_a2dp_t *a2dp =3D connections[i];
-
-		if (a2dp && a2dp->refcnt <=3D 0) {
-			a2dp->timeout =3D ((a2dp->timeout * 1000) - ticks) / 1000;
-			if (a2dp->timeout <=3D 0) {
-				connections[i] =3D NULL;
-				a2dp_free(a2dp);
-			}
-		}
-	}
=20
-	a2dp_unlock();
-}
-*/
 static void sighand(int signo)
 {
-  printf("Thread in signal handler %d\n", signo);
-  return;
+        return;
 }
=20
 void a2dp_init(void)
-{/*
-	snd_async_handler_t *async;
-=09
-	snd_timer_info_t *info;
-	snd_timer_params_t *params;
-	long resolution;
-	char timername[64];
-	int err, i;
-*/
-	// set up thread signal handler
-	memset(&actions, 0, sizeof(actions));
-	sigemptyset(&actions.sa_mask);
-	actions.sa_flags =3D 0;
-	actions.sa_handler =3D sighand;
-	sigaction(SIGALRM,&actions,NULL);
-/*
-	a2dp_lock();
-
-	for (i =3D 0; i < MAX_CONNECTIONS; i++)
-		connections[i] =3D NULL;
-
-	a2dp_unlock();
-
-	snd_timer_info_alloca(&info);
-	snd_timer_params_alloca(&params);
-
-	sprintf(timername, "hw:CLASS=3D%i,SCLASS=3D%i,CARD=3D%i,DEV=3D%i,SUBDEV=
=3D%i",
-		SND_TIMER_CLASS_GLOBAL, SND_TIMER_CLASS_NONE, 0,
-					SND_TIMER_GLOBAL_SYSTEM, 0);
-
-	err =3D snd_timer_open(&timer, timername, SND_TIMER_OPEN_NONBLOCK);
-	if (err < 0) {
-		SNDERR("Can't open global timer");
-		return;
-	}
-
-	err =3D snd_timer_info(timer, info);
-	if (err < 0) {
-		SNDERR("Can't get global timer info");
-		return;
-	}
-
-	snd_timer_params_set_auto_start(params, 1);
-
-	resolution =3D snd_timer_info_get_resolution(info);
-	snd_timer_params_set_ticks(params, 1000000000 / resolution);
-	if (snd_timer_params_get_ticks(params) < 1)
-		snd_timer_params_set_ticks(params, 1);
-
-	err =3D snd_timer_params(timer, params);
-	if (err < 0) {
-		SNDERR("Can't set global timer parameters");
-		snd_timer_close(timer);
-		return;
-	}
-
-	err =3D snd_async_add_timer_handler(&async, timer, a2dp_timer, NULL);
-	if (err < 0) {
-		SNDERR("Can't create global async callback");
-		snd_timer_close(timer);
-		return;
-	}
-*/
-	// Start sdp advertising
-	/*
-	g_sdpSessionP =3D sdp_connect(BDADDR_ANY, BDADDR_LOCAL, SDP_RETRY_IF_BU=
SY);
-	g_recordP =3D a2dp_advertise_sdp(g_sdpSessionP);
-	*/
-    /*
-	err =3D snd_timer_start(timer);*/
+{
+        // set up thread signal handler
+        memset(&actions, 0, sizeof(actions));
+        sigemptyset(&actions.sa_mask);
+        actions.sa_flags =3D 0;
+        actions.sa_handler =3D sighand;
+        sigaction(SIGALRM,&actions,NULL);
+       =20
+        // Start sdp advertising
+        /*
+        g_sdpSessionP =3D sdp_connect(BDADDR_ANY, BDADDR_LOCAL, SDP_RETR=
Y_IF_BUSY);
+        g_recordP =3D a2dp_advertise_sdp(g_sdpSessionP);
+        */
 }
=20
 void a2dp_exit(void)
 {
-//	int err, i;
-
-	// Stop advertising A2DP
-	/*
-	if (g_recordP)
-		sdp_record_free(g_recordP);
-	g_recordP =3D NULL;
-	if (g_sdpSessionP)
-		sdp_close(g_sdpSessionP);
-	g_sdpSessionP =3D NULL;
-	*/
-	/*
-	err =3D snd_timer_stop(timer);
-
-	err =3D snd_timer_close(timer);
-
-	a2dp_lock();
-
-	for (i =3D 0; i < MAX_CONNECTIONS; i++) {
-		snd_pcm_a2dp_t *a2dp =3D connections[i];
-
-		if (a2dp) {
-			connections[i] =3D NULL;
-			a2dp_free(a2dp);
-		}
-	}
-
-	a2dp_unlock();*/
 }
=20
 LPA2DP a2dp_new(char* addr)
 {
-	snd_pcm_a2dp_t *a2dp =3D NULL;
-	bdaddr_t src, dst;
-	int err, /*pos =3D -1, */use_rfcomm =3D 0;
-
-	DBG("Begin");
-	bacpy(&src, BDADDR_ANY);
-	bacpy(&dst, BDADDR_ANY);
-	DBG("bdaddr/dest is %s", addr);
-	str2ba(addr, &dst);
-
-/*
-	a2dp_lock();
-	for (n =3D 0; n < MAX_CONNECTIONS; n++) {
-		if (connections[n]) {
-			if (!bacmp(&connections[n]->dst, &dst) &&
-					(!bacmp(&connections[n]->src, &src) ||
-						!bacmp(&src, BDADDR_ANY))) {
-				a2dp =3D connections[n];
-				a2dp_get(a2dp);
-				break;
-			}
-		} else if (pos < 0)
-			pos =3D n;
-	}
-
-	if (!a2dp) {
-		if (pos < 0) {
-			DBG("Too many connections");
-			return NULL;
-		}
-*/
-	if (!a2dp) {
-		a2dp =3D a2dp_alloc();
-		if (!a2dp) {
-			DBG("Can't allocate");
-			return NULL;
-		}
-
-		//connections[pos] =3D a2dp;
-
-		a2dp->state  =3D BT_CONNECT;
-
-		bacpy(&a2dp->src, &src);
-		bacpy(&a2dp->dst, &dst);
-		a2dp->use_rfcomm =3D use_rfcomm;
-	}
-
-	//a2dp_unlock();
-
-	if (a2dp->state !=3D BT_CONNECTED) {
-		err =3D a2dp_connect(a2dp);
-		if (err < 0) {
-			DBG("Can't connect");
-			goto error;
-		}
+        snd_pcm_a2dp_t *a2dp =3D NULL;
+        bdaddr_t src, dst;
+        int err; //, pos =3D -1, use_rfcomm =3D 0;
+
+        DBG("Begin");
+        bacpy(&src, BDADDR_ANY);
+        bacpy(&dst, BDADDR_ANY);
+        DBG("bdaddr/dest is %s", addr);
+        str2ba(addr, &dst);
+       =20
+        a2dp =3D a2dp_alloc();
+        if (!a2dp) {
+                DBG("Can't allocate");
+                return NULL;
+        }
=20
-		a2dp->state =3D BT_CONNECTED;
-	}
+        bacpy(&a2dp->src, &src);
+        bacpy(&a2dp->dst, &dst);
+        //a2dp->use_rfcomm =3D use_rfcomm;
+
+        err =3D a2dp_connect(a2dp);
+        if (err < 0) {
+                DBG("Can't connect");
+                goto error;
+        }
=20
-	return a2dp;
+        return a2dp;
=20
 error:
-	a2dp_free(a2dp);
-	return NULL;
+        a2dp_free(a2dp);
+        return NULL;
 }
=20
 void a2dp_destroy(LPA2DP a2dp)
 {
-	struct stream_cmd close_stream;
-	struct close_stream_rsp close_resp;
-
-	DBG("Begin");
-	DBG("Destroying %p", a2dp);
+        struct stream_cmd close_stream;
+        struct close_stream_rsp close_resp;
=20
-	DBG("Listen thread terminating");
-	a2dp->stop_writing =3D 1;
-	pthread_kill(a2dp->hListenThread, SIGALRM);
-	pthread_join(a2dp->hListenThread, NULL);
-	DBG("Listen thread terminated");
+        DBG("Begin");
+        a2dp->stop_writing =3D 1;
+        pthread_kill(a2dp->hListenThread, SIGALRM);
+        pthread_join(a2dp->hListenThread, NULL);
=20
         memset(&close_stream, 0, sizeof(close_stream));
-	memset(&close_resp, 0, sizeof(close_resp));
+        memset(&close_resp, 0, sizeof(close_resp));
=20
-	// the stream-close used to make the iTech headset lock up and require =
it to be powercycled
-	// should be tested again now that we drain the queue properly
+        // the stream-close used to make the iTech headset lock up and r=
equire it to be powercycled
+        // should be tested again now that we drain the queue properly
=20
-	init_request(&close_stream.header, AVDTP_CLOSE);
-	close_stream.acp_seid =3D a2dp->seid;
-	if (write(a2dp->control_sk, &close_stream, sizeof(close_stream)) !=3D s=
izeof(close_stream))
-	{
-		printf("Couldn't send close_stream (errno=3D%d:%s)\n", errno, strerror=
(errno));
-        }
-
-	DBG("a2dp_free(%p)", a2dp);
-	a2dp_free(a2dp);
-	DBG("a2dp_free(%p) OK", a2dp);
-	DBG("a2dp_destroy(%p) OK", a2dp);
+        init_request(&close_stream.header, AVDTP_CLOSE);
+        close_stream.acp_seid =3D a2dp->seid;
+        if (write(a2dp->control_sk, &close_stream, sizeof(close_stream))=
 !=3D sizeof(close_stream))
+        {
+                DBG("Couldn't send close_stream (errno=3D%d:%s)\n", errn=
o, strerror(errno));
+        }
+
+        a2dp_free(a2dp);
+        DBG("a2dp_destroy(%p) OK", a2dp);
 }
=20
 int a2dp_make_listen_socket(unsigned short psm)
 {
-	DBG("Begin");
-	char* lpszError =3D NULL;
-	int sockfd =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
-=09
-	if (sockfd >=3D 0)
-	{
-		struct sockaddr_l2 addr;
-		memset(&addr, 0, sizeof(addr));
-		addr.l2_family =3D AF_BLUETOOTH;
-		bacpy(&addr.l2_bdaddr, BDADDR_ANY);
-		addr.l2_psm=3Dhtobs(psm);
-		if (bind(sockfd, (struct sockaddr *) &addr, sizeof(addr)) >=3D 0)
-		{
-			/*
-			struct l2cap_options opts;
-			unsigned int iOptSize =3D sizeof(opts);
-			// Get default options
-			if (getsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) >=3D 0)
-			{
-				if (setsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) >=3D 0)
-				{
-			*/
-					if(listen(sockfd,5)>=3D0)
-					{
-					}
-					else
-					{
-						lpszError =3D "Can't listen.";
-					}
-			/*
-				}
-				else
-				{
-					lpszError =3D "Can't get default L2CAP options.";
-				}
-			}
-			else
-			{
-				lpszError =3D "Can't set L2CAP options.";
-			}
-			*/
-		}
-		else
-		{
-			lpszError =3D "Can't bind socket (already used?).";
-		}
-	}
-	else
-	{
-		lpszError =3D "Can't create socket.";
-	}
-
-	if(lpszError)
-	{
-		printf("%s %s(%d)\n", lpszError, strerror(errno), errno);
-		close(sockfd);
-		sockfd=3D-1;
-	}
-=09
-	return sockfd;
+        DBG("Begin");
+        char* lpszError =3D NULL;
+        int sockfd =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CA=
P);
+       =20
+        if (sockfd >=3D 0)
+        {
+                struct sockaddr_l2 addr;
+                memset(&addr, 0, sizeof(addr));
+                addr.l2_family =3D AF_BLUETOOTH;
+                bacpy(&addr.l2_bdaddr, BDADDR_ANY);
+                addr.l2_psm=3Dhtobs(psm);
+                if (bind(sockfd, (struct sockaddr *) &addr, sizeof(addr)=
) >=3D 0)
+                {
+                        /*
+                        struct l2cap_options opts;
+                        unsigned int iOptSize =3D sizeof(opts);
+                        // Get default options
+                        if (getsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS,=
 &opts, &opt) >=3D 0)
+                        {
+                                if (setsockopt(sockfd, SOL_L2CAP, L2CAP_=
OPTIONS, &opts, opt) >=3D 0)
+                                {
+                        */
+                                        if(listen(sockfd,5)>=3D0)
+                                        {
+                                        }
+                                        else
+                                        {
+                                                lpszError =3D "Can't lis=
ten.";
+                                        }
+                        /*
+                                }
+                                else
+                                {
+                                        lpszError =3D "Can't get default=
 L2CAP options.";
+                                }
+                        }
+                        else
+                        {
+                                lpszError =3D "Can't set L2CAP options."=
;
+                        }
+                        */
+                }
+                else
+                {
+                        lpszError =3D "Can't bind socket (already used?)=
.";
+                }
+        }
+        else
+        {
+                lpszError =3D "Can't create socket.";
+        }
+
+        if(lpszError)
+        {
+                DBG("%s %s(%d)\n", lpszError, strerror(errno), errno);
+                close(sockfd);
+                sockfd=3D-1;
+        }
+       =20
+        return sockfd;
 }
=20
 int a2dp_wait_connection( int sockfd, char* szRemote, int iRemoteSize, u=
int16_t *mtu)
 {
-	// Wait client connection
-	struct sockaddr_l2 addr;
-	socklen_t addrlen =3D sizeof(addr);
-	int new_fd =3D accept(sockfd, (struct sockaddr *) &addr, &addrlen);
-
-	DBG("Begin");
-	if (szRemote) *szRemote=3D'\0';
-
-	if(new_fd >=3D 0)
-	{
-		// Get default options
-		struct l2cap_options opts;
-		unsigned int iOptSize =3D sizeof(opts);
-		if (getsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS, &opts, &iOptSize) >=3D=
 0)
-		{
-			if (mtu && opts.imtu)
-				*mtu =3D opts.imtu;
-			if (mtu && opts.omtu)
-				*mtu =3D opts.omtu;
-			if (!(*mtu))
-				*mtu=3D678;
-		}
-		printf( "Connected [imtu %d, omtu %d, flush_to %d]\n", opts.imtu, opts=
.omtu, opts.flush_to);
-
-		if (szRemote)=20
-		{
-			strncpy(szRemote, batostr(&addr.l2_bdaddr), iRemoteSize);
-			szRemote[iRemoteSize-1] =3D '\0';
-		}
-	}
-	return new_fd;
+        // Wait client connection
+        struct sockaddr_l2 addr;
+        socklen_t addrlen =3D sizeof(addr);
+        int new_fd =3D accept(sockfd, (struct sockaddr *) &addr, &addrle=
n);
+
+        DBG("Begin");
+        if (szRemote) *szRemote=3D'\0';
+
+        if(new_fd >=3D 0)
+        {
+                // Get default options
+                struct l2cap_options opts;
+                unsigned int iOptSize =3D sizeof(opts);
+                if (getsockopt(sockfd, SOL_L2CAP, L2CAP_OPTIONS, &opts, =
&iOptSize) >=3D 0)
+                {
+                        if (mtu && opts.imtu)
+                                *mtu =3D opts.imtu;
+                        if (mtu && opts.omtu)
+                                *mtu =3D opts.omtu;
+                        if (!(*mtu))
+                                *mtu=3DA2DPMAXIMUMTRANSFERUNITSIZE;
+                }
+                DBG("Connected [imtu %d, omtu %d, flush_to %d]\n", opts.=
imtu, opts.omtu, opts.flush_to);
+
+                if (szRemote)=20
+                {
+                        strncpy(szRemote, batostr(&addr.l2_bdaddr), iRem=
oteSize);
+                        szRemote[iRemoteSize-1] =3D '\0';
+                }
+        }
+        return new_fd;
 }
Index: alsa-plugins/a2dplib.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dplib.h,v
retrieving revision 1.1
diff -u -r1.1 a2dplib.h
--- alsa-plugins/a2dplib.h	12 Jul 2006 05:47:06 -0000	1.1
+++ alsa-plugins/a2dplib.h	28 Jul 2006 09:48:08 -0000
@@ -32,37 +32,6 @@
=20
 typedef struct snd_pcm_a2dp* LPA2DP;
=20
-/*
-void a2dp_init(void) __attribute__ ((constructor));
-void a2dp_exit(void) __attribute__ ((destructor));
-void change_endian( void *buf, int size);
-// Prepare packet headers
-void init_request(struct avdtp_header * header, int request_id);
-// Analyse the SEIDs the sink has sent to us
-int process_seid(int s, struct acp_seid_info * get_seid_resp, unsigned s=
hort *psm, sbc_t *sbc);
-// Detect whether A2DP Sink is present at the destination or not
-int detect_a2dp(bdaddr_t *src, bdaddr_t *dst, unsigned short *psm, unsig=
ned long *flags);
-// Connecting on PSM 25
-int do_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm, uint16_=
t *mtu);
-int connect_stream(bdaddr_t *src, bdaddr_t *dst, int *cmdfd_return, sbc_=
t *sbc);
-*/
-/*
-snd_pcm_sframes_t a2dp_pointer(snd_pcm_ioplug_t *io);
-void sleeptill(struct timeval *t, struct timeval *dt);
-// returns time to wait ie difference between tsend and current time
-// if time has come, advances tsend
-int time_to_wait(struct timeval *tsend, struct timeval *dt);
-int a2dp_close(snd_pcm_ioplug_t *io);
-int a2dp_params(snd_pcm_ioplug_t *io, snd_pcm_hw_params_t *params);
-int a2dp_prepare(snd_pcm_ioplug_t *io);
-int a2dp_drain(snd_pcm_ioplug_t *io);
-int a2dp_descriptors_count(snd_pcm_ioplug_t *io);
-int a2dp_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfds, unsigned=
 int space);
-int a2dp_poll(snd_pcm_ioplug_t *io, struct pollfd *pfds, unsigned int nf=
ds, unsigned short *revents);
-int a2dp_connect(snd_pcm_a2dp_t *a2dp);
-int a2dp_constraint(snd_pcm_a2dp_t *a2dp);
-void a2dp_timer(snd_async_handler_t *async);
-*/
 // Global library initialisation
 extern void a2dp_init( void);
 extern void a2dp_exit( void);
@@ -71,7 +40,7 @@
 extern LPA2DP a2dp_new( char* bdaddr);
 extern void a2dp_destroy( LPA2DP a2dp);
=20
-// transfers around correct time postions
+// compress and transfers data
 extern int a2dp_transfer_raw( LPA2DP a2dp, const char* pcm_buffer, int p=
cm_buffer_size);
=20
 // a2dp server functions
Index: alsa-plugins/a2dplib.o
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/a2dplib.o
diff -N alsa-plugins/a2dplib.o
Binary files /tmp/cvsL1OoEg and /dev/null differ
Index: alsa-plugins/ctl_a2dpd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: alsa-plugins/ctl_a2dpd.c
diff -N alsa-plugins/ctl_a2dpd.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/ctl_a2dpd.c	28 Jul 2006 09:48:08 -0000
@@ -0,0 +1,330 @@
+/*
+* Bluetooth Headset ALSA Plugin
+*
+* Copyright (c) 2006 by Fabien Chevalier
+*=20
+* This library is free software; you can redistribute it and/or modify
+* it under the terms of the GNU Lesser General Public License as
+* published by the Free Software Foundation; either version 2.1 of
+* the License, or (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU Lesser General Public License for more details.
+*
+* You should have received a copy of the GNU Lesser General Public
+* License along with this library; if not, write to the Free Software
+* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 U=
SA
+*/
+
+#include <syslog.h>
+#include <signal.h>
+#include <alsa/asoundlib.h>
+#include <alsa/control_external.h>
+
+#include "a2dp_ipc.h"
+#include "a2dpd_protocol.h"
+
+/* Defines */
+
+#define HS_SPEAKER    0
+#define HS_MICROPHONE 1
+
+#define MINVOL 0
+#define MAXVOL 15
+
+/* Debug */
+
+#define NDEBUG
+#ifdef NDEBUG
+        #define DBG(fmt, arg...)
+#else
+        #define DBG(fmt, arg...)  printf("DEBUG: %s: " fmt "\n" , __FUNC=
TION__ , ## arg)
+#endif
+
+typedef enum {SPEAKER, MICROPHONE} volume_t;
+
+typedef struct snd_ctl_a2dpd {
+        snd_ctl_ext_t ext;
+} snd_ctl_a2dpd_t;
+
+static const char* vol_devices[] =3D {=20
+        "A2DPD0 Playback Volume",
+        "A2DPD1 Capture Volume"
+};
+
+// Signal handler, there is a SIGPIPE sent when using tcp when the daemo=
n is not running
+// We catch it to not quit
+void sighand(int signo)
+{
+        //printf("A2DPD CTL in signal handler %d\n", signo);
+        return;
+}
+
+static void a2dpd_ctl_close(snd_ctl_ext_t *ext)
+{
+        snd_ctl_a2dpd_t *a2dpd =3D ext->private_data;
+        close_socket(ext->poll_fd);
+        free(a2dpd);
+}
+
+static int a2dpd_ctl_elem_count(snd_ctl_ext_t *ext)
+{
+        DBG("");
+        return 2;
+}
+
+static int a2dpd_ctl_elem_list(snd_ctl_ext_t *ext, unsigned int offset, =
snd_ctl_elem_id_t *id)
+{
+        DBG("%d", offset);
+
+        snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
+        if (offset < 2) {
+                snd_ctl_elem_id_set_name(id, vol_devices[offset]);
+                DBG("=3D> %s", vol_devices[offset]);
+                return 0;
+        }
+        else {
+                return -EINVAL;
+        }
+}
+
+static snd_ctl_ext_key_t a2dpd_ctl_find_elem(snd_ctl_ext_t *ext,
+                                const snd_ctl_elem_id_t *id)
+{
+        const char *name =3D snd_ctl_elem_id_get_name(id);
+        DBG("%s", name);
+
+        if(strcmp(name, vol_devices[0]) =3D=3D 0) {
+                return HS_SPEAKER;
+        }
+        else if(strcmp(name, vol_devices[1]) =3D=3D 0) {
+                return HS_MICROPHONE;
+        }
+        else {
+                return SND_CTL_EXT_KEY_NOT_FOUND;
+        }
+}
+
+static int a2dpd_ctl_get_attribute(snd_ctl_ext_t *ext, snd_ctl_ext_key_t=
 key,
+                        int *type, unsigned int *acc, unsigned int *coun=
t)
+{
+        DBG("");
+        *type  =3D SND_CTL_ELEM_TYPE_INTEGER;
+        *acc   =3D SND_CTL_EXT_ACCESS_READWRITE;
+        *count =3D 1;
+        return 0;
+}
+
+static int a2dpd_ctl_get_integer_info(snd_ctl_ext_t *ext, snd_ctl_ext_ke=
y_t key,
+                                long *imin, long *imax, long *istep)
+{
+        DBG("");
+        *istep =3D 1;
+        *imin  =3D MINVOL;
+        *imax  =3D MAXVOL;
+        return 0;
+}
+
+static int a2dpd_ctl_read_integer(snd_ctl_ext_t *ext, snd_ctl_ext_key_t =
key, long *value)
+{
+        AUDIOMIXERDATA AudioMixerData =3D INVALIDAUDIOMIXERDATA;
+        DBG("");
+
+        if(!value) return 0;
+
+        *value =3D 8;
+
+        int client_type=3DA2DPD_PLUGIN_CTL_READ;
+        int sockfd=3Dmake_client_socket();
+
+        if(send_socket(sockfd, &client_type, sizeof(client_type)) =3D=3D=
 sizeof(client_type))
+        {
+                if(recv_socket(sockfd, &AudioMixerData, sizeof(AudioMixe=
rData)) =3D=3D sizeof(AudioMixerData))
+                {
+                        if(key =3D=3D HS_SPEAKER)
+                        {
+                                if(AudioMixerData.volume_speaker_right!=3D=
-1 && AudioMixerData.volume_speaker_left!=3D-1)
+                                        *value =3D (AudioMixerData.volum=
e_speaker_right+AudioMixerData.volume_speaker_left)/2;
+                        }
+                        else if(key =3D=3D HS_MICROPHONE)
+                        {
+                                if(AudioMixerData.volume_micro_right!=3D=
-1 && AudioMixerData.volume_micro_left!=3D-1)
+                                        *value =3D (AudioMixerData.volum=
e_micro_right+AudioMixerData.volume_micro_left)/2;
+                        }
+                }
+                else
+                {
+                        DBG("Unable to receive new volume value from ser=
ver");
+                }
+        }
+        else
+        {
+                DBG("Unable to request new volume value to server");
+        }
+        close_socket(sockfd);
+
+        return 0;
+}
+
+static int a2dpd_ctl_write_integer(snd_ctl_ext_t *ext, snd_ctl_ext_key_t=
 key, long *value)
+{
+        int iResult =3D 0;
+        long curvalue;
+
+        DBG("");
+
+        a2dpd_ctl_read_integer(ext, key, &curvalue);
+
+        if(value && *value !=3D curvalue)
+        {
+                AUDIOMIXERDATA AudioMixerData =3D INVALIDAUDIOMIXERDATA;
+                int client_type=3DA2DPD_PLUGIN_CTL_WRITE;
+                int sockfd=3Dmake_client_socket();
+
+                if(send_socket(sockfd, &client_type, sizeof(client_type)=
) =3D=3D sizeof(client_type))
+                {
+                        if(key =3D=3D HS_SPEAKER)
+                        {
+                                AudioMixerData.volume_speaker_right =3D =
*value;
+                                AudioMixerData.volume_speaker_left =3D *=
value;
+                        }
+                        else if(key =3D=3D HS_MICROPHONE)
+                        {
+                                AudioMixerData.volume_micro_right =3D *v=
alue;
+                                AudioMixerData.volume_micro_left =3D *va=
lue;
+                        }
+
+                        if(send_socket(sockfd, &AudioMixerData, sizeof(A=
udioMixerData)) =3D=3D sizeof(AudioMixerData))
+                        {
+                                iResult=3D1;
+                        }
+                        else
+                        {
+                                DBG("Unable to send new volume value to =
server");
+                        }
+                }
+                else
+                {
+                        DBG("Unable to set new volume value to server");
+                }
+                close_socket(sockfd);
+        }
+
+        iResult=3D1;
+        return iResult;
+}
+
+static int a2dpd_ctl_read_event(snd_ctl_ext_t *ext, snd_ctl_elem_id_t *i=
d,
+                        unsigned int *event_mask)
+{
+        AUDIOMIXERDATA AudioMixerData =3D INVALIDAUDIOMIXERDATA;
+//	snd_ctl_a2dpd_t *a2dpd =3D ext->private_data;
+
+        DBG("");
+        syslog(LOG_INFO, "%s", __FUNCTION__);
+        if(recv_socket(ext->poll_fd, &AudioMixerData, sizeof(AudioMixerD=
ata)) =3D=3D sizeof(AudioMixerData))
+        {
+                snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIX=
ER);
+
+                if(AudioMixerData.volume_speaker_right!=3D-1 || AudioMix=
erData.volume_speaker_left!=3D-1)
+                        snd_ctl_elem_id_set_name(id, vol_devices[HS_SPEA=
KER]);
+                else if(AudioMixerData.volume_micro_right!=3D-1 || Audio=
MixerData.volume_micro_left!=3D-1)
+                        snd_ctl_elem_id_set_name(id, vol_devices[HS_MICR=
OPHONE]);
+
+                *event_mask =3D SND_CTL_EVENT_MASK_VALUE;
+                return 1;
+        }
+        else
+        {
+                syslog(LOG_INFO, "error %s", __FUNCTION__);
+                DBG("Unable to receive volume notification from server")=
;
+                return -errno;
+        }
+        return -EINVAL;
+        /*
+        if(recv(a2dpd->serverfd, &pkt, sizeof(pkt), MSG_DONTWAIT) =3D=3D=
 sizeof(pkt)) {
+                if(pkt.type =3D=3D PKT_TYPE_CTL_NTFY) {
+                        snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_I=
FACE_MIXER);
+                        snd_ctl_elem_id_set_name(id, pkt.voltype =3D=3D =
SPEAKER ? vol_devices[HS_SPEAKER] : vol_devices[HS_MICROPHONE]);
+                        *event_mask =3D SND_CTL_EVENT_MASK_VALUE;
+                        return 1;
+                }
+                else {
+                        SNDERR("Unexpected packet type %d received!", pk=
t.type);
+                        return -EAGAIN;
+                }
+        }
+        else {
+                return -errno;
+        }*/
+}
+
+static snd_ctl_ext_callback_t a2dpd_ext_callback =3D {
+        .close            =3D a2dpd_ctl_close,
+        .elem_count       =3D a2dpd_ctl_elem_count,
+        .elem_list        =3D a2dpd_ctl_elem_list,
+        .find_elem        =3D a2dpd_ctl_find_elem,
+        .get_attribute    =3D a2dpd_ctl_get_attribute,
+        .get_integer_info =3D a2dpd_ctl_get_integer_info,
+        .read_integer     =3D a2dpd_ctl_read_integer,
+        .write_integer    =3D a2dpd_ctl_write_integer,
+        .read_event       =3D a2dpd_ctl_read_event,
+};
+
+SND_CTL_PLUGIN_DEFINE_FUNC(a2dpd)
+{
+        snd_config_iterator_t it, next;
+        int err =3D 0;
+        snd_ctl_a2dpd_t *a2dpd =3D 0;
+
+        // set up thread signal handler
+        signal(SIGPIPE, sighand);
+
+        DBG("");
+        snd_config_for_each(it, next, conf) {
+                snd_config_t *n =3D snd_config_iterator_entry(it);
+                const char *id;
+                if (snd_config_get_id(n, &id) < 0)
+                        continue;
+
+                if (!strcmp(id, "comment") || !strcmp(id, "type"))
+                //if (snd_pcm_conf_generic_id(id)) // Alsa-lib 1.0.11
+                        continue;
+                SNDERR("Unknown field %s", id);
+                return -EINVAL;
+        }
+
+        a2dpd =3D malloc(sizeof(*a2dpd));
+        if(a2dpd =3D=3D NULL)
+        {
+                err=3DENOMEM;
+                goto error;
+        }
+
+        a2dpd->ext.version =3D SND_CTL_EXT_VERSION;
+        a2dpd->ext.card_idx =3D 0; //FIXME
+        strncpy(a2dpd->ext.id, "A2DPD CTL ID", sizeof(a2dpd->ext.id) - 1=
);
+        strncpy(a2dpd->ext.driver, "A2DPD CTL Bluetooth Headset Driver",=
 sizeof(a2dpd->ext.driver) - 1);
+        strncpy(a2dpd->ext.name, "A2DPD CTL Headset Name", sizeof(a2dpd-=
>ext.name) - 1);
+        strncpy(a2dpd->ext.longname, "A2DPD CTL Headset Long Name", size=
of(a2dpd->ext.longname) - 1);
+        strncpy(a2dpd->ext.mixername, "A2DPD CTL Headset Mixer Name", si=
zeof(a2dpd->ext.mixername) - 1);
+        a2dpd->ext.callback =3D &a2dpd_ext_callback;
+        a2dpd->ext.poll_fd =3D make_udp_socket();
+        a2dpd->ext.private_data =3D a2dpd;
+
+        err =3D snd_ctl_ext_create(&a2dpd->ext, name, mode);
+        if (err < 0)
+                goto error;
+
+        *handlep =3D a2dpd->ext.handle;
+        return 0;
+
+error:
+        if(a2dpd->ext.poll_fd!=3D-1) close_socket(a2dpd->ext.poll_fd);
+        if(a2dpd !=3D NULL) free(a2dpd);
+        return err;
+}
+
+SND_CTL_PLUGIN_SYMBOL(a2dpd);
Index: alsa-plugins/pcm_a2dpd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/pcm_a2dpd.c,v
retrieving revision 1.1
diff -u -r1.1 pcm_a2dpd.c
--- alsa-plugins/pcm_a2dpd.c	12 Jul 2006 05:47:07 -0000	1.1
+++ alsa-plugins/pcm_a2dpd.c	28 Jul 2006 09:48:08 -0000
@@ -32,24 +32,16 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/time.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
-#include <bluetooth/l2cap.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <syslog.h>
=20
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
 #include <alsa/timer.h>
=20
-#include <netinet/in.h>
-#include <sys/socket.h>
-#include <arpa/inet.h>
-
-#include <syslog.h>
+#include "a2dpd_protocol.h"
+#include "a2dp_timer.h"
+#include "a2dp_ipc.h"
=20
-#include "sbc.h"
 #include "../a2dp.h"
=20
 #define NONSPECAUDIO 1
@@ -59,285 +51,168 @@
 #define DBG(fmt, arg...)  printf("DEBUG: %s: (errno=3D%d:%s)" fmt "\n" ,=
 __FUNCTION__ , errno, strerror(errno), ## arg)
 //#define DBG(D...)
=20
-static void a2dp_init(void) __attribute__ ((constructor));
-static void a2dp_exit(void) __attribute__ ((destructor));
+
+// Signal handler, there is a strange SIGPIPE when the daemon is not run=
ning
+// We catch it to not quit
+void sighand(int signo)
+{
+        printf("A2DPD CTL in signal handler %d\n", signo);
+        return;
+}
=20
 typedef struct snd_pcm_a2dp {
         snd_pcm_ioplug_t io;
-        int refcnt;
-        int timeout;
-        unsigned long state;
-        bdaddr_t src;
-        bdaddr_t dst;
         int sk;
-        int control_sk;
-        sbc_t sbc;
+        int rate;
+        int channels;
         snd_pcm_sframes_t num;
-        unsigned char buf[1024];
-        unsigned int len;
         unsigned int frame_bytes;
-        int use_rfcomm;
-
-        char bufe[BUFS];
-        int lenbufe;//=3D0;
-
-        unsigned long nbytes;//=3D0;
-        struct timeval tsend;
-
-        time_t timestamp;//=3D0;
-        uint16_t seq_num;//=3D1;
-        int frame_count;//=3D0;
-
+        TIMERINFO TimerInfos;
 } snd_pcm_a2dp_t;
=20
-static void inline a2dp_get(snd_pcm_a2dp_t *a2dp)
+static int a2dp_disconnect(snd_pcm_a2dp_t *a2dp)
 {
-        a2dp->refcnt++;
-        a2dp->timeout =3D 0;
+        close_socket(a2dp->sk);
+        a2dp->sk =3D -1;
+        return 0;
 }
=20
-static void inline a2dp_put(snd_pcm_a2dp_t *a2dp)
+static int a2dp_connect(snd_pcm_a2dp_t *a2dp)
 {
-        a2dp->refcnt--;
-
-        if (a2dp->refcnt <=3D 0)
-                a2dp->timeout =3D 2;
+        if(a2dp->sk <=3D 0)
+        {
+                int sockfd =3D make_client_socket();
+                a2dp->sk =3D -1;
+                if(sockfd>0)
+                {
+                        int32_t client_type =3D A2DPD_PLUGIN_PCM_WRITE;
+                        if(send_socket(sockfd, &client_type, sizeof(clie=
nt_type))=3D=3Dsizeof(client_type))
+                        {
+                                a2dp->sk =3D sockfd;
+                                syslog(LOG_INFO, "Connected a2dp %p, sk =
%d", a2dp, a2dp->sk);
+                        }
+                        else
+                        {
+                                close_socket(sockfd);
+                                syslog(LOG_WARNING, "Connected a2dp %p, =
sk %d, Authorisation failed", a2dp, a2dp->sk);
+                        }
+                }
+                else
+                {
+                        syslog(LOG_ERR, "Socket failed a2dp %p, sk %d", =
a2dp, a2dp->sk);
+                }
+        }
+        return 0;
 }
=20
-static int a2dp_start(snd_pcm_ioplug_t *io)
+static inline snd_pcm_a2dp_t *a2dp_alloc(void)
 {
-        snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-        DBG("a2dp %p", a2dp);
+        snd_pcm_a2dp_t *a2dp;
+        DBG("Init");
+        a2dp =3D malloc(sizeof(*a2dp));
+        if (!a2dp)
+                return NULL;
+        memset(a2dp, 0, sizeof(*a2dp));
+        a2dp->sk =3D -1;
+        a2dp->TimerInfos.fps =3D A2DPD_BLOCK_FREQUENCY;
+        DBG("OK");
+        return a2dp;
+}
=20
-        a2dp->len =3D 13;
+static inline void a2dp_free(snd_pcm_a2dp_t *a2dp)
+{
+        DBG("Finishing");
+        a2dp_disconnect(a2dp);
+        free(a2dp);
+        DBG("OK");
+}
=20
+static int a2dp_start(snd_pcm_ioplug_t *io)
+{
+        //snd_pcm_a2dp_t *a2dp =3D io->private_data;
+        //FIXME
         return 0;
 }
=20
 static int a2dp_stop(snd_pcm_ioplug_t *io)
 {
-        snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-        DBG("a2dp %p", a2dp);
-
-        a2dp->len =3D 0;
-
+        //snd_pcm_a2dp_t *a2dp =3D io->private_data;
         return 0;
 }
=20
 static snd_pcm_sframes_t a2dp_pointer(snd_pcm_ioplug_t *io)
 {
         snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
         return a2dp->num;
 }
=20
-static int a2dp_disconnect(snd_pcm_a2dp_t *a2dp)
+// This is the main transfer func which does the transfer and sleep job
+static snd_pcm_sframes_t a2dp_transfer2(snd_pcm_ioplug_t *io,
+                        char* buf,
+                        int32_t datatoread)
 {
-        if(a2dp->sk > fileno(stderr))
-        {
-                DBG("a2dp %p", a2dp);
+        snd_pcm_a2dp_t* a2dp =3D io->private_data;
+        int transfer =3D 0;
=20
-                close(a2dp->sk);
-                a2dp->sk =3D -1;
-                a2dp->state =3D BT_CLOSED;
-        }
-        else
-        {
-                //DBG("INVALID DISCONNECT a2dp %p, sk %d", a2dp, a2dp->s=
k);
-        }
-        return 0;
-}
+        // Connect if needed and send
+        a2dp_connect(a2dp);
+        if(transfer>=3D0) transfer=3Dsend_socket(a2dp->sk, &datatoread, =
sizeof(datatoread));
+        if(transfer>=3D0) transfer=3Dsend_socket(a2dp->sk, buf, datatore=
ad);
=20
-static int a2dp_connect(snd_pcm_a2dp_t *a2dp)
-{
-        if(a2dp->sk <=3D fileno(stderr))
-        {
-                //DBG("a2dp %p", a2dp);
+        // Disconnect if error detected
+        if(transfer<0) a2dp_disconnect(a2dp);
=20
-                int sockfd =3D socket(PF_INET, SOCK_STREAM, 0);
-                if(sockfd>0)
-                {
-                        struct sockaddr_in my_addr;
-                        memset(&my_addr, 0, sizeof(my_addr));
-                        my_addr.sin_family =3D AF_INET;
-                        my_addr.sin_port =3D htons(0);
-                        my_addr.sin_addr.s_addr =3D htonl(INADDR_ANY);
+        // The data are sent to the daemon that act as a proxy thus we d=
ouble transfer delay to compensate latency
+        a2dp_timer_notifyframe(&a2dp->TimerInfos);
+        a2dp_timer_sleep(&a2dp->TimerInfos, 4*A2DPTIMERPREDELAY);=20
=20
-                        if(bind(sockfd, (struct sockaddr*)&my_addr, size=
of(my_addr)) =3D=3D 0)
-                        {
-                                struct timeval t;
-                                t.tv_sec=3D0;
-                                t.tv_usec=3D100*1000; // 100 ms
-                                setsockopt( sockfd, SOL_SOCKET, SO_SNDTI=
MEO, &t, sizeof(t));
-                                setsockopt( sockfd, SOL_SOCKET, SO_RCVTI=
MEO, &t, sizeof(t));
-                               =20
-                                struct sockaddr_in peer_addr;
-                                peer_addr.sin_family =3D AF_INET;
-                                peer_addr.sin_port =3D htons(21453);
-                                peer_addr.sin_addr.s_addr =3D inet_addr(=
"127.0.0.1");
-                               =20
-                                // Make connection
-                                if(connect(sockfd, (struct sockaddr*)&pe=
er_addr, sizeof(peer_addr)) =3D=3D 0)
-                                {
-                                        a2dp->sk =3D sockfd;
-                                        a2dp->state =3D BT_CONNECTED;
-                                        syslog(LOG_INFO, "Connected a2dp=
 %p, sk %d", a2dp, a2dp->sk);
-                                }
-                                else
-                                {
-                                        // Clean socket
-                                        a2dp->sk =3D -1;
-                                        //DBG("Connect failed a2dp %p, s=
k %d", a2dp, a2dp->sk);
-                                        syslog(LOG_WARNING, "Connect fai=
led a2dp %p, sk %d", a2dp, a2dp->sk);
-                                        close(sockfd);
-                                }
-                        }
-                        else
-                        {
-                                DBG("Bind failed a2dp %p, sk %d", a2dp, =
a2dp->sk);
-                                syslog(LOG_WARNING, "Bind failed a2dp %p=
, sk %d", a2dp, a2dp->sk);
-                                a2dp->sk =3D -1;
-                                close(sockfd);
-                        }
-                }
-                else
-                {
-                        DBG("Socket failed a2dp %p, sk %d", a2dp, a2dp->=
sk);
-                        syslog(LOG_WARNING, "Socket failed a2dp %p, sk %=
d", a2dp, a2dp->sk);
-                }
-        }
-        return 0;
-}
-
-int a2dp_send(snd_pcm_a2dp_t* a2dp, void* buf, int len)
-{
-        int result =3D -1;
-        int ioffset =3D 0;
-       =20
-        if(a2dp->sk>fileno(stderr))
+        // Stats
+        if(a2dp->TimerInfos.display>0)
         {
-                // The system may split 512 bytes of data so we loop
-                while(ioffset<len)
-                {
-                        result=3Dsend(a2dp->sk, ((char*)buf)+ioffset, le=
n-ioffset, 0);
-                        //DBG("[2] send(sk, buf+%d, %d-%d=3D%d) =3D=3D %=
d", ioffset, datatoread, ioffset, datatoread-ioffset, result);
-                        if(result>0)
-                        {
-                                ioffset +=3D result;
-                        }
-                        else
-                        {
-                                break;
-                        }
-                }
-               =20
-                if(result<0)
+                if(errno !=3D 0 || transfer <=3D 0)
                 {
-                        if(errno !=3D EAGAIN)
-                        {
-                                DBG("[2] send() failed with value =3D %d=
, (errno=3D%d:%s)", result, errno, strerror(errno));
-                                // Disconnect on error, we will reconnec=
t later
-                                a2dp_disconnect(a2dp);
-                        }
+                        syslog( LOG_INFO, "send_socket(%d bytes)=3D%d (e=
rrno=3D%d:%s)", datatoread, transfer, errno, strerror(errno));
                 }
         }
=20
-        return result;
+        // update pointer, tell alsa we're done
+        a2dp->num +=3D datatoread / a2dp->frame_bytes;
+
+        return datatoread / a2dp->frame_bytes;
 }
=20
 // also works but sleeps between transfers
 // This is the main transfer func which does the transfer and sleep job
-static snd_pcm_sframes_t a2dp_transfer2(snd_pcm_ioplug_t *io,
+static snd_pcm_sframes_t a2dp_transfer_all(snd_pcm_ioplug_t *io,
                         const snd_pcm_channel_area_t *areas,
                         snd_pcm_uframes_t offset, snd_pcm_uframes_t size=
)
 {
-        snd_pcm_a2dp_t *a2dp =3D io->private_data;
-        int codesize=3Da2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.cha=
nnels*2;
-        int datatoread=3Dmin(codesize,size*a2dp->frame_bytes);
-        int transfer =3D 0;
-        int display =3D 0;
-        char* buf =3D (char *) areas->addr + (areas->first + areas->step=
 * offset) / 8;
-
-        // Time reference
-        static struct timeval staticcounter =3D {0,0};
-        static int icount =3D 0;
-        if(staticcounter.tv_sec=3D=3D0)
+        snd_pcm_a2dp_t* a2dp =3D io->private_data;
+        int i =3D 0;
+        snd_pcm_sframes_t totaltransfered =3D 0;
+        while(i++<1 && totaltransfered < size)
         {
-                gettimeofday(&staticcounter, NULL);
-        }
-
-        struct timeval timeofday, duration, playtime, theoricaldate;
-        gettimeofday(&timeofday, NULL);
-        timersub(&timeofday, &staticcounter, &duration);
-
-        // Display data once per second
-        if(duration.tv_sec>0)
-        {
-                gettimeofday(&staticcounter, NULL);
-                display=3Dicount;
-                icount=3D1;
-        }
-
-        // sleeps a little bit to synchronize sound
-        // a2dp->sbc.channels*44100*2/(size*a2dp->frame_bytes);
-        // 344.53125=3Dchannels*freq*16 bits/sizeof(buf)
-        float fps=3D344.53125;
-        playtime.tv_sec=3D0;//ipart(icount/fps);
-        playtime.tv_usec=3D(int)(1.0*1000.0*1000.0*icount/fps);
-        timeradd(&staticcounter, &playtime, &theoricaldate);
-
-        // Si la date th=C3=A9orique est sup=C3=A9rieure =C3=A0 la date =
actuelle
-        if((theoricaldate.tv_sec>timeofday.tv_sec)
-                || (theoricaldate.tv_sec=3D=3Dtimeofday.tv_sec && theori=
caldate.tv_usec>timeofday.tv_usec)
-                )
-        {
-                // We're in advance, wait a little bit
-                timersub(&theoricaldate, &timeofday, &duration);
-                if(duration.tv_sec>0)
+                char* buf =3D (char *) areas->addr + (areas->first + are=
as->step * offset) / 8;
+                int datatoread=3Dmin(A2DPD_BLOCK_SIZE,size*a2dp->frame_b=
ytes);
+                snd_pcm_sframes_t transfered =3D a2dp_transfer2(io, buf,=
 datatoread);
+                if(transfered>0)
                 {
-                        DBG("ERROR duration calculed more than one sec :=
 { %d, %d }", (int)duration.tv_sec, (int)duration.tv_usec);
+                        offset +=3D transfered;
+                        totaltransfered +=3D transfered;
                 }
                 else
                 {
-                        usleep(duration.tv_usec);
+                        break;
                 }
         }
-        else
-        {
-                // We're late, do nothing
-        }
-
-        // Connect if needed and send
-        a2dp_connect(a2dp);
-        if(transfer>=3D0) transfer=3Da2dp_send(a2dp, &datatoread, sizeof=
(datatoread));
-        if(transfer>=3D0) transfer=3Da2dp_send(a2dp, buf, datatoread);
-        if(display>0 && transfer >=3D0)
-        {
-                DBG("a2dp_send(%d * %d =3D %d bytes of data) returned %d=
 (%d fps)", (int)size, (int)a2dp->frame_bytes, datatoread, transfer, disp=
lay);
-        }
-
-        icount++;
-
-        // update pointer, tells alsa we're done
-        a2dp->num +=3D datatoread / a2dp->frame_bytes;
-
-        return datatoread / a2dp->frame_bytes;
+        return totaltransfered;
 }
=20
 static int a2dp_close(snd_pcm_ioplug_t *io)
 {
         snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-        DBG("a2dp %p", a2dp);
-
         a2dp_disconnect(a2dp);
-
-        a2dp->len =3D 0;
-
-        a2dp_put(a2dp);
-
+        a2dp_free(a2dp);
         return 0;
 }
=20
@@ -364,51 +239,27 @@
 static int a2dp_prepare(snd_pcm_ioplug_t *io)
 {
         snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
         DBG("a2dp %p", a2dp);
-
-        a2dp->len =3D 13;
-
         a2dp->num =3D 0;
-
-        a2dp->sbc.rate =3D io->rate;
-        a2dp->sbc.channels =3D io->channels;
-        a2dp->sbc.subbands =3D 8; // safe default
-        a2dp->sbc.blocks =3D 16; // safe default
-        a2dp->sbc.bitpool =3D 32; // recommended value 53, safe default =
is 32
-
+        a2dp->rate =3D io->rate;
+        a2dp->channels =3D io->channels;
         return 0;
 }
=20
 static int a2dp_drain(snd_pcm_ioplug_t *io)
 {
         snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
         DBG("a2dp %p", a2dp);
-
-        a2dp->len =3D 0;
-
         return 0;
 }
=20
 static int a2dp_descriptors_count(snd_pcm_ioplug_t *io)
 {
-        // snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-        //DBG("Descriptor count =3D %d (state=3D%lu)", (a2dp->state !=3D=
 BT_CLOSED)?1:0, a2dp->state);
-
-        return 1; //(a2dp->state !=3D BT_CLOSED)?1:0;
+        return 1;
 }
=20
 static int a2dp_descriptors(snd_pcm_ioplug_t *io, struct pollfd *pfds, u=
nsigned int space)
 {
-//	snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-/*
-        // We won't reconnect if we do not have data
-        if (a2dp->state =3D=3D BT_CLOSED)
-                return 0;
-*/
         if (space < 1)
         {
                 DBG("Can't fill in descriptors");
@@ -417,14 +268,9 @@
         }
=20
         // Alsa does make sure writing now will not block
-        // If we have a valid socket, poll the socket
-        // Else poll stdout, so that Alsa do not block.
-        // We use sockets with low timeouts
-        pfds[0].fd =3D /*(a2dp->state =3D=3D BT_CONNECTED)?(a2dp->sk):*/=
fileno(stdout);
+        // So give him an always writable socket!
+        pfds[0].fd =3D fileno(stdout);
         pfds[0].events =3D POLLOUT;
-
-        // DBG("Descriptor filling=3D%d state=3D%lu fd =3D %d", (a2dp->s=
tate !=3D BT_CLOSED)?1:0, a2dp->state, pfds[0].fd);
-
         return 1;
 }
=20
@@ -432,12 +278,9 @@
                         unsigned int nfds, unsigned short *revents)
 {
         snd_pcm_a2dp_t *a2dp =3D io->private_data;
-
-        //DBG("Descriptor polling =3D %d (state=3D%lu)", (a2dp->state !=3D=
 BT_CLOSED)?1:0, a2dp->state);
-
         *revents =3D pfds[0].revents;
=20
-        if (a2dp->state =3D=3D BT_CLOSED)
+        if (a2dp->sk<=3D0)
                 return 0;
=20
         if (pfds[0].revents & POLLHUP) {
@@ -449,21 +292,22 @@
 }
=20
 static snd_pcm_ioplug_callback_t a2dp_callback =3D {
-        .start			=3D a2dp_start, //FDOK
-        .stop			=3D a2dp_stop,//FDOK
-        .pointer		=3D a2dp_pointer,//FDOK
-        .transfer		=3D a2dp_transfer2,
-        .close			=3D a2dp_close,//FDOK
-        .hw_params		=3D a2dp_params,//FDOK
-        .prepare		=3D a2dp_prepare,//FDOK
-        .drain			=3D a2dp_drain,//FDOK
-
-        .poll_descriptors_count	=3D a2dp_descriptors_count,//FDOK
-        .poll_descriptors	=3D a2dp_descriptors,//FDOK
-        .poll_revents		=3D a2dp_poll,//FDOK
+        .start			=3D a2dp_start,
+        .stop			=3D a2dp_stop,
+        .pointer		=3D a2dp_pointer,
+        .transfer		=3D a2dp_transfer_all,
+        .close			=3D a2dp_close,
+        .hw_params		=3D a2dp_params,
+        .prepare		=3D a2dp_prepare,
+        .drain			=3D a2dp_drain,
+
+        .poll_descriptors_count	=3D a2dp_descriptors_count,
+        .poll_descriptors	=3D a2dp_descriptors,
+        .poll_revents		=3D a2dp_poll,
 };
=20
-// Force alsa to give use the 44100 or 48000 hz sound
+// Force alsa to give use the 44100 hz sound
+// Or say alsa we will accept only 44100hz?
 static int a2dp_constraint(snd_pcm_a2dp_t *a2dp)
 {
         snd_pcm_ioplug_t *io =3D &a2dp->io;
@@ -474,7 +318,7 @@
         unsigned int format[2], channel[2], rate[2];
         int err;
=20
-        DBG("[build %s %s] a2dp %p", __DATE__, __TIME__, a2dp);
+        syslog(LOG_INFO, "[build %s %s] a2dp %p", __DATE__, __TIME__, a2=
dp);
=20
         err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCE=
SS, 2, access_list);
         if (err < 0)
@@ -493,10 +337,10 @@
         if (err < 0)
                 return err;
=20
-        rate[0] =3D 44100;
-        rate[1] =3D 48000;
+        rate[0] =3D A2DPD_FRAME_RATE;
+        //rate[1] =3D 48000;
=20
-        err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_RATE=
, 2, rate);
+        err =3D snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_RATE=
, 1, rate);
         if (err < 0)
                 return err;
=20
@@ -511,184 +355,20 @@
         return 0;
 }
=20
-#define MAX_CONNECTIONS 10
-
-static snd_pcm_a2dp_t *connections[MAX_CONNECTIONS];
-
-//static snd_timer_t *timer =3D NULL;
-
-static volatile sig_atomic_t __locked =3D 0;
-
-static inline void a2dp_lock(void)
-{
-        while (__locked)
-                usleep(100);
-
-        __locked =3D 1;
-}
-
-static inline void a2dp_unlock(void)
-{
-        __locked =3D 0;
-}
-
-static inline snd_pcm_a2dp_t *a2dp_alloc(void)
-{
-        snd_pcm_a2dp_t *a2dp;
-        DBG("Init");
-        a2dp =3D malloc(sizeof(*a2dp));
-        if (!a2dp)
-                return NULL;
-
-        memset(a2dp, 0, sizeof(*a2dp));
-
-        a2dp->sk =3D -1;
-        a2dp->refcnt =3D 1;
-        a2dp->seq_num =3D 1;
-        a2dp->state =3D BT_OPEN;
-
-        sbc_init(&a2dp->sbc, 0L);
-
-        DBG("OK");
-        return a2dp;
-}
-
-static inline void a2dp_free(snd_pcm_a2dp_t *a2dp)
-{
-        DBG("Finishing");
-        a2dp_disconnect(a2dp);
-       =20
-        sbc_finish(&a2dp->sbc);
-
-        free(a2dp);
-        DBG("OK");
-}
-/*
-// Le timer g=C3=A8re la d=C3=A9connexion=20
-static void a2dp_timer(snd_async_handler_t *async)
-{
-        snd_timer_t *handle =3D snd_async_handler_get_timer(async);
-        snd_timer_read_t tr;
-        int i, ticks =3D 0;
-
-        while (snd_timer_read(handle, &tr, sizeof(tr)) =3D=3D sizeof(tr)=
)
-                ticks +=3D tr.ticks;
-
-        a2dp_lock();
-
-        for (i =3D 0; i < MAX_CONNECTIONS; i++) {
-                snd_pcm_a2dp_t *a2dp =3D connections[i];
-
-                if (a2dp && a2dp->refcnt <=3D 0) {
-                        a2dp->timeout =3D ((a2dp->timeout * 1000) - tick=
s) / 1000;
-                        if (a2dp->timeout <=3D 0) {
-                                connections[i] =3D NULL;
-                                a2dp_free(a2dp);
-                        }
-                }
-        }
-
-        a2dp_unlock();
-}
-*/
-static void a2dp_init(void)
-{/*
-        snd_async_handler_t *async;
-        snd_timer_info_t *info;
-        snd_timer_params_t *params;
-        long resolution;
-        char timername[64];
-        int err, i;
-
-        a2dp_lock();
-
-        for (i =3D 0; i < MAX_CONNECTIONS; i++)
-                connections[i] =3D NULL;
-
-        a2dp_unlock();
-
-        snd_timer_info_alloca(&info);
-        snd_timer_params_alloca(&params);
-
-        sprintf(timername, "hw:CLASS=3D%i,SCLASS=3D%i,CARD=3D%i,DEV=3D%i=
,SUBDEV=3D%i",
-                SND_TIMER_CLASS_GLOBAL, SND_TIMER_CLASS_NONE, 0,
-                                        SND_TIMER_GLOBAL_SYSTEM, 0);
-
-        err =3D snd_timer_open(&timer, timername, SND_TIMER_OPEN_NONBLOC=
K);
-        if (err < 0) {
-                SNDERR("Can't open global timer");
-                return;
-        }
-
-        err =3D snd_timer_info(timer, info);
-        if (err < 0) {
-                SNDERR("Can't get global timer info");
-                return;
-        }
-
-        snd_timer_params_set_auto_start(params, 1);
-
-        resolution =3D snd_timer_info_get_resolution(info);
-        snd_timer_params_set_ticks(params, 1000000000 / resolution);
-        if (snd_timer_params_get_ticks(params) < 1)
-                snd_timer_params_set_ticks(params, 1);
-
-        err =3D snd_timer_params(timer, params);
-        if (err < 0) {
-                SNDERR("Can't set global timer parameters");
-                snd_timer_close(timer);
-                return;
-        }
-
-        err =3D snd_async_add_timer_handler(&async, timer, a2dp_timer, N=
ULL);
-        if (err < 0) {
-                SNDERR("Can't create global async callback");
-                snd_timer_close(timer);
-                return;
-        }
-
-        err =3D snd_timer_start(timer);
-*/
-}
-
-static void a2dp_exit(void)
-{/*
-        int err, i;
-
-        err =3D snd_timer_stop(timer);
-
-        err =3D snd_timer_close(timer);
-
-        a2dp_lock();
-
-        for (i =3D 0; i < MAX_CONNECTIONS; i++) {
-                snd_pcm_a2dp_t *a2dp =3D connections[i];
-
-                if (a2dp) {
-                        connections[i] =3D NULL;
-                        a2dp_free(a2dp);
-                }
-        }
-
-        a2dp_unlock();
-*/
-}
-
 SND_PCM_PLUGIN_DEFINE_FUNC(a2dpd)
 {
         snd_pcm_a2dp_t *a2dp =3D NULL;
         snd_config_iterator_t i, next;
-        bdaddr_t src, dst;
-        int err, n, pos =3D -1, use_rfcomm =3D 0;
+        int err =3D 0;
=20
         DBG("name %s mode %d", name, mode);
=20
-        bacpy(&src, BDADDR_ANY);
-        bacpy(&dst, BDADDR_ANY);
+        // set up thread signal handler
+        signal(SIGPIPE,sighand);
=20
         snd_config_for_each(i, next, conf) {
                 snd_config_t *n =3D snd_config_iterator_entry(i);
-                const char *id, *addr;
+                const char *id;
=20
                 if (snd_config_get_id(n, &id) < 0)
                         continue;
@@ -696,90 +376,24 @@
                 if (!strcmp(id, "comment") || !strcmp(id, "type"))
                         continue;
=20
-                if (!strcmp(id, "bdaddr") || !strcmp(id, "dst")) {
-                        if (snd_config_get_string(n, &addr) < 0) {
-                                SNDERR("Invalid type for %s", id);
-                                return -EINVAL;
-                        }
-                        DBG("bdaddr/dest is %s", addr);
-                        str2ba(addr, &dst);
-                        continue;
-                }
-
-                if (!strcmp(id, "local") || !strcmp(id, "src")) {
-                        if (snd_config_get_string(n, &addr) < 0) {
-                                SNDERR("Invalid type for %s", id);
-                                return -EINVAL;
-                        }
-                        str2ba(addr, &src);
-                        continue;
-                }
-
-                if (!strcmp(id, "use_rfcomm")) {
-                        if ((err =3D snd_config_get_bool(n)) < 0) {
-                                SNDERR("The field use_rfcomm must be a b=
oolean type");
-                                return err;
-                        }
-                        use_rfcomm =3D err;
+                // Ignore old options
+                if (strstr("ipaddr bdaddr port src dst use_rfcomm", id))
                         continue;
-                }
=20
                 SNDERR("Unknown field %s", id);
                 return -EINVAL;
         }
=20
-        a2dp_lock();
-
-        for (n =3D 0; n < MAX_CONNECTIONS; n++) {
-                if (connections[n]) {
-                        if (!bacmp(&connections[n]->dst, &dst) &&
-                                        (!bacmp(&connections[n]->src, &s=
rc) ||
-                                                !bacmp(&src, BDADDR_ANY)=
)) {
-                                a2dp =3D connections[n];
-                                a2dp_get(a2dp);
-                                break;
-                        }
-                } else if (pos < 0)
-                        pos =3D n;
-        }
-
-        if (!a2dp) {
-                if (pos < 0) {
-                        SNDERR("Too many connections");
-                        return -ENOMEM;
-                }
-
-                a2dp =3D a2dp_alloc();
-                if (!a2dp) {
-                        SNDERR("Can't allocate");
-                        return -ENOMEM;
-                }
-
-                connections[pos] =3D a2dp;
-
-                a2dp->state  =3D BT_CONNECT;
-
-                bacpy(&a2dp->src, &src);
-                bacpy(&a2dp->dst, &dst);
-                a2dp->use_rfcomm =3D use_rfcomm;
+        a2dp =3D a2dp_alloc();
+        if (!a2dp)
+        {
+                SNDERR("Can't allocate plugin data");
+                return -ENOMEM;
         }
=20
-        a2dp_unlock();
-/*
-        if (a2dp->state !=3D BT_CONNECTED) {
-                err =3D a2dp_connect(a2dp);
-                if (err < 0) {
-                        DBG("Can't connect");
-                        SNDERR("Can't connect");
-                        goto error;
-                }
-
-                a2dp->state =3D BT_CONNECTED;
-        }
-*/
         // Connect
         a2dp_connect(a2dp);
-       =20
+
         // Notify plugin
         a2dp->io.version      =3D SND_PCM_IOPLUG_VERSION;
         a2dp->io.name         =3D "Bluetooth Advanced Audio Distribution=
";
@@ -802,7 +416,7 @@
=20
 error:
         a2dp_disconnect(a2dp);
-        a2dp_put(a2dp);
+        a2dp_free(a2dp);
=20
         return err;
 }

--------------080308020201040705090508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------080308020201040705090508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------080308020201040705090508--
