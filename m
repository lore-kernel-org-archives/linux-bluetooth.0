Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44EC8877.8050200@palmsource.com>
Date: Wed, 23 Aug 2006 18:55:19 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------070002090306070900040100"
Subject: [Bluez-devel] Small patch to a2dpd
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
--------------070002090306070900040100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Brad,

Latest patch : Default daemon logfile is /dev/null. Try to open an l2cap=20
socket with short timeout before doing  sdp_connect that can last very=20
long. Also a script called a2dpair that wrap hcitool and passkey-agent=20
as an effort to simplify pairing and a2dpd setup :D
What about Matthew's patches? I plan to move to getopt and cleanup=20
indent and traces so having them integrated first would be better as=20
there are new options.

Fr=E9d=E9ric


--------------070002090306070900040100
Content-Type: text/x-patch;
 name="a2dpd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a2dpd.patch"

? .deps
? .libs
? Makefile
? Makefile.in
? a2play
? a2recv
? aclocal.m4
? autom4te.cache
? avrecv
? avsnd
? btsco
? btsco2
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
Index: alsa-plugins/a2dpair
===================================================================
RCS file: alsa-plugins/a2dpair
diff -N alsa-plugins/a2dpair
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-plugins/a2dpair	23 Aug 2006 16:43:12 -0000
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+#
+# Discovery
+#
+echo "Discovery in progress..."
+I=0
+SCANFILE=/tmp/hci_scan
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
+		echo "$I) [$BTADDR] $BTDESC" 
+		I=`expr $I + 1`
+		ARRAYADDR[$I]="$BTADDR"
+		ARRAYNAME[$I]="$BTDESC"
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
+SELECTION=
+I=`expr $I - 1`
+while [ -z $SELECTION ] || [ $SELECTION -gt $I ] ; do
+	echo "Choose device (0-$I)"
+	read SELECTION
+done
+# sh uses 1 based arrays
+SELECTION=`expr $SELECTION + 1`
+ADDRESS=${ARRAYADDR[$SELECTION]}
+NAME=${ARRAYNAME[$SELECTION]}
+#
+# Pairing
+#
+echo "Pair device (y/N)?"
+read CANPAIR
+
+if [ "$CANPAIR" = "y" ] ; then
+	
+	# Device passkey
+	SELECTION=
+	while [ -z $SELECTION ] ; do
+		echo "Enter passkey for $NAME"
+		read SELECTION
+	done
+	PASSKEY=$SELECTION
+	
+	# Prefetch password
+	sudo echo "Pairing in progress..."
+	
+	# passkey agent
+	if sudo passkey-agent --default $PASSKEY & PASSPID=$! ; then
+	
+		#echo "Registered passkey-agent pid=$PASSPID"
+	
+		# pairing
+		ANYTEXTISFAILURE=`sudo hcitool cc $ADDRESS 2>&1`
+	
+		if [ -z "$ANYTEXTISFAILURE" ] ; then
+			echo "Pairing successfull"
+			RESULT=0
+		else
+			echo "$ANYTEXTISFAILURE"
+			echo "Pairing failed"
+		fi
+	
+		#echo "Killing pid=$PASSPID"
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
+if [ "$A2PARAM" = "y" ] ; then
+	echo "Writing ~/.a2dprc"
+	if [ -f ~/.a2dprc ] ; then
+		mv -f ~/.a2dprc ~/.a2dprc~
+		cat ~/.a2dprc~ | while read LINE ; do
+			# Address line
+			if expr "$LINE" : "address=.*" > /dev/null; then
+				echo "address=$ADDRESS" >> ~/.a2dprc
+			else
+				echo "$LINE" >> ~/.a2dprc
+			fi
+		done
+	else
+		echo "[A2DPD]" > ~/.a2dprc
+		echo "address=$ADDRESS" >> ~/.a2dprc
+	fi
+fi
+
+
+#
+# A2DP Daemon
+#
+echo "Start a2dp daemon (y/N)?"
+read A2DAEMON
+if [ "$A2DAEMON" = "y" ] ; then
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
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd.c,v
retrieving revision 1.4
diff -u -r1.4 a2dpd.c
--- alsa-plugins/a2dpd.c	17 Aug 2006 14:06:27 -0000	1.4
+++ alsa-plugins/a2dpd.c	23 Aug 2006 16:43:13 -0000
@@ -95,10 +95,10 @@
                 chdir("/");
         }
 
