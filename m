Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A28C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BED120721
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 15:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y4pasZAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404270AbgDCPdk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:33:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41051 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404266AbgDCPdk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 11:33:40 -0400
Received: by mail-vs1-f65.google.com with SMTP id a63so5160484vsa.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gcz3eeQ2+0WzD1apCVGEkjRjlAZ7ZYY3BIn+Q6bn+QE=;
        b=Y4pasZAXXchmqenS46oUxtFb2jPuI1ekF3bBABf2Ed9cqCVN+5Q+QyRNc26BOWEGAR
         e0og32rpjiQvB6rIKT5xdnMJzbfm9rm2eAIO9Xf8tU3Y9Wb9FP4Ud1pGxG2ZJ3Z3lxTA
         fhmTKbD/GtWqYqzTT3BHrSpFT3U4O/WWQwI7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gcz3eeQ2+0WzD1apCVGEkjRjlAZ7ZYY3BIn+Q6bn+QE=;
        b=MFkmadaU18el7zGvh+dZ489Z10bwVwWSc1YW/vs7U+x085DZEXanAb5SUs+6fgS5//
         EjRF2eJ5FyOX9xDO1USQeibKyb6ZdQbD9J4OB37vXvRAkbTbHeymWOmUG3DnsTbVWxOP
         ytSVEboNhQtAW7xicHOq5ZDgfy4VD0+250zHLorNtCoX8zHplcue3oBXJFbnHtk2/i/f
         srQY+lHZCCzj+BuLBINjjXpAV/Oj4okMoc+aZ2tjtRx3agnvTeUxyNtPTmVOr6wwdRVQ
         F5ys7omAPs/dLItnmhTOHxO/GMJSAseJckURrBWLC8alRVxw0e0eSFFJw9oVEUAvhofD
         EKnw==
X-Gm-Message-State: AGi0PuaCwaRU+HIh3+r+1c2RPvN7llpB26aG5aoOf188vAjFFpa5u+OI
        bj/Aso62JDi4Y2GM0FMOQ57X+MqGJqo=
X-Google-Smtp-Source: APiQypKwRD1W3e5v4zorafN884R9APFKLqfQbOS+eBQ5nzkfxBTqYwfQm8s9Yug8oiQY9vT/AYi0dg==
X-Received: by 2002:a67:1587:: with SMTP id 129mr7724003vsv.146.1585928018222;
        Fri, 03 Apr 2020 08:33:38 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id u82sm2145510vsu.20.2020.04.03.08.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:33:37 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
Date:   Fri,  3 Apr 2020 15:33:30 +0000
Message-Id: <20200403153331.101846-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds an adapter Api to report the controller's
widebandspeech enabled state.

---

 doc/adapter-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index acae032d9..d8865e795 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -326,3 +326,11 @@ Properties	string Address [readonly]
 
 			Local Device ID information in modalias format
 			used by the kernel and udev.
+
+		boolean WidebandSpeechEnabled [readonly]
+
+			Returns true if the adapter's wideband speech feature is
+			supported and enabled.
+
+
+
-- 
2.26.0.292.g33ef6b2f38-goog

