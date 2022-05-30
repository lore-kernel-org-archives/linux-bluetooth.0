Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF89C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 08:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiE3INI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 04:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiE3INB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 04:13:01 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA1EB37A02
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 01:13:00 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-fxl7M77oPbG42cUxnaCIUA-1; Mon, 30 May 2022 04:12:58 -0400
X-MC-Unique: fxl7M77oPbG42cUxnaCIUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFB13802803;
        Mon, 30 May 2022 08:12:57 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACE7B1410F36;
        Mon, 30 May 2022 08:12:55 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez 13/13] Fixing use_after_free in prov-db.c
Date:   Mon, 30 May 2022 13:42:09 +0530
Message-Id: <20220530081209.560465-14-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220530081209.560465-1-gopalkrishna.tiwari@gmail.com>
References: <20220530081209.560465-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

Following scenario happens when prov is false and we have double free as
mentioned in the below

bluez-5.64/tools/mesh-gatt/prov-db.c:847: freed_arg: "g_free" frees "in_str".
bluez-5.64/tools/mesh-gatt/prov-db.c:867: double_free: Calling "g_free" frees pointer "in_str" which has already been freed.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 tools/mesh-gatt/prov-db.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/mesh-gatt/prov-db.c b/tools/mesh-gatt/prov-db.c
index 2fb08f799..a5b6997e0 100644
--- a/tools/mesh-gatt/prov-db.c
+++ b/tools/mesh-gatt/prov-db.c
@@ -859,7 +859,8 @@ bool prov_db_local_set_iv_index(uint32_t iv_index, bool update, bool prov)
 
 		set_local_iv_index(jmain, iv_index, update);
 		prov_file_write(jmain, false);
-	}
+	} else
+		return true;
 
 	res = true;
 done:
-- 
2.26.2

