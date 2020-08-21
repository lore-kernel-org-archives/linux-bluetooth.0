Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC27C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0336620702
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSKSlXum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHUR6r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHUR6n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:58:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426CAC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:58:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z23so1217640plo.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhSmR3bJAg3EPJpaAiOPxsM469jNIsw/321Korr/Tag=;
        b=WSKSlXumZMO7+jroTZzj2Xm5gQaivVbz/CdkOZXzGnnv+rQ6ZF9m9cRRR++coorOAy
         /CmstNZHn1g22XQsKILPLT4DeKInWLmSUKVHM39yebI3U1p3g1/q2zFY5dwRFjxlUjMd
         i8cxetNEzfMwjYjkcFwXuwzRvu19fv8HBmUiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhSmR3bJAg3EPJpaAiOPxsM469jNIsw/321Korr/Tag=;
        b=cK673ZHOFjteWCAPbd2pzj9IDEKv+fwaAXAUVaI87AirurnKTk5bxGYCGI4IsI4/JG
         wbgxaN+VMoLcC7WRuaDWP7H1UC0ZSvnDHu42qbm5aDmHTklhece62K63Wew0kafTCIx5
         WemE7ANoBLTj/0vyYHkPIQjzewp5vH2wBMofS19u0zMVUiJDU3EMWZBCxHmwJAqXQJUD
         4oQjopMpdMp5DFFyDWY0/r7CD0upBfotohHQUd8TV7X5lX9qOs/0v2M1AyWWR7PH830B
         01GNPIJWHji1ePTuJQzTyYmSv1huFbJZb0QHkMQ1z7QM/CKRX08mfvp3uNuhjl8CII3x
         2oZQ==
X-Gm-Message-State: AOAM5317uSrfsvs1AVvmhskGMlrEggYnGtNhPGwlci7WIOG07IbJpuw2
        yo8SOnHcIxL6cXOcbDSk5n+FP41woN+soA==
X-Google-Smtp-Source: ABdhPJxj2h2w5UjfztL55HoAHaFtdy+yZa37P9GZItCHGJsyyMsWYl7KaajUI+jJwL6fdAiN6YmStA==
X-Received: by 2002:a17:902:7088:: with SMTP id z8mr3044450plk.315.1598032722544;
        Fri, 21 Aug 2020 10:58:42 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id i72sm2807732pgc.70.2020.08.21.10.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 10:58:41 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v2] adapter: Fix crash in discovery_disconnect
Date:   Fri, 21 Aug 2020 10:58:38 -0700
Message-Id: <20200821175838.20761-1-sonnysasaka@chromium.org>
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
 src/adapter.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..1435e2bd7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5316,12 +5316,26 @@ static void free_service_auth(gpointer data, gpointer user_data)
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
 
+	/* Make sure the adapter's discovery list is cleaned up before freeing
+	 * the adapter.
+	 */
+	remove_discovery_list(adapter);
+
 	if (adapter->pairable_timeout_id > 0) {
 		g_source_remove(adapter->pairable_timeout_id);
 		adapter->pairable_timeout_id = 0;
@@ -6846,11 +6860,7 @@ static void adapter_stop(struct btd_adapter *adapter)
 
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

