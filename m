Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22734C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DAD20798
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 22:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbhABW24 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Jan 2021 17:28:56 -0500
Received: from hoster906.com ([192.252.156.27]:49006 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbhABW2z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Jan 2021 17:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=from:to
        :cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=dkim; bh=3a3ozUQKZL7l4Gq/fhNfenKeS
        ZMe3rXq3sm3ISX9+7c=; b=dUpZOjv1yUK1BjvfOD3BDG7xYCP6YT65ZXU7LpEDr
        QJbZgvI9VymZQf0uHgbkYVoSJ0w9zbdI08faBL/wiVcWGpD5irTbKNfCEbK44yD/
        YdIQ4N+RA5ky3IlwTO8V91WOcALj8kM+W4cIcoF5D74kUhrxPbi98o1W0ToRkpQu
        Jg=
Received: (qmail 37574 invoked by uid 503); 2 Jan 2021 22:28:14 -0000
Received: from unknown (HELO knuckle.Home) (mike@mnmoran.org@40.134.89.129)
  by hoster906.com with ESMTPA; 2 Jan 2021 22:28:14 -0000
From:   "Michael N. Moran" <mike@mnmoran.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        "Michael N. Moran" <mike@mnmoran.org>
Subject: [PATCH BlueZ] mesh: Update AppKeys on transition to Phase 0
Date:   Sat,  2 Jan 2021 17:27:55 -0500
Message-Id: <20210102222755.71019-1-mike@mnmoran.org>
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

---
 mesh/appkey.c | 18 ++++++++++++++++++
 mesh/appkey.h |  1 +
 mesh/net.c    |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 549f5a80d..504f67aab 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -50,6 +50,24 @@ static bool match_bound_key(const void *a, const void *b)
 	return key->net_idx == idx;
 }
 
+void finish_app_key(void *a, void *b)
+{
+	struct mesh_app_key *key = a;
+	uint16_t net_idx = L_PTR_TO_UINT(b);
+
+	if (key->net_idx != net_idx)
+		return;
+
+	if (key->new_key_aid == NET_NID_INVALID)
+		return;
+
+	key->key_aid = key->new_key_aid;
+
+	key->new_key_aid = NET_NID_INVALID;
+
+	memcpy(key->key, key->new_key, 16);
+}
+
 static struct mesh_app_key *app_key_new(void)
 {
 	struct mesh_app_key *key = l_new(struct mesh_app_key, 1);
diff --git a/mesh/appkey.h b/mesh/appkey.h
index 3bb70445b..c83dd03f6 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -16,6 +16,7 @@ struct mesh_app_key;
 bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 				uint8_t *key_value, uint8_t *new_key_value);
 void appkey_key_free(void *data);
+void finish_app_key(void *a, void *b);
 const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
 							uint8_t *key_id);
 int appkey_get_key_idx(struct mesh_app_key *app_key,
diff --git a/mesh/net.c b/mesh/net.c
index b24cdba77..22ec03d7a 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2600,6 +2600,8 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 
 	l_queue_foreach(net->friends, frnd_kr_phase3, net);
 
+	l_queue_foreach(net->app_keys, finish_app_key, L_UINT_TO_PTR(idx));
+
 	if (!mesh_config_net_key_set_phase(node_config_get(net->node), idx,
 							KEY_REFRESH_PHASE_NONE))
 		return MESH_STATUS_STORAGE_FAIL;
-- 
2.26.2

