Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A372C4346E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AA520791
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4Nf5NKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgIYBOA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgIYBOA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 21:14:00 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29788C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:00 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m23so874530qkh.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8vBMoMSgHHeONDxcUcDLkWOfgiaBsK4PHRwcC5tVjrQ=;
        b=C4Nf5NKUgW1V1w/SmuhiPeEevyKlp1hnh/mS6UNW8k5Tz6h1lm6iX5gDfiEls61FYU
         NUEC/sVs04hXSGhxBSEOKoLFqQXLnHOa7RtpXCjO07PN5eFPv9Vga91byzKTuR2DhJZb
         SRRfvBOXCkUTeZWePiAMzFsqqiZjaAll37gRbTbL4m5dpTFDEwZlaH8unlcKrzFgtch5
         1psYJCGhyAzKMjncNZuCS6PjDwNfaA3G/0b2eoripflUWk+O57XSS/9451nD+E2b3Bdp
         ycU1bFN9WvecArluPiPBBpttRazZY1V2g3sAUJ8C98/J4vC//sUWyMZCHO68F9MNuqG9
         fa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8vBMoMSgHHeONDxcUcDLkWOfgiaBsK4PHRwcC5tVjrQ=;
        b=KljTYTyAqXmQHXElpi47JRAhnGeSKnj0l3TxbszKELW8rmbZStKmuibeU6n7JA3LCr
         QJvbyYF2KIx4UHF+/R7CqR4F55r7pWUCnCie6JhEIZqXfRf6Kwx8iC1fSYUg88m9VWyt
         rTDo23DgTy/pkUGkVZ7sXUGVD8Cw4u3oWrB180+Hlu4sHXeDZavXThWWOS8kzbceIlB7
         rhxI+aD7jSB/67MSpGUNUbgJPSv+iRknUBP0k3qp3iG9D98Wf3VsrlxL7rUjNOHO49mr
         U5siAZMX/8SSfCyEpPuwHOTJW2/T11BlnXR8rHp1QV/Dl3tlioy3U82Fkj2R94YksMtu
         Uwcg==
X-Gm-Message-State: AOAM533jFMmMwjA+48SGJN5w5VIuJdmo89lz+o3QttAQciM1waHoqMzY
        3It9VNSCO9ru/WIO3A1irDxboiMBUfqiZz9sfhHW
X-Google-Smtp-Source: ABdhPJxmT2i6T+T8Jx/sbNPmGrkLpeCyuXvjGhp+xv7/qxA+XkCnQb/+MrVBqAtZPBv95DAMUPZ3OQTaj05tCcbuLp2t
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:5006:: with SMTP id
 s6mr2140980qvo.51.1600996439332; Thu, 24 Sep 2020 18:13:59 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:13:39 -0700
In-Reply-To: <20200925011347.2478464-1-danielwinkler@google.com>
Message-Id: <20200924180838.Bluez.v3.1.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
Mime-Version: 1.0
References: <20200925011347.2478464-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v3 1/9] doc/advertising-api: update API with new interface
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This updates the advertising documentation to include the following
features:

LE Advertising Manager:
- New SupportedCapabilities property

LE Advertisement:
- New min/max interval properties
- New tx power property

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3: None
Changes in v2: None

 doc/advertising-api.txt | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..3215a52f7 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -138,6 +138,33 @@ Properties	string Type
 					"2M"
 					"Coded"
 
+		uint32 MinInterval
+
+			Minimum advertising interval to be used by the
+			advertising set, in .625 millisecond slots.
+			Time = N * .625 ms, where N has range
+			[0x000020, 0xFFFFFF]. If the provided MinInterval is
+			larger than the provided MaxInterval, the registration
+			will return failure.
+
+		uint32 MaxInterval
+
+			Maximum advertising interval to be used by the
+			advertising set, in .625 millisecond slots.
+			Time = N * .625 ms, where N has range
+			[0x000020, 0xFFFFFF]. If the provided MinInterval is
+			larger than the provided MaxInterval, the registration
+			will return failure.
+
+		int16 TxPower
+
+			Requested transmission power of this advertising set.
+			The provided value is used only if the "CanSetTxPower"
+			feature is enabled on the Advertising Manager. The
+			provided value must be in range [-127 to +20], where
+			units are in dBm.
+
+
 LE Advertising Manager hierarchy
 ================================
 
@@ -209,3 +236,26 @@ Properties	byte ActiveInstances
 			Possible values: "1M"
 					 "2M"
 					 "Coded"
+
+		dict SupportedCapabilities
+
+			Enumerates Advertising-related controller capabilities
+			useful to the client.
+
+			Possible Values:
+
+				byte MaxAdvLen
+
+					Max advertising data length
+
+				byte MaxScnRspLen
+
+					Max advertising scan response length
+
+				int16 MinTxPower
+
+					Min advertising tx power (dBm)
+
+				int16 MaxTxPower
+
+					Max advertising tx power (dBm)
-- 
2.28.0.709.gb0816b6eb0-goog

