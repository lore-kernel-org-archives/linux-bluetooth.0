Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB7DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40856207DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UOLsSM9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHUHhV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgHUHhU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 03:37:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F6CC061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:37:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r4so520229pls.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8vbCiEt2lQZ7BLZaVTo8wOjdJdYQD5oyGSM9VtQ9BgU=;
        b=UOLsSM9x2C7zqgGj0vnr8q9Zgj8Fd2daTUYnhBevvuYOZPJNfQhfsy4IY9S23igZNR
         JWQYDQvuLpO6+57WflKpqtLQYphLAP/HXwzCIHzZkYNn8ljDxuxV9DAMxief/ZUyoQ6x
         aOzz4WRc32O5Qzd+NlwZoCW44Q2I8TxmNwGqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8vbCiEt2lQZ7BLZaVTo8wOjdJdYQD5oyGSM9VtQ9BgU=;
        b=OQ2VLau2GVTMjwfsKwPshsMidyFVFdEmRssDJ/M99DEABOLJJubGLB1sqQm8NcaNee
         ++DQsKIz+22YvJFwcsa+aoTM5HARKcve5oghr3Jvn7Z0Ixzxhj84lqIQ0LWkLga6hd8W
         EjPzdklvSllYte5F/TTPAkYO7EkK+nywNWiZcp8xGZvzYDvuENG+nASHh9ThX+WlD+H5
         hGYlq9N0cIjsEDcP6y8pH0hSIUJN/aQ5yUw8CaBeq78GjjHAAPj6gNHDRK3jwqP8wYBa
         D6KhxGr4e+5JGxKGCRUHy2Er1gv5R9oa4pwS0bqqnmOzBOTxn+5QuGdRmz48XMAEMn7a
         3CYA==
X-Gm-Message-State: AOAM530KxWNywcqKbk8QKLCAh/u2aXqCBXGp4dlJxLUPOeGhMrgiFNl0
        jstkUWL024CVQoICHwymLH4iW1uZ7e6KIQ==
X-Google-Smtp-Source: ABdhPJycApEimhqrhyRS+RwBMb3+2V28lXmK+9nJ5yW9yEpJLUXKKcRYzQr6RPlJxAtceydWGNHuXA==
X-Received: by 2002:a17:90a:b787:: with SMTP id m7mr1372078pjr.169.1597995438373;
        Fri, 21 Aug 2020 00:37:18 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id k125sm1247807pga.48.2020.08.21.00.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 00:37:17 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ] adapter: Fix crash in discovery_disconnect
Date:   Fri, 21 Aug 2020 00:37:14 -0700
Message-Id: <20200821073714.19626-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

discovery_disconnect crashed because the adapter pointer has been freed
before. This patch makes sure that discovery list is cleaned up before
adapter pointer is freed.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 src/adapter.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..c0b02bf3f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5316,12 +5316,25 @@ static void free_service_auth(gpointer data, gpointer user_data)
 	g_free(auth);
 }
 
+static void remove_discovery_list(struct btd_adapter *adapter)
+{
+	g_slist_free_full(adapter->set_filter_list, discovery_free);
+	adapter->set_filter_list = NULL;
+
+	g_slist_free_full(adapter->discovery_list, discovery_free);
+	adapter->discovery_list = NULL;
+}
+
 static void adapter_free(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
 
 	DBG("%p", adapter);
 
+	// Make sure the adapter's discovery list is cleaned up before freeing
+	// the adapter.
+	remove_discovery_list(adapter);
+
 	if (adapter->pairable_timeout_id > 0) {
 		g_source_remove(adapter->pairable_timeout_id);
 		adapter->pairable_timeout_id = 0;
@@ -6846,11 +6859,7 @@ static void adapter_stop(struct btd_adapter *adapter)
 
 	cancel_passive_scanning(adapter);
 
-	g_slist_free_full(adapter->set_filter_list, discovery_free);
-	adapter->set_filter_list = NULL;
-
-	g_slist_free_full(adapter->discovery_list, discovery_free);
-	adapter->discovery_list = NULL;
+	remove_discovery_list(adapter);
 
 	discovery_cleanup(adapter, 0);
 
-- 
2.26.2

