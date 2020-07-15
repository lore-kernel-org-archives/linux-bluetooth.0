Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7D0C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 22:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CFD206F4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 22:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HiOTawzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGOWru (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGOWrt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 18:47:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF3DC061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 15:47:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a24so2752734pfc.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++vPA9shmpTlF5O/7b0gP8ujZV4/9yR96SMTiioulIU=;
        b=HiOTawzA8/3fr/88eg1BFPSfMZFgKgL5XmmCtVJ8n9z1YDX+qvi0PZBN21d4BZ+xPw
         pM5R5tAYaEhckuZz8Gt6pT5WK85bVOEVcss45MDQsM745ZelhzbVgs2mobHtK2KASKLe
         cCi2ESFXvsRvhxGVWQfFbIDlMFXiaZY0aD480=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++vPA9shmpTlF5O/7b0gP8ujZV4/9yR96SMTiioulIU=;
        b=lbFkPu2LpiPbJaIsYIRAVzNxgncXsGYHpkVkIu7O5EYkAPVLX4zj3kF8+hR50wPIQt
         aOlQSypaTjWK9BSwYTPYan1jJdKbalc0AqMAP1QumzR9e8wmk7xekn0eKVWwAWMLlY1W
         LUrjecBWTmfgY9wh+tY3o6KhOJiZM9mouGqm+yn7Uigjb0oAxthQJWIqTJm3PJLI0/AW
         sDSxvLnY4kYbafOVu9uz26yt8lHLFzMt5GVhgNHLatG0rAn74bYNq/ZUmDYyxtwBGRBZ
         79HliFqgiLC1BuPenzoAclE4vad4nbL20q8zgY0o+2gVtiioI+2JyTAbELnjNdTFHDLO
         DVNQ==
X-Gm-Message-State: AOAM531cpZ5+pB/bgwr1WntVEDg+3Is8bEwdrtBA8+7kPzz4hsuhZM+E
        TUIfvPAWgb3TlDuExHJxRKdiCO9DMrM=
X-Google-Smtp-Source: ABdhPJy80OCzPQe2FWAQ8mdEg1Zj6NK+dKGPKOFXpEafceXLm3YW5whplmMSjh2pupJ/iAgF8oi6vQ==
X-Received: by 2002:a63:5220:: with SMTP id g32mr1656057pgb.78.1594853268828;
        Wed, 15 Jul 2020 15:47:48 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id u14sm3250471pfk.211.2020.07.15.15.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 15:47:48 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ v2] profile: Add exception to battery profile for external access
Date:   Wed, 15 Jul 2020 15:47:40 -0700
Message-Id: <20200715224740.238527-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CABBYNZKDuCbwG7c94HbMXq7WqvMgL7qDaH9_JrQsHzORrr9GOw@mail.gmail.com>
References: <CABBYNZKDuCbwG7c94HbMXq7WqvMgL7qDaH9_JrQsHzORrr9GOw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This gives exception to battery profile to be shared both internally and
externally.

---
 profiles/battery/battery.c | 1 +
 src/profile.h              | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 4da4355a1..c9a1af4b9 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -354,6 +354,7 @@ static struct btd_profile batt_profile = {
 	.device_remove	= batt_remove,
 	.accept		= batt_accept,
 	.disconnect	= batt_disconnect,
+	.external	= true,
 };
 
 static int batt_init(void)
diff --git a/src/profile.h b/src/profile.h
index 4448a2a6d..95523e50a 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -35,6 +35,10 @@ struct btd_profile {
 	const char *remote_uuid;
 
 	bool auto_connect;
+	/* Some profiles are considered safe to be handled internally and also
+	 * be exposed in the GATT API. This flag give such profiles exception
+	 * from being claimed internally.
+	 */
 	bool external;
 
 	int (*device_probe) (struct btd_service *service);
-- 
2.26.2

