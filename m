Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F1C43461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 22:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492FC2054F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 22:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YIdW57fX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgIKWa5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 18:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgIKWat (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 18:30:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DACAC0613ED
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 15:30:48 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c3so1540359plz.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/SMny2P7BvcZfQfCGZTxLxuPv+qDCSbc/fXi3RUGtg=;
        b=YIdW57fXDJDPfJWC84dOakS/JRR6DU97MKMfmWJpbZIypmzyrNVthU+rRju0soXp+F
         LZ4UhZW5A/q2Vz4RmRTQyYHbiQQ+vD5H8IyL/xOKr0bWn04Yybdp/UqQ7W/uQmnFZpch
         /wkhy/gBXI7DapM0ZkfIW4inEWRjM+/JAaC1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/SMny2P7BvcZfQfCGZTxLxuPv+qDCSbc/fXi3RUGtg=;
        b=kkZXfKjYD3L3QKEHEHDmgjQWEB1GWRXmLix9lS2n+DMPUcbMDQQb6qSFbefO4G5a6S
         CEFR2c74Q93L1JcWmCGDjlM95QVylpjt48MMWKsMT+6mhsrG7jbIbfSKhEAHxDEbQFk+
         lSScIP2441ub+8Ql5faMfESYqQg4PMtUOe+L0oddJc22yCf9kLxdayOwrK7zYmX8J2CE
         1Xlz9PXrIoyg9ptp23wNq7VofZDgypjMo+Q+Y6AxePjxQcfOeL6gd5bLq2Lx5rD8pp9T
         CVgc8J6p0r8UZGOmiL92knncFFBPakXNTzu0wyLk8qj9sMUSzENugNHueZurSyuk792u
         mcYQ==
X-Gm-Message-State: AOAM533af5MWA8oc1gQGSB/g42PDY+ASpmWeIEONDwxIvhdnSLIWGdPz
        Hj26AYKiJCmllGgfrEej796Pvg==
X-Google-Smtp-Source: ABdhPJwLGFTOzzcZN+YqPO2iA5iID3TEeLsKHWJ+dgWu385NEjN3j7Q8ErYQ5JjH5Ptg5l2U6ZyaSw==
X-Received: by 2002:a17:902:aa4b:b029:d0:cbe1:e739 with SMTP id c11-20020a170902aa4bb02900d0cbe1e739mr4589998plr.20.1599863447681;
        Fri, 11 Sep 2020 15:30:47 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id m14sm3123742pfo.202.2020.09.11.15.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:30:47 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [Bluez PATCH v4 3/4] policy: Enable reconnect for a2dp-sink in defaults
Date:   Fri, 11 Sep 2020 15:30:36 -0700
Message-Id: <20200911153010.Bluez.v4.3.Ic87c0fbb00fe76356cee8f78a82b29a47fc6d438@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911223037.4127188-1-abhishekpandit@chromium.org>
References: <20200911223037.4127188-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a2dp-sink to default reconnects list.
---

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

