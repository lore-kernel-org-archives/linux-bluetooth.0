Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4550B23D.8090706@palmsource.com>
Date: Tue, 07 Nov 2006 17:20:13 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------000503060805030604010400"
Subject: [Bluez-devel] [patch]
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
--------------000503060805030604010400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi brad,

Attached is my latest patch from a2dp,
It features :
- tests for an integrated resampler mainly if you don't have alsa,
- better plugin that will finally let alsa do all the resampling which 
gives the best quality and should work with any incoming stream.
- removed the realtime priority (could lock computer if spinning)
- Some A2DP protocol mods (AVDTP_START and AVDTP_STOP handled and 
AVDTP_CLOSE)
- Longer connection timeout

Certainly other things that I don't remember!

BR, Frederic


--------------000503060805030604010400
Content-Type: text/x-patch;
 name="patch_btsco_resample.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_btsco_resample.patch"

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
? alsa-plugins/headsetd/.deps
? alsa-plugins/headsetd/.libs
? alsa-plugins/headsetd/Makefile
? alsa-plugins/headsetd/Makefile.in
? alsa-plugins/headsetd/headsetd
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
Index: a2dp.h
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/a2dp.h,v
retrieving revision 1.10
diff -u -r1.10 a2dp.h
--- a2dp.h	5 Aug 2006 20:55:11 -0000	1.10
+++ a2dp.h	7 Nov 2006 15:41:23 -0000
@@ -220,10 +220,14 @@
 #define AVDTP_DISCOVER 1
 #define AVDTP_GET_CAPABILITIES 2
 #define AVDTP_SET_CONFIGURATION 3
+#define AVDTP_GET_CONFIGURATION 4
+#define AVDTP_RECONFIGURE 5
 #define AVDTP_OPEN 6
 #define AVDTP_START 7
 #define AVDTP_CLOSE 8
 #define AVDTP_SUSPEND 9
+#define AVDTP_ABORT 0xA
+#define AVDTP_SECURITY_CONTROL 0xB
 
 #define MEDIA_TRANSPORT_CATEGORY 1
 #define MEDIA_CODEC 7
Index: alsa-plugins/Makefile.am
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/Makefile.am,v
retrieving revision 1.9
diff -u -r1.9 Makefile.am
--- alsa-plugins/Makefile.am	26 Oct 2006 16:21:39 -0000	1.9
+++ alsa-plugins/Makefile.am	7 Nov 2006 15:41:23 -0000
@@ -27,7 +27,7 @@
 libasound_module_ctl_sco_la_LIBADD = @ALSA_LIBS@
 
 bin_PROGRAMS = a2dpd
-a2dpd_SOURCES = a2dpd.c a2dplib.c alsalib.c
+a2dpd_SOURCES = a2dpd.c a2dplib.c alsalib.c resample.c
 a2dpd_CFLAGS = $(AM_CFLAGS)
 #a2dp_timer.c a2dp_ipc.c
 a2dpd_LDADD = a2dp_timer.o a2dp_ipc.o @ALSA_LIBS@ @BLUEZ_LIBS@ -lsbc -lpthread -lrt
Index: alsa-plugins/a2dp_ipc.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dp_ipc.c,v
retrieving revision 1.4
diff -u -r1.4 a2dp_ipc.c
--- alsa-plugins/a2dp_ipc.c	6 Sep 2006 02:59:43 -0000	1.4
+++ alsa-plugins/a2dp_ipc.c	7 Nov 2006 15:41:23 -0000
@@ -100,6 +100,8 @@
 
         if(sockfd>0)
         {
+        	int on = 1;
+        	setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
                 if(bind(sockfd, (struct sockaddr *)&my_addr, sizeof(struct sockaddr))==0)
                 {
                         if(listen(sockfd, 0)==0)
@@ -223,6 +225,7 @@
 {
         int found=0, error=0;
         FILE* hFile = fopen(filename, "rt");
+	returnbuffer[0] = 0;
         //printf("read_config_string: reading %s\n", filename);
         if(hFile)
         {
@@ -285,7 +288,7 @@
                 strncpy(returnbuffer, defvalue, buffersize);
                 returnbuffer[buffersize-1]=0;
         }
-        syslog(LOG_INFO, "%s [%s] '%s'='%s'", __FUNCTION__, section, key, returnbuffer);
+        //syslog(LOG_INFO, "%s [%s] '%s'='%s'", __FUNCTION__, section, key, returnbuffer);
 }
 
 int read_config_int(char* filename, char* section, char* key, int defvalue)
Index: alsa-plugins/a2dpd.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd.c,v
retrieving revision 1.9
diff -u -r1.9 a2dpd.c
--- alsa-plugins/a2dpd.c	22 Sep 2006 17:34:38 -0000	1.9
+++ alsa-plugins/a2dpd.c	7 Nov 2006 15:41:24 -0000
@@ -42,15 +42,15 @@
 #include "a2dp_timer.h"
 #include "a2dp_ipc.h"
 #include "../avrcp.h"
+#include "resample.h"
 
-#define BLUETOOTHSOUNDFIFOSIZE (16*1024)
-#define MAXBLUETOOTHDEVICES    3
-#define MAXCLIENTSPERDEVICE    8
-#define MAXCLIENTSRINGSIZE     64
-#define POOLENTRYSIZE          A2DPD_BLOCK_SIZE
+#define MAXBLUETOOTHDEVICES    (3)
+#define MAXCLIENTSPERDEVICE    (8)
+#define MAXCLIENTSRINGSIZE     (32)
+#define POOLENTRYSIZE          (A2DPD_BLOCK_SIZE)
 #define PIDFILE                "/var/run/a2dp.pid"
 #define UINPUT_DEVICE          "/dev/input/uinput"
-#define A2DPD_CONFIG_FILE       ".a2dpdrc"
+#define A2DPD_CONFIG_FILE      ".a2dpdrc"
 
 static char g_sOutputFilename[512];
 static char g_srcfilename[512];
@@ -65,6 +65,55 @@
 static int g_brereadconfig = 0;
 static int g_breversestereo = 0;
 
+#define CHECKVAL ((uint32_t)0xFDFDFDFD)
+
+void* mymalloc(int size)
+{
+	char* buffer = malloc(size+8);
+	
+	if(buffer)
+	{
+		*((uint32_t*)buffer) = ((uint32_t)size);
+		buffer+=4;
+		*((uint32_t*)(buffer+size)) = CHECKVAL;
+	}
+	return buffer;
+}
+
+void myfree(void* p, int line)
+{
+	char* buffer = p;
+	if(buffer)
+	{
+		uint32_t size  = *((uint32_t*)(buffer-4));
+		uint32_t check = *((uint32_t*)(buffer+size));
+		if(check != CHECKVAL || size>2048)
+			printf("buffer overflow line %d (size=%d check=%X)\n", line, size, check);
+		buffer-=4;
+		free(buffer);
+	}
+}
+
+int checkbuffer__(void* p, int line)
+{
+	int result = 0;
+	char* buffer = p;
+	if(buffer)
+	{
+		uint32_t size  = *((uint32_t*)(buffer-4));
+		uint32_t check = *((uint32_t*)(buffer+size));
+		if(check != CHECKVAL || size>2048)
+		{
+			printf("buffer failed check line %d (size=%d check=%X)\n", line, size, check);
+			result = 1;
+		}
+	}
+	return result;
+}
+
+#define safefree(buf) do { if(buf) { myfree(buf, __LINE__); (buf) = NULL; } } while (0)
+#define checkbuffer(buf) checkbuffer__(buf, __LINE__)
+
 // This function is needed to destroy zombies processes
 // On Unix, any forked process which terminate before its parent create a zombie until parent call waitpid()
 // We do not want to wait as we just need to "fire and forget" processes
@@ -110,7 +159,7 @@
 			if (fd > 2)
 				(void) close(fd);
 		} else {
-			printf("a2dpd: Couldn't redirect output to '%s' (errno=%d:%s)", output_file_name, errno, strerror(errno));
+			perror("a2dpd: Couldn't redirect output");
 		}
 	}
 
@@ -142,15 +191,14 @@
 	header->packet_type = PACKET_TYPE_SINGLE;
 }
 
-
 static int init_uinput()
 {
 	int fd, i;
 	struct uinput_user_dev dev = {
 		.id = {
-		       .bustype = BUS_BLUETOOTH,
-		       .version = 0x0001,
-		       }
+		.bustype = BUS_BLUETOOTH,
+		.version = 0x0001,
+		}
 	};
 
 	if ((fd = open(UINPUT_DEVICE, O_WRONLY)) < 0) {
@@ -175,9 +223,9 @@
 	uinput_fd = fd;
 
 	return 0;
-      release:
+release:
 	ioctl(fd, UI_DEV_DESTROY);
-      shutdown:
+shutdown:
 	close(fd);
 	return 1;
 }
@@ -274,7 +322,7 @@
 		}
 	} else {
 		if (errno != EAGAIN)
-			printf("socket %d: Receive failed %d (error %d:%s)\n", sockfd, iReceived, errno, strerror(errno));
+			perror("AVRCP Receive failed");
 	}
 
 	return iReceived;
@@ -294,24 +342,27 @@
 
 #define max(x,y) ((x)>(y)?(x):(y))
 
-char *pool_pop()
-{
-	return malloc(POOLENTRYSIZE);
-}
+// Data used to mix audio
+typedef struct {
+	void* lpVoid;
+	uint32_t index_to_construct;
+	uint32_t index_0;
+	uint32_t size;
+} CONVERTBUFFER;
 
-void pool_push(char *pool)
-{
-	free(pool);
-}
+typedef struct {
+	int len;
+	char* buf;
+} RINGINFO;
 
 // Data used to mix audio
 typedef struct {
 	int lives;
 	pthread_mutex_t mutex;
+	CONVERTBUFFER conv;
 	int ring_in;
 	int ring_out;
-	int ring_len[MAXCLIENTSRINGSIZE];
-	char *ring[MAXCLIENTSRINGSIZE];
+	RINGINFO ring[MAXCLIENTSRINGSIZE];
 } BTA2DPPERCLIENTDATA;
 
 // Data to keep per Bluetooth device
@@ -324,6 +375,10 @@
 	AUDIOMIXERDATA mixer;
 	int nb_clients;
 	int bredirectalsa;
+	int a2dp_rate;
+	int a2dp_channels;
+	int a2dp_bitspersample;
+	int sbcbitpool;
 	BTA2DPPERCLIENTDATA clients[MAXCLIENTSPERDEVICE];
 } BTA2DPPERDEVICEDATA, *LPBTA2DPPERDEVICEDATA;
 
@@ -338,7 +393,7 @@
 LPBTA2DPPERDEVICEDATA bta2dpdevicenew(char *addr)
 {
 	int i = 0;
-	LPBTA2DPPERDEVICEDATA lpDevice = malloc(sizeof(BTA2DPPERDEVICEDATA));
+	LPBTA2DPPERDEVICEDATA lpDevice = mymalloc(sizeof(BTA2DPPERDEVICEDATA));
 	if (lpDevice) {
 		memset(lpDevice, 0, sizeof(BTA2DPPERDEVICEDATA));
 		strncpy(lpDevice->addr, addr, sizeof(lpDevice->addr));
@@ -364,7 +419,7 @@
 			pthread_mutex_destroy(&lpDevice->clients[i].mutex);
 		}
 		pthread_mutex_destroy(&lpDevice->mutex);
-		free(lpDevice);
+		safefree(lpDevice);
 	}
 }
 
