Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA701C33CAF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 23:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E9124655
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 23:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="goiqc4pU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgAUX1K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:27:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39064 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUX1K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 18:27:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so2030044plp.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 15:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2neVyJZsiwbeBb26itcM7RJ6y+SOUJTIn2tXxv5NII=;
        b=goiqc4pU0j/S7d1W080bCF7yrCCWNhTO9N97NMlbWufaQkPgWuic42sQ44kQGeRshl
         EAcCy2iVSCD0hJ1xUeSDjLLZQeGSTeo5R01/6bWsyIRKZyLdT4jo0ohxSVGBYoiCMInu
         uZ270LxkJXZaJO9LDHpPu9/mNMhlx5Xi+s3nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2neVyJZsiwbeBb26itcM7RJ6y+SOUJTIn2tXxv5NII=;
        b=NnXRREvKVdJWwWCI9SbAHPTtBGsH8YQAun9iF1bM3UZ/G4vTdh7BX4qBD8kpPlSQJW
         JzwljdYGV0v0GRrVxfR8hCPYm7pYSp0qO6lKAjwj2Wu4165cB4GMiQhC5ggliuJ4QlT8
         f0v7AwxAMHgubX7JsCw5EeW9hzjR2+OKfH4TL1FxyBUP0H6W7vJpkdYpFi0vwR/2Eqz3
         Ly8JRKPVvvkWiLMYj4SDdEyNXlUjgIqt1fcAgGSZQ1BaV7pWFGB2s0e87S0BoMAvACBk
         aPepae+le0jzfAsI1awqdaoNxmdNut6vwMjlVUJ7xz7m4NeaE6kAMNv6Hc482ea4hSat
         9qKg==
X-Gm-Message-State: APjAAAVPBthYZDI2IWpZuJaLcWjWGaxV3bQ/i0/PcWErbA5BCK9FpKiD
        1Yc9JheK+P0m9/7GFRLgePQQwwo5GWk+Fg==
X-Google-Smtp-Source: APXvYqwUpMUMJLR38pK1BUFllB8wf/b04jMuNV1i04/H+CQVz9ETS6Qb0/xlEHW9tRU8D3n2I36MtA==
X-Received: by 2002:a17:90a:628c:: with SMTP id d12mr1004211pjj.59.1579649229504;
        Tue, 21 Jan 2020 15:27:09 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id l8sm498320pjy.24.2020.01.21.15.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:27:09 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v2 3/3] client: Display wake capable property with info
Date:   Tue, 21 Jan 2020 15:27:00 -0800
Message-Id: <20200121152640.BlueZ.v2.3.I80d0e557c53f464415742324eb3ff2cc4cdcbc2a@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200121232700.158933-1-abhishekpandit@chromium.org>
References: <20200121232700.158933-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Display whether the device is configured as wake capable when queried
with cmd_info.

---

Changes in v2:
* Newly added to show whether device is wake capable
* Removed automatically setting wake capable for HID devices

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 8bd0bac9e..5c53fe08d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1609,6 +1609,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Trusted");
 	print_property(proxy, "Blocked");
 	print_property(proxy, "Connected");
+	print_property(proxy, "WakeCapable");
 	print_property(proxy, "LegacyPairing");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
-- 
2.25.0.341.g760bfbb309-goog

