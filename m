Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH] Bluetooth: Add support to specify patch download location
Date: Mon, 4 Oct 2010 12:36:16 +0530
Message-ID: <1286175976-20477-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for specifying patch download address for
AR300x patch download logic.

---
 tools/hciattach_ath3k.c |   52 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index 5589254..e27cc4b 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -461,20 +461,68 @@ struct patch_entry {
 	uint8_t data[MAX_PATCH_CMD];
 };
 
+#define SET_PATCH_RAM_ID	0x0D
+#define SET_PATCH_RAM_CMD_SIZE	11
+#define ADDRESS_LEN		4
+static int set_patch_ram(int dev, char *patch_loc, int len)
+{
+	int err;
+	uint8_t cmd[20];
+	int i, j;
+	char loc_byte[3];
+	uint8_t *event;
+	uint8_t *loc_ptr = (uint8_t *)&cmd[7];
+
+	if (!patch_loc)
+		return -1;
+
+	loc_byte[2] = '\0';
+
+	load_hci_ps_hdr(cmd, SET_PATCH_RAM_ID, ADDRESS_LEN, 0);
+
+	for (i = 0, j = 3; i < 4; i++, j--) {
+		loc_byte[0] = patch_loc[0];
+		loc_byte[1] = patch_loc[1];
+		loc_ptr[j] = strtol(loc_byte, NULL, 16);
+		patch_loc += 2;
+	}
+
+	err = send_hci_cmd_sync(dev, cmd, SET_PATCH_RAM_CMD_SIZE, &event);
+	if (err < 0)
+		return err;
+
+	err = read_ps_event(event, HCI_PS_CMD_OCF);
+
+	if (event)
+		free(event);
+
+	return err;
+}
+
+#define PATCH_LOC_KEY    "DA:"
+#define PATCH_LOC_STRING_LEN    8
 static int ps_patch_download(int fd, FILE *stream)
 {
 	char byte[3];
 	char ptr[MAX_PATCH_CMD + 1];
 	int byte_cnt;
 	int patch_count = 0;
+	char patch_loc[PATCH_LOC_STRING_LEN + 1];
 
 	byte[2] = '\0';
 
 	while (fgets(ptr, MAX_PATCH_CMD, stream)) {
-		if (strlen(ptr) <= 1 || !isxdigit(ptr[0]))
+		if (strlen(ptr) <= 1)
 			continue;
-		else
+		else if (strstr(ptr, PATCH_LOC_KEY) == ptr) {
+			strncpy(patch_loc, &ptr[sizeof(PATCH_LOC_KEY) - 1],
+							PATCH_LOC_STRING_LEN);
+			if (set_patch_ram(fd, patch_loc, sizeof(patch_loc)) < 0)
+				return -1;
+		} else if (isxdigit(ptr[0]))
 			break;
+		else
+			return -1;
 	}
 
 	byte_cnt = strtol(ptr, NULL, 16);
-- 
1.7.0.4

