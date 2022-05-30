Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 08:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiE3IM7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 04:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiE3IMs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 04:12:48 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 520A76E8D2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 01:12:45 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-aO-wbx35PFy0OyHpE-IJbQ-1; Mon, 30 May 2022 04:12:36 -0400
X-MC-Unique: aO-wbx35PFy0OyHpE-IJbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAA2880A0B9;
        Mon, 30 May 2022 08:12:35 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2B57140EBD5;
        Mon, 30 May 2022 08:12:33 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez 06/13] Fixing leaked_handle in create-image.c
Date:   Mon, 30 May 2022 13:42:02 +0530
Message-Id: <20220530081209.560465-7-gopalkrishna.tiwari@gmail.com>
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

bluez-5.64/tools/create-image.c:124: leaked_storage: Variable "map" going out of scope leaks the storage it points to.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 tools/create-image.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/create-image.c b/tools/create-image.c
index aba940da7..90cd87315 100644
--- a/tools/create-image.c
+++ b/tools/create-image.c
@@ -97,12 +97,13 @@ static void write_block(FILE *fp, const char *pathname, unsigned int ino,
 
 	map = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
 	if (!map || map == MAP_FAILED) {
-		close(fd);
-		fd = -1;
 		map = NULL;
 		st.st_size = 0;
         }
 
+	close(fd);
+	fd = -1;
+
 done:
 	fprintf(fp, HDR_FMT, HDR_MAGIC, ino, mode, 0, 0, 1, 0,
 		(uintmax_t) st.st_size, 0, 0, 0, 0, namelen + 1, 0, name);
@@ -117,9 +118,7 @@ done:
 		pad = 3 - ((st.st_size + 3) % 4);
 		for (i = 0; i < pad; i++)
 			fputc(0, fp);
-
 		munmap(map, st.st_size);
-		close(fd);
 	}
 }
 
-- 
2.26.2

