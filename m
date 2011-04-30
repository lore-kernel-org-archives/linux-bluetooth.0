Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 13/16] Implement stop_discovery hciops callback
Date: Fri, 29 Apr 2011 21:27:29 -0300
Message-Id: <1304123252-14464-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 8653ab5..c3a28b9 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3247,8 +3247,18 @@ static int hciops_start_discovery(int index)
 
 static int hciops_stop_discovery(int index)
 {
+	struct dev_info *dev = &devs[index];
+
 	DBG("index %d", index);
-	return -ENOSYS;
+
+	switch (dev->discov_state) {
+	case DISCOV_INQ:
+		return hciops_stop_inquiry(index);
+	case DISCOV_SCAN:
+		return hciops_stop_scanning(index);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int hciops_fast_connectable(int index, gboolean enable)
-- 
1.7.1

