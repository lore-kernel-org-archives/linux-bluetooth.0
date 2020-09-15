Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B2DC43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943B321974
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 17:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLQmmhyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgIORnY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgIORmA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 13:42:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB10AC06178B
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:41:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so169573pjg.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etTtXFZ+lu630ZAqLK4CGu9TZoeAs1sQTeV8Ne2d0us=;
        b=OLQmmhykEbiDObMY6ZoX0TLRp1ikCpRQyFIyK1sjIC0ENWMNyGSUAxdt+OD97awO3+
         6YKkwfzsOP2C5Q18SyYf0T8YUUOAxj+g4zbJ5rStZUVB8g/TCbbSRHTR1MNG4Lw9h3eG
         Q9XkScCXCbLPD0sRs7YQEysLZLNHya8dG2vdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etTtXFZ+lu630ZAqLK4CGu9TZoeAs1sQTeV8Ne2d0us=;
        b=Wtot8YXLdN29U1UvlsTtXAJwaKoW4NJEeQStue0bkhFXjEnLDq00dpsasPMQHCx3wJ
         nuB+U76hB7kos1t23Q+H1cACHsjJpVTFufO9R2z2p/2ryOuzRFDJrjqm1XWpcnmDt6YC
         jdo7xgicp2KSWNbh1TUnQJhKoh5TLDYZgQQme3MEqPhydTTfwLIZcSrMxcgEHRT7juhN
         KdQCPFlyz/taxOL1K7qUvCq7qjSvuWMXG+IvJDGad0FtTbjgiQ9u/LC/3EnLVi3AwPBJ
         ukRIujWIZs6hZEXUzQXDMCDcCfVKkHTtsk+pB4MG5WOsurVvIBGtYyRU1GCHltIaJRxA
         7JnA==
X-Gm-Message-State: AOAM531IlYzcvUkum+GEw35AGV7lwd1sop1kAxQEdD7tMykdGYiQPKBw
        EHXmwSU/T4mwjsNmJqCdF3wKOQ==
X-Google-Smtp-Source: ABdhPJy67haYqzSnqDJzk9iacHskFZpn5BMblVFqIjsigk+6rRYwzns2rmgFVA5iCQcPxWU4wrtgAA==
X-Received: by 2002:a17:90a:dd46:: with SMTP id u6mr456402pjv.67.1600191719475;
        Tue, 15 Sep 2020 10:41:59 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id y29sm15490232pfq.207.2020.09.15.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:41:58 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v5 3/4] policy: Enable reconnect for a2dp-sink in defaults
Date:   Tue, 15 Sep 2020 10:41:45 -0700
Message-Id: <20200915104127.Bluez.v5.3.Ic87c0fbb00fe76356cee8f78a82b29a47fc6d438@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915174146.1693687-1-abhishekpandit@chromium.org>
References: <20200915174146.1693687-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a2dp-sink to default reconnects list.
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 plugins/policy.c | 3 ++-
 src/main.conf    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index de51e58b9..c18ca8d1f 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -65,7 +65,8 @@ struct reconnect_data {
 };
 
 static const char *default_reconnect[] = {
-			HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID, NULL };
+			HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID,
+			A2DP_SINK_UUID, NULL };
 static char **reconnect_uuids = NULL;
 
 static const size_t default_attempts = 7;
diff --git a/src/main.conf b/src/main.conf
index 42f7e41c5..e1d77cc47 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -186,7 +186,7 @@
 # timeout). The policy plugin should contain a sane set of values by
 # default, but this list can be overridden here. By setting the list to
 # empty the reconnection feature gets disabled.
-#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb
+#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb,0000110b-0000-1000-8000-00805f9b34fb
 
 # ReconnectAttempts define the number of attempts to reconnect after a link
 # lost. Setting the value to 0 disables reconnecting feature.
-- 
2.28.0.618.gf4bc123cb7-goog

