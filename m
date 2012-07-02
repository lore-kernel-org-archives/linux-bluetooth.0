Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: "tedd.an" <tedd.an@intel.com>
Subject: hicattach: fix return length after reading the patch file
Date: Mon, 02 Jul 2012 09:52:17 -0700
Message-ID: <1898220.KzhPWWYfm0@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong AN <tedd.an@intel.com>

This patch fixes the issue that returns alwasy 0 after reading the patch line.

---
 tools/hciattach_intel.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/hciattach_intel.c b/tools/hciattach_intel.c
index 9129993..749098e 100644
--- a/tools/hciattach_intel.c
+++ b/tools/hciattach_intel.c
@@ -148,14 +148,13 @@ static int validate_events(struct patch_entry *event,
  */
 static int get_next_patch_entry(int fd, struct patch_entry *entry)
 {
-	int len, size;
+	int size;
 	char rb;
 
 	if (read(fd, &rb, 1) <= 0)
 		return 0;
 
 	entry->type = rb;
-	len = 0;
 
 	switch (entry->type) {
 	case PATCH_TYPE_CMD:
@@ -176,7 +175,7 @@ static int get_next_patch_entry(int fd, struct patch_entry *entry)
 	case PATCH_TYPE_EVT:
 		entry->data[0] = HCI_EVENT_PKT;
 
-		if (read(fd, &entry->data[len], 2) < 0)
+		if (read(fd, &entry->data[1], 2) < 0)
 			return -1;
 
 		size = (int)entry->data[2];
@@ -193,7 +192,7 @@ static int get_next_patch_entry(int fd, struct patch_entry *entry)
 		return -1;
 	}
 
-	return len;
+	return entry->len;
 }
 
 /**
-- 
1.7.9.5