-        // Redirect output to file in silent mode, verbose will print output to stdin/out/err
+        // Redirect output to file (default /dev/null) in silent mode, verbose will print output to stdin/out/err
         if(!bVerbose)
         {
-        int fd;
+                int fd;
                 if ((fd = open(output_file_name, O_CREAT|O_APPEND|O_RDWR, 0)) != -1)
                 {
                         fchmod(fd, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
@@ -764,6 +764,7 @@
                                         setup_socket(new_fd);
                                         int iReceived = 0;
                                         int play = 0;
+                                        int count = 0;
                                         do
                                         {
                                                 iReceived = a2dp_handle_avdtp_message(NULL, new_fd, NULL, NULL, 0);
@@ -771,16 +772,18 @@
                                                 {
                                                         printf("avdtp: socket %d: Received frame, start %s\n", new_fd, g_sCmdNew);
                                                         play=1;
+                                                        count=0;
                                                         break;
                                                 }
-                                                else
+                                                else if(iReceived<0)
                                                 {
-                                                        if(iReceived!=EAGAIN)
+                                                        if(errno!=EAGAIN)
                                                                 printf("avdtp: socket %d: Received failed result=%d (errno=%d:%s)\n", new_fd, iReceived, errno, strerror(errno));
                                                 }
+                                                count++;
                                         }
                                         // AVDTP do not need to have a device connected, since it can establish device connection
-                                        while(!bSigINTReceived && (iReceived>=0 || errno==EAGAIN));
+                                        while(!bSigINTReceived && (iReceived>=0 || errno==EAGAIN) && count<10);
                                         printf("avdtp: socket %d: timed out\n", new_fd);
                                         close_socket(new_fd);
 
@@ -852,7 +855,6 @@
                                 }
                                 else
                                 {
-
                                         if(errno!=EAGAIN)
                                         {
                                                 printf("a2dp_wait_connection failed (AVRCP socket) : %d (errno=%d:%s)\n", new_fd, errno, strerror(errno));
@@ -970,7 +972,7 @@
         read_config_string(g_srcfilename, "a2dpd", "cmdprev",  g_sCmdPrev,  sizeof(g_sCmdPrev),  "");
         read_config_string(g_srcfilename, "a2dpd", "cmdnext",  g_sCmdNext,  sizeof(g_sCmdNext),  "");
         read_config_string(g_srcfilename, "a2dpd", "cmdnew",   g_sCmdNew,   sizeof(g_sCmdNew),  "");
-        read_config_string(g_srcfilename, "a2dpd", "logfile",  g_sOutputFilename,  sizeof(g_sOutputFilename),  "/tmp/a2dpd.log");
+        read_config_string(g_srcfilename, "a2dpd", "logfile",  g_sOutputFilename,  sizeof(g_sOutputFilename),  "/dev/null");
 
         // Parse command line parameters
         for(i=1; i<argc && argv[i]!=NULL; i++)
Index: alsa-plugins/a2dplib.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dplib.c,v
retrieving revision 1.4
diff -u -r1.4 a2dplib.c
--- alsa-plugins/a2dplib.c	17 Aug 2006 14:06:27 -0000	1.4
+++ alsa-plugins/a2dplib.c	23 Aug 2006 16:43:13 -0000
@@ -54,6 +54,7 @@
 #include "sbc.h"
 #include "../a2dp.h"
 
+#define NBSDPRETRIESMAX 0
 #define NONSPECAUDIO 1
 #define BUFS 2048
 // In fact sbc blocks are 76 bytes long, so a group of them is either 608 or 684 bytes
@@ -64,6 +65,7 @@
 #define DBG(fmt, arg...) { if(errno!=0) printf("DEBUG: %s: (errno=%d:%s)" fmt "\n" , __FUNCTION__ , errno, strerror(errno), ## arg);\
         else printf("DEBUG: %s: " fmt "\n" , __FUNCTION__ , ## arg); errno=0;}
 
+
 //#define DBG(fmt, arg...)  printf("DEBUG: %s: " fmt "\n" , __FUNCTION__ , ## arg)
 //#define DBG(D...)
 
@@ -194,7 +196,6 @@
         struct set_config_resp s_resp;
         struct stream_cmd open_stream;
         struct open_stream_rsp open_resp;
-        DBG("Begin SEID = %d", seid);
 
         memset(&put_req, 0, sizeof(put_req));
         init_request(&put_req.header, AVDTP_GET_CAPABILITIES);
@@ -205,10 +206,7 @@
                 DBG("Couldn't request capabilities for SEID = %d", seid);
                 return (-1);
         }
-        else
-        {
-                DBG("Requested Capabilities for SEID = %d",seid);
-        }
+
         if (read(s, &cap_resp, sizeof(cap_resp)) < sizeof(cap_resp) ||
                         cap_resp.header.message_type == MESSAGE_TYPE_REJECT ||
                         cap_resp.media_type != AUDIO_MEDIA_TYPE ||
@@ -316,10 +314,8 @@
                 return (-1);
         }
 
-        DBG("Sent set configurations command");
-        
         size = read(s, &s_resp, sizeof(s_resp));
-        DBG("Got a Set Configurations (%d bytes) Response (msgtype=%d,pkttype=%d,lbl=%d,sig=%d,rfa=%d)", 
+        DBG("Got Set Configurations Response (%d bytes:msgtype=%d,pkttype=%d,lbl=%d,sig=%d,rfa=%d)", 
                 size,
                 s_resp.header.message_type,
                 s_resp.header.packet_type,
@@ -336,20 +332,103 @@
                 return (-1);
         }
 
-        DBG("Sent open stream command");
-
         if (read(s, &open_resp, sizeof(open_resp)) < sizeof(open_resp) - 1 ||
                         open_resp.header.message_type == MESSAGE_TYPE_REJECT) {
                 DBG("Didn't receive open response confirm for SEID = %d", seid);
                 return (-1);
         }
 
-        DBG("Got open stream confirm");
-
         *psm = 25;
         return 0;
 }
 
+int test_sdp(dst)
+{
+	int result = 0;
+	
+	return result;
+}
+
+// Connecting on PSM 25
+int do_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm, uint16_t *mtu)
+{
+        struct sockaddr_l2 addr;
+        struct l2cap_options opts;
+        int sk;
+        unsigned int opt;
+        int tries;
+
+        sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+        if (sk < 0) {
+                DBG( "Can't create socket. %s(%d)",
+                        strerror(errno), errno);
+                return -1;
+        }
+
+        // Set connection timeout
+        struct timeval t = { 3, 0 };
+        setsockopt( sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
+        setsockopt( sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
+        memset(&addr, 0, sizeof(addr));
+        addr.l2_family = AF_BLUETOOTH;
+        bacpy(&addr.l2_bdaddr, src);
+        if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+                DBG( "Can't bind socket. %s(%d)",
+                                                strerror(errno), errno);
+                return -1;
+        }
+
+        /* Get default options */
+        opt = sizeof(opts);
+        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
+                DBG( "Can't get default L2CAP options. %s(%d)",
+                                                strerror(errno), errno);
+                return -1;
+        }
+
+        /* Set new options */
+        if(mtu && *mtu) {
+                opts.omtu = *mtu;
+                //opts.imtu = *mtu;
+        }
+        if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
+                DBG( "Can't set L2CAP options. %s(%d)",
+                                                strerror(errno), errno);
+                return -1;
+        }
+
+        memset(&addr, 0, sizeof(addr));
+        addr.l2_family = AF_BLUETOOTH;
+        bacpy(&addr.l2_bdaddr, dst);
+        addr.l2_psm = htobs(psm);
+
+        tries = 0;
+        while (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+                DBG("Can't connect to %s on psm %d. %s(%d)",
+                                batostr(&addr.l2_bdaddr), psm, strerror(errno), errno);
+                if(++tries > NBSDPRETRIESMAX) {
+                        close(sk);
+                        return -1;
+                }
+                sleep(1);
+        }
+        opt = sizeof(opts);
+        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
+                DBG( "Can't get L2CAP options. %s(%d)",
+                                                strerror(errno), errno);
+                close(sk);
+                return -1;
+        }
+
+        //DBG( "Connected psm=%d sk=%d [imtu %d, omtu %d, flush_to %d]", psm, sk, opts.imtu, opts.omtu, opts.flush_to);
+
+        if (mtu)
+                *mtu = opts.omtu;
+
+        return sk;
+}
+
 // Detect whether A2DP Sink is present at the destination or not
 int detect_a2dp(bdaddr_t *src, bdaddr_t *dst, unsigned short *psm, unsigned long *flags)
 {
@@ -361,17 +440,28 @@
         int err;
         int tries;
 
-        DBG("Begin");
+	// Try to connect an L2CAP socket to the sdp psm with short timeout for user interaction
+	int tmpsk = do_connect(src, dst, 1, NULL);
+	if(tmpsk>0)
+	{
+		close(tmpsk);
+	}
+	else
+	{
+                DBG( "Warning: failed to connect to SDP server");
+		return -1;
+	}
+
         tries = 0;
         while(!(sess = sdp_connect(src, dst, SDP_RETRY_IF_BUSY))) {
                 DBG("retrying sdp connect: %s", strerror(errno));
-                sleep(1);
-                if(++tries > 2) {
+                if(++tries > NBSDPRETRIESMAX) {
                         break;
-                }
+			}
+                sleep(1);
         }
         if (!sess) {
-                DBG( "Warning: failed to connect to SDP server: %s", strerror(errno));
+                DBG( "Warning: failed to connect to SDP server");
                 if(psm) *psm = 25;
                 if(flags) *flags = 0;
                 return 0;
@@ -448,84 +538,6 @@
         sdp_close(sess);
         return 0;
 }
-// Connecting on PSM 25
-int do_connect(bdaddr_t *src, bdaddr_t *dst, unsigned short psm, uint16_t *mtu)
-{
-        struct sockaddr_l2 addr;
-        struct l2cap_options opts;
-        int sk;
-        unsigned int opt;
-        int tries;
-        
-        DBG("Begin");
-        sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
-        if (sk < 0) {
-                DBG( "Can't create socket. %s(%d)",
-                        strerror(errno), errno);
-                return -1;
-        }
-
-        DBG( "Connecting to bluetooth");
-
-        memset(&addr, 0, sizeof(addr));
-        addr.l2_family = AF_BLUETOOTH;
-        bacpy(&addr.l2_bdaddr, src);
-        if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-                DBG( "Can't bind socket. %s(%d)",
-                                                strerror(errno), errno);
-                return -1;
-        }
-
-        /* Get default options */
-        opt = sizeof(opts);
-        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
-                DBG( "Can't get default L2CAP options. %s(%d)",
-                                                strerror(errno), errno);
-                return -1;
-        }
-
-        /* Set new options */
-        if(mtu && *mtu) {
-                opts.omtu = *mtu;
-                //opts.imtu = *mtu;
-        }
-        if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
-                DBG( "Can't set L2CAP options. %s(%d)",
-                                                strerror(errno), errno);
-                return -1;
-        }
-
-        memset(&addr, 0, sizeof(addr));
-        addr.l2_family = AF_BLUETOOTH;
-        bacpy(&addr.l2_bdaddr, dst);
-        addr.l2_psm = htobs(psm);
-
-        tries = 0;
-        while (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-                DBG("Can't connect to %s on psm %d. %s(%d)",
-                                batostr(&addr.l2_bdaddr), psm, strerror(errno), errno);
-                sleep(1);
-                if(++tries > 2) {
-                        close(sk);
-                        return -1;
-                }
-        }
-        opt = sizeof(opts);
-        if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
-                DBG( "Can't get L2CAP options. %s(%d)",
-                                                strerror(errno), errno);
-                close(sk);
-                return -1;
-        }
-
-        DBG( "Connected psm=%d sk=%d [imtu %d, omtu %d, flush_to %d]", psm, sk,
-                                        opts.imtu, opts.omtu, opts.flush_to);
-
-        if (mtu)
-                *mtu = opts.omtu;
-
-        return sk;
-}
 
 int connect_stream(bdaddr_t *src, bdaddr_t *dst, int *cmdfd_return, sbc_t *sbc, int* seid_return, int* omtu)
 {
@@ -543,9 +555,6 @@
         uint16_t mtu = 0;
         int tries, res;
 
-        DBG("Begin");
-        DBG( "Using address: %s", batostr(dst));
-
         if (detect_a2dp(src, dst, &psm_cmd, &flags) < 0) {
                 DBG( "could not find A2DP services on device %s", batostr(dst));
                 return -1;
@@ -831,7 +840,11 @@
 {
         snd_pcm_a2dp_t* a2dp = (snd_pcm_a2dp_t*)param;
 
-        if(a2dp->control_sk<0) return NULL;
+        if(a2dp->control_sk<0) 
+        {
+        	DBG("Listen thread not started [control_sk=%d]", a2dp->control_sk);
+		return NULL;
+        }
 
         DBG("Listen thread running [control_sk=%d]", a2dp->control_sk);
 
@@ -895,7 +908,6 @@
         int sk = -1;
         int control_sk = -1;
         errno=0;
-        DBG("a2dp %p", a2dp);
         /*
         if(a2dp->use_rfcomm) {
                 sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
@@ -943,20 +955,23 @@
         a2dp->pause_writing = 0;
         a2dp->stop_writing = 0;
         
-        // Set pthread stack size to decrease unused memory usage
-        pthread_attr_t tattr;
-        size_t size = PTHREAD_STACK_MIN;
-        int ret = pthread_attr_init(&tattr);
-        ret = pthread_attr_setstacksize(&tattr, size);
-        pthread_create(&a2dp->hListenThread, &tattr, listen_thread, (void*)a2dp);
-        pthread_attr_destroy(&tattr);
-        return 0;
+        if(sk>0)
+        {
+		// Set pthread stack size to decrease unused memory usage
+		pthread_attr_t tattr;
+		size_t size = PTHREAD_STACK_MIN;
+		int ret = pthread_attr_init(&tattr);
+		ret = pthread_attr_setstacksize(&tattr, size);
+		pthread_create(&a2dp->hListenThread, &tattr, listen_thread, (void*)a2dp);
+		pthread_attr_destroy(&tattr);
+	}
+
+        return sk;
 }
 
 snd_pcm_a2dp_t *a2dp_alloc(void)
 {
         snd_pcm_a2dp_t *a2dp;
-        DBG("Begin");
         a2dp = malloc(sizeof(*a2dp));
         if (!a2dp)
                 return NULL;
@@ -976,7 +991,7 @@
 
 void a2dp_free(snd_pcm_a2dp_t *a2dp)
 {
-        DBG("Begin");
+        DBG("");
         if (a2dp->sk > 0)
                 close(a2dp->sk);
         if (a2dp->control_sk > 0)
@@ -1018,12 +1033,12 @@
         bdaddr_t src, dst;
         int err; //, pos = -1, use_rfcomm = 0;
 
-        DBG("Begin");
+        DBG("%s, %d", addr, framerate);
+
         bacpy(&src, BDADDR_ANY);
         bacpy(&dst, BDADDR_ANY);
-        DBG("bdaddr/dest is %s", addr);
         str2ba(addr, &dst);
-        
+
         a2dp = a2dp_alloc();
         if (!a2dp) {
                 DBG("Can't allocate");
@@ -1262,7 +1277,7 @@
         {
                 result=iReceived;
                 if(errno!=EAGAIN)
-                        printf("socket %d: Receive failed %d (error %d:%s)\n", sockfd, iReceived, errno, strerror(errno));
+                        printf("socket %d: Receive failed %d (errno=%d:%s)\n", sockfd, iReceived, errno, strerror(errno));
         }
 
         return result;
Index: alsa-plugins/pcm_a2dp.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/pcm_a2dp.c,v
retrieving revision 1.15
diff -u -r1.15 pcm_a2dp.c
--- alsa-plugins/pcm_a2dp.c	3 Aug 2006 18:02:37 -0000	1.15
+++ alsa-plugins/pcm_a2dp.c	23 Aug 2006 16:43:13 -0000
@@ -818,7 +818,7 @@
 	struct media_packet_header packet_header;
 	struct media_payload_header payload_header;
 	int codesize,datatoread;
-	unsigned long sleeptime;
+	unsigned long sleeptime=0;
 	int written;
 	struct timeval dt;
 	struct timeval timeofday;

--------------070002090306070900040100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------070002090306070900040100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------070002090306070900040100--
