Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D3631D.503@palmsource.com>
Date: Fri, 04 Aug 2006 17:09:17 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <056BF200E9632F4285220E570FEED673D3B631@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <056BF200E9632F4285220E570FEED673D3B631@GBMDDMH202AMSX.gb001.siemens.net>
Content-Type: multipart/mixed; boundary="------------080805060104000500030609"
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms error
 (trials and tribulations) how cool is this!!! new patch
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
--------------080805060104000500030609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi all,

Now the a2dpd handles avrcp too. Only play / pause / next / prev but=20
other commands if any should go straight away.

Waldram, Andrew (SBS UK) a =E9crit :

>When you say you integrated it into a2dpd do you mean all the a2recv stu=
ff, if so doean't that make the deamon a xmms dependant tool?
> =20
>
No thanks to the config file

>It'd be real cool if it'd parse a config file so something like the foll=
owing could be done
>
>/etc/a2dpd.conf
> =20
>
done, see attachment
$HOME/.a2dprc for now

>For now, it is not yet handled but you see the daemon receive a frame of=
=20
>the form 0x00 0x01 (AVDTP_DISCOVER).
>I will try today reject the frame and system(xmms --play).
> =20
>
done, see patch

Two commands line options appeared:
-d forks (+d no fork) on startup
-v redirect output to stdout (+v to logfile specified in rc def :=20
/tmp/a2dpd.log)

If your headset is avrcp, what can you do :
start a2dpd
press play on the headset, and it will start up xmms. You should hear mus=
ic
press play again, it will pause xmms.
press play again, music restart.
press next or prev to switch song.

you can also try alsamixer -D ctl.a2dpd

Fr=E9d=E9ric



--------------080805060104000500030609
Content-Type: text/plain;
 name="patch-2006-08-04"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2006-08-04"

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
? configure
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
Index: a2dp.h
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/a2dp.h,v
retrieving revision 1.9
diff -u -r1.9 a2dp.h
--- a2dp.h	19 Jun 2006 05:11:22 -0000	1.9
+++ a2dp.h	4 Aug 2006 14:52:07 -0000
@@ -20,6 +20,9 @@
  *
  */
 
+#ifndef A2DP_H
+#define A2DP_H
+
 #include <stdint.h>
  
 /* AVDTP structures */
@@ -280,3 +283,5 @@
         uint32_t sample_rate;   /* sample rate */
         uint32_t channels;      /* number of channels (voices) */
 };
+
+#endif
Index: alsa-plugins/Makefile.am
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/Makefile.am,v
retrieving revision 1.4
diff -u -r1.4 Makefile.am
--- alsa-plugins/Makefile.am	28 Jul 2006 21:34:48 -0000	1.4
+++ alsa-plugins/Makefile.am	4 Aug 2006 14:52:08 -0000
@@ -27,6 +27,9 @@
 a2dpd_SOURCES = a2dpd.c a2dplib.c a2dp_timer.c a2dp_ipc.c
 a2dpd_LDADD = @BLUEZ_LIBS@ -lsbc -lpthread -lrt
 
+# This one will remove a warning
+a2dpd_CFLAGS = -pthread
+
 AM_CFLAGS = @ALSA_CFLAGS@ @BLUEZ_CFLAGS@ -pthread
 
 endif
