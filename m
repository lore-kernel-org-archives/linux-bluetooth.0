Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH 2/3] hog: Move dis_notify around
Date: Fri, 24 Feb 2017 16:13:25 -0800
Message-Id: <1487981606-14150-3-git-send-email-juha.kuikka@synapse.com>
In-Reply-To: <1487981606-14150-1-git-send-email-juha.kuikka@synapse.com>
References: <1487981606-14150-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No functional changes
---
 profiles/input/hog-lib.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index b93324a..71de3a1 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1372,6 +1372,16 @@ static void foreach_hog_service(struct gatt_db_attribute *attr, void *user_data)
 	hog_attach_instace(hog, attr);
 }
 
+static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
+					uint16_t version, void *user_data)
+{
+	struct bt_hog *hog = user_data;
+
+	hog->vendor = vendor;
+	hog->product = product;
+	hog->version = version;
+}
+
 struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 					uint16_t product, uint16_t version,
 					struct gatt_db *db)
@@ -1458,16 +1468,6 @@ static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
 		bt_scpp_attach(hog->scpp, hog->attrib);
 }
 
-static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
-					uint16_t version, void *user_data)
-{
-	struct bt_hog *hog = user_data;
-
-	hog->vendor = vendor;
-	hog->product = product;
-	hog->version = version;
-}
-
 static void hog_attach_dis(struct bt_hog *hog, struct gatt_primary *primary)
 {
 	if (hog->dis) {
-- 
2.7.4

