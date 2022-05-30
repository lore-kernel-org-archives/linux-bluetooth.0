Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E28C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 May 2022 08:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiE3IMv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 May 2022 04:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiE3IMq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 May 2022 04:12:46 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70EB23B572
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 01:12:41 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-DpkBOrIfMneHj-fHFqUQiA-1; Mon, 30 May 2022 04:12:39 -0400
X-MC-Unique: DpkBOrIfMneHj-fHFqUQiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C350C1C0515D;
        Mon, 30 May 2022 08:12:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FDD91415100;
        Mon, 30 May 2022 08:12:36 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez 07/13] Fixing leaked_handle in l2cap-tester.c
Date:   Mon, 30 May 2022 13:42:03 +0530
Message-Id: <20220530081209.560465-8-gopalkrishna.tiwari@gmail.com>
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

bluez-5.64/tools/l2cap-tester.c:1712: leaked_handle: Handle variable "new_sk" going out of scope leaks the handle.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 tools/l2cap-tester.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index d78b1e29c..3f0464013 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1709,6 +1709,7 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 
 	if (!check_mtu(data, new_sk)) {
 		tester_test_failed();
+		close(new_sk);
 		return FALSE;
 	}
 
-- 
2.26.2

