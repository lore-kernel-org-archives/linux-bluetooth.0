Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B780C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 08:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiE3IMz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 04:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiE3IMs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 04:12:48 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 681FD6EC4A
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 01:12:45 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-UGt0DmVlMEymLthO7_-CBQ-1; Mon, 30 May 2022 04:12:42 -0400
X-MC-Unique: UGt0DmVlMEymLthO7_-CBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D64B0101AA45;
        Mon, 30 May 2022 08:12:41 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACD1C1415100;
        Mon, 30 May 2022 08:12:39 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez 08/13] Fixing resource leak in mesh/mesh-db.c
Date:   Mon, 30 May 2022 13:42:04 +0530
Message-Id: <20220530081209.560465-9-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220530081209.560465-1-gopalkrishna.tiwari@gmail.com>
References: <20220530081209.560465-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

While performing static tool analysis using coverity found following reports for resouse leak

bluez-5.64/tools/mesh/mesh-db.c:2388: leaked_handle: Handle variable "fd" going out of scope leaks the handle.

bluez-5.64/tools/mesh/mesh-db.c:2388: leaked_storage: Variable "str" going out of scope leaks the storage it points to.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 tools/mesh/mesh-db.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index fa11837df..896ff722c 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -2384,6 +2384,8 @@ bool mesh_db_load(const char *fname)
 
 	sz = read(fd, str, st.st_size);
 	if (sz != st.st_size) {
+		close(fd);
+		l_free(str);
 		l_error("Failed to read configuration file %s", fname);
 		return false;
 	}
-- 
2.26.2

