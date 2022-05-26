Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B91C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 11:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245265AbiEZLZX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 07:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347158AbiEZLZV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 07:25:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E55D1B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a13so1193590plh.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySQEG2VohkZ7Y1G2FbtZgKUEZ+qLmIWmonRCjlk0Uto=;
        b=WZIvL4ctAhiGiXT+aEnWB1MMJnGrE0Yld86+G8pb+0nm1NEb4O3vCjt/El3BMO+8mj
         ltwRJ7gIbwlFbXW8iTHeTSKQPOFqYBOm9acwrRrjhQRP3JOfLspTlgjunbSQxm24T6mN
         7zalsqddMO5e6P9NkO4CxTZfpjK3rBMMRHqd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySQEG2VohkZ7Y1G2FbtZgKUEZ+qLmIWmonRCjlk0Uto=;
        b=PfOKQcJSLoaBtLVtpIdJPYmb7WAeqqiE8aTu/SIjoPiQeEFxDn9MAWciKcw8n1PkgI
         JIMpjXihzFb06Mmc9ZVa5OTLydv2M326FPoDyzrANihQRcg/1jjmVrYV2dbuHcj/KsOa
         XiHdnFaI7YKyv4KZxvxO+6X5d1J3jEX3QXZcW7vvxOcoKxmcJybUwEzWWXIRQZx8SNY4
         55BcP6hihzXVekqJc0SsFcUdBLlYuFKEr5AGXwf6MZwmT7NNVXu+tnOVE350hYIPWPNL
         3ay1rj4fUnRfspxpfKbKoamhYznGslNQPin1rTAkuti8UmsKt1ofI3kkAfUCCzEBoHZp
         6Qbg==
X-Gm-Message-State: AOAM530ZoQGOCiPsazzgTUw7hJlrAHlPwY1tUroyn1+exKUMj0oHqXh1
        v2NgqrM67bF1Mlj8oR8txX4f957fkeXNNw==
X-Google-Smtp-Source: ABdhPJybsyA7Q8lNvZxqlooDl0W2oeWcu7y657WgIXlDWqPSU8V/GPt0qixyVqRgEpSZ2olF9LPVYA==
X-Received: by 2002:a17:902:8644:b0:153:9f01:2090 with SMTP id y4-20020a170902864400b001539f012090mr36565843plt.101.1653564320761;
        Thu, 26 May 2022 04:25:20 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id f3-20020aa79d83000000b0050dc76281f0sm1220385pfq.202.2022.05.26.04.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 04:25:20 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v6 8/8] monitor: packet: add missing decodings of MGMT commands to todo
Date:   Thu, 26 May 2022 19:24:56 +0800
Message-Id: <20220526112456.2488536-6-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220526112456.2488536-1-josephsih@chromium.org>
References: <20220526112456.2488536-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the missing decodings of MGMT commands to
btmon --todo.

---

(no changes since v4)

Changes in v4:
- This is a new patch that adds the missing decodings of MGMT commands.

 monitor/packet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 851296ee6..c26a80110 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -15237,4 +15237,13 @@ void packet_todo(void)
 
 		printf("\t%s\n", le_meta_event_table[i].str);
 	}
+
+	printf("MGMT commands with missing decodings:\n");
+
+	for (i = 0; mgmt_command_table[i].str; i++) {
+		if (mgmt_command_table[i].func)
+			continue;
+
+		printf("\t%s\n", mgmt_command_table[i].str);
+	}
 }
-- 
2.36.1.124.g0e6072fb45-goog