@@ -385,141 +440,437 @@
 	}
 }
 
-// This function handles a client
-void *client_handler(void *param)
+// This function append data received from a client to the device ring buffer
+void append_to_ring_buffer(BTA2DPPERCLIENTDATA* lpClientData, CONVERTBUFFER* lpConvert)
 {
-	int bError = 0;
-	int client_index = -1;
-	int32_t client_type = INVALID_CLIENT_TYPE;
-	int result;
-	LPA2DPDCLIENT lpClient = (LPA2DPDCLIENT) param;
-	AUDIOMIXERDATA AudioMixerData = INVALIDAUDIOMIXERDATA;
+	if(lpConvert->lpVoid != NULL) {
+		// Enqueue in bluetooth headset if we can else loose packet
+		pthread_mutex_lock(&lpClientData->mutex);
+	
+		// Append data to ring
+		int this_ring = lpClientData->ring_in;
+		int next_ring = ((this_ring + 1) % MAXCLIENTSRINGSIZE);
+
+		if (next_ring != lpClientData->ring_out) {
+			lpClientData->ring[this_ring].buf = lpConvert->lpVoid;
+			lpClientData->ring[this_ring].len = lpConvert->size;
+			lpClientData->ring_in = next_ring;
+			// We will not free that buffer, it's the bthandler thread which will do it
+			lpConvert->lpVoid = NULL;
+			lpConvert->size = 0;
+			lpConvert->index_to_construct = 0;
+			lpConvert->index_0 = 0;
+		}
 
-	// We should not terminate the process if clients are still running
-	iThreadsRunning++;
+		pthread_mutex_unlock(&lpClientData->mutex);
+	}
+	// Reintegrate data in pool if not transmitted via bthandler thread
+	safefree(lpConvert->lpVoid);
+}
 
-	pthread_detach(lpClient->thread);
+// Convert individual sample
+void convert_sample(AUDIOSTREAMINFOS* lpStreamInfos, void* lpSample, void* lpConvertedSample, BTA2DPPERDEVICEDATA* lpDevice)
+{
+	// Signed 32bits pivot
+	int32_t channel_1=0;
+	int32_t channel_2=0;
+	// Convert to pivot format
+	if(lpStreamInfos->channels==1) {
+		if(lpStreamInfos->format==A2DPD_PCM_FORMAT_S8) {
+			channel_1 = (*(((int8_t*)lpSample)+0))*256;
+			channel_2 = (*(((int8_t*)lpSample)+0))*256;
+		} else if(lpStreamInfos->format==A2DPD_PCM_FORMAT_U8) {
+			channel_1 = ((*(((int8_t*)lpSample)+0))-(int)128)*256;
+			channel_2 = ((*(((int8_t*)lpSample)+0))-(int)128)*256;
+		} else if(lpStreamInfos->format==A2DPD_PCM_FORMAT_S16_LE) {
+			channel_1 = *(((int16_t*)lpSample)+0);
+			channel_2 = *(((int16_t*)lpSample)+0);
+		}
+	} else if(lpStreamInfos->channels==2) {
+		if(lpStreamInfos->format==A2DPD_PCM_FORMAT_S8) {
+			channel_1 = (*(((int8_t*)lpSample)+0))*256;
+			channel_2 = (*(((int8_t*)lpSample)+1))*256;
+		} else if(lpStreamInfos->format==A2DPD_PCM_FORMAT_U8) {
+			channel_1 = ((*(((int8_t*)lpSample)+0))-(int)128)*256;
+			channel_2 = ((*(((int8_t*)lpSample)+1))-(int)128)*256;
+		} else if(lpStreamInfos->format==A2DPD_PCM_FORMAT_S16_LE) {
+			channel_1 = *(((int16_t*)lpSample)+0);
+			channel_2 = *(((int16_t*)lpSample)+1);
+		}
+	} else {
+		if(lpStreamInfos->format==A2DPD_PCM_FORMAT_S8) {
+			channel_1 = (*(((int8_t*)lpSample)+0))*256;
+			channel_2 = (*(((int8_t*)lpSample)+1))*256;
+		} else if(lpStreamInfos->format==A2DPD_PCM_FORMAT_U8) {
+			channel_1 = ((*(((int8_t*)lpSample)+0))-(int)128)*256;
+			channel_2 = ((*(((int8_t*)lpSample)+1))-(int)128)*256;
+		} else if(lpStreamInfos->format==A2DPD_PCM_FORMAT_S16_LE) {
+			channel_1 = *(((int16_t*)lpSample)+0);
+			channel_2 = *(((int16_t*)lpSample)+1);
+		}
+	}
 
-	setup_socket(lpClient->sockfd);
+	// Convert to destination format
+	if(lpDevice->a2dp_channels==1) {
+		if(lpDevice->a2dp_bitspersample==1) {
+			*(int8_t*)lpConvertedSample=(channel_1+channel_2)/(2*256);
+		} else if(lpDevice->a2dp_bitspersample==2) {
+			*(int16_t*)lpConvertedSample=(channel_1+channel_2)/(2);
+		}
+	} else if(lpDevice->a2dp_channels==2) {
+		if(lpDevice->a2dp_bitspersample==1) {
+			*(((int8_t*)lpConvertedSample)+0)=channel_1/256;
+			*(((int8_t*)lpConvertedSample)+1)=channel_2/256;
+		} else if(lpDevice->a2dp_bitspersample==2) {
+			*(((int16_t*)lpConvertedSample)+0)=channel_1;
+			*(((int16_t*)lpConvertedSample)+1)=channel_2;
+		}
+	} else {
+		memset(lpConvertedSample, 0, lpDevice->a2dp_bitspersample*lpDevice->a2dp_channels);
+		if(lpDevice->a2dp_bitspersample==1) {
+			*(((int8_t*)lpConvertedSample)+0)=channel_1/256;
+			*(((int8_t*)lpConvertedSample)+1)=channel_2/256;
+		} else if(lpDevice->a2dp_bitspersample==2) {
+			*(((int16_t*)lpConvertedSample)+0)=channel_1;
+			*(((int16_t*)lpConvertedSample)+1)=channel_2;
+		}
+	}
+}
 
