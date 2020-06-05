Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B95EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB66207D8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Synz8syj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgFERsa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgFERsa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 13:48:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7411AC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 10:48:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so3990957plo.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mnS5X/8c1lwJj8VOPXZd1EctHVYAJejNY9LVjUwL9ww=;
        b=Synz8syjeJAkR2B4sunKC1HXwd/OAAfUrzMpPf3y2wOdSgcqLGcyFHe6zwwO1uJlu2
         Iu+TYL5rhPuJyQdnCoqYR0SwXI+F6IE71CUq6agZ2vS3KAJB6vytpLNfb+kt/7+9Rziq
         AlFLcYjBhfXJOH0T9K5DYZVjH4KzY1J2Ak6FIqgsgJMXoPaTx6Sb6JwHQxeJFj4ABMBH
         TrIYCjXBxqNNFWgPJXoHuSS45rAqQkfhmKZl13bm++ZG6LWog0jJNCDkReCmXLo0i8E/
         6lMiMPy+UEuiRLZD/3coGqXVYovojCe9Cv+fYioSg4A/qNL6k+3sfMPotI/MjuYd0gwu
         uJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnS5X/8c1lwJj8VOPXZd1EctHVYAJejNY9LVjUwL9ww=;
        b=S/caEZEewq0ttsaejP8jt1ws57aY4Xnk5KR6N0emsfg8B65CUg3TEuJRKskAQ3X4eE
         VldDK8zBe5RbgKatqPtW6R0bKkU5UX4e9KIXid2ycqR2BzeERjQUTcpJ4WYYWhnpZsCW
         1Ep+g1lBIKgQCyoWKwlnD32WBLNXkx/5fnDPSu2hpYIJS9k6UJXCU8T0STvCg1E6ly8o
         L5nVyd9Y4RQQv0pASqmyO+AMLRlUR2jaCUwhK5SiIiJqlAAjdF/bdy/9zb9cf43hNgeP
         8+BeGnyPCDLOGyObmWGWs8ABvtLBu8gdJGlTPelhZUFIqiFhsSNhkXTmLpyV4zaqXuyF
         pReA==
X-Gm-Message-State: AOAM530yTxRKETrfsA04ZqmrG9JHLgaTRhOugQHl3zjUb2RfyFi1/yfV
        7w1Uw8GbXzVxJKz/CUGr1U6xbtmN
X-Google-Smtp-Source: ABdhPJxFCRob+cbXQ8hnmkoTxOyiAWE/wma//GlLAUFwbRNKcO29EP+O2IBMb6MfsOfvJ78lKY1IyA==
X-Received: by 2002:a17:902:d688:: with SMTP id v8mr11268904ply.215.1591379308597;
        Fri, 05 Jun 2020 10:48:28 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 128sm217173pfd.114.2020.06.05.10.48.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 10:48:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] advertising: Fix reseting NO_BREDR flag
Date:   Fri,  5 Jun 2020 10:48:25 -0700
Message-Id: <20200605174825.717902-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200605174825.717902-1-luiz.dentz@gmail.com>
References: <20200605174825.717902-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When setting BT_AD_FLAG_LIMITED it was actually overwritting
BT_AD_FLAG_NO_BREDR as well so this moves the logic of detecting if the
instance needs to set BT_AD_FLAG_NO_BREDR to set_flags so it is always
updated when attempting to set any flags.
---
 src/advertising.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 4c91586c2..076d591b6 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -675,6 +675,13 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 	if (!btd_adapter_get_bredr(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
+	/* Set BR/EDR Not Supported if adapter is not discoverable but the
+	 * instance is.
+	 */
+	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
+			!btd_adapter_get_discoverable(client->manager->adapter))
+		flags |= BT_AD_FLAG_NO_BREDR;
+
 	if (!bt_ad_add_flags(client->data, &flags, 1))
 		return false;
 
@@ -697,12 +704,9 @@ static bool parse_discoverable(DBusMessageIter *iter,
 
 	dbus_message_iter_get_basic(iter, &discoverable);
 
-	if (discoverable) {
-		/* Set BR/EDR Not Supported if adapter is no discoverable */
-		if (!btd_adapter_get_discoverable(client->manager->adapter))
-			flags = BT_AD_FLAG_NO_BREDR;
-		flags |= BT_AD_FLAG_GENERAL;
-	} else
+	if (discoverable)
+		flags = BT_AD_FLAG_GENERAL;
+	else
 		flags = 0x00;
 
 	if (!set_flags(client , flags))
-- 
2.25.3

