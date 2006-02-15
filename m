Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_m2n8DDDRA9GlHNM"
Message-Id: <200602151102.30162.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] sdptool/hciconfig patches
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 15 Feb 2006 11:02:30 +1000

--Boundary-00=_m2n8DDDRA9GlHNM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D Fix a small bug in hciconfig which prevents it from displaying the corr=
ect=20
category of =A0Peripheral or Imaging or Uncategorized device class devices=
=20
(reports as invalid)
=2D Capability for sdptool to perform searches by 16/32/128 bit uuids

=2DDenis

--Boundary-00=_m2n8DDDRA9GlHNM
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="bluez-libs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-libs.patch"

Index: include/sdp_lib.h
===================================================================
RCS file: /cvsroot/bluez/libs/include/sdp_lib.h,v
retrieving revision 1.14
diff -u -r1.14 sdp_lib.h
--- include/sdp_lib.h	3 Jan 2006 12:56:09 -0000	1.14
+++ include/sdp_lib.h	15 Feb 2006 00:46:21 -0000
@@ -442,6 +442,8 @@
 int sdp_svclass_uuid2strn(const uuid_t *uuid, char *str, size_t n);
 int sdp_profile_uuid2strn(const uuid_t *uuid, char *str, size_t n);
 
+int sdp_extract_uuid_from_string(uint128_t *dst, const char *str);
+
 /*
  * In all the sdp_get_XXX(handle, XXX *xxx) functions below, 
  * the XXX * is set to point to the value, should it exist
Index: src/sdp.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/sdp.c,v
retrieving revision 1.37
diff -u -r1.37 sdp.c
--- src/sdp.c	17 Jan 2006 10:39:37 -0000	1.37
+++ src/sdp.c	15 Feb 2006 00:46:21 -0000
@@ -2031,6 +2031,89 @@
 	sdp_attr_add_new(rec, SDP_ATTR_ICON_URL, SDP_URL_STR8, icon);
 }
 
+/* Extract a 128-bit number from a UUID formed string
+   returns -1 on failure, 0 on success
+*/
+int sdp_extract_uuid_from_string(uint128_t *dst, const char *str)
+{
+	char baseStr[128];
+	int delim = '-';
+	unsigned long dataLongValue;
+	char *delimPtr;
+	char *dataPtr;
+	char temp[10];
+	int toBeCopied;
+	uint8_t *data;
+
+	if (str == NULL)
+		return -1;
+
+	if (dst == NULL)
+		return -1;
+
+	strcpy(baseStr, str);
+	data = dst->data;
+	memset(data, '\0', sizeof(uint128_t));
+	memset(temp, '\0', 10);
+	dataPtr = baseStr;
+	delimPtr = NULL;
+	delimPtr = strchr(dataPtr, delim);
+	toBeCopied = delimPtr - dataPtr;
+	if (toBeCopied != 8) {
+		SDPDBG("To be copied(1) : %d\n", toBeCopied);
+		return -1;
+	}
+	strncpy(temp, dataPtr, toBeCopied);
+	dataLongValue = htonl(strtoul(temp, NULL, 16));
+	memcpy(&data[0], &dataLongValue, 4);
+
+	/*
+	 * Get the next 4 bytes (note that there is a "-"
+	 * between them now)
+	 */
+	memset(temp, '\0', 10);
+	dataPtr = delimPtr + 1;
+	delimPtr = strchr(dataPtr, delim);
+	toBeCopied = delimPtr - dataPtr;
+	if (toBeCopied != 4) {
+		SDPDBG("To be copied(2) : %d\n", toBeCopied);
+		return -1;
+	}
+	strncpy(temp, dataPtr, toBeCopied);
+	dataPtr = delimPtr + 1;
+	delimPtr = strchr(dataPtr, delim);
+	toBeCopied = delimPtr - dataPtr;
+	if (toBeCopied != 4) {
+		SDPDBG("To be copied(3) : %d\n", toBeCopied);
+		return -1;
+	}
+	strncat(temp, dataPtr, toBeCopied);
+	dataLongValue = htonl(strtoul(temp, NULL, 16));
+	memcpy(&data[4], &dataLongValue, 4);
+
+	/*
+	 * Get the last 4 bytes (note that there are 6 bytes
+	 * after the last separator, which is truncated (2+4)
+	 */
+	memset(temp, '\0', 10);
+	dataPtr = delimPtr + 1;
+	dataPtr = delimPtr + 1;
+	delimPtr = strchr(dataPtr, delim);
+	toBeCopied = delimPtr - dataPtr;
+	if (toBeCopied != 4) {
+		SDPDBG("To be copied(4) : %d\n", toBeCopied);
+		return -1;
+	}
+	strncpy(temp, dataPtr, toBeCopied);
+	strncat(temp, (delimPtr + 1), 4);
+	dataLongValue = htonl(strtoul(temp, NULL, 16));
+	memcpy(&data[8], &dataLongValue, 4);
+	dataLongValue = htonl(strtoul(delimPtr + 5, NULL, 16));
+	memcpy(&data[12], &dataLongValue, 4);
+
+	return 0;
+}
+
 /*
  * The code in this function is executed only once per
  * thread. We compute the actual bit value of the Bluetooth
@@ -2043,77 +2126,15 @@
  */
 uint128_t *sdp_create_base_uuid(void)
 {
-	char baseStr[128];
-	int delim = '-';
-	unsigned long dataLongValue;
-	char *delimPtr;
-	char *dataPtr;
-	char temp[10];
-	int toBeCopied;
-	uint8_t *data;
-
 	if (bluetooth_base_uuid == NULL) {
-		strcpy(baseStr, BASE_UUID);
 		bluetooth_base_uuid = (uint128_t *)malloc(sizeof(uint128_t));
-		data = bluetooth_base_uuid->data;
-		memset(data, '\0', sizeof(uint128_t));
-		memset(temp, '\0', 10);
-		dataPtr = baseStr;
-		delimPtr = NULL;
-		delimPtr = strchr(dataPtr, delim);
-		toBeCopied = delimPtr - dataPtr;
-		if (toBeCopied != 8) {
-			SDPDBG("To be copied(1) : %d\n", toBeCopied);
+		if (sdp_extract_uuid_from_string(bluetooth_base_uuid, BASE_UUID) != 0) {
+			free(bluetooth_base_uuid);
+			bluetooth_base_uuid = NULL;
 			return NULL;
 		}
-		strncpy(temp, dataPtr, toBeCopied);
-		dataLongValue = htonl(strtoul(temp, NULL, 16));
-		memcpy(&data[0], &dataLongValue, 4);
-
-		/*
-		 * Get the next 4 bytes (note that there is a "-"
-		 * between them now)
-		 */
-		memset(temp, '\0', 10);
-		dataPtr = delimPtr + 1;
-		delimPtr = strchr(dataPtr, delim);
-		toBeCopied = delimPtr - dataPtr;
-		if (toBeCopied != 4) {
-			SDPDBG("To be copied(2) : %d\n", toBeCopied);
-			return NULL;
-		}
-		strncpy(temp, dataPtr, toBeCopied);
-		dataPtr = delimPtr + 1;
-		delimPtr = strchr(dataPtr, delim);
-		toBeCopied = delimPtr - dataPtr;
-		if (toBeCopied != 4) {
-			SDPDBG("To be copied(3) : %d\n", toBeCopied);
-			return NULL;
-		}
-		strncat(temp, dataPtr, toBeCopied);
-		dataLongValue = htonl(strtoul(temp, NULL, 16));
-		memcpy(&data[4], &dataLongValue, 4);
-
-		/*
-		 * Get the last 4 bytes (note that there are 6 bytes
-		 * after the last separator, which is truncated (2+4)
-		 */
-		memset(temp, '\0', 10);
-		dataPtr = delimPtr + 1;
-		dataPtr = delimPtr + 1;
-		delimPtr = strchr(dataPtr, delim);
-		toBeCopied = delimPtr - dataPtr;
-		if (toBeCopied != 4) {
-			SDPDBG("To be copied(4) : %d\n", toBeCopied);
-			return NULL;
-		}
-		strncpy(temp, dataPtr, toBeCopied);
-		strncat(temp, (delimPtr + 1), 4);
-		dataLongValue = htonl(strtoul(temp, NULL, 16));
-		memcpy(&data[8], &dataLongValue, 4);
-		dataLongValue = htonl(strtoul(delimPtr + 5, NULL, 16));
-		memcpy(&data[12], &dataLongValue, 4);
 	}
+
 	return bluetooth_base_uuid;
 }
 

--Boundary-00=_m2n8DDDRA9GlHNM
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="bluez-utils.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-utils.patch"

Index: tools/hciconfig.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hciconfig.c,v
retrieving revision 1.76
diff -u -r1.76 hciconfig.c
--- tools/hciconfig.c	3 Jan 2006 13:29:03 -0000	1.76
+++ tools/hciconfig.c	15 Feb 2006 00:46:39 -0000
@@ -676,7 +676,7 @@
 		} else
 			printf("Unspecified");
 		printf("\n\tDevice Class: ");
