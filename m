Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9123C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 03:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9950A2087E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 03:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbhADDtY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:49:24 -0500
Received: from hoster906.com ([192.252.156.27]:53706 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbhADDtY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Jan 2021 22:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=from:to
        :cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=dkim; bh=g7n4CLz/nkU/yTp3y+J39Wgtr
        QtFbid2ADi5NsEapSg=; b=mvAL+PDKhK8HUR4d3tpqlI54IlTK6TrZ1ERzu/FEa
        okFc6qTxeoMHvqA2V6YiLwABoIwCTLThZTpOuyp8HU3j1uN96RcfUJQ0gBBKVGtf
        kC053qi5sIv5SRX1x9RF2cn01698/IJrgOjbXQg6i3YfLxr9A3DEGPedz5jUZAkt
        Jo=
Received: (qmail 2951 invoked by uid 503); 4 Jan 2021 03:48:42 -0000
Received: from unknown (HELO knuckle.Home) (mike@mnmoran.org@40.134.89.129)
  by hoster906.com with ESMTPA; 4 Jan 2021 03:48:42 -0000
From:   "Michael N. Moran" <mike@mnmoran.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        "Michael N. Moran" <mike@mnmoran.org>
Subject: [PATCH BlueZ v2] mesh: Update AppKeys on transition to Phase 0
Date:   Sun,  3 Jan 2021 22:48:37 -0500
Message-Id: <20210104034837.640081-1-mike@mnmoran.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

At the end of the mesh Key Refresh procedure when a subnet
transitions to Phase 0, local AppKeys that were updated were
not updating until the bluetooth-meshd daemon was restarted.

This patch iterates the AppKeys at the end of mesh Key Refresh
when the subnet transitions to Phase 0, setting the new state
of each updated AppKey.

********* v2 ************

This version incorporates recommendations from Brian Gix
creating a public function appkey_finalize(); and adding
new APP_AID_INVALID constant to replace the use of 0xFF
as an indication that the new_key_aid field is invalid.


---
 mesh/appkey.c    | 33 +++++++++++++++++++++++++++++++--
 mesh/appkey.h    |  1 +
 mesh/mesh-defs.h |  1 +
 mesh/net.c       |  2 ++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 549f5a80d..5088a1812 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -50,11 +50,40 @@ static bool match_bound_key(const void *a, const void *b)
 	return key->net_idx == idx;
 }
 
+static void finalize_key(void *a, void *b)
+{
+	struct mesh_app_key *key = a;
+	uint16_t net_idx = L_PTR_TO_UINT(b);
+
+	if (key->net_idx != net_idx)
+		return;
+
+	if (key->new_key_aid == APP_AID_INVALID)
+		return;
+
+	key->key_aid = key->new_key_aid;
+
+	key->new_key_aid = APP_AID_INVALID;
+
+	memcpy(key->key, key->new_key, 16);
+}
+
+void appkey_finalize(struct mesh_net *net, uint16_t net_idx)
+{
+	struct l_queue *app_keys;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return;
+
+	l_queue_foreach(app_keys, finalize_key, L_UINT_TO_PTR(net_idx));
+}
+
 static struct mesh_app_key *app_key_new(void)
 {
 	struct mesh_app_key *key = l_new(struct mesh_app_key, 1);
 
-	key->new_key_aid = 0xFF;
+	key->new_key_aid = APP_AID_INVALID;
 	return key;
 }
 
@@ -146,7 +175,7 @@ const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
 		return app_key->key;
 	}
 
-	if (app_key->new_key_aid == NET_NID_INVALID)
+	if (app_key->new_key_aid == APP_AID_INVALID)
 		return NULL;
 
 	*key_aid = app_key->new_key_aid;
diff --git a/mesh/appkey.h b/mesh/appkey.h
index 3bb70445b..6688d87fb 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -16,6 +16,7 @@ struct mesh_app_key;
 bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 				uint8_t *key_value, uint8_t *new_key_value);
 void appkey_key_free(void *data);
+void appkey_finalize(struct mesh_net *net, uint16_t net_idx);
 const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
 							uint8_t *key_id);
 int appkey_get_key_idx(struct mesh_app_key *app_key,
diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 43bdf5aab..25ce0126c 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -100,6 +100,7 @@
 
 #define NET_IDX_MAX		0x0fff
 #define APP_IDX_MAX		0x0fff
+#define APP_AID_INVALID	0xff
 
 #define APP_IDX_MASK		0x0fff
 #define APP_IDX_DEV_REMOTE	0x6fff
diff --git a/mesh/net.c b/mesh/net.c
index b24cdba77..9624cd058 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2600,6 +2600,8 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 
 	l_queue_foreach(net->friends, frnd_kr_phase3, net);
 
+	appkey_finalize(net, idx);
+
 	if (!mesh_config_net_key_set_phase(node_config_get(net->node), idx,
 							KEY_REFRESH_PHASE_NONE))
 		return MESH_STATUS_STORAGE_FAIL;
-- 
2.26.2

