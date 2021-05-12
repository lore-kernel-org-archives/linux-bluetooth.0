Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632E0C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B31F61264
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhELWmW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 18:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240090AbhELVma (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 17:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620855678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TTYJ3Bnc3DeTlgL7SCfb/BMwRzq28UznCXeadugW4Mo=;
        b=D35ddgrwAdHFc1NIUvMdJ80xVYVHKg1tdT+sidg+fnprC3o58QwYvzUKh2PSGuHl2Rnx+B
        4xRdNxzqwMOg7ZhDJ4JRpzSIv/d6AyMn79VsS801EOb5eFvwUt8e/qWUR6et9ivc8un8xH
        eT/fw2+gmmejVVwfdpZtQND/1HIZEnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-0hBKDTVeN2SoeDJsl6ISpw-1; Wed, 12 May 2021 17:41:16 -0400
X-MC-Unique: 0hBKDTVeN2SoeDJsl6ISpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42B748014D8
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:41:15 +0000 (UTC)
Received: from ivy-bridge (ovpn-112-130.rdu2.redhat.com [10.10.112.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3C4160657
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:41:14 +0000 (UTC)
Date:   Wed, 12 May 2021 17:41:42 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 6/6] Fix leaks in tools
Message-ID: <20210512174142.310080bc@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


req is allocated memory that must be freed. It appears all other error
paths got fail which handles this.

g_new0 allocates memory to data which must be freed.

g_malloc0 allocates memory to comp which must be freed.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
---
 tools/mesh-cfgclient.c |  2 +-
 tools/mesh-gatt/gatt.c |  1 +
 tools/mesh-gatt/node.c | 12 +++++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 1eeed2a1a..49069674f 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -914,7 +914,7 @@ static void cmd_import_node(int argc, char *argv[])
 
 	/* Number of elements */
 	if (sscanf(argv[4], "%u", &req->arg3) != 1)
-		return;
+		goto fail;
 
 	/* DevKey */
 	req->data2 = l_util_from_hexstring(argv[5], &sz);
diff --git a/tools/mesh-gatt/gatt.c b/tools/mesh-gatt/gatt.c
index b99234f91..c8a8123fb 100644
--- a/tools/mesh-gatt/gatt.c
+++ b/tools/mesh-gatt/gatt.c
@@ -525,6 +525,7 @@ bool mesh_gatt_notify(GDBusProxy *proxy, bool enable, GDBusReturnFunction cb,
 			notify_io_destroy();
 			if (cb)
 				cb(NULL, user_data);
+			g_free(data);
 			return true;
 		} else {
 			method = "StopNotify";
diff --git a/tools/mesh-gatt/node.c b/tools/mesh-gatt/node.c
index 6afda3387..356e1cd1a 100644
--- a/tools/mesh-gatt/node.c
+++ b/tools/mesh-gatt/node.c
@@ -396,8 +396,10 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 		uint16_t vendor_id;
 		struct mesh_element *ele;
 		ele = g_malloc0(sizeof(struct mesh_element));
-		if (!ele)
+		if (!ele) {
+			g_free(comp);
 			return false;
+		}
 
 		ele->index = i;
 		ele->loc = get_le16(data);
@@ -412,8 +414,10 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 			mod_id = get_le16(data);
 			/* initialize uppper 16 bits to 0xffff for SIG models */
 			mod_id |= 0xffff0000;
-			if (!node_set_model(node, ele->index, mod_id))
+			if (!node_set_model(node, ele->index, mod_id)) {
+				g_free(comp);
 				return false;
+			}
 			data += 2;
 			len -= 2;
 		}
@@ -421,8 +425,10 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 			mod_id = get_le16(data + 2);
 			vendor_id = get_le16(data);
 			mod_id |= (vendor_id << 16);
-			if (!node_set_model(node, ele->index, mod_id))
+			if (!node_set_model(node, ele->index, mod_id)) {
+				g_free(comp);
 				return false;
+			}
 			data += 4;
 			len -= 4;
 		}
-- 
2.31.1

