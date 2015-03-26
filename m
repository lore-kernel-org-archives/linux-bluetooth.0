Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 1/3] tools/btmgmt: Better usage info for add-adv
Date: Wed, 25 Mar 2015 20:07:10 -0700
Message-Id: <1427339232-27053-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch improves the usage string that gets printed for the add-adv
command to provide more details about the possible options.
---
 tools/btmgmt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index f64327b..58a5926 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3687,8 +3687,18 @@ static void add_adv_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void add_adv_usage(void)
 {
-	print("Usage: add-adv [-u uuid] [-d adv_data] [-s scan_rsp] "
-		"[-t timeout] [-c] [-d] [-e] [-l] [-m] [-p] <instance_id>");
+	print("Usage: add-adv [options] <instance_id>\nOptions:\n"
+		"\t -u, --uuid <uuid>\t\tService UUID\n"
+		"\t -d, --adv-data <data>\t\tAdvertising Data bytes\n"
+		"\t -s, --scan-rsp <data>\t\tScan Response Data bytes\n"
+		"\t -t, --timeout <timeout>\tTimeout in seconds\n"
+		"\t -c, --connectable\t\t\"connectable\" flag\n"
+		"\t -e, --discoverable\t\t\"general-discoverable\" flag\n"
+		"\t -l, --limited-discov\t\t\"limited-discoverable\" flag\n"
+		"\t -m, --managed-flags\t\t\"managed-flags\" flag\n"
+		"\t -p, --tx-power\t\t\t\"tx-power\" flag\n"
+		"e.g.:\n"
+		"\tadd-adv -u 180d -u 180f -d 080954657374204C45 1");
 }
 
 static struct option add_adv_options[] = {
-- 
2.2.0.rc0.207.ga3a616c

