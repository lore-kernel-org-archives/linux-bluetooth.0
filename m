Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5C3C11D2F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 15:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055D020828
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 15:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OROAtfc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgBXPGl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:06:41 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:44460 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgBXPGl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 10:06:41 -0500
Received: by mail-vk1-f181.google.com with SMTP id y184so2565217vkc.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 07:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCzwcWKMXacxw3/H15nYzub3WvNHkT/pnNEIxQEwRxg=;
        b=OROAtfc2xHdEhdkdFpWN93qjhD4BlCmGqpKhkRn44n+jVNUjq6LGrY+4191GQ26lPw
         V2XtYj00CRIkn/wAU8cJmVON4v7rtnUlth1Hs2iGf5weEhn7o5fS44GURuZidebzbShd
         UX8Z4jadzPoosgvIRY32jPfHaHFDeRW8wFeNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCzwcWKMXacxw3/H15nYzub3WvNHkT/pnNEIxQEwRxg=;
        b=qugVbv+yoVLNt6F9/Lh6XNhue8/Jq5T8mncsjjPee5Aslro6DkWNk8aTM/iDV9hUAb
         Hfpp6atZon7oZCbk/n3Sy2jjwJKPV16mcwWZBFPfMfCr+OFIvQ2yBnhvrdwp1rize8dU
         UR5yO0DKozVDsidnLKKorD4Dbr/8VTXonKciOB2iR9kGiDyizA9kVqXiGKV4VnIGDQoJ
         hlz+SQKCyf+zW7UkuihwHaH/8vjibgL/KSmY8cqiYY61KTn3Xnt0UJXzoMPhYChgfl8+
         lS2iqWTfGd1S1SploH77ZoDbBXsoe6nlqUrj5bC6a3j1buHgI7I9wDtM4s4cLybDmefG
         8NYA==
X-Gm-Message-State: APjAAAU5ZF93qt+RO8stAHExZ7V5DP+jOyhzrpeR0U+DUQH6iO/GKplb
        fqRFh1eAy4DSOhnNl1CXR8mkz5NqCJweCQ==
X-Google-Smtp-Source: APXvYqyurKNiKTWR7zYBhxcK/n8xVQx2GAYU2gTgQYMCw4RKKfsT0LoosxWgwJGgRLy0uiQ5VtnVJw==
X-Received: by 2002:a1f:dc42:: with SMTP id t63mr23933289vkg.5.1582556799159;
        Mon, 24 Feb 2020 07:06:39 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id 126sm2713871vsz.19.2020.02.24.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:06:38 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [Bluez-PATCH] Add controller wideband speech query capability
Date:   Mon, 24 Feb 2020 15:06:36 +0000
Message-Id: <20200224150636.167272-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds support for higher level applications to query the
controller's wide band speech capability.
>
---

 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 8336ebb21..426a1fa04 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -308,6 +308,7 @@ Read Controller Information Command
 		14	Controller Configuration
 		15	Static Address
 		16	Erroneous Data Reporting
+		17	Wideband Speech
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
-- 
2.25.0.265.gbab2e86ba0-goog