-	// Receive type of client
-	result = recv_socket(lpClient->sockfd, &client_type, sizeof(client_type));
+// This function convert a buffer to sample rate and format needed for device
+void convert_rate(BTA2DPPERDEVICEDATA* lpDevice, BTA2DPPERCLIENTDATA* lpClientData, void* pcm_buffer, int pcm_buffer_size, AUDIOSTREAMINFOS* lpStreamInfos)
+{
+	// We need this structure accross calls
+	CONVERTBUFFER* lpConvert = &lpClientData->conv;
 
-	// This client wants to send us pcm control data
-	if (client_type == A2DPD_PLUGIN_CTL_WRITE) {
-		printf("CTL WRITE thread %d.%d started\n", client_index, lpClient->sockfd);
+	if(lpConvert && lpStreamInfos && lpStreamInfos->bitspersample) {
+		unsigned int pcm_buffer_index = 0;
+		unsigned int pcm_buffer_index_0 = 0;
+		unsigned int pcm_buffer_frame_bytes = (lpStreamInfos->channels*lpStreamInfos->bitspersample);
+		unsigned int pcm_buffer_nframes = pcm_buffer_size/pcm_buffer_frame_bytes;
+		unsigned int rate_multiplier = ((unsigned int)lpStreamInfos->rate)*256 / ((unsigned int)lpDevice->a2dp_rate);
+		unsigned int convert_frame_bytes = (lpDevice->a2dp_channels*lpDevice->a2dp_bitspersample);
+		void* lpConvertedSample = mymalloc(convert_frame_bytes);
+		void* lpSample = NULL;
+		//int i;
+
+		lpConvert->index_0 = lpConvert->index_to_construct;
+		lpConvert->index_to_construct = 0;
+		while(pcm_buffer_index<pcm_buffer_nframes) {
+			// Allocate destination if needed
+			if(lpConvert->lpVoid==NULL) {
+				lpConvert->lpVoid = mymalloc(POOLENTRYSIZE);
+				lpConvert->size = POOLENTRYSIZE;
+				/*
+				for(i=0; i<lpConvert->size; i++)
+				{
+					((char*)lpConvert->lpVoid)[i]=(char)0xFA;
+				}
+				*/
+				lpConvert->index_to_construct = 0;
+				lpConvert->index_0 = 0;
+			}
+
+			// Get pointer to sample to convert
+			lpSample = pcm_buffer+(pcm_buffer_index*pcm_buffer_frame_bytes);
+
+			// Conversion of individual samples
+			convert_sample(lpStreamInfos, lpSample, lpConvertedSample, lpDevice);
+
+			// Append converted sample to constructed blocks, Can be avoided by converting in destination buffer
+			void* lpDest = lpConvert->lpVoid+((lpConvert->index_0+lpConvert->index_to_construct)*convert_frame_bytes);
+			memcpy(lpDest, lpConvertedSample, convert_frame_bytes);
+
+			// Fill next index
+			lpConvert->index_to_construct++;
+
+			// The index to fill will be mapped according to rates
+			pcm_buffer_index = pcm_buffer_index_0 + ((lpConvert->index_to_construct*rate_multiplier)/256);
+
+			// If constructed block is full, enqueue and allocate new
+			if(((lpConvert->index_0+lpConvert->index_to_construct)*convert_frame_bytes)>=lpConvert->size) {
+				/*
+				if(checkbuffer(lpConvert->lpVoid))
+				{
+					printf("Buffer overflow: %d,%d\n", lpConvert->index_0+lpConvert->index_to_construct, POOLENTRYSIZE/convert_frame_bytes);
+				}
+				int state=0;
+				int count=0;
+				int total=0;
+				for(i=0; i<lpConvert->size/2; i+=2) {
+					if(state==0) {
+						//printf("%08X | %08X   %d | %d\n", ((int16_t*)lpConvert->lpVoid)[i], ((int16_t*)lpConvert->lpVoid)[i+1], ((int16_t*)lpConvert->lpVoid)[i], ((int16_t*)lpConvert->lpVoid)[i+1]);
+						if(((int16_t*)lpConvert->lpVoid)[i]==(int16_t)0xFAFA) {
+							state=1;
+							count++;
+							total++;
+						} else {
+							state=0;
+						}
+					} else if(state==1) {
+						if(((int16_t*)lpConvert->lpVoid)[i]==(int16_t)0xFAFA) {
+							count++;
+							total++;
+						} else {
+							//printf("Gap in the data %d,%d\n", count, i);
+							state=0;
+							count=0;
+						}
+					}
+				}
+				if(state==1) {
+					printf("Gap in the data: %d, total=%d\n", count, total);
+				}
+				//exit(0);
+				*/
+
+				// Enqueue in ring buffer
+				append_to_ring_buffer(lpClientData, lpConvert);
 
-		if (recv_socket(lpClient->sockfd, &AudioMixerData, sizeof(AudioMixerData)) == sizeof(AudioMixerData)) {
-			pthread_mutex_lock(&lpClient->lpDevice->mutex);
-			if (AudioMixerData.volume_speaker_left != -1)
-				lpClient->lpDevice->mixer.volume_speaker_left = AudioMixerData.volume_speaker_left;
-			if (AudioMixerData.volume_speaker_left != -1)
-				lpClient->lpDevice->mixer.volume_speaker_right = AudioMixerData.volume_speaker_right;
-			if (AudioMixerData.volume_micro_left != -1)
-				lpClient->lpDevice->mixer.volume_micro_left = AudioMixerData.volume_micro_left;
-			if (AudioMixerData.volume_micro_left != -1)
-				lpClient->lpDevice->mixer.volume_micro_right = AudioMixerData.volume_micro_right;
-			pthread_mutex_unlock(&lpClient->lpDevice->mutex);
-			// Notify other clients
-			int notifyfd = make_udp_socket();
-			int i = send_socket(notifyfd, &AudioMixerData,
-					    sizeof(AudioMixerData));
-			printf("Notify return %d\n", i);
-			close_socket(notifyfd);
+				// Store next index to read
+				pcm_buffer_index_0 = pcm_buffer_index;
+				pcm_buffer_index = pcm_buffer_index_0;
+			}
 		}
+
+		safefree(lpConvertedSample);
 	}
-	// This client wants to read our control status
-	if (client_type == A2DPD_PLUGIN_CTL_READ) {
-		printf("CTL READ thread %d.%d started\n", client_index, lpClient->sockfd);
+}
 
-		pthread_mutex_lock(&lpClient->lpDevice->mutex);
-		AudioMixerData = lpClient->lpDevice->mixer;
-		pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+// This function convert a buffer to sample rate and format needed for device
+void convert_rateX(BTA2DPPERDEVICEDATA* lpDevice, BTA2DPPERCLIENTDATA* lpClientData, void* pcm_buffer, int pcm_buffer_size, AUDIOSTREAMINFOS* lpStreamInfos)
+{
+	// We need this structure accross calls
+	CONVERTBUFFER* lpConvert = &lpClientData->conv;
 
-		send_socket(lpClient->sockfd, &AudioMixerData, sizeof(AudioMixerData));
-	}
-	// This client wants to send us pcm stream
-	if (client_type == A2DPD_PLUGIN_PCM_WRITE) {
-		// Find an index in clients table for the mixer
-		pthread_mutex_lock(&lpClient->lpDevice->mutex);
-		for (client_index = 0; client_index < MAXCLIENTSPERDEVICE; client_index++) {
-			if (lpClient->lpDevice->clients[client_index].lives == 0) {
-				lpClient->lpDevice->clients[client_index].lives = 1;
-				lpClient->lpDevice->clients[client_index].ring_in = 0;
-				lpClient->lpDevice->clients[client_index].ring_out = 0;
-				break;
+	if(lpConvert && lpStreamInfos && lpStreamInfos->bitspersample) {
+		unsigned int pcm_buffer_index = 0;
+//		unsigned int pcm_buffer_index_0 = 0;
+		unsigned int pcm_buffer_frame_bytes = (lpStreamInfos->channels*lpStreamInfos->bitspersample);
+		unsigned int pcm_buffer_nframes = pcm_buffer_size/pcm_buffer_frame_bytes;
+		//unsigned int rate_multiplier = ((unsigned int)lpStreamInfos->rate)*256 / ((unsigned int)lpDevice->a2dp_rate);
+		unsigned int convert_frame_bytes = (lpDevice->a2dp_channels*lpDevice->a2dp_bitspersample);
+		int convert_nframes = POOLENTRYSIZE/convert_frame_bytes;
+		ReSampleContext* ctx = audio_resample_init(lpDevice->a2dp_channels, lpStreamInfos->channels, lpDevice->a2dp_rate, lpStreamInfos->rate);
+
+		// We must convert pcm_buffer
+		while(pcm_buffer_index<pcm_buffer_nframes) {
+			printf("Converting: idx=%d, ctx=%d\n", pcm_buffer_index, lpConvert->index_0);
+			int nframes_to_convert = 0;
+			if(lpConvert->lpVoid==NULL) {
+				lpConvert->size = POOLENTRYSIZE;
+				lpConvert->lpVoid = mymalloc(POOLENTRYSIZE);
+				lpConvert->index_0 = 0;
+				lpConvert->index_to_construct = 0;
 			}
+			#define min(x,y) ((x)<(y)?(x):(y))
+			nframes_to_convert = min((convert_nframes-lpConvert->index_0),(pcm_buffer_nframes*lpDevice->a2dp_rate/lpStreamInfos->rate));
+			nframes_to_convert = nframes_to_convert*lpStreamInfos->rate/lpDevice->a2dp_rate;
+			
+			int converted = audio_resample(ctx, lpConvert->lpVoid+(lpConvert->index_0*convert_frame_bytes), pcm_buffer, nframes_to_convert);
+			printf("Converted: %d frames to %d (%d)\n", nframes_to_convert, converted, (nframes_to_convert*lpDevice->a2dp_rate/lpStreamInfos->rate));
+			lpConvert->index_0 += converted;
+			if(lpConvert->index_0 >= convert_nframes) {
+				append_to_ring_buffer(lpClientData, lpConvert);
+			}
+
+			pcm_buffer_index += nframes_to_convert;
 		}
+
+		audio_resample_close(ctx);
+	}
+}
+
+// This function manage volume change wanted by clients
+void a2dpd_plugin_ctl_write(LPA2DPDCLIENT lpClient)
+{
+	AUDIOMIXERDATA AudioMixerData = INVALIDAUDIOMIXERDATA;
+
+	printf("CTL WRITE thread %d started\n", lpClient->sockfd);
+
+	if (recv_socket(lpClient->sockfd, &AudioMixerData, sizeof(AudioMixerData)) == sizeof(AudioMixerData)) {
+		pthread_mutex_lock(&lpClient->lpDevice->mutex);
+		if (AudioMixerData.volume_speaker_left != -1)
+			lpClient->lpDevice->mixer.volume_speaker_left = AudioMixerData.volume_speaker_left;
+		if (AudioMixerData.volume_speaker_left != -1)
+			lpClient->lpDevice->mixer.volume_speaker_right = AudioMixerData.volume_speaker_right;
+		if (AudioMixerData.volume_micro_left != -1)
+			lpClient->lpDevice->mixer.volume_micro_left = AudioMixerData.volume_micro_left;
+		if (AudioMixerData.volume_micro_left != -1)
+			lpClient->lpDevice->mixer.volume_micro_right = AudioMixerData.volume_micro_right;
 		pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+		// Notify other clients
+		int notifyfd = make_udp_socket();
+		send_socket(notifyfd, &AudioMixerData, sizeof(AudioMixerData));
+		close_socket(notifyfd);
+	}
+}
 
-		printf("PCM thread %d.%d started\n", client_index, lpClient->sockfd);
+// This function manage volume read for client
+void a2dpd_plugin_ctl_read(LPA2DPDCLIENT lpClient)
+{
+	AUDIOMIXERDATA AudioMixerData = INVALIDAUDIOMIXERDATA;
+	printf("CTL READ thread %d started\n", lpClient->sockfd);
+
+	pthread_mutex_lock(&lpClient->lpDevice->mutex);
+	AudioMixerData = lpClient->lpDevice->mixer;
+	pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+
+	send_socket(lpClient->sockfd, &AudioMixerData, sizeof(AudioMixerData));
+}
+
+// This function manage pcm streams sent by clients
+int a2dpd_plugin_pcm_write(LPA2DPDCLIENT lpClient)
+{
+	int client_index = -1;
+	int bError = 0;
+	AUDIOSTREAMINFOS StreamInfos = INVALIDAUDIOSTREAMINFOS;
 
-		if (client_index >= MAXCLIENTSPERDEVICE) {
-			printf("Client thread %d cannot start (too many clients already connected)\n", client_index);
-			return 0;
+	// Find an index in clients table for the mixer
+	pthread_mutex_lock(&lpClient->lpDevice->mutex);
+	for (client_index = 0; client_index < MAXCLIENTSPERDEVICE; client_index++) {
+		if (lpClient->lpDevice->clients[client_index].lives == 0) {
+			// FIXME Not sure this is safe but this is very unlikely to happen
+			lpClient->lpDevice->clients[client_index].lives = 1;
+			lpClient->lpDevice->clients[client_index].ring_in = 0;
+			lpClient->lpDevice->clients[client_index].ring_out = 0;
+			break;
 		}
+	}
+
+	pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+
+	if (client_index >= MAXCLIENTSPERDEVICE) {
+		perror("Too many clients");
+		return 0;
+	}
+
+	if(recv_socket(lpClient->sockfd, &StreamInfos, sizeof(StreamInfos))==sizeof(StreamInfos))
+	{
+		printf("PCM thread %d.%d started (%d Hz, %d channels, %d bits)\n", client_index, lpClient->sockfd, StreamInfos.rate, StreamInfos.channels, StreamInfos.bitspersample*8);
+
 		// Loop while we receive data
 		while (!bSigINTReceived && !bError) {
 			// Receive data
 			int32_t pcm_buffer_size = 0;
-			result = recv_socket(lpClient->sockfd, &pcm_buffer_size, sizeof(pcm_buffer_size));
-			if (result == sizeof(pcm_buffer_size)
-			    && pcm_buffer_size <= POOLENTRYSIZE) {
-				char *pcm_buffer = pool_pop();
-				result = recv_socket(lpClient->sockfd, pcm_buffer, pcm_buffer_size);
-
-				if (result == pcm_buffer_size) {
-					// Enqueue in bluetooth headset if we can else loose packet
-					pthread_mutex_lock(&lpClient->lpDevice->clients[client_index].mutex);
-
-					// Append data to ring
-					int this_ring = lpClient->lpDevice->clients[client_index].ring_in;
-					int next_ring = ((this_ring + 1) % MAXCLIENTSRINGSIZE);
-
-					if (next_ring != lpClient->lpDevice->clients[client_index].ring_out) {
-						lpClient->lpDevice->clients[client_index].ring[this_ring] = pcm_buffer;
-						lpClient->lpDevice->clients[client_index].ring_len[this_ring] = pcm_buffer_size;
-						lpClient->lpDevice->clients[client_index].ring_in = next_ring;
-						// We will not free that buffer, it's the bthandler thread which will do it
-						pcm_buffer = NULL;
+			int result = recv_socket(lpClient->sockfd, &pcm_buffer_size, sizeof(pcm_buffer_size));
+			if (result == sizeof(pcm_buffer_size) && pcm_buffer_size <= A2DPD_BLOCK_SIZE) {
+				char *pcm_buffer = mymalloc(pcm_buffer_size);
+				if(pcm_buffer) {
+					/*
+					int i;
+					for(i = 0; i<pcm_buffer_size; i++)
+					{
+						pcm_buffer[i]=0xFB;
 					}
-
-					pthread_mutex_unlock(&lpClient->lpDevice->clients[client_index].mutex);
-
-					// Reintegrate data in pool
-					if (pcm_buffer)
-						pool_push(pcm_buffer);
+					*/
+					result = recv_socket(lpClient->sockfd, pcm_buffer, pcm_buffer_size);
+					if (result <= pcm_buffer_size) {
+						// Rate conversion
+						convert_rate(lpClient->lpDevice, &lpClient->lpDevice->clients[client_index], pcm_buffer, result, &StreamInfos);
+					} else {
+						perror("Receiving failed on socket");
+						bError = 1;
+					}
+					/*
+					int state=0;
+					int count=0;
+					int total=0;
+					
+					for(i=0; i<pcm_buffer_size/2; i+=2) {
+						if(state==0) {
+							//printf("%08X | %08X   %d | %d\n", ((int16_t*)lpConvert->lpVoid)[i], ((int16_t*)lpConvert->lpVoid)[i+1], ((int16_t*)lpConvert->lpVoid)[i], ((int16_t*)lpConvert->lpVoid)[i+1]);
+							if(((int16_t*)pcm_buffer)[i]==(int16_t)0xFAFA) {
+								state=1;
+								count++;
+								total++;
+							} else {
+								state=0;
+							}
+						} else if(state==1) {
+							if(((int16_t*)pcm_buffer)[i]==(int16_t)0xFAFA) {
+								count++;
+								total++;
+							} else {
+								//printf("Gap in the data %d,%d\n", count, i);
+								state=0;
+								count=0;
+							}
+						}
+					}
+					if(state==1) {
+						//printf("Gap in the data: %d, total=%d\n", count, total);
+					}
+					*/
+					safefree(pcm_buffer);
 				} else {
-					printf("[2] Receiving failed on socket %d.%d error (%d/%d bytes)\n", client_index, lpClient->sockfd, result, pcm_buffer_size);
+					perror("Not enough memory");
 					bError = 1;
 				}
 			} else {
 				if (result == sizeof(pcm_buffer_size)) {
-					printf("[1] Receiving will not fit pool (poolentrysize=%d != pcm_buffer_size=%d)\n", POOLENTRYSIZE, pcm_buffer_size);
+					perror("Receiving will not fit pool");
 				} else {
-					printf("[1] Receiving failed on socket %d.%d error (%d/%d bytes) errno=%d:%s\n", client_index, lpClient->sockfd, result, sizeof(pcm_buffer_size), errno,
-					       strerror(errno));
+					perror("Receiving failed");
 				}
 				bError = 1;
 			}
 		}
+	} else {
+		perror("Receiving stream informations failed");
+	}
 
-		pthread_mutex_lock(&lpClient->lpDevice->mutex);
-		if (client_index >= 0)
-			lpClient->lpDevice->clients[client_index].lives = 0;
-		pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+	safefree(lpClient->lpDevice->clients[client_index].conv.lpVoid);
+
+	pthread_mutex_lock(&lpClient->lpDevice->mutex);
+	if (client_index >= 0)
+		lpClient->lpDevice->clients[client_index].lives = 0;
+	pthread_mutex_unlock(&lpClient->lpDevice->mutex);
+
+	printf("Client thread %d ending: %s\n", lpClient->sockfd, (bError ? (errno == EAGAIN ? "timeout" : "error") : "no error"));
+
+	return 0;
+}
+
+// This function handles a client
+void *client_handler(void *param)
+{
+	int32_t client_type = INVALID_CLIENT_TYPE;
+	LPA2DPDCLIENT lpClient = (LPA2DPDCLIENT) param;
+
+	// We should not terminate the process if clients are still running
+	iThreadsRunning++;
+
+	pthread_detach(lpClient->thread);
+
+	setup_socket(lpClient->sockfd);
+
+	// Receive type of client
+	recv_socket(lpClient->sockfd, &client_type, sizeof(client_type));
+
+	// This client wants to send us pcm control data
+	if (client_type == A2DPD_PLUGIN_CTL_WRITE) {
+		a2dpd_plugin_ctl_write(lpClient);
+	}
+	// This client wants to read our control status
+	if (client_type == A2DPD_PLUGIN_CTL_READ) {
+		a2dpd_plugin_ctl_read(lpClient);
 	}
+	// This client wants to send us pcm stream
+	if (client_type == A2DPD_PLUGIN_PCM_WRITE) {
+		a2dpd_plugin_pcm_write(lpClient);
+	}
+
 	// Say goodbye
 	pthread_mutex_lock(&lpClient->lpDevice->mutex);
 	lpClient->lpDevice->nb_clients--;
 	pthread_mutex_unlock(&lpClient->lpDevice->mutex);
 
 	// Close socket
-	printf("Client thread %d.%d ending: %s\n", client_index, lpClient->sockfd, (bError ? (errno == EAGAIN ? "timeout" : "error") : "no error"));
 	close_socket(lpClient->sockfd);
 
 	// Free client data
-	free(lpClient);
+	safefree(lpClient);
 
 	// Decrease thread count
 	iThreadsRunning--;
@@ -587,8 +938,10 @@
 	return pcm_buffer_filed_size;
 }
 
+/////////////////////////////////
 // This function handle the bluetooth connection
 void *bt_handler(void *param)
+/////////////////////////////////
 {
 	int i;
 	// We should not terminate the process if clients are still running
@@ -601,19 +954,24 @@
 	while (!bSigINTReceived) {
 		int bError = 0;
 		int destroy_count = 0;
-		int ibytespersecond = 0;
 
 		// Connect to the A2DP device
 		void *lpA2dp = NULL;
-		char *pcm_buffer = pool_pop();
+		char *pcm_buffer = mymalloc(POOLENTRYSIZE);
 		enum { NOSOUND, SOUND };
 		int state_previous = NOSOUND;
 		TIMERINFO TimerInfos;
-		int rate = read_config_int(g_srcfilename, "a2dpd", "rate",
-					   A2DPD_FRAME_RATE);
+		lpDevice->a2dp_rate = read_config_int(g_srcfilename, "a2dpd", "rate", A2DPD_FRAME_RATE);
+		lpDevice->a2dp_channels = read_config_int(g_srcfilename, "a2dpd", "channels", 2);
+		lpDevice->a2dp_bitspersample = 16/8;//(read_config_int(g_srcfilename, "a2dpd", "bitspersample", 16))/8;
+		lpDevice->sbcbitpool = read_config_int(g_srcfilename, "a2dpd", "sbcbitpool", 32);
+		printf("New connection to bluetooth [%d hz, %d channels, %d bits]\n", lpDevice->a2dp_rate, lpDevice->a2dp_channels, lpDevice->a2dp_bitspersample*8);
+
+		// This timer is used to sync bluetooth sound emission
+		// This is because not all device have a queue for incoming sample
+		// And device who have a queue won't react correctly
 		memset(&TimerInfos, 0, sizeof(TimerInfos));
-		TimerInfos.fps = (float) ((((float) rate) * ((float) A2DPD_FRAME_BYTES) / ((float) A2DPD_BLOCK_SIZE)) / 1.0);
-		printf("New connection to bluetooth [%d hz]\n", rate);
+		TimerInfos.fps = (float)(((float) (lpDevice->a2dp_rate*lpDevice->a2dp_channels*lpDevice->a2dp_bitspersample)/((float) POOLENTRYSIZE))/1.0);
 
 		// As long as we can send sound
 		while (!bSigINTReceived && !bError) {
@@ -637,11 +995,11 @@
 
 						if (lpDevice->clients[i].ring_in != lpDevice->clients[i].ring_out) {
 							// Get ring buffer
-							pcm_buffers[i] = lpDevice->clients[i].ring[lpDevice->clients[i].ring_out];
-							pcm_buffers_size[i] = lpDevice->clients[i].ring_len[lpDevice->clients[i].ring_out];
+							pcm_buffers[i] = lpDevice->clients[i].ring[lpDevice->clients[i].ring_out].buf;
+							pcm_buffers_size[i] = lpDevice->clients[i].ring[lpDevice->clients[i].ring_out].len;
 							// Tell client we got them
-							lpDevice->clients[i].ring[lpDevice->clients[i].ring_out] = NULL;
-							lpDevice->clients[i].ring_len[lpDevice->clients[i].ring_out] = 0;
+							lpDevice->clients[i].ring[lpDevice->clients[i].ring_out].buf = NULL;
+							lpDevice->clients[i].ring[lpDevice->clients[i].ring_out].len = 0;
 
 							// Move to next ring
 							int next_ring = ((lpDevice->clients[i].ring_out + 1) % MAXCLIENTSRINGSIZE);
@@ -670,7 +1028,7 @@
 				for (i = 0; i < MAXCLIENTSPERDEVICE; i++) {
 					if (pcm_buffers[i]) {
 						// Reintegrate data where they come from
-						pool_push(pcm_buffers[i]);
+						safefree(pcm_buffers[i]);
 					}
 				}
 
@@ -679,9 +1037,9 @@
 				/////////////////////////////////
 
 				if (pcm_buffer && pcm_buffer_filed_size > 0) {
-					// Transfer takes place by A2DPD_BLOCK_SIZE bytes blocks
+					// Transfer takes place by POOLENTRYSIZE bytes blocks
 					int blockstart = 0;
-					int blocksize = A2DPD_BLOCK_SIZE;
+					int blocksize = POOLENTRYSIZE;
 
 					// Allocate A2DP if we are not connected
 					if (!lpA2dp) {
@@ -690,10 +1048,21 @@
 						read_config_string(g_srcfilename, "a2dpd", "address", lpDevice->addr, sizeof(lpDevice->addr), "");
 						read_config_string(g_srcfilename, "a2dpd", "alsaoutput", lpDevice->plug, sizeof(lpDevice->plug), "");
 						// Allocate it
-						if (lpDevice->bredirectalsa)
-							lpA2dp = alsa_new(lpDevice->plug, rate);
-						else
-							lpA2dp = a2dp_new(lpDevice->addr, rate);
+						if (lpDevice->bredirectalsa) {
+							lpA2dp = alsa_new(lpDevice->plug, lpDevice->a2dp_rate);
+						} else {
+							A2DPSETTINGS settings;
+							memset(&settings, 0, sizeof(settings));
+							strncpy(settings.bdaddr, lpDevice->addr, sizeof(settings.bdaddr)-1);
+							settings.framerate=lpDevice->a2dp_rate;
+							settings.channels=lpDevice->a2dp_channels;
+							settings.sbcbitpool=lpDevice->sbcbitpool;
+							lpA2dp = a2dp_new(&settings);
+						}
+						// Do not spin if connection failed, this appear if no bluetooth device is installed
+						if(!lpA2dp) {
+							sleep(1);
+						}
 						g_nbdeviceconnected++;
 						destroy_count = 0;
 					}
@@ -703,7 +1072,7 @@
 						while (!bError && blockstart < pcm_buffer_filed_size) {
 							int transfer;
 
-							blocksize = (pcm_buffer_filed_size < A2DPD_BLOCK_SIZE) ? pcm_buffer_filed_size : A2DPD_BLOCK_SIZE;
+							blocksize = (pcm_buffer_filed_size < POOLENTRYSIZE) ? pcm_buffer_filed_size : POOLENTRYSIZE;
 
 							if (lpDevice->bredirectalsa)
 								transfer = alsa_transfer_raw(lpA2dp, pcm_buffer + blockstart, blocksize);
@@ -712,8 +1081,7 @@
 
 							if (transfer >= 0) {
 								destroy_count = 0;
-								blockstart += blocksize;
-								ibytespersecond += transfer;
+								blockstart += transfer;
 								a2dp_timer_notifyframe(&TimerInfos);
 							} else {
 								printf("Error in a2dp_transfer_raw\n");
@@ -750,21 +1118,19 @@
 					}
 				}
 				/*
-				   char* lpszFormat = "A2DPD: [%d,%d|%d,%d] %s %s clients=%d freq=%d[%d b/s] sleep=%d satur=%d\n";
-				   if(satured==0) lpszFormat = "A2DPD: [%d,%d|%d,%d] %s %s clients=%d freq=%d[%d b/s]\n";
-				   printf(lpszFormat, 
-				   lpDevice->mixer.volume_speaker_left,
-				   lpDevice->mixer.volume_speaker_right,
-				   lpDevice->mixer.volume_micro_left,
-				   lpDevice->mixer.volume_micro_right,
-				   (state_current==SOUND)?"playing":"silent",
-				   lpA2dp?"connected":"disconnected", lpDevice->nb_clients, TimerInfos.display,
-				   ibytespersecond,
-				   satured);
-				   // Reset all variables used
-				   ibytespersecond=0;
-				   satured=0;
-				 */
+				char* lpszFormat = "A2DPD: [%d,%d|%d,%d] %s %s clients=%d freq=%d[%d b/s] sleep=%d satur=%d\n";
+				if(satured==0) lpszFormat = "A2DPD: [%d,%d|%d,%d] %s %s clients=%d freq=%d[%d b/s]\n";
+				printf(lpszFormat, 
+				lpDevice->mixer.volume_speaker_left,
+				lpDevice->mixer.volume_speaker_right,
+				lpDevice->mixer.volume_micro_left,
+				lpDevice->mixer.volume_micro_right,
+				(state_current==SOUND)?"playing":"silent",
+				lpA2dp?"connected":"disconnected", lpDevice->nb_clients, TimerInfos.display,
+				satured);
+				// Reset all variables used
+				satured=0;
+				*/
 			}
 
 			// Free the A2DP device if needed
@@ -783,7 +1149,7 @@
 
 			state_previous = state_current;
 		}
-		pool_push(pcm_buffer);
+		safefree(pcm_buffer);
 
 		// Sleep a little bit before retrying
 		if (!bSigINTReceived)
@@ -844,13 +1210,13 @@
 							break;
 						} else if (iReceived < 0) {
 							if (errno != EAGAIN)
-								printf("avdtp: socket %d: Received failed result=%d (errno=%d:%s)\n", new_fd, iReceived, errno, strerror(errno));
+								perror("avdtp: Received failed");
 						}
 						count++;
 					}
 					// AVDTP do not need to have a device connected, since it can establish device connection
 					while (!bSigINTReceived && (iReceived >= 0 || errno == EAGAIN)
-					       && count < 10);
+					&& count < 10);
 					printf("avdtp: socket %d: timed out\n", new_fd);
 					close_socket(new_fd);
 
@@ -859,7 +1225,7 @@
 					}
 				} else {
 					if (errno != EAGAIN) {
-						printf("a2dp_wait_connection failed (AVDTP socket) : %d (errno=%d:%s)\n", new_fd, errno, strerror(errno));
+						perror("avdtp: a2dp_wait_connection failed");
 						break;
 					}
 				}
@@ -896,8 +1262,8 @@
 				uint16_t iMTU = 0;
 
 				int new_fd = a2dp_wait_connection(sockfd, szRemote,
-								  sizeof(szRemote),
-								  &iMTU);
+								sizeof(szRemote),
+								&iMTU);
 
 				if (new_fd > 0) {
 					printf("avrcp: socket %d: Connection from %s, mtu=%d\n", new_fd, szRemote, iMTU);
@@ -905,16 +1271,14 @@
 					setup_socket(new_fd);
 					int iReceived = 0;
 					do {
-						printf("avrcp: socket %d: Reading from %s, mtu=%d\n", new_fd, szRemote, iMTU);
 						errno = 0;
 						iReceived = a2dp_handle_avrcp_message(new_fd);
 					}
-					// AVRCP need device connected
-					while (g_nbdeviceconnected && !bSigINTReceived && (iReceived > 0 || errno == EAGAIN));
+					while (!bSigINTReceived && (iReceived > 0 || errno == EAGAIN));
 					printf("avrcp: socket %d: timed out\n", new_fd);
 					close_socket(new_fd);
 				} else if (errno != EAGAIN) {
-					printf("a2dp_wait_connection failed (AVRCP socket) : %d (errno=%d:%s)\n", new_fd, errno, strerror(errno));
+					perror("avrcp: a2dp_wait_connection failed");
 					break;
 				}
 			}
@@ -953,13 +1317,11 @@
 
 			while (!bSigINTReceived) {
 				int new_fd = -1;
-				printf("main_thread:Accepting incoming tcp stream connection\n");
 				new_fd = accept_socket(sockfd);
-				printf("main_thread: Accepted %d\n", new_fd);
 
 				// Handle connection if it is not the final dummy client
 				if (!bSigINTReceived && new_fd > 0) {
-					LPA2DPDCLIENT lpClient = malloc(sizeof(A2DPDCLIENT));
+					LPA2DPDCLIENT lpClient = mymalloc(sizeof(A2DPDCLIENT));
 					lpClient->lpDevice = lpDevice;
 					lpClient->sockfd = new_fd;
 
@@ -981,7 +1343,7 @@
 			// But we Must wait all client termination
 			// We will pthread_join one day
 			int icount = 0;
-			while (iThreadsRunning > 0 && icount < 30) {
+			while (iThreadsRunning > 0 /*&& icount < 30*/) {
 				printf("A2DPD still %d clients running\n", iThreadsRunning);
 				icount++;
 				sleep(1);
@@ -991,7 +1353,7 @@
 			bta2dpdevicefree(lpDevice);
 			pthread_attr_destroy(&tattr);
 		} else {
-			printf("Error %d: cannot get the socket errno=%d (%s)\n", sockfd, errno, strerror(errno));
+			perror("a2dpd: Cannot get the socket");
 		}
 
 		sleep(1);
@@ -1011,7 +1373,7 @@
 	//char* iphono420= "C2:00:08:F4:30:07:64";
 	//char* hpheadphone= "00:0D:44:2A:17:C7";
 	struct sched_param schedparam = { sched_get_priority_max(SCHED_FIFO) };
-	int res = 0, bFork = 0, bVerbose = 1, bKill = 0, fd = 0;
+	int res = 0, bFork = 0, bVerbose = 1, bKill = 0, fd = 0, bRealtime = 0;
 	FILE *fp;
 	pid_t pid;
 
@@ -1048,6 +1410,8 @@
 			bFork = 0;
 		} else if (!strcmp(argv[i], "+v")) {
 			bVerbose = 0;
+		} else if (!strcmp(argv[i], "-r")) {
+			bRealtime = 1;
 		} else {
 			printf("Parameter not handled: %s\r\n", argv[i]);
 		}
@@ -1076,7 +1440,7 @@
 
 		pid = -1;
 		if ((fscanf(fp, "%d", &pid) != 1) || (pid == getpid())
-		    || (lock_fd(fileno(fp)) == 0)) {
+		|| (lock_fd(fileno(fp)) == 0)) {
 			unlink(PIDFILE);
 		} else {
 			if (bKill) {
@@ -1102,13 +1466,18 @@
 	fflush(fp);
 	fcntl(fd, F_SETFD, (long) 1);
 
-      post_lock:
+post_lock:
 	printf("%s addr=%s timer=%d us [%s %s]\n", argv[0], addr, (int) (timer_resolution.tv_nsec / 1000), __DATE__, __TIME__);
 
 	// If we can be realtime it will be better
-	res = sched_setscheduler(0, SCHED_FIFO, &schedparam);
-	printf("setscheduler returns %d (errno=%d:%s)\n", res, errno, strerror(errno));
-
+	if(bRealtime)
+	{
+		// After some trouble while developping, a2dpd started spining 100%cpu
+		// In realtime, this led me with the only option of rebooting my PC
+		res = sched_setscheduler(0, SCHED_FIFO, &schedparam);
+		if(res != 0)
+			perror("setscheduler failed");
+	}
 	// set up the handler
 	signal(SIGINT, sigint_handler);
 	signal(SIGTERM, sigint_handler);
@@ -1119,12 +1488,12 @@
 	// Run main loop
 	main_loop(addr);
 
-	// global free
+	// global termination
 	a2dp_exit();
 
 	kill_uinput();
 
-      shutdown:
+shutdown:
 	printf("A2DPD terminated succesfully\n");
 
 	return 0;
Index: alsa-plugins/a2dpd_protocol.h
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd_protocol.h,v
retrieving revision 1.4
diff -u -r1.4 a2dpd_protocol.h
--- alsa-plugins/a2dpd_protocol.h	6 Sep 2006 02:59:43 -0000	1.4
+++ alsa-plugins/a2dpd_protocol.h	7 Nov 2006 15:41:24 -0000
@@ -24,17 +24,35 @@
 
 #include <stdint.h>
 
-
 // parameters used to describe device state
 typedef struct {
 	int16_t volume_speaker_right;
 	int16_t volume_speaker_left;
 	int16_t volume_micro_right;
 	int16_t volume_micro_left;
-} AUDIOMIXERDATA;
+} __attribute__ ((packed)) AUDIOMIXERDATA;
 
 #define INVALIDAUDIOMIXERDATA   { -1, -1, -1, -1 }
 
+// PCM formats defined in alsa, we will restrict our selves to 8 and 16 bits
+#define A2DPD_PCM_FORMAT_UNKNOWN 0x00000000
+#define A2DPD_PCM_FORMAT_S8      0x00000001
+#define A2DPD_PCM_FORMAT_U8      0x00000002
+#define A2DPD_PCM_FORMAT_S16_LE  0x00000003
+//#define A2DPD_FORMAT_S16_BE        0x00000004
+//#define A2DPD_FORMAT_U16_LE        0x00000005
+//#define A2DPD_FORMAT_U16_BE        0x00000006
+
+// parameters used to describe device state
+typedef struct {
+	uint32_t format;
+	uint16_t rate;
+	uint8_t channels;
+	uint16_t bitspersample;
+} __attribute__ ((packed)) AUDIOSTREAMINFOS;
+
+#define INVALIDAUDIOSTREAMINFOS   { 0, 0, 0 }
+
 // Different types of client plugin for the daemon
 #define INVALID_CLIENT_TYPE     0xFFFFFFFF
 #define A2DPD_PLUGIN_CTL_WRITE  0x00000001
Index: alsa-plugins/a2dplib.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dplib.c,v
retrieving revision 1.6
diff -u -r1.6 a2dplib.c
--- alsa-plugins/a2dplib.c	6 Sep 2006 02:59:43 -0000	1.6
+++ alsa-plugins/a2dplib.c	7 Nov 2006 15:41:24 -0000
@@ -25,12 +25,15 @@
 #include <config.h>
 #endif
 
+// #define FASTTIMEOUTS 1
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
 #include <malloc.h>
 #include <signal.h>
+#include <time.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/time.h>
@@ -62,6 +65,7 @@
 // However some devices may have longer transfer unit up to I saw omtu=733?
 
 #define min(X, Y)  ((X) < (Y) ? (X) : (Y))
+#define max(X, Y)  ((X) > (Y) ? (X) : (Y))
 #define DBG(fmt, arg...) { if(errno!=0) printf("DEBUG: %s: (errno=%d:%s)" fmt "\n" , __FUNCTION__ , errno, strerror(errno), ## arg);\
         else printf("DEBUG: %s: " fmt "\n" , __FUNCTION__ , ## arg); errno=0;}
 
@@ -81,7 +85,7 @@
 
 static struct sigaction actions;
 /*
-sdp_record_t* a2dp_advertise_sdp(sdp_session_t* sdpSessionP)
+static sdp_record_t* a2dp_advertise_sdp(sdp_session_t* sdpSessionP)
 {
         sdp_record_t *recordP=NULL;
         sdp_list_t *svclass=NULL, *rootlist=NULL, *protolist=NULL, *l2caplist=NULL, *avdtplist=NULL, *profileslist=NULL;
@@ -152,9 +156,7 @@
 
         return recordP;
 }
-*/
 
-/*
 void a2dp_init(void) __attribute__ ((constructor));
 void a2dp_exit(void) __attribute__ ((destructor));
 */
@@ -344,26 +346,27 @@
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 	if (sk < 0) {
-		DBG("Can't create socket. %s(%d)", strerror(errno), errno);
+		DBG("Can't create socket.");
 		return -1;
 	}
+#ifdef FASTTIMEOUTS
 	// Set connection timeout
 	struct timeval t = { 3, 0 };
 	setsockopt(sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
-
+#endif
 	memset(&addr, 0, sizeof(addr));
 	addr.l2_family = AF_BLUETOOTH;
 	bacpy(&addr.l2_bdaddr, src);
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		DBG("Can't bind socket. %s(%d)", strerror(errno), errno);
+		DBG("Can't bind socket.");
 		return -1;
 	}
 
 	/* Get default options */
 	opt = sizeof(opts);
 	if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
-		DBG("Can't get default L2CAP options. %s(%d)", strerror(errno), errno);
+		DBG("Can't get default L2CAP options.");
 		return -1;
 	}
 
@@ -373,7 +376,7 @@
 		//opts.imtu = *mtu;
 	}
 	if (setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, opt) < 0) {
-		DBG("Can't set L2CAP options. %s(%d)", strerror(errno), errno);
+		DBG("Can't set L2CAP options.");
 		return -1;
 	}
 
@@ -384,7 +387,9 @@
 
 	tries = 0;
 	while (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		DBG("Can't connect to %s on psm %d. %s(%d)", batostr(&addr.l2_bdaddr), psm, strerror(errno), errno);
+		char* tmpaddr = batostr(&addr.l2_bdaddr);
+		DBG("Can't connect to %s on psm %d.", tmpaddr, psm);
+		free(tmpaddr);
 		if (++tries > NBSDPRETRIESMAX) {
 			close(sk);
 			return -1;
@@ -393,7 +398,7 @@
 	}
 	opt = sizeof(opts);
 	if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &opt) < 0) {
-		DBG("Can't get L2CAP options. %s(%d)", strerror(errno), errno);
+		DBG("Can't get L2CAP options.");
 		close(sk);
 		return -1;
 	}
@@ -416,6 +421,7 @@
 	int err;
 	int tries;
 
+#ifdef FASTTIMEOUTS
 	// Try to connect an L2CAP socket to the sdp psm with short timeout for user interaction
 	int tmpsk = do_connect(src, dst, 1, NULL);
 	if (tmpsk > 0) {
@@ -424,10 +430,10 @@
 		DBG("Warning: failed to connect to SDP server");
 		return -1;
 	}
-
+#endif
 	tries = 0;
 	while (!(sess = sdp_connect(src, dst, SDP_RETRY_IF_BUSY))) {
-		DBG("retrying sdp connect: %s", strerror(errno));
+		DBG("retrying sdp connect.");
 		if (++tries > NBSDPRETRIESMAX) {
 			break;
 		}
@@ -451,7 +457,7 @@
 	sdp_list_free(attrid, 0);
 
 	if (err) {
-		DBG("Service Search failed: %s", strerror(errno));
+		DBG("Service Search failed.");
 		sdp_close(sess);
 		return -1;
 	}
@@ -529,7 +535,9 @@
 	int tries, res;
 
 	if (detect_a2dp(src, dst, &psm_cmd, &flags) < 0) {
-		DBG("could not find A2DP services on device %s", batostr(dst));
+		char* tmpaddr=batostr(dst);
+		DBG("could not find A2DP services on device %s", tmpaddr);
+		free(tmpaddr);
 		return -1;
 	} else {
 		DBG("Found A2DP Sink at the destination (psm_cmd=%d)", psm_cmd);
@@ -582,6 +590,11 @@
 	}
 
 	seid = -1;
+	if(size<sizeof(discover_resp.header)) {
+		DBG("Received invalid capabilities (size=%d, wanted=%d)", size, sizeof(discover_resp.header));
+		return -1;
+	}
+
 	nb_seid = (size - sizeof(discover_resp.header)) / sizeof(struct acp_seid_info);
 
 	DBG("received %d capabilities", nb_seid);
@@ -598,6 +611,7 @@
 		DBG("couldn't locate the correct seid");
 		return -1;
 	}
+
 	// open the stream
 	streamfd = do_connect(src, dst, psm_stream, &mtu);
 	if (streamfd < 0) {
@@ -635,6 +649,7 @@
 }
 
 typedef struct snd_pcm_a2dp {
+	A2DPSETTINGS settings;
 	bdaddr_t src;
 	bdaddr_t dst;
 	int sk;
@@ -654,6 +669,10 @@
 	int mtu;		//=A2DPMAXIMUMTRANSFERUNITSIZE
 	int seid;
 
+	// Bluetooth bandwith used
+	int bandwithcount;
+	struct timeval bandwithtimestamp;
+
 	// Used to control stream from headset
 	int stop_writing;	// = 0;
 	int pause_writing;	// = 0;
@@ -680,7 +699,7 @@
 	codesize = a2dp->sbc.subbands * a2dp->sbc.blocks * a2dp->sbc.channels * 2;
 	// 44 bitpool?
 	//codesize=a2dp->sbc.bitpool*a2dp->sbc.subbands*a2dp->sbc.blocks/8;
-	datatoread = min(codesize, pcm_buffer_size);
+	datatoread = min((BUFS - a2dp->lenbufe), pcm_buffer_size);
 
 	// Enqueue data in bufe
 	if (a2dp->lenbufe + datatoread < BUFS) {
@@ -691,6 +710,7 @@
 		datatoread = 0;
 	}
 
+	result = datatoread;
 
 	// If bufe is full, encode
 	if (a2dp->lenbufe >= codesize) {
@@ -721,6 +741,7 @@
 			memcpy(a2dp->buf, &packet_header, sizeof(packet_header));
 			memcpy(a2dp->buf + sizeof(packet_header), &payload_header, sizeof(payload_header));
 			if (a2dp->sk > 0) {
+			/*
 				// Check if data are to be read
 				// Not seen a device showing this yet
 				fd_set readfds;
@@ -733,20 +754,55 @@
 						a2dp_handle_avdtp_message(a2dp, a2dp->sk, NULL, NULL, 0);
 					}
 				}
+			*/
 				// Pause?
-				// The value 0 have never been tested
+				// The value 0 have finally been tested ;)
 				// However, we may safely simulate a failed write
 				if (!a2dp->pause_writing) {
 					// Send our data
 					if ((written = write(a2dp->sk, a2dp->buf, a2dp->len)) != a2dp->len) {
 						// Error while sending data
-						DBG("Wrote %d not %d bytes; (errno=%d:%s)", written, a2dp->len, errno, strerror(errno));
+						DBG("Wrote %d not %d bytes.", written, a2dp->len);
+						/*
+						if (errno == EAGAIN) {
+							usleep(1);
+							if ((written = write(a2dp->sk, a2dp->buf, a2dp->len)) != a2dp->len) {
+								// Error while sending data
+								DBG("Wrote %d not %d bytes. (2)", written, a2dp->len);
+								// Return the error
+								result = written;
+							}
+						}
+						else
+						{
+						}
+						*/
+						// Return the error
 						result = written;
+					} else {
+						// Measure bandwith usage
+						struct timeval now = { 0, 0 };
+						struct timeval interval = { 0, 0 };
+
+						if(a2dp->bandwithtimestamp.tv_sec==0)
+							gettimeofday(&a2dp->bandwithtimestamp, NULL);
+
+						// See if we must wait again
+						gettimeofday(&now, NULL);
+						timersub(&now, &a2dp->bandwithtimestamp, &interval);
+						if(interval.tv_sec>0) {
+							DBG("Bandwith: %d (%d kbps) %d", a2dp->bandwithcount, a2dp->bandwithcount/128, a2dp->sbc.bitpool);
+							a2dp->bandwithtimestamp = now;
+							a2dp->bandwithcount = 0;
+						}
+
+						a2dp->bandwithcount += written;
 					}
-					result = written;
+					
+					
 				} else {
 					// Make the upper layer believe we sent data
-					result = a2dp->len;
+					//result = a2dp->len;
 				}
 			}
 			// Reset buffer of data to send
@@ -762,7 +818,7 @@
 
 	return result;
 }
-
+/*
 static void init_response(struct avdtp_header *header, int response_type)
 {
 	// leave signal_id and transaction label since we are reusing the request
@@ -772,7 +828,7 @@
 	// clear rfa bits
 	header->rfa0 = 0;
 }
-
+*/
 // monitor the control connection for pause/play signals from headset
 // note this signaling is in the avdtp core; avrcp signaling is different
 static void *listen_thread(void *param)
@@ -786,43 +842,22 @@
 
 	DBG("Listen thread running [control_sk=%d]", a2dp->control_sk);
 
+//#ifdef FASTTIMEOUTS
 	// Set a timeout to close thread
 	struct timeval t = { 1, 0 };
 	setsockopt(a2dp->control_sk, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
 	setsockopt(a2dp->control_sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+//#endif
 
 	// Loop until end of writing
 	while (!a2dp->stop_writing) {
-		char szBuffer[A2DPMAXIMUMTRANSFERUNITSIZE];
-		struct stream_cmd *cmd = (struct stream_cmd *) szBuffer;
 		if (a2dp_handle_avdtp_message(a2dp, a2dp->control_sk, NULL, NULL, 0) < 0) {
 			// Error
+			//FIXME we must reconnect
 			usleep(100 * 1000);
 		}
-
-		int size = read(a2dp->control_sk, szBuffer, sizeof(szBuffer));
-		if (size > 0) {
-			if (cmd->header.signal_id == AVDTP_SUSPEND) {
-				DBG("Received signal AVDTP_SUSPEND(%d) from set", cmd->header.signal_id);
-				a2dp->pause_writing = 1;
-			} else if (cmd->header.signal_id == AVDTP_START) {
-				DBG("Received signal AVDTP_START(%d) from set", cmd->header.signal_id);
-				a2dp->pause_writing = 0;
-			} else {
-				DBG("Unexpected headset directive %d", cmd->header.signal_id);
-			}
-			// ack the command regardless
-			//FIXME take a shortcut and reuse the command struct (knock one byte off length)
-			init_response(&cmd->header, MESSAGE_TYPE_ACCEPT);
-			if (write(a2dp->control_sk, &cmd, sizeof(cmd) - 1) != sizeof(cmd) - 1) {
-				DBG("Couldn't ack %d", cmd->header.signal_id);
-			}
-		} else {
-			if (errno != EAGAIN)
-				DBG("Error while receiving %d (errno=%d:%s)", size, errno, strerror(errno));
-			if (errno != EINTR)
-				break;
-		}
+		// Make sure we do not spin in case of errors
+		usleep(10 * 1000);
 	}
 
 	return NULL;
@@ -953,41 +988,33 @@
 {
 }
 
-LPA2DP a2dp_new(char *addr, int framerate)
+LPA2DP a2dp_new(A2DPSETTINGS* settings)
 {
 	snd_pcm_a2dp_t *a2dp = NULL;
-	bdaddr_t src, dst;
-	int err;		//, pos = -1, use_rfcomm = 0;
 
-	DBG("%s, %d", addr, framerate);
+	if(settings) {
+		a2dp = a2dp_alloc();
 
-	bacpy(&src, BDADDR_ANY);
-	bacpy(&dst, BDADDR_ANY);
-	str2ba(addr, &dst);
-
-	a2dp = a2dp_alloc();
-	if (!a2dp) {
-		DBG("Can't allocate");
-		return NULL;
-	}
-	if (a2dp)
-		a2dp->sbc.rate = framerate;
+		DBG("%s, %d", settings->bdaddr, settings->framerate);
 
-	bacpy(&a2dp->src, &src);
-	bacpy(&a2dp->dst, &dst);
-	//a2dp->use_rfcomm = use_rfcomm;
-
-	err = a2dp_connect(a2dp);
-	if (err < 0) {
-		DBG("Can't connect");
-		goto error;
+		if (a2dp) {
+			memcpy(&a2dp->settings, settings, sizeof(a2dp->settings));
+			a2dp->sbc.rate = settings->framerate;
+			a2dp->sbc.channels = max(1, min(settings->channels, 2));
+			a2dp->sbc.bitpool = settings->sbcbitpool;
+			if(settings->channels==1)
+				a2dp->sbc.joint=1;
+			bacpy(&a2dp->src, BDADDR_ANY);
+			str2ba(settings->bdaddr, &a2dp->dst);
+
+			if (a2dp_connect(a2dp) < 0) {
+				DBG("Can't connect");
+				a2dp_free(a2dp);
+				a2dp=NULL;
+			}
+		}
 	}
-
 	return a2dp;
-
-      error:
-	a2dp_free(a2dp);
-	return NULL;
 }
 
 void a2dp_destroy(LPA2DP a2dp)
@@ -1005,15 +1032,23 @@
 
 	// the stream-close used to make the iTech headset lock up and require it to be powercycled
 	// should be tested again now that we drain the queue properly
+	//FIXME Should be tested again now that we read the answer, Sonorix used to do something similar and no longer does it!
 
 	init_request(&close_stream.header, AVDTP_CLOSE);
 	close_stream.acp_seid = a2dp->seid;
-	// Use control_sk if it is needed
-	if ((a2dp->control_sk > 0 && (write(a2dp->control_sk, &close_stream, sizeof(close_stream)) != sizeof(close_stream)))
-	    // Else use sk
-	    || (write(a2dp->sk, &close_stream, sizeof(close_stream)) != sizeof(close_stream))
-	    ) {
-		DBG("Couldn't send close_stream (errno=%d:%s)", errno, strerror(errno));
+	if (a2dp->control_sk > 0) {
+		if(write(a2dp->control_sk, &close_stream, sizeof(close_stream)) == sizeof(close_stream)) {
+			// Receive close stream answer if any?
+			int i, size;
+			DBG("Receiving answer to close stream");
+			size = recv(a2dp->control_sk, &close_stream, sizeof(close_stream), 0);
+			DBG("Received answer size=%d", size);
+			for (i = 0; i < size; i++)
+				printf("%02X", (int) (*(((char *) &close_stream) + i)));
+			printf("\n");
+		} else {
+			DBG("Couldn't send close_stream");
+		}
 	}
 
 	a2dp_free(a2dp);
@@ -1065,7 +1100,7 @@
 	}
 
 	if (lpszError) {
-		DBG("%s %s(%d)", lpszError, strerror(errno), errno);
+		DBG("%s", lpszError);
 		close(sockfd);
 		sockfd = -1;
 	}
@@ -1104,9 +1139,13 @@
 		//DBG("Connected [imtu %d, omtu %d, flush_to %d]", opts.imtu, opts.omtu, opts.flush_to);
 
 		if (szRemote) {
-			strncpy(szRemote, batostr(&addr.l2_bdaddr), iRemoteSize);
+			char* tmpaddr = batostr(&addr.l2_bdaddr);
+			strncpy(szRemote, tmpaddr, iRemoteSize);
+			free(tmpaddr);
 			szRemote[iRemoteSize - 1] = '\0';
 		}
+	} else {
+		sleep(1);
 	}
 	return new_fd;
 }
@@ -1135,8 +1174,7 @@
 			}
 			printf("\n");
 			result = 0;
-		} else if ((pkt_hdr->message_type == MESSAGE_TYPE_ACCEPT) && (pkt_hdr->signal_id == sent_packet->signal_id)
-		    ) {
+		} else if ((pkt_hdr->message_type == MESSAGE_TYPE_ACCEPT) && (pkt_hdr->signal_id == sent_packet->signal_id)) {
 			// Got expected answer
 			memcpy(answer, lpFrame, answer_size > iReceived ? answer_size : iReceived);
 			result = iReceived;
@@ -1148,15 +1186,35 @@
 		// Reply to the packet by rejecting it
 		if (pkt_hdr->message_type == MESSAGE_TYPE_COMMAND) {
 			int accepted = 0;
-			if (a2dp && pkt_hdr->signal_id == AVDTP_SUSPEND) {
-				DBG("Received signal AVDTP_SUSPEND(%d) from set", pkt_hdr->signal_id);
-				a2dp->pause_writing = 1;
-				accepted = 1;
-			} else if (a2dp && pkt_hdr->signal_id == AVDTP_START) {
+			if (pkt_hdr->signal_id == AVDTP_DISCOVER) {
+				DBG("Received signal AVDTP_DISCOVER(%d) from set", pkt_hdr->signal_id);
+			} else if (pkt_hdr->signal_id == AVDTP_GET_CAPABILITIES) {
+				DBG("Received signal AVDTP_GET_CAPABILITIES(%d) from set", pkt_hdr->signal_id);
+			} else if (pkt_hdr->signal_id == AVDTP_SET_CONFIGURATION) {
+				DBG("Received signal AVDTP_SET_CONFIGURATION(%d) from set", pkt_hdr->signal_id);
+			} else if (pkt_hdr->signal_id == AVDTP_GET_CONFIGURATION) {
+				DBG("Received signal AVDTP_GET_CONFIGURATION(%d) from set", pkt_hdr->signal_id);
+			} else if (pkt_hdr->signal_id == AVDTP_RECONFIGURE) {
+				DBG("Received signal AVDTP_RECONFIGURE(%d) from set", pkt_hdr->signal_id);
+			} else if (pkt_hdr->signal_id == AVDTP_OPEN) {
+				DBG("Received signal AVDTP_OPEN(%d) from set", pkt_hdr->signal_id);
+			} else if (pkt_hdr->signal_id == AVDTP_START) {
 				DBG("Received signal AVDTP_START(%d) from set", pkt_hdr->signal_id);
-				a2dp->pause_writing = 0;
+				if(a2dp)
+					a2dp->pause_writing = 0;
 				accepted = 1;
-			} else {
+			} else if (pkt_hdr->signal_id == AVDTP_CLOSE) {
+				DBG("Received signal AVDTP_CLOSE(%d) from set", pkt_hdr->signal_id);
+			} else if (pkt_hdr->signal_id == AVDTP_SUSPEND) {
+				DBG("Received signal AVDTP_SUSPEND(%d) from set", pkt_hdr->signal_id);
+				if(a2dp)
+					a2dp->pause_writing = 1;
+				accepted = 1;
+			} else if (pkt_hdr->signal_id == AVDTP_ABORT) {
+				DBG("Received signal AVDTP_ABORT(%d) from set", pkt_hdr->signal_id);
+			} else if (pkt_hdr->signal_id == AVDTP_SECURITY_CONTROL) {
+				DBG("Received signal AVDTP_SECURITY_CONTROL(%d) from set", pkt_hdr->signal_id);
+			}  else {
 				DBG("Unexpected headset directive %d", pkt_hdr->signal_id);
 			}
 
@@ -1167,8 +1225,8 @@
 			wrresult = write(sockfd, pkt_hdr, sizeof(*pkt_hdr));
 
 			if (wrresult != sizeof(*pkt_hdr)) {
-				DBG("FAILED Answering command packet (msgtype=%s,signal=%d) wrresult=%d/%d (errno=%d:%s)", accepted ? "MESSAGE_TYPE_ACCEPT" : "MESSAGE_TYPE_REJECT", pkt_hdr->signal_id,
-				    wrresult, sizeof(*pkt_hdr), errno, strerror(errno));
+				DBG("FAILED Answering command packet (msgtype=%s,signal=%d) wrresult=%d/%d", accepted ? "MESSAGE_TYPE_ACCEPT" : "MESSAGE_TYPE_REJECT", pkt_hdr->signal_id,
+				    wrresult, sizeof(*pkt_hdr));
 			}
 		} else {
 			DBG("Read non command packet (msgtype=%d,signal=%d)", pkt_hdr->message_type, pkt_hdr->signal_id);
@@ -1176,7 +1234,7 @@
 	} else {
 		result = iReceived;
 		if (errno != EAGAIN)
-			printf("socket %d: Receive failed %d (errno=%d:%s)\n", sockfd, iReceived, errno, strerror(errno));
+			printf("socket %d: Receive failed %d\n", sockfd, iReceived);
 	}
 
 	return result;
Index: alsa-plugins/a2dplib.h
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dplib.h,v
retrieving revision 1.4
diff -u -r1.4 a2dplib.h
--- alsa-plugins/a2dplib.h	17 Aug 2006 14:06:27 -0000	1.4
+++ alsa-plugins/a2dplib.h	7 Nov 2006 15:41:24 -0000
@@ -33,7 +33,6 @@
 
 #define A2DPMAXIMUMTRANSFERUNITSIZE 610
 
-
 // To send one L2CAP packets of 678 bytes, 4 ACL packets are sent, 3 are 192 bytes long, 
 // 1 contains 49 bytes  => loss 192-49/4
 // To send one L2CAP packets of 610 bytes, 3 ACL packets are sent, 2 are 192 bytes long, 
@@ -46,7 +45,15 @@
 extern void a2dp_exit( void);
 
 // Connect to an a2dp provider
-extern LPA2DP a2dp_new( char* bdaddr, int framerate);
+typedef struct
+{
+	char bdaddr[32];
+	int framerate;
+	int channels;
+	int sbcbitpool;
+} A2DPSETTINGS;
+
+extern LPA2DP a2dp_new( A2DPSETTINGS* settings);
 extern void a2dp_destroy( LPA2DP a2dp);
 
 // compress and transfers data
Index: alsa-plugins/pcm_a2dpd.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/pcm_a2dpd.c,v
retrieving revision 1.5
diff -u -r1.5 pcm_a2dpd.c
--- alsa-plugins/pcm_a2dpd.c	6 Sep 2006 02:59:43 -0000	1.5
+++ alsa-plugins/pcm_a2dpd.c	7 Nov 2006 15:41:24 -0000
@@ -51,8 +51,6 @@
 #define DBG(fmt, arg...)  printf("DEBUG: %s: (errno=%d:%s)" fmt "\n" , __FUNCTION__ , errno, strerror(errno), ## arg)
 //#define DBG(D...)
 
-static char g_srcfilename[512];
-
 // Signal handler, there is a strange SIGPIPE when the daemon is not running
 // We catch it to not quit
 void sighand(int signo)
@@ -73,6 +71,7 @@
 
 static int a2dp_disconnect(snd_pcm_a2dp_t * a2dp)
 {
+	//syslog(LOG_INFO, "Disconnected a2dp %p, sk %d", a2dp, a2dp->sk);
 	close_socket(a2dp->sk);
 	a2dp->sk = -1;
 	return 0;
@@ -86,8 +85,24 @@
 		if (sockfd > 0) {
 			int32_t client_type = A2DPD_PLUGIN_PCM_WRITE;
 			if (send_socket(sockfd, &client_type, sizeof(client_type)) == sizeof(client_type)) {
-				a2dp->sk = sockfd;
-				syslog(LOG_INFO, "Connected a2dp %p, sk %d", a2dp, a2dp->sk);
+				// Fill stream informations
+				AUDIOSTREAMINFOS StreamInfos = INVALIDAUDIOSTREAMINFOS;
+				StreamInfos.rate = a2dp->rate;
+				StreamInfos.channels = a2dp->channels;
+				StreamInfos.bitspersample = a2dp->frame_bytes/a2dp->channels;
+				switch(a2dp->io.format) {
+				case SND_PCM_FORMAT_S8:     StreamInfos.format = A2DPD_PCM_FORMAT_S8; break;
+				case SND_PCM_FORMAT_U8:     StreamInfos.format = A2DPD_PCM_FORMAT_U8; break;
+				case SND_PCM_FORMAT_S16_LE: StreamInfos.format = A2DPD_PCM_FORMAT_S16_LE; break;
+				default: StreamInfos.format = A2DPD_PCM_FORMAT_UNKNOWN; break;
+				}
+				if (send_socket(sockfd, &StreamInfos, sizeof(StreamInfos)) == sizeof(StreamInfos)) {
+					a2dp->sk = sockfd;
+					syslog(LOG_INFO, "Connected a2dp %p, sk %d, fps %f", a2dp, a2dp->sk, a2dp->TimerInfos.fps);
+				} else {
+					syslog(LOG_WARNING, "Couldn't send stream informations");
+					a2dp_disconnect(a2dp);
+				}
 			} else {
 				close_socket(sockfd);
 				syslog(LOG_WARNING, "Connected a2dp %p, sk %d, Authorisation failed", a2dp, a2dp->sk);
@@ -102,28 +117,18 @@
 static inline snd_pcm_a2dp_t *a2dp_alloc(void)
 {
 	snd_pcm_a2dp_t *a2dp;
-	DBG("Init");
 	a2dp = malloc(sizeof(*a2dp));
-	if (!a2dp)
-		return NULL;
-	memset(a2dp, 0, sizeof(*a2dp));
-	a2dp->sk = -1;
-
-	{
-		get_config_filename(g_srcfilename, sizeof(g_srcfilename));
-		int rate = read_config_int(g_srcfilename, "a2dpd", "rate", A2DPD_FRAME_RATE);
-		a2dp->TimerInfos.fps = (float) ((((float) rate) * ((float) A2DPD_FRAME_BYTES) / ((float) A2DPD_BLOCK_SIZE)) / 1.0);
+	if (a2dp) {
+		memset(a2dp, 0, sizeof(*a2dp));
+		a2dp->sk = -1;
 	}
-	DBG("OK");
 	return a2dp;
 }
 
 static inline void a2dp_free(snd_pcm_a2dp_t * a2dp)
 {
-	DBG("Finishing");
 	a2dp_disconnect(a2dp);
 	free(a2dp);
-	DBG("OK");
 }
 
 static int a2dp_start(snd_pcm_ioplug_t * io)
@@ -180,14 +185,14 @@
 
 // also works but sleeps between transfers
 // This is the main transfer func which does the transfer and sleep job
-static snd_pcm_sframes_t a2dp_transfer_all(snd_pcm_ioplug_t * io, const snd_pcm_channel_area_t * areas, snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
+static snd_pcm_sframes_t a2dp_transfer_all(snd_pcm_ioplug_t * io, const snd_pcm_channel_area_t * areas, snd_pcm_uframes_t offset, snd_pcm_uframes_t nframes)
 {
 	snd_pcm_a2dp_t *a2dp = io->private_data;
 	int i = 0;
 	snd_pcm_sframes_t totaltransfered = 0;
-	while (i++ < 1 && totaltransfered < size) {
+	while (i++ < 1 && totaltransfered < nframes) {
 		char *buf = (char *) areas->addr + (areas->first + areas->step * offset) / 8;
-		int datatoread = min(A2DPD_BLOCK_SIZE, size * a2dp->frame_bytes);
+		int datatoread = min(A2DPD_BLOCK_SIZE, nframes * a2dp->frame_bytes);
 		snd_pcm_sframes_t transfered = a2dp_transfer2(io, buf, datatoread);
 		if (transfered > 0) {
 			offset += transfered;
@@ -212,15 +217,13 @@
 	snd_pcm_a2dp_t *a2dp = io->private_data;
 	unsigned int period_bytes;
 
-	DBG("a2dp %p", a2dp);
-
 	a2dp->frame_bytes = (snd_pcm_format_physical_width(io->format) * io->channels) / 8;
 
 	period_bytes = io->period_size * a2dp->frame_bytes;
 
-	DBG("format %s rate %d channels %d", snd_pcm_format_name(io->format), io->rate, io->channels);
+//	DBG("format %s rate %d channels %d", snd_pcm_format_name(io->format), io->rate, io->channels);
 
-	DBG("frame_bytes %d period_bytes %d period_size %ld buffer_size %ld", a2dp->frame_bytes, period_bytes, io->period_size, io->buffer_size);
+//	DBG("frame_bytes %d period_bytes %d period_size %ld buffer_size %ld", a2dp->frame_bytes, period_bytes, io->period_size, io->buffer_size);
 
 	return 0;
 }
@@ -228,17 +231,20 @@
 static int a2dp_prepare(snd_pcm_ioplug_t * io)
 {
 	snd_pcm_a2dp_t *a2dp = io->private_data;
-	DBG("a2dp %p", a2dp);
+
 	a2dp->num = 0;
 	a2dp->rate = io->rate;
 	a2dp->channels = io->channels;
+
+	a2dp->TimerInfos.fps = (float) ((((float)a2dp->rate) * ((float) a2dp->frame_bytes) / ((float) A2DPD_BLOCK_SIZE)) / 1.0);
+
 	return 0;
 }
 
 static int a2dp_drain(snd_pcm_ioplug_t * io)
 {
-	snd_pcm_a2dp_t *a2dp = io->private_data;
-	DBG("a2dp %p", a2dp);
+//	snd_pcm_a2dp_t *a2dp = io->private_data;
+//	DBG("a2dp %p", a2dp);
 	return 0;
 }
 
@@ -250,7 +256,7 @@
 static int a2dp_descriptors(snd_pcm_ioplug_t * io, struct pollfd *pfds, unsigned int space)
 {
 	if (space < 1) {
-		DBG("Can't fill in descriptors");
+//		DBG("Can't fill in descriptors");
 		SNDERR("Can't fill in descriptors");
 		return 0;
 	}
@@ -291,42 +297,59 @@
 	.poll_revents = a2dp_poll,
 };
 
-// Force alsa to give use the 44100 hz sound
-// Or say alsa we will accept only 44100hz?
+// Alsa can convert about any format/channels/rate to any other rate
+// However, since we added some code in the daemon to convert, why not do it ourselves!!!
+// Moreover some player like aplay won't play a wav file if the device that do not natively support the requested format
+// If you want alsa to do the conversion, just remove the value you want to see converted
 static int a2dp_constraint(snd_pcm_a2dp_t * a2dp)
 {
 	snd_pcm_ioplug_t *io = &a2dp->io;
-	snd_pcm_access_t access_list[] = {
-		SND_PCM_ACCESS_RW_INTERLEAVED,
-		SND_PCM_ACCESS_MMAP_INTERLEAVED,
-	};
-	unsigned int format[2], channel[2], rate[2];
+	#define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
+	snd_pcm_access_t access_list[] = { SND_PCM_ACCESS_RW_INTERLEAVED };
+	unsigned int formats[] = { SND_PCM_FORMAT_U8, SND_PCM_FORMAT_S8, SND_PCM_FORMAT_S16_LE };
+	unsigned int channels[] = { 1, 2 };
+	unsigned int rates[] = { 8000, 11025, 22050, 32000, 44100, 48000 };
+	int formats_nb = ARRAY_SIZE(formats);
+	int channels_nb = ARRAY_SIZE(channels);
+	int rates_nb = ARRAY_SIZE(rates);
+	int rate_daemon = 0;
+	int rate_prefered = 0;
+	char srcfilename[512];
 	int err;
 
+	get_config_filename(srcfilename, sizeof(srcfilename));
+	// Default is same as the daemon
+	rate_daemon = read_config_int(srcfilename, "a2dpd", "rate", A2DPD_FRAME_RATE);
+	// If a value is specified, use it
+	rate_prefered = read_config_int(srcfilename, "a2dpd", "plugin-rate", rate_daemon);
+	// If this value is not 0, alsa will convert to plugin-rate
+	if(rate_prefered != 0) {
+		// use defaults settings the rate specified + 16 bits stereo
+		rates[0] = rate_prefered;
+		rates_nb = 1;
+		formats[0] = SND_PCM_FORMAT_S16_LE;
+		formats_nb = 1;
+		channels[0] = 2;
+		channels_nb = 1;
+	} else {
+		// If this value is 0, the daemon will do most conversions
+	}
+
 	syslog(LOG_INFO, "[build %s %s] a2dp %p", __DATE__, __TIME__, a2dp);
 
-	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS, 2, access_list);
+	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS, ARRAY_SIZE(access_list), access_list);
 	if (err < 0)
 		return err;
 
-	format[0] = SND_PCM_FORMAT_S16_LE;
-
-	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT, 1, format);
+	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT, formats_nb, formats);
 	if (err < 0)
 		return err;
 
-	channel[0] = 1;
-	channel[1] = 2;
-
-	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_CHANNELS, 2, channel);
+	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_CHANNELS, channels_nb, channels);
 	if (err < 0)
 		return err;
 
-	get_config_filename(g_srcfilename, sizeof(g_srcfilename));
-	rate[0] = read_config_int(g_srcfilename, "a2dpd", "rate", A2DPD_FRAME_RATE);
-	//rate[1] = 48000;
-
-	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_RATE, 1, rate);
+	err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_RATE, rates_nb, rates);
 	if (err < 0)
 		return err;
 
@@ -347,7 +370,7 @@
 	snd_config_iterator_t i, next;
 	int err = 0;
 
-	DBG("name %s mode %d", name, mode);
+//	DBG("name %s mode %d", name, mode);
 
 	// set up thread signal handler
 	signal(SIGPIPE, sighand);
@@ -375,8 +398,6 @@
 		SNDERR("Can't allocate plugin data");
 		return -ENOMEM;
 	}
-	// Connect
-	a2dp_connect(a2dp);
 
 	// Notify plugin
 	a2dp->io.version = SND_PCM_IOPLUG_VERSION;
Index: alsa-plugins/sample.a2dprc
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/sample.a2dprc,v
retrieving revision 1.3
diff -u -r1.3 sample.a2dprc
--- alsa-plugins/sample.a2dprc	6 Sep 2006 02:59:43 -0000	1.3
+++ alsa-plugins/sample.a2dprc	7 Nov 2006 15:41:24 -0000
@@ -2,15 +2,26 @@
 #
 # Rate
 # use 32000 if your headset seems to not support 44100 (HP works well at 44100, Sonorix at 32000)
-# Alsa output may not work depending on your graphics card
-# Very few players supports it (xmms does, but not amarok/gxine engine)
+# However, 44100 is mandatory
 #
 rate=44100
 #rate=32000
+
+#
+# plugin-rate default is the rate used between the plugin and the daemon
+# if this value is 0 then 
+# if this value is not 0 then alsa will convert all stream to the specified rate and then send it to the daemon
+# if this value is 0, then alsa will do no conversion at all, the daemon will do it's own resampling.
+# This "features" is disabled because of the crappy quality of the daemon resampler
+# To test a2dpd resampling from 32000 to 44100 use plugin-rate=32000 and rate=44100
+#plugin-rate=32000
+
+# Recommended
 enablereversestereo=1
 
 #
 # AVRCP Commands to run
+# If these entries are emptied, then some keyboard entry will be sent to /dev/uinput
 #
 cmdplay=xmms --play
 cmdpause=xmms --pause

--------------000503060805030604010400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------000503060805030604010400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000503060805030604010400--
