Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFBCC5517A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC7C221F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XLZHS02o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbgKKBR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 20:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbgKKBR4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 20:17:56 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4856C0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:55 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x13so506298pfa.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQ+EnXZ2kdnBZmC8x3MiuHzZ0854bTxxkZnBN1oy2g0=;
        b=XLZHS02oUWYhs8LxNQ5yMnT0sxOSuGOSUaw3DSncZGj34Q0BCRuwkPm+TgA1RJDRma
         kq6RW0zJ1/hnLwDFVvCyRPv8c+1O2GG68dPSxDyJGcycg/pIPyY1ou2IRyUkSNBkJGPp
         JxFqU/3wbjYeQqHXeeWMtzz+ZGR0zYbVZeCCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQ+EnXZ2kdnBZmC8x3MiuHzZ0854bTxxkZnBN1oy2g0=;
        b=iVnBLKT6Hd50567QtBT+gOum9GEiVwh9fru+RIxKh3ExfmQnz4/X3hG8pgNzy1PDzj
         K+h78J2QnVahIVTUiS8Q8ILY9FYFIW6Ol0KI3H4OmMFQCiptOzicPC+OJDNvoNqVL2U9
         bgCaF+IAHAhwjZ60uTnuFZDnb8/4Svf5RXR+OyD6gBY/7Rxx58/awfQl1dapiT6wx3IH
         W6tiv6rSuEmJbd6K3YY5/vSJX91401yb3wW/qX6CtU7l1PcC3izR5iWG2LErkhBTYY51
         pNVuKcBO8GEPMt26Zyf9ROz6igqK6BT0ePF1YYihziRgBIh95KX0CfwyG9ccDv+CnbS5
         UuGw==
X-Gm-Message-State: AOAM530k3Tjfl2NoAYTrsvmTjMrcMbpOucC+pgjx0AZvyRoUS5GXCmHU
        KzEeY24DQLsdnavSFFjASNhuXsmNCmgXYQ==
X-Google-Smtp-Source: ABdhPJyArm2VZBB8lvXY4u5nWyeOtZgdpOWjTktTrmDmbBw1cvrEFP/UiYSqymtwqaKmEFHFrSjiuQ==
X-Received: by 2002:a65:4305:: with SMTP id j5mr19067813pgq.249.1605057475085;
        Tue, 10 Nov 2020 17:17:55 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y19sm331695pfn.147.2020.11.10.17.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 17:17:54 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v2 4/7] doc: Add Battery Provider API doc
Date:   Tue, 10 Nov 2020 17:17:42 -0800
Message-Id: <20201111011745.2016-4-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111011745.2016-1-sonnysasaka@chromium.org>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
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
index dc7dbeda2..058bf0c6e 100644
--- a/doc/battery-api.txt
+++ b/doc/battery-api.txt
@@ -12,3 +12,58 @@ Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 Properties	byte Percentage [readonly]
 
 			The percentage of battery left as an unsigned 8-bit integer.
+
+		string Source [readonly, optional, experimental]
+
+			Describes where the battery information comes from
+			(e.g. "HFP 1.7", "HID").
+			This property is informational only and may be useful
+			for debugging purposes.
+
+
+Battery Provider Manager hierarchy
+==================================
+A battery provider starts by registering itself as a battery provider with the
+RegisterBatteryProvider method passing an object path as the provider ID. Then,
+it can start exposing org.bluez.BatteryProvider1 objects having the path
+starting with the given provider ID. It can also remove objects at any time.
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
+Object path	{provider_root}/org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties	byte Percentage [readonly]
+
+			The percentage of battery left as an unsigned 8-bit
+			integer.
+
+		string Source [readonly, optional]
+
+			Describes where the battery information comes from
+			(e.g. "HFP 1.7", "HID").
+			This property is informational only and may be useful
+			for debugging purposes. The content of this property is
+			a free string, but it is recommended to include the
+			profile name and version to be useful.
-- 
2.26.2

