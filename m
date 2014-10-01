Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 08/17] android/tester: Expose pdu_set structure so it can be reused
Date: Wed,  1 Oct 2014 11:01:30 +0200
Message-Id: <1412154099-28014-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

More tester will reuse this structure when we move to generic pdu
exchange mechanism.
---
 android/tester-a2dp.c  | 5 +----
 android/tester-avrcp.c | 5 +----
 android/tester-main.h  | 5 +++++
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 047822e..e12844e 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -50,10 +50,7 @@ static struct emu_cid_data cid_data;
 #define req_suspend	0x50, 0x09, 0x04
 #define rsp_suspend	0x52, 0x09
 
-const struct pdu_set {
-	struct pdu req;
-	struct pdu rsp;
-} pdus[] = {
+static struct pdu_set pdus[] = {
 	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc) },
 	{ raw_pdu(req_get), raw_pdu(rsp_get) },
 	{ raw_pdu(req_cfg), raw_pdu(rsp_cfg) },
diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index fab6dfc..13ffd74 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -73,10 +73,7 @@ static struct pdu sdp_rsp_pdu = raw_pdu(
 #define req_suspend 0x50, 0x09, 0x04
 #define rsp_suspend 0x52, 0x09
 
-static const struct pdu_set {
-	const struct pdu req;
-	const struct pdu rsp;
-} pdus[] = {
+static struct pdu_set pdus[] = {
 	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc) },
 	{ raw_pdu(req_get), raw_pdu(rsp_get) },
 	{ raw_pdu(req_cfg), raw_pdu(rsp_cfg) },
diff --git a/android/tester-main.h b/android/tester-main.h
index 0b3b9ff..3484c3e 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -60,6 +60,11 @@ struct pdu {
 	uint16_t size;
 };
 
+struct pdu_set {
+	struct pdu req;
+	struct pdu rsp;
+};
+
 #define raw_data(args...) ((unsigned char[]) { args })
 
 #define raw_pdu(args...)					\
-- 
1.9.1

