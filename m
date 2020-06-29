Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A58AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3CE206E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JxvkC+kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgF2XCi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgF2XCh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 19:02:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE509C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 67so4469107pfg.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agMkRPFhgMe1f/hFXF9SjRTi2sxyZRnC9GuMfZzTrjc=;
        b=JxvkC+krK9jVF8aauUPT4a0+JgM9VTquGgkwnEGJBAGNw5+ivq6qIE9T21xD96F+mI
         y5qMrOldan0EA0MkPEX9qgehcibNmU7v3TvKKFUjKpSOBvcu/SZRBWrdLng3ZiAmqFJH
         A9VdLr+fHCJWS9fTftRERv9/dQk6KcRFJioCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agMkRPFhgMe1f/hFXF9SjRTi2sxyZRnC9GuMfZzTrjc=;
        b=YnQmykZVKGsFkdChw1rkEDpo+iqulaOhYS4b36g1V+zJrvhgZyIZFz/7s2T5qVVPOq
         R+ktMAAd6HpYzy+NKIWyJz2YXPJVTETEp1fS2/X8ORNDJupoCnEREOwPyZpmPb6ZMXO1
         6Bm3kcVtby/a/9h7w/SHfVjEXPzJXDp/4b8lqd1m36NC9DBuNb+w1bJAbHSbkzMc8yO1
         qK3PNfIp06obLuHZ8R9+x196qNP8qO85yRLdQt6SiASIfuaab4iypog4A5f5WKhLMzmp
         23gk4fvibcNnkygE5yYi+ksR8dlmoAd+n3hqK5VrNR//XiMXx3zA5L6wLR1dcwvI1JkJ
         GnhA==
X-Gm-Message-State: AOAM5300mXdkEz5ewLxb5DAYXKDPbuSMURW8kZAK6bCWFLY1aJiWhsZY
        1JQeZs2aINrbejD2M9RBGPbcWw==
X-Google-Smtp-Source: ABdhPJyihaBDtBDoNLeXy0/ngiL8p0sO2snTgxoepPvvnBczq7OX2koloKiIPgHYt2v6ecWBf69QgQ==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr16484227pfd.248.1593471756268;
        Mon, 29 Jun 2020 16:02:36 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id i13sm467275pjd.33.2020.06.29.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:02:35 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v6 6/6] input: Make HID devices support wake
Date:   Mon, 29 Jun 2020 16:02:23 -0700
Message-Id: <20200629160206.BlueZ.v6.6.I3290604153369ff32013f3dcadda4df3f2eb0f36@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200629230223.3538949-1-abhishekpandit@chromium.org>
References: <20200629230223.3538949-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HID devices can wake the host from a suspended state. Mark the profiles
to support wake when they are accepted. If the device hasn't already
been configured with a Wake Allowed configuration, it will default to
yes when the profile is accepted.

---

Changes in v6: None
Changes in v5:
* Only call device_set_wake_support

Changes in v4:
* Renamed device_set_profile_wake_support to just
device_set_wake_support

Changes in v3:
* Mark HID device to support wake from suspend

Changes in v2: None

 profiles/input/device.c | 1 +
 profiles/input/hog.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index d3724ed54..2dc2ecab2 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1409,6 +1409,7 @@ int input_device_register(struct btd_service *service)
 	}
 
 	btd_service_set_user_data(service, idev);
+	device_set_wake_support(device, true);
 
 	return 0;
 }
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 9335b7e8b..130f696a9 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -166,6 +166,7 @@ static int hog_probe(struct btd_service *service)
 		return -EINVAL;
 
 	btd_service_set_user_data(service, dev);
+	device_set_wake_support(device, true);
 	return 0;
 }
 
-- 
2.27.0.212.ge8ba1cc988-goog

