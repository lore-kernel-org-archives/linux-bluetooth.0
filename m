Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33882C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 14:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104FA61460
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 14:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhENOCF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 10:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232467AbhENOCE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 10:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621000852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2lWRxNCJUBOEXLUFkEZYi48NEyf2fGZlzRhezQGxN1U=;
        b=WRxvdDbWiNTdQKWugTz4oHgXmL9xNY6XQAKTvUOHHKnzx530wsEyDonKTvvG7d3jGzBEeQ
        kAQWNMLCX+UI2Ug5TRP+aNtiGABFNHlkQAD18SaIlbOgjxvHkUPjmZaR/RTNJFqFuJ7VBD
        jTJNYiq6hktT1egTz8egMm4THX+MsUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-O_xATaSUMtexZfiv1AIXcQ-1; Fri, 14 May 2021 10:00:50 -0400
X-MC-Unique: O_xATaSUMtexZfiv1AIXcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EB5A8027E2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 14:00:49 +0000 (UTC)
Received: from ivy-bridge (ovpn-117-226.rdu2.redhat.com [10.10.117.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDE3B19C79
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 14:00:48 +0000 (UTC)
Date:   Fri, 14 May 2021 10:01:17 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 6/6] Fix leaks in tools
Message-ID: <20210514100117.3ea5f337@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


req is allocated memory that must be freed. It appears all other error
paths got fail which handles this.

g_new0 allocates memory to data which must be freed.

g_malloc0 allocates memory to comp which must be freed.

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

