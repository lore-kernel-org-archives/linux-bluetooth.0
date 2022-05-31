Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0127C43217
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 07:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbiEaHlh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 03:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244566AbiEaHlf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 03:41:35 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C2408D68D
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 00:41:33 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-sIRHd_r7NjyK8nzKz0QJBw-1; Tue, 31 May 2022 03:41:31 -0400
X-MC-Unique: sIRHd_r7NjyK8nzKz0QJBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35C2E85A5BC;
        Tue, 31 May 2022 07:41:31 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F68B140EBD5;
        Tue, 31 May 2022 07:41:28 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez V2 02/13] Fixing memory leakage in appkey.c
Date:   Tue, 31 May 2022 13:11:06 +0530
Message-Id: <20220531074117.610321-3-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
References: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

While performing the static analysis using the coverity tool found
following memory leak reports

bluez-5.64/mesh/appkey.c:143: leaked_storage: Variable "key" going 
out of scope leaks the storage it points to.

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/mesh/appkey.c:146: leaked_storage: Variable "key" going 
out of scope leaks the storage it points to.

Fixing them.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 mesh/appkey.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 5088a1812..52fed8c31 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -139,11 +139,15 @@ bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 	key->net_idx = net_idx;
 	key->app_idx = app_idx;
 
-	if (key_value && !set_key(key, app_idx, key_value, false))
+	if (key_value && !set_key(key, app_idx, key_value, false)) {
+		appkey_key_free(key);
 		return false;
+	}
 
-	if (new_key_value && !set_key(key, app_idx, new_key_value, true))
+	if (new_key_value && !set_key(key, app_idx, new_key_value, true)) {
+		appkey_key_free(key);
 		return false;
+	}
 
 	l_queue_push_tail(app_keys, key);
 
-- 
2.26.2

