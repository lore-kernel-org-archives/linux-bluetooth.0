Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B148CE7F14F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjI0Vkc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjI0Vkb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:31 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3462A193
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:29 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af608eb367so736134b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850827; x=1696455627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KV4ZorwYJLjRQxEs+/Y5/kmw2P0hzFQxubwf3sPfIIU=;
        b=FbKpRMYnl5+SdDtJUSmbgb+V0ViyAawcvYoo7J0UmUu465IQQzKXazVHFozTATuZyy
         /lI+nuHYbOqDxNSWzIr8AKSVVe6b+0sIBpAFzYFqMWJDlTgpvTYt2KfX5ZV3eHd8kht/
         E96wn0N1l+lxHf2Tti24fGHU4+bHMhXjubqz2qO4kqo+0kEtM1Fe1ZIv8UwAgsGMNTfT
         25NQbGfqnd/c/NPHinBChuEcdZhvcDycBdcvFocM2/6FjrP0Ja0kQ8qkT6+ym6wXEyQc
         yGayU4oCkyQmJabn+oQ2DVJq7jom5JVbviDEJGVi11lDyDLXYlYB3nLyDmDLGrvlDCVb
         7x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850827; x=1696455627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV4ZorwYJLjRQxEs+/Y5/kmw2P0hzFQxubwf3sPfIIU=;
        b=RP++ToWsKaQzeqPnF4KItFBV4cELrwtXQcfzhNkCGpk2cV+R31W8NEtblDaNZFNJX5
         EnrlBKdE0QY6SJZE/5IYJyb5rbAVO2SUuARhgMhPVpD58oAHvMcLlfuIPVHtac99eiwV
         UCwJNWKk53cys8nceWDcknNuSx+blV6aiwvhdiJDj/1sl+PHxhNJ2Up49kgoYVSR6xng
         yZ2jmzVngLVxABSP5aJ5jOL3K4uPdeCrz0V3QCv2uSPgBV6VfmcbMw7bObwZTCGr4RgT
         sDegpjHIdBc4TnWGlo0LmN+3Wy05HY0VYSpwtduRJ/AGydQq1J25CcCe+J5N5TsuwMaz
         Zg8A==
X-Gm-Message-State: AOJu0YxlHuvspkEwsj4P2FBKvfrRTSQxUJLu3PiAiDW9faq2UL1OdsxV
        iVHIxNJbNvWJOmDAa6H/3Cigl1oyDCGFbxNm
X-Google-Smtp-Source: AGHT+IGiGOqdDsxErvM5ajlZy9d1IbNNfH/rPVe28j0NnF0EfGMpHXdllAOqyQqDibydt2Xn8z7X4Q==
X-Received: by 2002:a05:6808:905:b0:3a8:f3e7:d696 with SMTP id w5-20020a056808090500b003a8f3e7d696mr3424775oih.45.1695850827585;
        Wed, 27 Sep 2023 14:40:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 11/12] client: Make endpoint.show print ISO specific capabilities
Date:   Wed, 27 Sep 2023 14:40:02 -0700
Message-ID: <20230927214003.1873224-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927214003.1873224-1-luiz.dentz@gmail.com>
References: <20230927214003.1873224-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes endpoint.show print Locations, SupportedContext, Context and
Qos capabilities.
---
 client/player.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client/player.c b/client/player.c
index 6953eff28543..d1809f24fd27 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2142,6 +2142,10 @@ static void cmd_show_endpoint(int argc, char *argv[])
 	print_property(proxy, "Capabilities");
 	print_property(proxy, "Device");
 	print_property(proxy, "DelayReporting");
+	print_property(proxy, "Locations");
+	print_property(proxy, "SupportedContext");
+	print_property(proxy, "Context");
+	print_property(proxy, "QoS");
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
-- 
2.41.0

