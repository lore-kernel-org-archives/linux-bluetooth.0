Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFEDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 17:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 324CD20759
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 17:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mGs+Mq4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgEUR4O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 13:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEUR4O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 13:56:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B563C061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 10:56:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a13so3134517pls.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Z3lB2ps1Sz+hH9uANqYM5GmYI38A+1RffLNsWxLBxs=;
        b=mGs+Mq4b6FrrO8mownqel2X2HrQuI6o+WpxPUAnlJ370aidz3hkq3YNxx9WYEiHUV6
         2ASanzagfwSkMo7O4wRpw2Suq8TNQK5reLIsCDCDqO76RQBc5/7RpVI6GpfcJLHVT8N6
         nIvAy1sSJ1FNI/Vc6IbI3sVD3JEXN7KOK9PQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Z3lB2ps1Sz+hH9uANqYM5GmYI38A+1RffLNsWxLBxs=;
        b=C65nP8UIgSYvXGT0RtXPstZgogwMRCRKC5rzYBGGPBV8znHSWoLJBlBhae8dBlsc5X
         sYSnFz4wR0wQ6VhJkfBozskuByJqTiVgfI/hYigrVNKMLCyIuhGQMrWPXAixfGYKFyc5
         FdBQz2mfkEsPu6qKZVp2MHvH3o4nxA4QtMPWAvfShzbm3vrGm/rJ2IWrZw7C1tUoakyn
         SzTw+anmuMkBMYnW44WYk9YEGlTwPMrqKOFOlwCUE04DlZKRHeFWBO8IEWv1Wp21uEcK
         RjE5CYkaUSxZz+WPhtR8vEZCPIPhNhjHQ5/ZS/zblyFYt+QDLYeN1ZBAl6L+b4iC/ABT
         rdbw==
X-Gm-Message-State: AOAM530PSXEw2ABSdnAQpu/d1/luv9uo5zr0Feloe0ueKzW6kKQUUuw9
        Yqh7BHMdzrlc294lhqhLW0+stz3Z2aw=
X-Google-Smtp-Source: ABdhPJxWYfFAUXQHpGtlPDk9NGs2z4LXK+hoyX8kGREBJLyBy4oH1DOTsnbNbW9yxnlT+AGHJCItAQ==
X-Received: by 2002:a17:902:c403:: with SMTP id k3mr10841725plk.12.1590083773335;
        Thu, 21 May 2020 10:56:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id a16sm4881910pjs.23.2020.05.21.10.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:56:12 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH v2 2/3] doc/device-api: Add Types property to org.bluez.Device1
Date:   Thu, 21 May 2020 10:55:42 -0700
Message-Id: <20200521175543.7923-2-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521175543.7923-1-sonnysasaka@chromium.org>
References: <20200521175543.7923-1-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 65d8fee37..ceb68d2f6 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -158,6 +158,11 @@ Properties	string Address [readonly]
 
 			The Bluetooth class of device of the remote device.
 
+		string Type [readonly, optional]
+
+			The carriers supported by this remote device. If it
+			exists, it can be one of "BR/EDR", "LE", or "DUAL".
+
 		uint16 Appearance [readonly, optional]
 
 			External appearance of device, as found on GAP service.
-- 
2.17.1

