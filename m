Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C31C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8279E20659
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 14:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgFEO2O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:28:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:50946 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgFEO2N (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 10:28:13 -0400
IronPort-SDR: /Z5lhJ3tYI3kDAJ4hOKLckjdWGOnbLt+r8coW11gSpG0gleDS4FFUc3BUZXjtYz0+n7FUFT6Ca
 06whQfC/or1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 07:28:12 -0700
IronPort-SDR: AYsc9DJbjHNmxJ2J8QXbc3Q3B+iw2+kkQrb3UZJJ6dAJCk8AvE4+kA5djl5/ZwnT554F8XqcwQ
 gtQuNK7jjJYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="471808362"
Received: from amit-h97m-d3h.iind.intel.com (HELO localhost.localdomain) ([10.223.96.198])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2020 07:28:11 -0700
From:   Amitsi5x <amitx.k.singh@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     amitx.k.singh@intel.com
Subject: [PATCH] bluez:update handle for large database
Date:   Fri,  5 Jun 2020 19:55:41 +0530
Message-Id: <20200605142541.28412-5-amitx.k.singh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605142541.28412-1-amitx.k.singh@intel.com>
References: <20200605142541.28412-1-amitx.k.singh@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: amit <amitx.k.singh@intel.com>

Update handle for large database and
added condition before free to avoid double free

Signed-off-by: amit <amitx.k.singh@intel.com>
---
 src/shared/gatt-client.c | 12 +++++++-----
 src/shared/gatt-db.c     | 15 +++++++++------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 19ff6ab65..3cb6ae443 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1131,8 +1131,6 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 				success = false;
 				goto done;
 			}
-			/* Database has changed adjust last handle */
-			op->last = end;
 		}
 
 		/* Update pending list */
@@ -1392,9 +1390,13 @@ static void db_hash_read_cb(bool success, uint8_t att_ecode,
 	util_hexdump(' ', value, len, client->debug_callback,
 						client->debug_data);
 
-	/* Store ithe new hash in the db */
-	gatt_db_attribute_write(op->hash, 0, value, len, 0, NULL,
-					db_hash_write_value_cb, client);
+	/* Store the new hash in the db */
+	if(gatt_db_attribute_write(op->hash, 0, value, len, 0, NULL,
+						db_hash_write_value_cb, client)) {
+		util_debug(client->debug_callback, client->debug_data,"DB Hash match write: skipping discovery");
+		queue_remove_all(op->pending_svcs, NULL, NULL, NULL);
+	}
+
 
 discover:
 	if (!op->success) {
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b44f7b5e9..15af4c20a 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -344,10 +344,15 @@ static bool db_hash_update(void *user_data)
 	gatt_db_foreach_service(db, NULL, service_gen_hash_m, &hash);
 	bt_crypto_gatt_hash(db->crypto, hash.iov, db->next_handle, db->hash);
 
-	for (i = 0; i < hash.i; i++)
-		free(hash.iov[i].iov_base);
+	for (i = 0; i < hash.i; i++) {
+		if(hash.iov[i].iov_base)
+			free(hash.iov[i].iov_base);
+	}
+
+	if(hash.iov)
+		free(hash.iov);
 
-	free(hash.iov);
+	hash.iov = NULL;
 
 	return false;
 }
@@ -689,7 +694,7 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 	service->num_handles = num_handles;
 
 	/* Fast-forward next_handle if the new service was added to the end */
-	db->next_handle = MAX(handle + num_handles, db->next_handle);
+	db->next_handle += num_handles;
 
 	return service->attributes[0];
 
@@ -811,8 +816,6 @@ service_insert_characteristic(struct gatt_db_service *service,
 	 * declaration. All characteristic definitions shall have a
 	 * Characteristic Value declaration.
 	 */
-	if (handle == UINT16_MAX)
-		return NULL;
 
 	i = get_attribute_index(service, 1);
 	if (!i)
-- 
2.17.1

