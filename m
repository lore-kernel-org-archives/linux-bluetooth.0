Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5A6C64E7B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 19:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9084D2151B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 19:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zj3gtqrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404311AbgLATlQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404304AbgLATlP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 14:41:15 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC8C0617A7
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 11:40:35 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so1790416pfb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMithT29S8jllD7+H9uldq/66FIvtbycuIS3MLZQIFI=;
        b=Zj3gtqrXb83oqehxe1iIn9KtC1I6YXuo6SvZ597/m+MfZZ/e80P7QDMDndp+oZ4JND
         Umn6QmSuofSVPrpn5YBhVJl8hFmjnFxliX1P3seM/A7b6ilqQhW6Ym8uHAqfJAbZkqQn
         WXibjiv1+d8PQ5u7PdjMQgBQC/ffmkj7ty7EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMithT29S8jllD7+H9uldq/66FIvtbycuIS3MLZQIFI=;
        b=CROQMfxVAMWgFkN8UhZVyj4henKh5gyWSZWGmiMGgzgppwHPHSQL/3XRWt9NZfaIP2
         LTV7OjqCqzuXHkfammMZLKIia6Q1TCa8OE8JRNBLN4+P6SpMvQLHO/Ggexah+wjPfo5M
         7L7e8DgZ985mUHQXLK40CugDc+zgtc+et3Hb9Gy87335S6Z7KgGTahjwbE430clKImbU
         xSeKj4T0hg3FSUlyDGnK2TgO9yoQt+0bH31HE/oNWP+RLJwZTRKZdTma3XmZcefl6UBB
         CqcuyunIKmMiZZVcpH2yAZ7LDeenlvZKCQIQ+rV+KVOfKRITCvpZNuTMhfJD95L/B5WT
         Ygeg==
X-Gm-Message-State: AOAM530mNQObHwz17iwHUaRxcFowi3TzGcuir29dY44Pw3+4c7F8USGc
        /YcfmkN/dJSeAX4Pnn2inoc+z11tbhl0ag==
X-Google-Smtp-Source: ABdhPJxQR+IaC2C8rXGbWpPJXZV/VNJzfPtseZtvFUXqxMsV8VAtge79HbaBaE0oUpoKiNUXNebXzA==
X-Received: by 2002:a62:5e81:0:b029:197:baa5:1792 with SMTP id s123-20020a625e810000b0290197baa51792mr3916669pfb.80.1606851634831;
        Tue, 01 Dec 2020 11:40:34 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y19sm393529pge.15.2020.12.01.11.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2020 11:40:34 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] doc: Update battery API doc
Date:   Tue,  1 Dec 2020 11:40:21 -0800
Message-Id: <20201201194021.341363-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/battery-api.txt | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
index 9a6b4fd39..ec7d593da 100644
--- a/doc/battery-api.txt
+++ b/doc/battery-api.txt
@@ -15,12 +15,10 @@ Properties	byte Percentage [readonly]
 
 		string Source [readonly, optional, experimental]
 
-			Describes where the battery information comes from
-			This property is informational only and may be useful
-			for debugging purposes.
-			Providers from BatteryProvider1 may make use of this
-			property to indicate where the battery report comes from
-			(e.g. "HFP 1.7", "HID", or the profile UUID).
+			Describes where the battery information comes from.
+			Providers may provide the source information in the form
+			of the profile UUID where the battery information is
+			reported.
 
 
 Battery Provider Manager hierarchy
@@ -61,8 +59,8 @@ Object path	{provider_root}/{unique battery object path}
 
 Properties	Objects provided on this interface contain the same properties
 		as org.bluez.Battery1 interface. Additionally, this interface
-		needs to have the Device property indicating the object path
-		of the device this battery provides.
+		needs to have a Device property indicating the object path the
+		battery information is provided for.
 
 		object Device [readonly]
 
-- 
2.26.2