Index: alsa-plugins/a2dp_ipc.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dp_ipc.c,v
retrieving revision 1.1
diff -u -r1.1 a2dp_ipc.c
--- alsa-plugins/a2dp_ipc.c	28 Jul 2006 21:34:48 -0000	1.1
+++ alsa-plugins/a2dp_ipc.c	4 Aug 2006 14:52:08 -0000
@@ -127,7 +127,7 @@
 void setup_socket(int sockfd)
 {
         // Timeouts
-        struct timeval t = { 2, 100 };
+        struct timeval t = { 1, 0 };
         setsockopt( sockfd, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
         setsockopt( sockfd, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
 }
Index: alsa-plugins/a2dpd.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd.c,v
retrieving revision 1.2
diff -u -r1.2 a2dpd.c
--- alsa-plugins/a2dpd.c	28 Jul 2006 21:34:48 -0000	1.2
+++ alsa-plugins/a2dpd.c	4 Aug 2006 14:52:08 -0000
@@ -24,12 +24,15 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <string.h>
+#include <strings.h>
 #include <errno.h>
 #include <signal.h>
 #include <pthread.h>
+#include <fcntl.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/time.h>
+#include <sys/stat.h>
 
 #include "a2dplib.h"
 #include "a2dpd_protocol.h"
@@ -42,6 +45,270 @@
 #define MAXCLIENTSRINGSIZE     64
 #define POOLENTRYSIZE          A2DPD_BLOCK_SIZE
 
+#define A2DPD_CONFIG_FILE       ".a2dpdrc"
+
+
+static char     g_sOutputFilename       [512];
+static char     g_srcfilename           [512];
+static char     g_sCmdPlay              [512];
+static char     g_sCmdPause             [512];
+static char     g_sCmdPrev              [512];
+static char     g_sCmdNext              [512];
+static char     g_sCmdNew               [512];
+static int      g_nbdeviceconnected     = 0;
+
+// This function is needed to destroy zombies processes
+// On Unix, any forked process do terminate before its parent create a zombie until parent call waitpid()
+// We do not want to wait as we just need to "fire and forget" processes
+// Found that on the web, hope it works
+// http://www.erlenstar.demon.co.uk/unix/faq_2.html
+void ignore_child_processes_return_values()
+{
+struct sigaction sa;
+    sa.sa_handler = SIG_IGN;
+#ifdef SA_NOCLDWAIT
+    sa.sa_flags = SA_NOCLDWAIT;
+#else
+    sa.sa_flags = 0;
+#endif
+    sigemptyset(&sa.sa_mask);
+    sigaction(SIGCHLD, &sa, NULL);
+}
+
+void make_daemon_process(int bFork, int bVerbose, char*output_file_name)
+{
+	// Fork to background process if needed
+	if (bFork == 1)
+	{
+		switch (fork())
+		{
+			case -1:
+				exit(-1);
+			case 0:
+				break;
+			default:
+				exit(0);
+		}
+
+		if (setsid() == -1)
+			exit(-1);
+	}
+
+	// Redirect output to file in silent mode, verbose will print output to stdin/out/err
+	if(!bVerbose)
+	{
+	       int fd;
+		if ((fd = open(output_file_name, O_CREAT|O_APPEND|O_RDWR, 0)) != -1)
+		{
+                        fchmod(fd, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
+			(void) dup2(fd, STDIN_FILENO);
+			(void) dup2(fd, STDOUT_FILENO);
+			(void) dup2(fd, STDERR_FILENO);
+			if (fd > 2)
+				(void) close(fd);
+		}
+		else
+		{
+			printf("a2dpd: Couldn't redirect output to '%s' (errno=%d:%s)", output_file_name, errno, strerror(errno));
+		}
+	}
+
+	printf("a2dpd [%s %s] starting ...", __DATE__, __TIME__);
+}
+
+static void async_run_process(char* cmd)
+{
+        char command[256];
+        char* argv[2];
+        int i;
+        strncpy(command, cmd, sizeof(command));
+        command[sizeof(command)-1]=0;
+        argv[0] = strchr(command, ' ');
+        if(argv[0]) { *argv[0]=0; argv[0]++; }
+
+        if(cmd && cmd[0])
+        {
+                switch(fork())
+                {
+                        case 0:
+                                // Children process
+                                // Replace children with new process
+                                i = execlp(command, command, argv[0], NULL);
+                                printf("execlp failed %s=%d (errno=%d:%s)\n", cmd, i, errno, strerror(errno));
+                                break;
+                        case -1:
+                                // failed
+                                printf("Fork %s failed\n", cmd);
+                                break;
+                        default:
+                                printf("Forked %s\n", cmd);
+                                // Parent, nothing to do
+                                break;
+                }
+        }
+}
+
+//////////////////////////////////////////
+//////////////////////////////////////////
+// AVRCP CODE BEGIN //////////////////////
+//////////////////////////////////////////
+//////////////////////////////////////////
+
+
+#include "avrcp.h"
+// Prepare packet headers
+static void init_response(struct avctp_header *header)
+{
+	header->ipid = 0;
+	header->cr = AVCTP_RESPONSE_FRAME;
+	header->packet_type = PACKET_TYPE_SINGLE;
+}
+
+// This function handle the bluetooth connection
+int a2dp_handle_avrcp_message(int sockfd)
+{
+        char lpFrame [A2DPMAXIMUMTRANSFERUNITSIZE];
+        int iReceived = recv(sockfd, lpFrame, sizeof(lpFrame), 0);
+        if(iReceived>0)
+        {
+                struct avc_frame frame = *((struct avc_frame*)lpFrame);
+
+                // Handle message
+                if(frame.ctype == CMD_PASSTHROUGH)
+                {
+                        switch (frame.operand0)
+                        {
+                        case PLAY_OP:
+                                printf("[play] %s\n", g_sCmdPlay);
+                                if(g_sCmdPlay[0]) async_run_process(g_sCmdPlay);
+                                break;
+                        case PAUSE_OP:
+                                printf("[pause] %s\n", g_sCmdPause);
+                                if(g_sCmdPause[0]) async_run_process(g_sCmdPause);
+                                break;
+                        case NEXT_OP:
+                                printf("[next] %s\n", g_sCmdNext);
+                                if(g_sCmdNext[0]) async_run_process(g_sCmdNext);
+                                break;
+                        case PREV_OP:
+                                printf("[previous] %s\n", g_sCmdPrev);
+                                if(g_sCmdPrev[0]) async_run_process(g_sCmdPrev);
+                                break;
+                        default:
+                                printf("received passthrough %d bytes:\n", iReceived);
+                                //dump_packet(&frame, iReceived);
+                        }
+                }
+                else
+                {
+                        printf("received %d bytes:\n", iReceived);
+                        //dump_packet(&frame, iReceived);
+                }
+                // Send response
+                if(iReceived > 0)
+                {
+                        if(frame.ctype == CMD_ACCEPTED)
+                        {
+                                printf("(ack)\n");
+                        }
+                        else
+                        if(frame.ctype == CMD_PASSTHROUGH)
+                        {
+                                init_response(&frame.header);
+                                frame.ctype = CMD_ACCEPTED;
+                                write(sockfd, &frame, iReceived);
+                        }
+                        else
+                        {
+                                printf("only passthrough ctype command is implemented. doh!\n");
+                                // ierk!!! exit(0);
+                        }
+                }
+        }
+        else
+        {
+                if(errno!=EAGAIN)
+                        printf("socket %d: Receive failed %d (error %d:%s)\n", sockfd, iReceived, errno, strerror(errno));
+        }
+
+        return iReceived;
+}
+
+//////////////////////////////////////////
+//////////////////////////////////////////
+// AVRCP CODE END ////////////////////////
+//////////////////////////////////////////
+//////////////////////////////////////////
+
+void read_config_string(char* filename, char* section, char* key, char* returnbuffer, int buffersize, char* defvalue)
+{
+        int found=0, error=0;
+        FILE* hFile = fopen(filename, "rt");
+        //printf("read_config_string: reading %s\n", filename);
+        if(hFile)
+        {
+                // search section
+                while(!error && !found && !feof(hFile))
+                {
+                        char buffer[256], szsection[256];
+                        if(fgets(buffer, sizeof(buffer), hFile) == NULL)
+                        {
+                                error=1;
+                                break;
+                        }
+
+        //printf("read_config_string: read section %s\n", buffer);
+                        if(sscanf(buffer, "[%s]", szsection)==1)
+                        {
+                                szsection[strlen(szsection)-1]=0;
+        //printf("read_config_string: scanned %s\n", szsection);
+                                // Found section
+                                if(!strcasecmp(section, szsection))
+                                {
+                                        // key search loop
+                                        while(!error && !found && !feof(hFile))
+                                        {
+                                                char szkey[256], szvalue[256];
+                                                if(fgets(buffer, sizeof(buffer), hFile) == NULL)
+                                                {
+                                                        error=1;
+                                                        break;
+                                                }
+        //printf("read_config_string: read key %s\n", buffer);
+                                                // Another section name will exit the key search loop
+                                                if(sscanf(buffer, "[%s]", szsection)==1)
+                                                {
+                                                        break;
+                                                }
+                                                // A key name
+                                                if(sscanf(buffer, "%[^=]=%[^\n]", szkey, szvalue)>1)
+                                                {
+        //printf("read_config_string: read %s '%s' '%s'\n", buffer, szkey, szvalue);
+                                                        // Found key
+                                                        if(!strcasecmp(key, szkey))
+                                                        {
+        //printf("read_config_string: buffer=%s\n", buffer);
+                                                                strncpy(returnbuffer, szvalue, buffersize);
+                                                                returnbuffer[buffersize-1]=0;
+                                                                found = 1;
+                                                        }
+                                                }
+                                        }
+                                }
+                        }
+                }
+                fclose(hFile);
+        }
+
+        // Put default value
+        if(!found)
+        {
+                strncpy(returnbuffer, defvalue, buffersize);
+                returnbuffer[buffersize-1]=0;
+        }
+        printf("%s: [%s] '%s'='%s'\n", __FUNCTION__, section, key, returnbuffer);
+}
+
 // if 1 then quit gently
 static sig_atomic_t bSigINTReceived = 0;
 
@@ -59,6 +326,7 @@
 {
         free(pool);
 }
+
 // Data used to mix audio
 typedef struct
 {
@@ -345,7 +613,7 @@
                         memset(pcm_buffers_size, 0, sizeof(pcm_buffers_size));
 
                         // If there are BT data, send them
-                        //FIXME 
+                        //FIXME Since we read nb_clients, we should lock mutex, but it may create timer issues
                         // pthread_mutex_lock(&lpDevice->mutex);
 
                         if(lpDevice->nb_clients>0)
@@ -461,6 +729,7 @@
                                                 if(!lpA2dp)
                                                 {
                                                         lpA2dp = a2dp_new(lpDevice->addr);
+                                                        g_nbdeviceconnected++;
                                                         destroy_count = 0;
                                                 }
 
@@ -503,12 +772,13 @@
                         }
 
                         // Free the A2DP device if needed
-                        // When destroy_count reaches 5000 we will destroy the A2DP link
+                        // When destroy_count reaches 2000 we will destroy the A2DP link
                         // However, destroy_count is reset whenever data are sent
                         destroy_count++;
-                        if(lpA2dp && destroy_count>5000)
+                        if(lpA2dp && destroy_count>2000)
                         {
                                 printf("Destroying lpA2dp, destroy_count is %d\n", destroy_count);
+                                g_nbdeviceconnected--;
                                 a2dp_destroy(lpA2dp);
                                 lpA2dp = NULL;
                         }
@@ -552,6 +822,7 @@
                 if(lpA2dp)
                 {
                         printf("Destroying lpA2dp, end of loop\n");
+                        g_nbdeviceconnected--;
                         a2dp_destroy(lpA2dp);
                         lpA2dp = NULL;
                 }
@@ -563,7 +834,7 @@
 }
 
 // This function handle the bluetooth connection
-void* bt_receiver(void* param)
+void* avdtp_listener(void* param)
 {
         // We should not terminate the process if clients are still running
         iThreadsRunning ++;
@@ -572,64 +843,100 @@
         pthread_detach(lpDevice->thread);
 
         // As long as daemon is running
+        printf("avdtp: Accepting incoming connection\n");
         while(!bSigINTReceived)
         {
                 int sockfd = a2dp_make_listen_socket( 25);
-
-                int bError = (sockfd < 0);
-
                 if(sockfd>=0)
                 {
-                        while(!bSigINTReceived && !bError)
+                        while(!bSigINTReceived)
                         {
                                 // Wait for incoming connections
                                 char szRemote[64];
                                 uint16_t iMTU = 0;
 
-                                printf("Accepting incoming A2DP connection\n");
                                 int new_fd = a2dp_wait_connection(sockfd, szRemote, sizeof(szRemote), &iMTU);
 
-                                printf("socket %d: Connection from %s, mtu=%d\n", new_fd, szRemote, iMTU);
-
-                                setup_socket(new_fd);
-
                                 if(new_fd>0)
                                 {
-                                        char* lpFrame = malloc(iMTU);
-                                        if(lpFrame)
+                                        printf("avdtp: socket %d: Connection from %s, mtu=%d\n", new_fd, szRemote, iMTU);
+
+                                        // Loop and manage what the client sends
+                                        setup_socket(new_fd);
+                                        int iReceived = 0;
+                                        int play = 0;
+                                        do
                                         {
-                                                // Loop and display what the client sends
-                                                int iReceived = 0;
-                                                do
+                                                iReceived = a2dp_handle_avdtp_message(NULL, new_fd, NULL, NULL, 0);
+                                                if(iReceived==0)
                                                 {
-                                                        iReceived = recv(new_fd, lpFrame, iMTU, 0);
-                                                        if(iReceived>=0)
-                                                        {
-                                                                int i;
-                                                                printf("socket %d: Received %d bytes\n", new_fd, iReceived);
-                                                                for(i = 0; i<iReceived; i++)
-                                                                {
-                                                                        char c=lpFrame[i];
-                                                                        if(i%16==0) printf("%05d: ", i);
-                                                                        printf("%02x ", c);
-                                                                        if(i%16==15) printf("\n");
-                                                                }
-                                                                printf("\n");
-                                                        }
-                                                        else
-                                                        {
-                                                                if(errno!=EAGAIN)
-                                                                        printf("socket %d: Receive failed %d (error %d:%s)\n", new_fd, iReceived, errno, strerror(errno));
-                                                        }
+                                                        printf("avdtp: socket %d: Received frame, start %s\n", new_fd, g_sCmdNew);
+                                                        play=1;
+                                                        break;
                                                 }
-                                                while(iReceived>=0 || errno==EAGAIN);
-                                                free(lpFrame);
                                         }
+                                        // AVDTP do not need to have a device connected, since it can establish device connection
+                                        while(!bSigINTReceived && (iReceived>=0 || errno==EAGAIN));
+                                        printf("avdtp: socket %d: timed out\n", new_fd);
                                         close_socket(new_fd);
+
+                                        if(play&&g_sCmdNew[0])
+                                        {
+                                                async_run_process(g_sCmdNew);
+                                        }
                                 }
-                                else
+                        }
+
+                        close_socket(sockfd);
+                }
+
+                // Sleep a little bit if we must retry
+                sleep(bSigINTReceived?1:0);
+        }
+
+        iThreadsRunning --;
+
+        return 0;
+}
+
+// This function handle the bluetooth connection
+void* avrcp_listener(void* param)
+{
+        // We should not terminate the process if clients are still running
+        iThreadsRunning ++;
+
+        LPBTA2DPPERDEVICEDATA lpDevice = (LPBTA2DPPERDEVICEDATA)param;
+        pthread_detach(lpDevice->thread);
+
+        // As long as daemon is running
+        printf("avrcp: Accepting incoming connection\n");
+        while(!bSigINTReceived)
+        {
+                int sockfd = a2dp_make_listen_socket( 23);
+                if(sockfd>=0)
+                {
+                        while(!bSigINTReceived)
+                        {
+                                // Wait for incoming connections
+                                char szRemote[64];
+                                uint16_t iMTU = 0;
+
+                                int new_fd = a2dp_wait_connection(sockfd, szRemote, sizeof(szRemote), &iMTU);
+
+                                if(new_fd>0)
                                 {
-                                        bError = 1;
+                                        printf("avrcp: socket %d: Connection from %s, mtu=%d\n", new_fd, szRemote, iMTU);
+                                        // Loop and manage what the client sends
+                                        setup_socket(new_fd);
+                                        int iReceived = 0;
+                                        do
+                                        {
+                                                iReceived = a2dp_handle_avrcp_message(new_fd);
+                                        }
+                                        // AVRCP need device connected
+                                        while(g_nbdeviceconnected && !bSigINTReceived && (iReceived>0 || errno==EAGAIN));
+                                        printf("avrcp: socket %d: timed out\n", new_fd);
+                                        close_socket(new_fd);
                                 }
                         }
 
@@ -652,7 +959,7 @@
         {
                 // Master socket
                 int sockfd = make_server_socket();
-        
+
                 if(sockfd>0)
                 {
                         LPBTA2DPPERDEVICEDATA lpDevice = bta2dpdevicenew(addr);
@@ -662,15 +969,16 @@
                         int ret = pthread_attr_init(&tattr);
                         ret = pthread_attr_setstacksize(&tattr, size);
                         pthread_create(&lpDevice->thread, &tattr, bt_handler,  lpDevice);
-                        pthread_create(&lpDevice->thread, &tattr, bt_receiver, lpDevice);
-        
+                        pthread_create(&lpDevice->thread, &tattr, avrcp_listener, lpDevice);
+                        pthread_create(&lpDevice->thread, &tattr, avdtp_listener, lpDevice);
+
                         while(!bSigINTReceived)
                         {
                                 int new_fd = -1;
-                                printf("Accepting incoming stream connection\n");
+                                printf("Accepting incoming tcp stream connection\n");
                                 new_fd=accept_socket(sockfd);
                                 printf("Accepted %d\n", new_fd);
-        
+
                                 // Handle connection if it is not the final dummy client
                                 if(!bSigINTReceived)
                                 {
@@ -725,36 +1033,75 @@
 {
         int i = 0;
         struct timespec timer_resolution = { 0, 0 };
-        char* addr = "00:0A:56:00:C0:C2 Sonorix";
-        // C2:00:08:F4:30:07:64 IPhono
-        // 00:0D:44:2A:17:C7 HP
-        // If we can be realtime it will be better
+        char address[256] = "";
+        char* addr = &address[0];
+        char* sonorix="00:0A:56:00:C0:C2";
+        //char* iphono420= "C2:00:08:F4:30:07:64";
+        //char* hpheadphone= "00:0D:44:2A:17:C7";
         struct sched_param schedparam = { sched_get_priority_max(SCHED_FIFO) };
-        int res = sched_setscheduler(0, SCHED_FIFO, &schedparam); 
-        int bTestThread = 0;
-        printf("setscheduler returns %d (errno=%d:%s)\n", res, errno, strerror(errno));
-	
-	// Parse command line parameters
-	for(i=1; i<argc && argv[i]!=NULL; i++)
-	{
-	       char c;
-	       // Search a glade file
-	       if(0==strcmp(argv[i], "-t"))
-	       {
-	               bTestThread = 1;
-	       }
-	       // Search a bluetooth addr
-	       else if(sscanf(argv[i], "%c%c:%c%c:%c%c:%c%c:%c%c:%c%c", &c, &c, &c, &c, &c, &c, &c, &c, &c, &c, &c, &c)==12)
-	       {
-	               addr=argv[i];
-	       }
-	       else
-	       {
-	               printf("Parameter not handled: %s\r\n", argv[i]);
-	       }
-	}
+        int res=0,  bFork=0, bVerbose=1;
+
+        // Read config values from config file
+        sprintf(g_srcfilename, "%s/%s", getenv("HOME"), ".a2dprc");
+        read_config_string(g_srcfilename, "a2dpd", "address",  address,     sizeof(address),     sonorix);
+        read_config_string(g_srcfilename, "a2dpd", "cmdplay",  g_sCmdPlay,  sizeof(g_sCmdPlay),  "");
+        read_config_string(g_srcfilename, "a2dpd", "cmdpause", g_sCmdPause, sizeof(g_sCmdPause), "");
+        read_config_string(g_srcfilename, "a2dpd", "cmdprev",  g_sCmdPrev,  sizeof(g_sCmdPrev),  "");
+        read_config_string(g_srcfilename, "a2dpd", "cmdnext",  g_sCmdNext,  sizeof(g_sCmdNext),  "");
+        read_config_string(g_srcfilename, "a2dpd", "cmdnew",   g_sCmdNew,   sizeof(g_sCmdNew),  "");
+        read_config_string(g_srcfilename, "a2dpd", "logfile",  g_sOutputFilename,  sizeof(g_sOutputFilename),  "/tmp/a2dpd.log");
+
+        // Parse command line parameters
+        for(i=1; i<argc && argv[i]!=NULL; i++)
+        {
+                char c;
+                // Search a bluetooth addr
+                if(sscanf(argv[i], "%c%c:%c%c:%c%c:%c%c:%c%c:%c%c", &c, &c, &c, &c, &c, &c, &c, &c, &c, &c, &c, &c)==12)
+                {
+                        addr=argv[i];
+                }
+                else if(!strcmp(argv[i], "-n"))
+                {
+                        bFork=0;
+                }
+                else if(!strcmp(argv[i], "-d"))
+                {
+                        bFork=1;
+                }
+                else if(!strcmp(argv[i], "-v"))
+                {
+                        bVerbose=1;
+                }
+                else if(!strcmp(argv[i], "+n"))
+                {
+                        bFork=1;
+                }
+                else if(!strcmp(argv[i], "+d"))
+                {
+                        bFork=0;
+                }
+                else if(!strcmp(argv[i], "+v"))
+                {
+                        bVerbose=0;
+                }
+                else
+                {
+                        printf("Parameter not handled: %s\r\n", argv[i]);
+                }
+        }
         clock_getres(CLOCK_REALTIME, &timer_resolution);
+
+        ignore_child_processes_return_values();
+        
+        // Redirect outputs
+        make_daemon_process(bFork, bVerbose, g_sOutputFilename);
+
         printf("%s addr=%s timer=%d us [%s %s]\n", argv[0], addr, (int)(timer_resolution.tv_nsec/1000), __DATE__, __TIME__);
+
+        // If we can be realtime it will be better
+        res = sched_setscheduler(0, SCHED_FIFO, &schedparam); 
+        printf("setscheduler returns %d (errno=%d:%s)\n", res, errno, strerror(errno));
+
         // set up the handler
         signal(SIGINT, sigint_handler);
         signal(SIGTERM, sigint_handler);
Index: alsa-plugins/a2dpd_protocol.h
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd_protocol.h,v
retrieving revision 1.1
diff -u -r1.1 a2dpd_protocol.h
--- alsa-plugins/a2dpd_protocol.h	28 Jul 2006 21:34:48 -0000	1.1
+++ alsa-plugins/a2dpd_protocol.h	4 Aug 2006 14:52:08 -0000
@@ -44,11 +44,11 @@
 #define A2DPD_VOLUME_MIN        0
 #define A2DPD_VOLUME_MAX        15
 
+#define A2DPD_FRAME_BYTES       4 // 16bits * 2 channels
+#define A2DPD_FRAME_RATE        44100 // Can be 32000, tested with HP, iPhono and needed Sonorix, but quality decreases, 48000 nearly never works
 // a2dp->sbc.channels*44100*2/(size*a2dp->frame_bytes);
 // 344.53125=channels*freq*16 bits/sizeof(buf)
-#define A2DPD_BLOCK_FREQUENCY   (344.53125/1)
 #define A2DPD_BLOCK_SIZE        (512*1)
-#define A2DPD_FRAME_BYTES       4 // 16bits * 2 channels
-#define A2DPD_FRAME_RATE        44100
+#define A2DPD_BLOCK_FREQUENCY   (float)((((float)A2DPD_FRAME_RATE)*((float)A2DPD_FRAME_BYTES)/((float)A2DPD_BLOCK_SIZE))/1.0)
 
 #endif
Index: alsa-plugins/a2dplib.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dplib.c,v
retrieving revision 1.2
diff -u -r1.2 a2dplib.c
--- alsa-plugins/a2dplib.c	28 Jul 2006 21:34:48 -0000	1.2
+++ alsa-plugins/a2dplib.c	4 Aug 2006 14:52:08 -0000
@@ -34,6 +34,7 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/time.h>
+#include <sys/select.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/rfcomm.h>
@@ -47,14 +48,14 @@
 
 
 #include "a2dplib.h"
+#include "a2dpd_protocol.h"
 #include "a2dp_timer.h"
 #include "a2dp_ipc.h"
 #include "sbc.h"
 #include "../a2dp.h"
 
 #define NONSPECAUDIO 1
-#define BUFS 1024
-#define A2DPMAXIMUMTRANSFERUNITSIZE 678
+#define BUFS 2048
 // In fact sbc blocks are 76 bytes long, so a group of them is either 608 or 684 bytes
 // So 650 or 678 makes no differences!
 // However some devices may have longer transfer unit up to I saw omtu=733?
@@ -158,7 +159,7 @@
 void memcpy_changeendian( void* dst, const void *src, int size)
 {
         int i;
-        uint16_t* ptrsrc=src;
+        const uint16_t* ptrsrc=src;
         uint16_t* ptrdst=dst;
         for(i = 0; i < size/2; i ++)
         {
@@ -199,11 +200,13 @@
         init_request(&put_req.header, AVDTP_GET_CAPABILITIES);
         put_req.acp_seid = seid;
 
-        if (write(s, &put_req, sizeof(put_req)) != sizeof(put_req)) {
+        if (write(s, &put_req, sizeof(put_req)) != sizeof(put_req))
+        {
                 DBG("Couldn't request capabilities for SEID = %d", seid);
                 return (-1);
         }
-        else {
+        else
+        {
                 DBG("Requested Capabilities for SEID = %d",seid);
         }
         if (read(s, &cap_resp, sizeof(cap_resp)) < sizeof(cap_resp) ||
@@ -214,13 +217,20 @@
                 return (-1);
         }
 
-        DBG("Got capabilities response");
+        DBG("Got capabilities response:\nservcap_cap=%d, servcap_len=%d,\ncap_type=%d, length=%d, media_type=%d, codec=%d",
+                cap_resp.serv_cap,
+                cap_resp.serv_cap_len,
+                cap_resp.cap_type,
+                cap_resp.length,
+                cap_resp.media_type,
+                cap_resp.media_codec_type
+        );
 
         memset(&s_config, 0, sizeof(s_config));
         init_request(&s_config.header, AVDTP_SET_CONFIGURATION);
         s_config.serv_cap = MEDIA_TRANSPORT_CATEGORY;
         s_config.acp_seid = seid;
-        s_config.int_seid = 1;	// how should I choose the int_seid??
+        s_config.int_seid = 1;	//FIXME how should I choose the int_seid??
         s_config.cap_type = MEDIA_CODEC;
         s_config.length = 6;
         s_config.media_type = AUDIO_MEDIA_TYPE;
@@ -309,11 +319,13 @@
         DBG("Sent set configurations command");
         
         size = read(s, &s_resp, sizeof(s_resp));
-        if (size == sizeof(s_resp) - 2) {
-                DBG("Set configurations command accepted");
-        } else {
-                DBG("Set configurations command rejected");
-        }
+        DBG("Got a Set Configurations (%d bytes) Response (msgtype=%d,pkttype=%d,lbl=%d,sig=%d,rfa=%d)", 
+                size,
+                s_resp.header.message_type,
+                s_resp.header.packet_type,
+                s_resp.header.transaction_label,
+                s_resp.header.signal_id,
+                s_resp.header.rfa0);
         
         memset(&open_stream, 0, sizeof(open_stream));
         init_request(&open_stream.header, AVDTP_OPEN);
@@ -336,8 +348,8 @@
 
         *psm = 25;
         return 0;
-
 }
+
 // Detect whether A2DP Sink is present at the destination or not
 int detect_a2dp(bdaddr_t *src, bdaddr_t *dst, unsigned short *psm, unsigned long *flags)
 {
@@ -568,35 +580,17 @@
         // SONORIX sends us a discover signal we should answer but we will discard
         while(tries<10)
         {
-                size = read(cmdfd, &discover_resp, sizeof(discover_resp));
-                tries++;
+                size=a2dp_handle_avdtp_message(NULL, cmdfd, &discover_req.header, &discover_resp.header, sizeof(discover_resp));
                 if(size>0)
                 {
-                        if((discover_resp.header.message_type == MESSAGE_TYPE_ACCEPT)
-                         &&(discover_resp.header.signal_id == AVDTP_DISCOVER)
-                          )
-                        {
-                                break;
-                        }
-                        else
-                        {
-                                DBG("Invalid response read, rejected...");
-                                if(discover_resp.header.message_type == MESSAGE_TYPE_COMMAND)
-                                {
-                                        discover_resp.header.message_type = MESSAGE_TYPE_REJECT;
-                                        write(cmdfd, &discover_resp, sizeof(discover_resp.header));
-                                }
-                                
-                                DBG("retrying discover response read...");
-                                // Discard what is not an answer
-                                usleep(100);
-                        }
+                        // Answer to what we send
+                        break;
                 }
                 else
                 {
-                        DBG("retrying discover response read...");
-                        // Discard what is not an answer
+                        // Not answer
                         usleep(100);
+                        tries++;
                 }
         }
 
@@ -671,6 +665,7 @@
 
         DBG("Got start stream confirm");
 
+        *omtu = A2DPMAXIMUMTRANSFERUNITSIZE; //mtu;
         *seid_return = seid;
         *cmdfd_return = cmdfd;
         return streamfd;
@@ -718,8 +713,10 @@
         if(a2dp==0 || pcm_buffer==0 || pcm_buffer_size==0) return EINVAL;
 
         // How much data can be encoded by sbc at a time?
-        codesize=a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.channels*2;
         // 16 bits * 2 channels * 16 blocks * 8 subbands = 4096bits = 512 o
+        codesize=a2dp->sbc.subbands*a2dp->sbc.blocks*a2dp->sbc.channels*2;
+        // 44 bitpool?
+        //codesize=a2dp->sbc.bitpool*a2dp->sbc.subbands*a2dp->sbc.blocks/8;
         datatoread=min(codesize,pcm_buffer_size);
 
         // Enqueue data in bufe
@@ -757,21 +754,51 @@
                         payload_header.frame_count=a2dp->frame_count;
                         packet_header.v = 2;
                         packet_header.pt = 1;
+                        packet_header.cc = 0;
                         packet_header.sequence_number = htons(a2dp->seq_num);
                         packet_header.timestamp = htonl(a2dp->timestamp);
                         packet_header.ssrc = htonl(1);
-                        a2dp->timestamp += (a2dp->sbc.blocks + 1)*4 * (a2dp->sbc.subbands + 1)*4;
+
+                        a2dp->timestamp += (a2dp->sbc.blocks+1)*4 * (a2dp->sbc.subbands+1)*4;
                         memcpy(a2dp->buf, &packet_header, sizeof(packet_header));
                         memcpy(a2dp->buf + sizeof(packet_header), &payload_header, sizeof(payload_header));
-                        // Send our data
-                        if((written = write(a2dp->sk,a2dp->buf,a2dp->len)) != a2dp->len)
+                        if(a2dp->sk>0)
                         {
-                                // Error while sending data
-                                DBG("Wrote %d not %d bytes; (errno=%d:%s)", written, a2dp->len, errno,
-                                        strerror(errno));
-                                result = written;
+                                // Check if data are to be read
+                                // Not seen a device showing this yet
+                                fd_set readfds;
+                                struct timeval zero_timeout = {0,0};
+                                FD_ZERO(&readfds);
+                                FD_SET(a2dp->sk, &readfds);
+                                int iselect=select(1, &readfds, NULL, NULL, &zero_timeout);
+                                if(iselect>0)
+                                {
+                                        if(FD_ISSET(a2dp->sk, &readfds))
+                                        {
+                                                a2dp_handle_avdtp_message(a2dp, a2dp->sk, NULL, NULL, 0);
+                                        }
+                                }
+                                // Pause?
+                                // The value 0 have never been tested
+                                // However, we may safely simulate a failed write
+                                if(!a2dp->pause_writing)
+                                {
+                                        // Send our data
+                                        if((written = write(a2dp->sk,a2dp->buf,a2dp->len)) != a2dp->len)
+                                        {
+                                                // Error while sending data
+                                                DBG("Wrote %d not %d bytes; (errno=%d:%s)", written, a2dp->len, errno,
+                                                        strerror(errno));
+                                                result = written;
+                                        }
+                                        result = written;
+                                }
+                                else
+                                {
+                                        // Make the upper layer believe we sent data
+                                        result = a2dp->len;
+                                }
                         }
-                        result = written;
 
                         // Reset buffer of data to send
                         a2dp->len = sizeof(struct media_packet_header)+sizeof(struct media_payload_header);
@@ -804,45 +831,55 @@
 {
         snd_pcm_a2dp_t* a2dp = (snd_pcm_a2dp_t*)param;
 
-        DBG("Listen thread running\n");
+        if(a2dp->control_sk<0) return NULL;
+
+        DBG("Listen thread running [control_sk=%d]", a2dp->control_sk);
 
         // Set a timeout to close thread
-        struct timeval t = { 5, 0 };
+        struct timeval t = { 1, 0 };
         setsockopt( a2dp->control_sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
         setsockopt( a2dp->control_sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
 
         // Loop until end of writing
         while(!a2dp->stop_writing)
         {
-                struct stream_cmd cmd;
-                int size = read(a2dp->control_sk, &cmd, sizeof(cmd));
-                if(size == sizeof(cmd))
+                char szBuffer[A2DPMAXIMUMTRANSFERUNITSIZE];
+                struct stream_cmd* cmd = (struct stream_cmd*)szBuffer;
+                if(a2dp_handle_avdtp_message(a2dp, a2dp->control_sk, NULL, NULL, 0)<0)
                 {
-                        DBG("Received signal %d from set\n", cmd.header.signal_id);
-                        if(cmd.header.signal_id == AVDTP_SUSPEND)
+                        // Error
+                        usleep(100*1000);
+                }
+
+                int size = read(a2dp->control_sk, szBuffer, sizeof(szBuffer));
+                if(size>0)
+                {
+                        if(cmd->header.signal_id == AVDTP_SUSPEND)
                         {
+                                DBG("Received signal AVDTP_SUSPEND(%d) from set", cmd->header.signal_id);
                                 a2dp->pause_writing = 1;
                         }
-                        else if(cmd.header.signal_id == AVDTP_START)
+                        else if(cmd->header.signal_id == AVDTP_START)
                         {
+                                DBG("Received signal AVDTP_START(%d) from set", cmd->header.signal_id);
                                 a2dp->pause_writing = 0;
                         }
                         else
                         {
-                                DBG("Unexpected headset directive %d\n", cmd.header.signal_id);
+                                DBG("Unexpected headset directive %d", cmd->header.signal_id);
                         }
                         // ack the command regardless
-                        // take a shortcut and reuse the command struct (knock one byte off length)
-                        init_response(&cmd.header, MESSAGE_TYPE_ACCEPT);
+                        //FIXME take a shortcut and reuse the command struct (knock one byte off length)
+                        init_response(&cmd->header, MESSAGE_TYPE_ACCEPT);
                         if (write(a2dp->control_sk, &cmd, sizeof(cmd)-1) != sizeof(cmd)-1)
                         {
-                                DBG("Couldn't ack %d\n", cmd.header.signal_id);
+                                DBG("Couldn't ack %d", cmd->header.signal_id);
                         }
                 }
                 else
                 {
                         if(errno!=EAGAIN)
-                                DBG("Error while receiving %d (errno=%d:%s)\n", size, errno, strerror(errno));
+                                DBG("Error while receiving %d (errno=%d:%s)", size, errno, strerror(errno));
                         if(errno!=EINTR)
                                 break;
                 }
@@ -928,8 +965,20 @@
         a2dp->seq_num = 1;
         a2dp->mtu = A2DPMAXIMUMTRANSFERUNITSIZE;
         a2dp->len = sizeof(struct media_packet_header)+sizeof(struct media_payload_header);
-        sbc_init(&a2dp->sbc, 0L);
 
+        sbc_init(&a2dp->sbc, 0L);
+/*
+        a2dp->sbc.channels = 2;
+        */
+        a2dp->sbc.rate = A2DPD_FRAME_RATE;
+        /*
+        a2dp->sbc.joint = 0;
+        a2dp->sbc.subbands = 8; // safe default
+        a2dp->sbc.blocks = 16; // safe default
+        */
+        a2dp->sbc.subbands = 8; // safe default
+        a2dp->sbc.blocks = 16; // safe default
+        a2dp->sbc.bitpool = 32; // recommended value 53, safe default is 32
         return a2dp;
 }
 
@@ -1024,9 +1073,13 @@
 
         init_request(&close_stream.header, AVDTP_CLOSE);
         close_stream.acp_seid = a2dp->seid;
-        if (write(a2dp->control_sk, &close_stream, sizeof(close_stream)) != sizeof(close_stream))
+        // Use control_sk if it is needed
+        if((a2dp->control_sk>0 && (write(a2dp->control_sk, &close_stream, sizeof(close_stream)) != sizeof(close_stream)))
+        // Else use sk
+        || (write(a2dp->sk, &close_stream, sizeof(close_stream)) != sizeof(close_stream))
+          )
         {
-                DBG("Couldn't send close_stream (errno=%d:%s)\n", errno, strerror(errno));
+                DBG("Couldn't send close_stream (errno=%d:%s)", errno, strerror(errno));
         }
 
         a2dp_free(a2dp);
@@ -1035,7 +1088,6 @@
 
 int a2dp_make_listen_socket(unsigned short psm)
 {
-        DBG("Begin");
         char* lpszError = NULL;
         int sockfd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
         
@@ -1089,7 +1141,7 @@
 
         if(lpszError)
         {
-                DBG("%s %s(%d)\n", lpszError, strerror(errno), errno);
+                DBG("%s %s(%d)", lpszError, strerror(errno), errno);
                 close(sockfd);
                 sockfd=-1;
         }
@@ -1102,9 +1154,14 @@
         // Wait client connection
         struct sockaddr_l2 addr;
         socklen_t addrlen = sizeof(addr);
+
+        // Timeouts each second to read variables
+        struct timeval t = { 1, 0 };
+        setsockopt( sockfd, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
+        setsockopt( sockfd, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
         int new_fd = accept(sockfd, (struct sockaddr *) &addr, &addrlen);
 
-        DBG("Begin");
         if (szRemote) *szRemote='\0';
 
         if(new_fd >= 0)
@@ -1121,7 +1178,7 @@
                         if (!(*mtu))
                                 *mtu=A2DPMAXIMUMTRANSFERUNITSIZE;
                 }
-                DBG("Connected [imtu %d, omtu %d, flush_to %d]\n", opts.imtu, opts.omtu, opts.flush_to);
+                //DBG("Connected [imtu %d, omtu %d, flush_to %d]", opts.imtu, opts.omtu, opts.flush_to);
 
                 if (szRemote) 
                 {
@@ -1131,3 +1188,83 @@
         }
         return new_fd;
 }
+
+// This function handle the bluetooth connection
+int a2dp_handle_avdtp_message(LPA2DP a2dp, int sockfd, struct avdtp_header* sent_packet, struct avdtp_header* answer, int answer_size)
+{
+        int result = 0;
+        
+        char lpFrame [A2DPMAXIMUMTRANSFERUNITSIZE];
+        int iReceived = recv(sockfd, lpFrame, sizeof(lpFrame), 0);
+        struct avdtp_header* pkt_hdr = (struct avdtp_header*)lpFrame;
+        if(iReceived>0)
+        {
+                // Manage the packet
+                if(sent_packet==NULL)
+                {
+                        int i;
+                        printf("socket %d: Received %d bytes\n", sockfd, iReceived);
+                        for(i = 0; i<iReceived; i++)
+                        {
+                                char c=lpFrame[i];
+                                if(i%16==0) printf("%05d: ", i);
+                                printf("%02x ", c);
+                                if(i%16==15) printf("\n");
+                        }
+                        printf("\n");
+                        result=0;
+                }
+                else if((pkt_hdr->message_type == MESSAGE_TYPE_ACCEPT)                               &&(pkt_hdr->signal_id == sent_packet->signal_id)
+                )
+                {
+                        // Got expected answer
+                        memcpy(answer, lpFrame, answer_size>iReceived?answer_size:iReceived);
+                        result=iReceived;
+                }
+                else
+                {
+                        // Got bad answer
+                        result=0;
+                }
+
+                // Reply to the packet by rejecting it
+                if(pkt_hdr->message_type == MESSAGE_TYPE_COMMAND)
+                {
+                        int accepted = 0;
+                        if(a2dp && pkt_hdr->signal_id == AVDTP_SUSPEND)
+                        {
+                                DBG("Received signal AVDTP_SUSPEND(%d) from set", pkt_hdr->signal_id);
+                                a2dp->pause_writing = 1;
+                                accepted=1;
+                        }
+                        else if(a2dp && pkt_hdr->signal_id == AVDTP_START)
+                        {
+                                DBG("Received signal AVDTP_START(%d) from set", pkt_hdr->signal_id);
+                                a2dp->pause_writing = 0;
+                                accepted=1;
+                        }
+                        else
+                        {
+                                DBG("Unexpected headset directive %d", pkt_hdr->signal_id);
+                        }
+
+                        DBG("Answering command packet (msgtype=%s,signal=%d)", accepted?"MESSAGE_TYPE_ACCEPT":"MESSAGE_TYPE_REJECT", pkt_hdr->signal_id);
+                        // Reject a command received
+                        pkt_hdr->message_type = accepted?MESSAGE_TYPE_ACCEPT:MESSAGE_TYPE_REJECT;
+                        write(sockfd, pkt_hdr, sizeof(*pkt_hdr));
+                }
+                else
+                {
+                        DBG("Read non command packet (msgtype=%d,signal=%d)", pkt_hdr->message_type, pkt_hdr->signal_id);
+                }
+        }
+        else
+        {
+                result=iReceived;
+                if(errno!=EAGAIN)
+                        printf("socket %d: Receive failed %d (error %d:%s)\n", sockfd, iReceived, errno, strerror(errno));
+        }
+
+        return result;
+}
+
Index: alsa-plugins/a2dplib.h
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dplib.h,v
retrieving revision 1.2
diff -u -r1.2 a2dplib.h
--- alsa-plugins/a2dplib.h	28 Jul 2006 21:34:48 -0000	1.2
+++ alsa-plugins/a2dplib.h	4 Aug 2006 14:52:08 -0000
@@ -28,8 +28,17 @@
 #include <config.h>
 #endif
 
+#include "../a2dp.h"
 #include <stdio.h>
 
+#define A2DPMAXIMUMTRANSFERUNITSIZE 610
+
+
+// To send one L2CAP packets of 678 bytes, 4 ACL packets are sent, 3 are 192 bytes long, 
+// 1 contains 49 bytes  => loss 192-49/4
+// To send one L2CAP packets of 610 bytes, 3 ACL packets are sent, 2 are 192 bytes long, 
+// 1 contains 165 bytes => loss 192-165/3
+
 typedef struct snd_pcm_a2dp* LPA2DP;
 
 // Global library initialisation
@@ -47,4 +56,9 @@
 int a2dp_make_listen_socket( unsigned short psm);
 int a2dp_wait_connection( int sockfd, char* szRemote, int iRemoteSize, uint16_t *mtu);
 
+// Returns 0 on receiving bad frame
+// Returns negative on error
+// Size of received frame on success
+int a2dp_handle_avdtp_message( LPA2DP a2dp, int sockfd, struct avdtp_header* sent_packet, struct avdtp_header* answer, int answer_size);
+
 #endif
Index: alsa-plugins/pcm_a2dpd.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/pcm_a2dpd.c,v
retrieving revision 1.2
diff -u -r1.2 pcm_a2dpd.c
--- alsa-plugins/pcm_a2dpd.c	28 Jul 2006 21:34:48 -0000	1.2
+++ alsa-plugins/pcm_a2dpd.c	4 Aug 2006 14:52:08 -0000
@@ -60,7 +60,8 @@
         return;
 }
 
-typedef struct snd_pcm_a2dp {
+typedef struct snd_pcm_a2dp
+{
         snd_pcm_ioplug_t io;
         int sk;
         int rate;

--------------080805060104000500030609
Content-Type: text/plain;
 name=".a2dprc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".a2dprc"

[a2dpd]
address=00:0D:44:2A:17:C7
cmdplay=xmms --play
cmdpause=xmms --pause
cmdprev=xmms --rew
cmdnext=xmms --fwd
cmdnew=xmms --play


--------------080805060104000500030609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------080805060104000500030609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------080805060104000500030609--
