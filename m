Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CFEC83011
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B73206DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHXrymvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgK3UEJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgK3UEI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 15:04:08 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63E8C0617A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:03:28 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b10so9722671pfo.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kh50OcTzrFmgdURg93OTnhuU/F5aplwBjH9orxXDq7k=;
        b=ZHXrymvG+HCPPaUA8Jhpy/HpmMT+jmJwkdmRokoKjuNFPrTEnbdmu0msgOTbViU7RB
         tQcV1VUKUGiibzv3Vbi556w+G9MIOfqkGt+aqxA5JRhMZqc/NhHKkpC6ZeMgsFWsS/ui
         AVTZ0ncsX6ONYI/zZjwGJ/L8xqLnXL/yHZ2is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kh50OcTzrFmgdURg93OTnhuU/F5aplwBjH9orxXDq7k=;
        b=oi8PHih0niGXernLP5+Uk74/PMTadh594LM5fp8ijIBn4N8x43j579k4OF9YkdYX1P
         n98z26GDcX0Cu8USDbu0JXdaH1S4BmdIeXrfHp56lUkbojXCvsCod34mRqLBufrvgP6J
         IbgTYkxoYWkQCQuluGEgS0UlL9Ird/ecw662lWVDa0+piYg2OkPvN2hBvGWn72ADxOcN
         j04ecRxDMOmvLcigdFp8R39rP2omceGSeRi6G1dLw/mO3tdN9mNzJYadn8p8LA5zhtjX
         HRXpOCyt0ckuqhNbzjXawkO3ZXAFMy+kAb7FLJQ0DdC930PI7AJIRtNykCn+p7P7AMyC
         Uzhw==
X-Gm-Message-State: AOAM5301ByOoI2oleeRiqC0CGwHMO9SH2wsrMzWqsW/eLXciUVqX7/pa
        ujIlo9byb3n9x/HPP3OA+mYEecEK4SAjYw==
X-Google-Smtp-Source: ABdhPJwedhvIlyrWsZZe6OFhadYr/GypNyC5QIkKLD5bEQv2q5wOWjUAkufjK/aGnT8eTivh3zlX7w==
X-Received: by 2002:aa7:8254:0:b029:19a:c192:5ddc with SMTP id e20-20020aa782540000b029019ac1925ddcmr13114659pfn.26.1606766607300;
        Mon, 30 Nov 2020 12:03:27 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y24sm17117184pfn.176.2020.11.30.12.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 12:03:26 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v4 4/7] doc: Add Battery Provider API doc
Date:   Mon, 30 Nov 2020 12:03:04 -0800
Message-Id: <20201130200307.386410-4-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130200307.386410-1-sonnysasaka@chromium.org>
References: <20201130200307.386410-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch add the documentation of the Battery Provider which lets
external clients feed battery information to BlueZ if they are able to
decode battery reporting via any profile. BlueZ UI clients can then use
the org.bluez.Battery1 API as a single source of battery information
coming from many different profiles.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 doc/battery-api.txt | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
index dc7dbeda2..9a6b4fd39 100644
--- a/doc/battery-api.txt
+++ b/doc/battery-api.txt
@@ -12,3 +12,58 @@ Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 Properties	byte Percentage [readonly]
 
 			The percentage of battery left as an unsigned 8-bit integer.
+
+		string Source [readonly, optional, experimental]
+
+			Describes where the battery information comes from
+			This property is informational only and may be useful
+			for debugging purposes.
+			Providers from BatteryProvider1 may make use of this
+			property to indicate where the battery report comes from
+			(e.g. "HFP 1.7", "HID", or the profile UUID).
+
+
+Battery Provider Manager hierarchy
+==================================
+A battery provider starts by registering itself as a battery provider with the
+RegisterBatteryProvider method passing an object path as the provider ID. Then,
+it can start exposing org.bluez.BatteryProvider1 objects having the path
+starting with the given provider ID. It can also remove objects at any time.
+The objects and their properties exposed by battery providers will be reflected
+on org.bluez.Battery1 interface.
+
+BlueZ will stop monitoring these exposed and removed objects after
+UnregisterBatteryProvider is called for that provider ID.
+
+Service		org.bluez
+Interface	org.bluez.BatteryProviderManager1 [experimental]
+Object path	/org/bluez/{hci0,hci1,...}
+
+Methods		void RegisterBatteryProvider(object provider)
+
+			This registers a battery provider. A registered
+			battery provider can then expose objects with
+			org.bluez.BatteryProvider1 interface described below.
+
+		void UnregisterBatteryProvider(object provider)
+
+			This unregisters a battery provider. After
+			unregistration, the BatteryProvider1 objects provided
+			by this client are ignored by BlueZ.
+
+
+Battery Provider hierarchy
+==========================
+
+Service		<client D-Bus address>
+Interface	org.bluez.BatteryProvider1 [experimental]
+Object path	{provider_root}/{unique battery object path}
+
+Properties	Objects provided on this interface contain the same properties
+		as org.bluez.Battery1 interface. Additionally, this interface
+		needs to have the Device property indicating the object path
+		of the device this battery provides.
+
+		object Device [readonly]
+
+			The object path of the device that has this battery.
-- 
2.26.2

