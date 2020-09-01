Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85203C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B1F207D3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 22:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mJOq3nud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgIAWAr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgIAWAp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 18:00:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1705C061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 15:00:45 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v16so1942555qka.18
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hnl7tu+tFkxi4drosybbGZuJGk8hlqywEjZu+JdyxrI=;
        b=mJOq3nudhJLOQ/5by+6oaYDoAD9icfuqJh7bQE4kcsBrqbUSzqC3dmptvZz+L1Evk4
         0aMAKBGLlld7PZtqcTgztVG5gst5lxULxb6NPiWPG9CfuQmBbkp9XIb3xNMW2ZmaG6TA
         HGBgaaosWcIWW1ftmC/wyDFiDYN0bmYGjsmWgKH4KhuXsvDPuV43tG2TePhLsRXsA/Gy
         S7nDTvZzMkmCmKPmxmwflQAIvhelZr2ODhntJLWZPvt4KcP6wXuzCiXowT+09HZR+pCp
         cvx+DZti7y4ck8JsvYsOrRtC34ge3mPy5QamMZht5vE8nLy1bd5W28kNTEbfS8qIz14b
         NUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hnl7tu+tFkxi4drosybbGZuJGk8hlqywEjZu+JdyxrI=;
        b=s/chXl1IGbtQEdUnf4I2gjgr/0hOIjiOB+mfEO5Y2UY4Ij18w311KHZbhOQakyhlGd
         KoskxAVs8evjAqVl9RPahgRsApUkcJB/ZXeQp7URvqrR5eteiPoHM8nboukJw2CokT2l
         AwrR8uc6EYipfBdCjuui+u1Gr5+KXV68HKlcGH503RzBhiR6+BrGogP07PXGlKq3qsWW
         kut8XnB3WG8mwiJkH7d7xKsxAS6lk5BpwbbZJqQFhS6Ad3jfxIVp9P8GTuPv65QVKPrF
         Cr9G8/oLbBDqfglFpTW92sTmfYR+s7giEGS5MtNiRXkNizHVLiRa/mesA04tglM9Qi9+
         2PTA==
X-Gm-Message-State: AOAM531PdJHvjLveIEvPeMVTBZrH7fKz1jtg6TqjLtsVh3UtDP3NhKt7
        cH1Dn6KBnNp+zmyo1liZLMClbVt0WYucIgBMVdF9a3hc/pq5l7xhF2FHx5zb61DcKZpv93B2DS4
        QnbH74U7sBNXIirR798f7dX2qH91b7ZrnbSXxODekFfQguD2YCvE8NsdnBDLsAnvTTf2K5VU6iq
        NkWJIR/C9STJTkF2EA
X-Google-Smtp-Source: ABdhPJzjWAmiSZ7Y7fqkGLzJzJAoY7cYni0t4CuOky31bwC5OEEZQVg/AyHWkEhxFA0yXLsVDnm4tb4OxBswIDBY8T/D
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a05:6214:1146:: with SMTP id
 b6mr3638038qvt.135.1598997644794; Tue, 01 Sep 2020 15:00:44 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:00:23 -0700
In-Reply-To: <20200901220024.662941-1-danielwinkler@google.com>
Message-Id: <20200901145820.Bluez.v2.2.I33cf8432f94675b635ab429b3125f54048c5b66a@changeid>
Mime-Version: 1.0
References: <20200901220024.662941-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v2 2/3] advertising: Add adv SupportedFeatures to bluetoothctl
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds SupportedFeatures to be shown in "show" option of
bluetoothctl. It was tested with and without kernel support for features
to verify that they are shown or not shown correctly.

Change was tested by verifying SupportedFeatures were populated
correctly in bluetoothctl on hatch and kukui chromebooks

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v2: None

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index da877b546..6368cd516 100644
--- a/client/main.c
+++ b/client/main.c
@@ -933,6 +933,7 @@ static void cmd_show(int argc, char *argv[])
 		print_property(adapter->ad_proxy, "SupportedInstances");
 		print_property(adapter->ad_proxy, "SupportedIncludes");
 		print_property(adapter->ad_proxy, "SupportedSecondaryChannels");
+		print_property(adapter->ad_proxy, "SupportedFeatures");
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-- 
2.28.0.402.g5ffc5be6b7-goog

