Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071D3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF7A207D3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Az8o8PIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgEUSBZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgEUSBZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 14:01:25 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB3DC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:01:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ci21so3469493pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmaJF7nOa6Y9+nFEhxxc6SRQTQCSt7W0TAl3VOq5HbE=;
        b=Az8o8PIWEGNe7/ZkB7OUnsRaDV9kZ4IEHQWk341yuIG0MDkxrpfQDUjK46pkbBLz3a
         IIJjjEtNF56d7EJrO/vQLnfyXYkUJpdabFoWYbCJ/hotjWHICwFx7eAiwqffZkTu//8S
         9UDuXbeUdahkp5ukRmdLxl4+eBA1kmthcWjpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GmaJF7nOa6Y9+nFEhxxc6SRQTQCSt7W0TAl3VOq5HbE=;
        b=nO2tDxixBlbWSQAB8CcAYftXEc9nBXOGlDbpxwXEQTObdTkS16zQhlWQ1xAzWBQ1TV
         e0orZxyHCcJJVnJxPNIPuqbRW1NZFCxgtkUJOvisn8UC6PKK8jtlnTdrJ6LYBltyZoAH
         oiFaJJyDfFCqZzIHX+Xr7M539fjltY7J7mVgahg46I8mcxqMB4uTLUU2ETOxtYjUqFZs
         DuovH9r2GOHwR4wwTMIx6OAON4p44SSMDARfX7ZRmfhYNHrEICbLDkhW6tiN/2W6bRiS
         3OwR2GBH9BZuVOsq4pBst0G1KXP4oikqTYYH0oFXsilX9Hv7ca+A9oAxxJfE6WHATRPW
         Z2Cw==
X-Gm-Message-State: AOAM531urkWZdqolEcOJVxqcUU23OQWQnE2WeuUD1OmmVE+R4fkHKOQz
        vn/bRtdI7iecuZjRgDy8QA09Jdcv5sY=
X-Google-Smtp-Source: ABdhPJy8yr4ToZxSciNJg88AbEiAJoJsvqLnhe/ngOawYlQoPKgCjtn23Cp0F6n7jk3BtGwkUPF2VA==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr10982032plk.5.1590084082602;
        Thu, 21 May 2020 11:01:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id h4sm4845975pfo.3.2020.05.21.11.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:01:22 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH v3 2/3] doc/device-api: Add Types property to org.bluez.Device1
Date:   Thu, 21 May 2020 11:01:00 -0700
Message-Id: <20200521180101.8223-2-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521180101.8223-1-sonnysasaka@chromium.org>
References: <20200521180101.8223-1-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 65d8fee37..32a146321 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -137,6 +137,11 @@ Properties	string Address [readonly]
 				"public" - Public address
 				"random" - Random address
 
+		array{string} Types [readonly]
+
+			The core configurations supported by this remote device.
+			It can contain "le" and "bredr".
+
 		string Name [readonly, optional]
 
 			The Bluetooth remote name. This value can not be
-- 
2.17.1

