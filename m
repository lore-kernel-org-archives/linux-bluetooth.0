Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88884C4320E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 12:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B14F60F39
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Aug 2021 12:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhHOMR6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Aug 2021 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbhHOMR4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Aug 2021 08:17:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF387C0617AD
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Aug 2021 05:17:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nt11so22318093pjb.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Aug 2021 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFA69i6hcXDHmIcHg92qE1Me9tWDfkAMJZYxzK2xT7U=;
        b=klMfIjeVpam8pT5arjIEW49vm/9ag/9V62RMumJ9lbuKijF9Zd6XHjjUhsG/cGBRe/
         7h6qPKiWGP1c06B7Wg797fvFz79+SYvTr//XH1zLiFbLUCKHQPGh6SyE1vGd7MjqLvx+
         p/rk6BzVHpbxz6pbm38CF/KXfraSQm//v/ev4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFA69i6hcXDHmIcHg92qE1Me9tWDfkAMJZYxzK2xT7U=;
        b=sLqt4thMzZKHySSbvTmjaPruMrOgBRoJHMzCUJBHfhRk0cPd+bkpwobKhHzcskZe/A
         7OgSAbA7iV9mHOV76Qik9vcLpE+v4UF/R+/YrtS759QqRp88YX3kRLPZNWFfCaNRm1vM
         bTSv1dJWrRxyPzhrx/oK8quXxyv5TZ8lFmFNWZlH8sqAyb+uO/1dhzE7WZOYONyQKnDE
         RmUgjPJuQQgereFItQbBJxUs/CqXo/vvnd2074+haWx7rF5EWiFArK7J1Y1D89f1FmOS
         BF3mMqSxM6N3qvMXo/KG69ByHc2nzTgvR+HTotJJ6loXuZNYfmpwlBhfX7nxygUJ9Uv0
         jhZw==
X-Gm-Message-State: AOAM531F3QZrgAGg6HPRqnErtPx9w2s3I5kX3YDfH6aUjt/nhPfM0upv
        uSAxeiy1erhbdwJpSE+96MLFCevmLMzYhQ==
X-Google-Smtp-Source: ABdhPJxqkV5RcplPXSijny0oPio503+9aIz3axKmrr7c6QDFYGiRSETKBZkvhThq11NMzETOmyXdmw==
X-Received: by 2002:a62:dd57:0:b029:3cd:c96e:625e with SMTP id w84-20020a62dd570000b02903cdc96e625emr10935357pff.45.1629029846133;
        Sun, 15 Aug 2021 05:17:26 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:9cee:5877:e805:fe2b])
        by smtp.gmail.com with ESMTPSA id v20sm9773170pgi.39.2021.08.15.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 05:17:25 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/5] Bluetooth: btintel: support link statistics telemetry events
Date:   Sun, 15 Aug 2021 20:17:14 +0800
Message-Id: <20210815201611.v9.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210815201611.v9.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210815201611.v9.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

This patch supports the link statistics telemetry events for
intel controllers

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

(no changes since v7)

Changes in v7:
- Rebase on Tedd's patches that moved functionality from btusb to
  btintel.

 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0fe093fa5158..643e2194ca01 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1285,8 +1285,10 @@ static int btintel_read_debug_features(struct hci_dev *hdev,
 static int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
-	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
+	u8 period[5] = { 0x04, 0x91, 0x02, 0x05, 0x00 };
+	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
 	if (!features)
@@ -1303,8 +1305,24 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, 5, period, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting periodicity for link statistics traces failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
 
+	skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Enable tracing of link statistics events failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
 	kfree_skb(skb);
+
 	return 0;
 }
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

