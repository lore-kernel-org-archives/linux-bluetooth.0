Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 15/17] bccmd: Fix overwriting errno value
Date: Wed, 16 Nov 2011 09:20:02 -0400
Message-Id: <1321449604-4188-16-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On error, transport_read() returns -1 and sets errno.
---
 tools/bccmd.c |   32 ++++++++------------------------
 1 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/tools/bccmd.c b/tools/bccmd.c
index ca9302c..952bf13 100644
--- a/tools/bccmd.c
+++ b/tools/bccmd.c
@@ -253,10 +253,8 @@ static int cmd_builddef(int transport, int argc, char *argv[])
 		array[1] = def >> 8;
 
 		err = transport_read(transport, CSR_VARID_GET_NEXT_BUILDDEF, array, 8);
-		if (err < 0) {
-			errno = -err;
+		if (err < 0)
 			break;
-		}
 
 		nextdef = array[2] | (array[3] << 8);
 
@@ -286,10 +284,8 @@ static int cmd_keylen(int transport, int argc, char *argv[])
 	array[1] = handle >> 8;
 
 	err = transport_read(transport, CSR_VARID_CRYPT_KEY_LENGTH, array, 8);
-	if (err < 0) {
-		errno = -err;
+	if (err < 0)
 		return -1;
-	}
 
 	handle = array[0] | (array[1] << 8);
 	keylen = array[2] | (array[3] << 8);
@@ -310,10 +306,8 @@ static int cmd_clock(int transport, int argc, char *argv[])
 	memset(array, 0, sizeof(array));
 
 	err = transport_read(transport, CSR_VARID_BT_CLOCK, array, 8);
-	if (err < 0) {
-		errno = -err;
+	if (err < 0)
 		return -1;
-	}
 
 	clock = array[2] | (array[3] << 8) | (array[0] << 16) | (array[1] << 24);
 
@@ -333,10 +327,8 @@ static int cmd_rand(int transport, int argc, char *argv[])
 	memset(array, 0, sizeof(array));
 
 	err = transport_read(transport, CSR_VARID_RAND, array, 8);
-	if (err < 0) {
-		errno = -err;
+	if (err < 0)
 		return -1;
-	}
 
 	rand = array[0] | (array[1] << 8);
 
@@ -357,10 +349,8 @@ static int cmd_chiprev(int transport, int argc, char *argv[])
 	memset(array, 0, sizeof(array));
 
 	err = transport_read(transport, CSR_VARID_CHIPREV, array, 8);
-	if (err < 0) {
-		errno = -err;
+	if (err < 0)
 		return -1;
-	}
 
 	rev = array[0] | (array[1] << 8);
 
@@ -417,10 +407,8 @@ static int cmd_buildname(int transport, int argc, char *argv[])
 	memset(array, 0, sizeof(array));
 
 	err = transport_read(transport, CSR_VARID_READ_BUILD_NAME, array, 128);
-	if (err < 0) {
-		errno = -err;
+	if (err < 0)
 		return -1;
-	}
 
 	for (i = 0; i < sizeof(name); i++)
 		name[i] = array[(i * 2) + 4];
@@ -441,10 +429,8 @@ static int cmd_panicarg(int transport, int argc, char *argv[])
 	memset(array, 0, sizeof(array));
 
 	err = transport_read(transport, CSR_VARID_PANIC_ARG, array, 8);
-	if (err < 0) {
-		errno = -err;
+	if (err < 0)
 		return -1;
-	}
 
 	error = array[0] | (array[1] << 8);
 
@@ -465,10 +451,8 @@ static int cmd_faultarg(int transport, int argc, char *argv[])
 	memset(array, 0, sizeof(array));
 
 	err = transport_read(transport, CSR_VARID_FAULT_ARG, array, 8);
-	if (err < 0) {
-		errno = -err;
+	if (err < 0)
 		return -1;
-	}
 
 	error = array[0] | (array[1] << 8);
 
-- 
1.7.0.4

