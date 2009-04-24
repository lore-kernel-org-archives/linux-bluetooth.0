Return-Path: <cyrus@holtmann.org>
From: Sandro Giessl <s.giessl@niftylight.de>
To: linux-bluetooth@vger.kernel.org
Subject: bluez dfutool: patch & questions
Date: Fri, 24 Apr 2009 03:29:12 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oXR8JY+nLW7j+MG"
Message-Id: <200904240329.12596.s.giessl@niftylight.de>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_oXR8JY+nLW7j+MG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Marcel and others,

I'm developing DFU capabilities for a ARM7 STM32 based device. As I've been 
new to DFU this wasn't a straigt forward process for me, but my endeavors are 
slowly paying off. :) I must say that I've been glad to find dfutool. It was 
very helpful to have a lean code base I was able to modify as I whished and 
that could easily be stepped through with gdb.

While the device by now can be programmed more or less using the stock 
dfutool, I have made some modifications (based on 
http://www.usb.org/developers/devclass_docs/usbdfu10.pdf) that may be useful 
to others; these are mainly:

- When waiting for the DNLOAD_BUSY -> idle state transition, do not sleep 1s, 
but use the timeout suggested by the device in the state response. makes the 
upgrade a little bit quicker.

- Between the last download request in the loop and the EOF (zero length) 
download-request, there should also be repeated get_status requests; otherwise 
the EOF-download request would fail (for me, it did).
The patch fixes it this way: basically, the order of get_status and download 
within the download loop should better be reversed, in my eyes. Download 
should be first, and get_status should wait for idle state.

- After the EOF download request, some devices want to get put into 
manifestation state (initiated by get_status) where the write operation could 
be finished and the device can reset itself. I have implemented this.


I didn't find information about the current state and goals for dfutool. Would 
you mind elaborating a little about this?
Is dfutool only targeted at bluetooth device firmware upgrades? Does it cover 
the full range of bluetooth devices (this would surprise me since DFU protocol 
implementations seem to differ from device to device. there are various 
different tools for linux, each with its own strength/weakness/list of 
supported target devices)? 

I'm curious about any experience of how devices in practise do differ in 
details when talking to them via DFU. With DfuSe by STMicroelectronics there 
is an effort of an DFU extension that allows devices to announce their 
capabilities (memory layout, alternative memory settings to choose from, add 
generic 'function' list and functions such as LIST_FUNCTIONS, SET_POINTER, 
ERASE). I'm not considering to use it since it appears to be a little complex 
for simple consumer devices. I consider it dangerous as well, since 
SET_POINTER/ERASE allows to access any memory area, not just the one reserved 
for the firmware image, possibly making the device not recoverable via DFU. 
And ironically, is incompatible to most dfu tools because in UPLOAD/DOWNLOAD 
requests, the blocks 0 and 1 are reserved for the generic function extension 
thing (data blocks are numbered from 2 to n instead of 0 to n. when used with 
e.g. dfutool, the device would get into STATUS_ERRSTALLEDPKT because it's 
forbidden to DNLOAD to block 1).

Another question regarding the hardcoded upload/download packet size of 1023 
bytes (in dfutool.c): Why this and not e.g. 1024? (I'm going to use a fixed 
size of 1024 because this allows usb firmware code to erase one page of flash 
memory and program it in one go).

Best regards,
Sandro

--Boundary-00=_oXR8JY+nLW7j+MG
Content-Type: text/x-patch;
  charset="UTF-8";
  name="bluez-4.12-dfutool.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-4.12-dfutool.diff"

--- /tmp/bluez-4.12/tools/dfutool.c	2008-08-05 23:14:56.000000000 +0200
+++ dfutool.c	2009-04-24 02:38:24.000000000 +0200
@@ -73,6 +73,8 @@ static inline struct usb_bus *usb_get_bu
 #define USB_CLASS_APPLICATION	0xfe
 #endif
 
+#define DFU_PACKETSIZE 1023
+
 static int get_interface_number(struct usb_device *dev)
 {
 	int c, i, a;
@@ -412,14 +414,84 @@ static void cmd_modify(char *device, int
 {
 }
 
+static int state_request_retry(struct usb_dev_handle *udev, int do_timeout_sleep, int try)
+{
+    unsigned long timeout = 0;
+    struct dfu_status status;
+
+    while(1)
+    {
+        if (dfu_get_status(udev, 0, &status) < 0) {
+            if (try-- > 0) {
+                sleep(1);
+                continue;
+            }
+            printf("Can't get status: %s (%d)\n", strerror(errno), errno);
+            return -1;
+        }
+
+        if (status.bStatus != DFU_OK) {
+            if (try-- > 0) {
+                dfu_clear_status(udev, 0);
+                sleep(1);
+                continue;
+            }
+            printf("Firmware download ... aborting (status %d state %d)\n",
+                   status.bStatus, status.bState);
+            return -1;
+        }
+
+        if(do_timeout_sleep)
+        {
+            timeout = (status.bwPollTimeout[2] << 16) |
+                (status.bwPollTimeout[1] << 8) |
+                status.bwPollTimeout[0];
+
+            usleep(timeout * 1000);
+        }
+
+        return status.bState;
+    }
+
+    /* not reached */
+    return -1;
+}
+
+static int state_request(struct usb_dev_handle *udev, int do_timeout_sleep)
+{
+    return state_request_retry(udev, do_timeout_sleep, 10);
+}
+
+/* return amount of bytes written, or -1 on error. */
+static int download_request(struct usb_dev_handle *udev, int intf, int block, char *buffer, int size)
+{
+    int len = -1;
+    int try = 10;
+
+    while(len < 0)
+    {
+        len = dfu_download(udev, 0, block, buffer, size);
+        if (len < 0) {
+            if (try-- > 0) {
+                /* try again */
+                sleep(1);
+                continue;
+            }
+            printf("Can't upload next block: %s (%d)\n", strerror(errno), errno);
+            return -1;
+        }
+    }
+
+    return len;
+}
+
 static void cmd_upgrade(char *device, int argc, char **argv)
 {
 	struct usb_dev_handle *udev;
-	struct dfu_status status;
 	struct dfu_suffix suffix;
 	struct stat st;
 	char *buf;
-	unsigned long filesize, count, timeout = 0;
+	unsigned long filesize, count;
 	char *filename;
 	uint32_t crc, dwCRC;
 	int fd, i, block, len, size, sent = 0, try = 10;
@@ -488,52 +560,67 @@ static void cmd_upgrade(char *device, in
 	count = filesize - DFU_SUFFIX_SIZE;
 	block = 0;
 
-	while (count) {
-		size = (count > 1023) ? 1023 : count;
-
-		if (dfu_get_status(udev, 0, &status) < 0) {
-			if (try-- > 0) {
-				sleep(1);
-				continue;
-			}
-			printf("\rCan't get status: %s (%d)\n", strerror(errno), errno);
-			goto done;
-		}
-
-		if (status.bStatus != DFU_OK) {
-			if (try-- > 0) {
-				dfu_clear_status(udev, 0);
-				sleep(1);
-				continue;
-			}
-			printf("\rFirmware download ... aborting (status %d state %d)\n",
-						status.bStatus, status.bState);
-			goto done;
-		}
-
-		if (status.bState != DFU_STATE_DFU_IDLE &&
-				status.bState != DFU_STATE_DFU_DNLOAD_IDLE) {
-			sleep(1);
-			continue;
-		}
+        /* ensure the device is in DFU_STATE_DFU_IDLE */
 
-		timeout = (status.bwPollTimeout[2] << 16) |
-				(status.bwPollTimeout[1] << 8) |
-					status.bwPollTimeout[0];
+        while(1)
+        {
+            int state;
+            if ( (state = state_request(udev, 1)) < 0) {
+                if (try-- > 0) {
+                    sleep(1);
+                    continue;
+                }
+                printf("\rCan't get status: %s (%d)\n", strerror(errno), errno);
+                goto done;
+            }
+
+            if(state != DFU_STATE_DFU_IDLE)
+            {
+                printf("\rDevice is not ready to download firmware ... aborting (state %d)\n",
+                       state);
+                goto done;
+            }
+
+            /* success */
+            break;
+        }
 
-		usleep(timeout * 1000);
+	while (count) {
+		size = (count > DFU_PACKETSIZE) ? DFU_PACKETSIZE : count;
 
-		len = dfu_download(udev, 0, block, buf + sent, size);
+                len = download_request(udev, 0, block, buf+sent, size);
 		if (len < 0) {
 			if (try-- > 0) {
 				sleep(1);
 				continue;
 			}
-			printf("\rCan't upload next block: %s (%d)\n", strerror(errno), errno);
+			printf("Can't upload next block.\n");
 			goto done;
 		}
 
-		printf("\rFirmware download ... %d bytes ", block * 1023 + len);
+                while(1)
+                {
+                    /* get state & wait the amount that was requested
+                       by device */
+                    int state = state_request(udev, 1);
+                    if(state < 0) {
+                        goto done;
+                    }
+
+                    if (state == DFU_STATE_DFU_IDLE ||
+                        state == DFU_STATE_DFU_DNLOAD_IDLE) {
+                        /* success */
+                        break;
+                    }
+                    else if(state != DFU_STATE_DFU_DNLOAD_BUSY)
+                    {
+                        /* error, unexpected state received */
+                        printf("Received unknown state while waiting for DNLOAD_BUSY -> DNLOAD_IDLE transition.\n");
+                        goto done;
+                    }
+                }
+
+		printf("\rFirmware download ... %d of %ld bytes ", block * DFU_PACKETSIZE + len, sent+count);
 		fflush(stdout);
 
 		sent  += len;
@@ -547,24 +634,58 @@ static void cmd_upgrade(char *device, in
 
 	sleep(1);
 
-	if (dfu_get_status(udev, 0, &status) < 0) {
-		printf("\rCan't get status: %s (%d)\n", strerror(errno), errno);
-		goto done;
-	}
-
-	timeout = (status.bwPollTimeout[2] << 16) |
-			(status.bwPollTimeout[1] << 8) |
-				status.bwPollTimeout[0];
+        /* mark the end of file (EOF) to the device by sending block of zero size */
+        if(download_request(udev, 0, block, NULL, 0) < 0)
+        {
+            printf("\nCan't send final block informing device of EOF.\n");
+            goto done;
+        }
+        /* get state & wait the amount that was requested
+           by device */
+        int state = state_request(udev, 1);
+        if(state < 0) {
+            goto done;
+        }
+        else if (state == DFU_STATE_DFU_IDLE) {
+            /* device does not offer manifestation state? quit. */
+        }
+        else if(state == DFU_STATE_DFU_MANIFEST) {
+            /* do manifestation... wait for either dfuIDLE, or dfuMAINIFEST-WAIT-RESET */
+            printf("Doing DFU manifestation.\n");
+            while(1)
+            {
+                state = state_request_retry(udev, 1, 0);
+                if(state < 0) {
+                    /* the device has probably reset itself. this is no error. */
+                    printf("Device reset after manifestation.\n");
+                    break;
+                }
+                else if(state == DFU_STATE_DFU_MANIFEST_SYNC) {
+                    /* manifestation still in progress, poll status again. */
+                    continue;
+                }
+                else if(state == DFU_STATE_DFU_IDLE) {
+                    /* manifestation done. quit. */
+                    break;
+                }
+                else if(state == DFU_STATE_MANIFEST_WAIT_RESET)
+                {
+                    /* initiate device reset. then quit. */
+                    usb_reset(udev);
+                    break;
+                }
+                else
+                {
+                    printf("Received unknown state while waiting for dfuMANIFEST -> (dfuIDLE|dfuMANIFEST_WAIT_RESET) transition.\n");
+                    goto done;
+                }
+            }
+        } else {
+            /* error, unexpected state received */
+            printf("Received unknown state while waiting for dfuDNLOAD_IDLE -> (dfuMANIFEST|dfuIDLE) transition.\n");
+            goto done;
+        }
 
-	usleep(timeout * 1000);
-
-	if (count == 0) {
-		len = dfu_download(udev, 0, block, NULL, 0);
-		if (len < 0) {
-			printf("\rCan't send final block: %s (%d)\n", strerror(errno), errno);
-			goto done;
-		}
-	}
 
 	printf("\r" "          " "          " "          " "          " "          ");
 	printf("\rWaiting for device ... ");
@@ -650,7 +771,7 @@ static void cmd_archive(char *device, in
 
 		usleep(timeout * 1000);
 
-		len = dfu_upload(udev, 0, n, buf, 1023);
+		len = dfu_upload(udev, 0, n, buf, DFU_PACKETSIZE);
 		if (len < 0) {
 			if (try-- > 0) {
 				sleep(1);
@@ -660,7 +781,7 @@ static void cmd_archive(char *device, in
 			goto done;
 		}
 
-		printf("\rFirmware upload ... %d bytes ", n * 1023 + len);
+		printf("\rFirmware upload ... %d bytes ", n * DFU_PACKETSIZE + len);
 		fflush(stdout);
 
 		for (i = 0; i < len; i++)
@@ -674,7 +795,10 @@ static void cmd_archive(char *device, in
 		}
 
 		n++;
-		if (len != 1023)
+
+/*                 printf("\nFirmware upload ... got %d bytes \n", len); */
+
+		if (len != DFU_PACKETSIZE)
 			break;
 	}
 	printf("\n");

--Boundary-00=_oXR8JY+nLW7j+MG--