-		if ((cls[1] & 0x1f) > sizeof(*major_devices))
+		if ((cls[1] & 0x1f) >= sizeof(major_devices) / sizeof(*major_devices))
 			printf("Invalid Device Class!\n");
 		else
 			printf("%s, %s\n", major_devices[cls[1] & 0x1f],
Index: tools/sdptool.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/sdptool.c,v
retrieving revision 1.54
diff -u -r1.54 sdptool.c
--- tools/sdptool.c	8 Feb 2006 11:16:47 -0000	1.54
+++ tools/sdptool.c	15 Feb 2006 00:46:40 -0000
@@ -989,7 +989,10 @@
 
 	sdp_uuid2strn(uuid, UUID_str, MAX_LEN_UUID_STR);
 	sdp_svclass_uuid2strn(uuid, ServiceClassUUID_str, MAX_LEN_SERVICECLASS_UUID_STR);
-	printf("  \"%s\" (0x%s)\n", ServiceClassUUID_str, UUID_str);
+        if (uuid->type != SDP_UUID128)
+		printf("  \"%s\" (0x%s)\n", ServiceClassUUID_str, UUID_str);
+	else
+		printf("  UUID 128: %s\n", UUID_str);
 }
 
 static void print_service_desc(void *value, void *user)
@@ -3485,6 +3488,7 @@
 {
 	struct search_context context;
 	unsigned char *uuid = NULL;
+        uint128_t uuid128;
 	uint32_t class = 0;
 	bdaddr_t bdaddr;
 	int has_addr = 0;
@@ -3529,6 +3533,9 @@
 		sscanf(context.svc + 2, "%X", &num);
 		class = num;
 		printf("Class 0x%X\n", class);
+	}
+	else if (sdp_extract_uuid_from_string(&uuid128, context.svc) == 0) {
+		uuid = uuid128.data;
 	} else {
 		/* Convert class name to an UUID */
 

--Boundary-00=_m2n8DDDRA9GlHNM--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
