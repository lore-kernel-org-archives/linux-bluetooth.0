Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8413C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 07:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbiEaHmF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244563AbiEaHmB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 03:42:01 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8C6C140C1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 00:41:45 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-faiczsxNPkSRCy644BqX9g-1; Tue, 31 May 2022 03:41:40 -0400
X-MC-Unique: faiczsxNPkSRCy644BqX9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F40C803B22;
        Tue, 31 May 2022 07:41:40 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 439631410F36;
        Tue, 31 May 2022 07:41:37 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez V2 05/13] Fixing leaked_handle in cltest.c
Date:   Tue, 31 May 2022 13:11:09 +0530
Message-Id: <20220531074117.610321-6-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
References: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

While performing static tool analysis using coverity found 
following reports for resouse leak

bluez-5.64/tools/cltest.c:75: leaked_handle: Handle variable "fd" 
going out of scope leaks the handle.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 tools/cltest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/cltest.c b/tools/cltest.c
index 2766fcd23..250c93cc7 100644
--- a/tools/cltest.c
+++ b/tools/cltest.c
@@ -72,6 +72,7 @@ static bool send_message(const bdaddr_t *src, const bdaddr_t *dst,
 		return false;
 	}
 
+	close(fd);
 	return true;
 }
 
-- 
2.26.2

