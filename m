Return-Path: <SRS0=3clX=DM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EB5C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Oct 2020 04:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AEB2080A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Oct 2020 04:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgJEETl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Oct 2020 00:19:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:11656 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgJEETl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Oct 2020 00:19:41 -0400
IronPort-SDR: CGnSG1Oa/OUOury7WARpyZPOLDKB5bW0RQ/s/HD6VPKCs7DXkhBKhi5JjGJhy0+pVK4mh18TKI
 f6IbyJaJeg+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="181446331"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="181446331"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 21:19:41 -0700
IronPort-SDR: LrI03wyPDNQwN3AopGz4ZvRKXYj5/BMFYowz2ELSNAs1TLqC6vdyMGEOxJZ/H+jNm6c21I9agH
 +hbDd9GL44Tg==
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="459327569"
Received: from faghadia-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.251.21.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 21:19:40 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] shared/timeout-ell: Fix timeout wrapper implementation
Date:   Sun,  4 Oct 2020 21:19:32 -0700
Message-Id: <20201005041932.99783-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the following issues:
- Correct user data is passed around to l_timeout_create():
  locally allocated timeout data is a valid "user data" to
  associate with a newly created timeout. Previously, user_data
  passed as an argument to timeout_add() was incorrectly used as
  an argument to l_timeout_create()
- To maintain common API and work around the issue when the conversion
  of a pointer to an unsigned int truncates the initial value, a queue
  of active timeouts is maintained where pointer each l_timeout structure
  is associate with a unique id. This id is returned when timeout_create()
  API is called and can be subsequently used with timeout_remove().
---
 src/shared/timeout-ell.c | 50 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/src/shared/timeout-ell.c b/src/shared/timeout-ell.c
index c2da387e2..023364069 100644
--- a/src/shared/timeout-ell.c
+++ b/src/shared/timeout-ell.c
@@ -12,13 +12,23 @@
 
 #include "timeout.h"
 
+static struct l_queue *timeout_q;
+
 struct timeout_data {
 	timeout_func_t func;
 	timeout_destroy_func_t destroy;
-	unsigned int timeout;
 	void *user_data;
+	unsigned int timeout;
 };
 
+static bool match_id(const void *a, const void *b)
+{
+	unsigned int to_id = L_PTR_TO_UINT(a);
+	unsigned int id = L_PTR_TO_UINT(b);
+
+	return (to_id == id);
+}
+
 static void timeout_callback(struct l_timeout *timeout, void *user_data)
 {
 	struct timeout_data *data = user_data;
@@ -43,7 +53,12 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
 			void *user_data, timeout_destroy_func_t destroy)
 {
 	struct timeout_data *data;
-	uint32_t id;
+	unsigned int id = 0;
+	struct l_timeout *to;
+	int tries = 0;
+
+	if (!timeout_q)
+		timeout_q = l_queue_new();
 
 	data = l_new(struct timeout_data, 1);
 
@@ -52,12 +67,37 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
 	data->user_data = user_data;
 	data->timeout = timeout;
 
-	id = L_PTR_TO_UINT(l_timeout_create(timeout, timeout_callback,
-						user_data, timeout_destroy));
+	while (id == 0 && tries < 3) {
+		to = l_timeout_create(timeout, timeout_callback,
+							data, timeout_destroy);
+		if (!to)
+			break;
+
+		tries++;
+		id = L_PTR_TO_UINT(to);
+
+		if (id == 0 ||
+			l_queue_find(timeout_q, match_id, L_UINT_TO_PTR(id))) {
+
+			l_timeout_remove(to);
+			continue;
+		}
+
+		l_queue_push_tail(timeout_q, to);
+	}
+
+	if (id == 0)
+		l_free(data);
+
 	return id;
 }
 
 void timeout_remove(unsigned int id)
 {
-	l_timeout_remove(L_UINT_TO_PTR(id));
+	struct l_timeout *to;
+
+	to = l_queue_remove_if(timeout_q, match_id, L_UINT_TO_PTR(id));
+
+	if (to)
+		l_timeout_remove(to);
 }
-- 
2.26.2

