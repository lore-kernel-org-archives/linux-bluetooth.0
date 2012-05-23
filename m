Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org, marcel <marcel@holtmann.org>
Cc: "tedd.an" <tedd.an@intel.com>
Subject: [PATCH v2 2/3] hciattach: replace DBGPRINT macro with common debug print functions
Date: Tue, 22 May 2012 21:35:37 -0700
Message-ID: <1372810.LzkPS8x1vv@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch removes INTEL_DEBUG macro and replace DBGPRINT with common
debug print functions.

---
 tools/hciattach_intel.c |   46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/tools/hciattach_intel.c b/tools/hciattach_intel.c
index 9129993..ccb0a87 100644
--- a/tools/hciattach_intel.c
+++ b/tools/hciattach_intel.c
@@ -41,20 +41,6 @@
 
 #include "hciattach.h"
 
-#ifdef INTEL_DEBUG
-#define DBGPRINT(fmt, args...)	printf("DBG: " fmt "\n", ## args)
-#define PRINT_PACKET(buf, len, msg)	{	\
-	int i;					\
-	printf("%s\n", msg);			\
-	for (i = 0; i < len; i++)		\
-		printf("%02X ", buf[i]);	\
-	printf("\n");				\
-	}
-#else
-#define DBGPRINT(fmt, args...)
-#define PRINT_PACKET(buf, len, msg)
-#endif
-
 #define PATCH_SEQ_EXT           ".bseq"
 #define PATCH_FILE_PATH         "/lib/firmware/intel/"
 #define PATCH_MAX_LEN           260
@@ -90,7 +76,7 @@ static int intel_write_cmd(int dev, unsigned char *buf, int len)
 {
 	int ret;
 
-	PRINT_PACKET(buf, len, "<----- SEND CMD: ");
+	dbg_print_pkt("<----- SEND CMD: ", buf, len);
 
 	ret = write(dev, buf, len);
 	if (ret < 0)
@@ -113,7 +99,7 @@ static int intel_read_evt(int dev, unsigned char *buf, int len)
 	if (ret < 0)
 		return -1;
 
-	PRINT_PACKET(buf, ret, "-----> READ EVT: ");
+	dbg_print_pkt("-----> READ EVT: ", buf, ret);
 
 	return ret;
 }
@@ -125,18 +111,18 @@ static int validate_events(struct patch_entry *event,
 		struct patch_entry *entry)
 {
 	if (event == NULL || entry == NULL) {
-		DBGPRINT("invalid patch entry parameters");
+		dbg_print("invalid patch entry parameters");
 		return -1;
 	}
 
 	if (event->len != entry->len) {
-		DBGPRINT("lengths are mismatched:[%d|%d]",
+		dbg_print("lengths are mismatched:[%d|%d]",
 				event->len, entry->len);
 		return -1;
 	}
 
 	if (memcmp(event->data, entry->data, event->len)) {
-		DBGPRINT("data is mismatched");
+		dbg_print("data is mismatched");
 		return -1;
 	}
 
@@ -205,7 +191,7 @@ static int intel_download_patch(struct patch_ctx *ctx)
 	struct patch_entry entry;
 	struct patch_entry event;
 
-	DBGPRINT("start patch downloading");
+	dbg_print("start patch downloading");
 
 	do {
 		ret = get_next_patch_entry(ctx->fd, &entry);
@@ -237,7 +223,7 @@ static int intel_download_patch(struct patch_ctx *ctx)
 			event.len = ret;
 
 			if (validate_events(&event, &entry) < 0) {
-				DBGPRINT("events are mismatched");
+				dbg_print("events are mismatched");
 				ctx->patch_error = 1;
 				return -1;
 			}
@@ -259,11 +245,11 @@ static int open_patch_file(struct patch_ctx *ctx, char *fw_ver)
 
 	snprintf(patch_file, PATH_MAX, "%s%s%s", PATCH_FILE_PATH,
 			fw_ver, PATCH_SEQ_EXT);
-	DBGPRINT("PATCH_FILE: %s", patch_file);
+	dbg_print("PATCH_FILE: %s", patch_file);
 
 	ctx->fd = open(patch_file, O_RDONLY);
 	if (ctx->fd < 0) {
-		DBGPRINT("cannot open patch file. go to post patch");
+		dbg_print("cannot open patch file. go to post patch");
 		return -1;
 	}
 
@@ -279,7 +265,7 @@ static int pre_patch(struct patch_ctx *ctx)
 	struct patch_entry entry;
 	char fw_ver[INTEL_VER_PARAM_LEN * 2];
 
-	DBGPRINT("start pre_patch");
+	dbg_print("start pre_patch");
 
 	entry.data[0] = HCI_COMMAND_PKT;
 	entry.data[1] = 0x11;
@@ -303,7 +289,7 @@ static int pre_patch(struct patch_ctx *ctx)
 	entry.len = ret;
 
 	if (entry.data[6] != 0x00) {
-		DBGPRINT("command failed. status=%02x", entry.data[6]);
+		dbg_print("command failed. status=%02x", entry.data[6]);
 		ctx->patch_error = 1;
 		return -1;
 	}
@@ -328,7 +314,7 @@ static int pre_patch(struct patch_ctx *ctx)
 	entry.len = ret;
 
 	if (entry.data[6] != 0x00) {
-		DBGPRINT("command failed. status=%02x", entry.data[6]);
+		dbg_print("command failed. status=%02x", entry.data[6]);
 		ctx->patch_error = 1;
 		return -1;
 	}
@@ -363,7 +349,7 @@ static int post_patch(struct patch_ctx *ctx)
 	int ret;
 	struct patch_entry entry;
 
-	DBGPRINT("start post_patch");
+	dbg_print("start post_patch");
 
 	entry.data[0] = HCI_COMMAND_PKT;
 	entry.data[1] = 0x11;
@@ -422,7 +408,7 @@ static int intel_patch_device(struct patch_ctx *ctx)
 			return ret;
 		}
 
-		DBGPRINT("patch failed. proceed to post patch");
+		dbg_print("patch failed. proceed to post patch");
 		goto post_patch;
 	}
 
@@ -434,7 +420,7 @@ static int intel_patch_device(struct patch_ctx *ctx)
 			return ret;
 		}
 	} else {
-		DBGPRINT("patch done");
+		dbg_print("patch done");
 		ctx->reset_enable_patch = 1;
 	}
 
@@ -515,7 +501,7 @@ static int change_baudrate(int dev, int init_speed, int *speed,
 	unsigned char cmd[5];
 	unsigned char evt[7];
 
-	DBGPRINT("start baudrate change");
+	dbg_print("start baudrate change");
 
 	ret = set_rts(dev, 0);
 	if (ret < 0) {
-- 
1.7.9.5
