Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453FBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B8C206C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lTJW6YCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgF2XCf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgF2XCe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 19:02:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00D4C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so9005832pgk.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/3TX1GMSyX3TTscRoWjCKEmSjIsfk15HaizZFDaaBE=;
        b=lTJW6YCM5+pShACNr8EEFsMa3SNagZUkm2LSLPPyu4neBqCjEa11U5k/msctTp75T3
         gaFYlEIabatzaok7X3Cr3UwRyeAdvCYDJdq2VTwaD2riGd4XQBuZnNQ9Et4rbaf2Q5wC
         RS7ZcF4vN7Pd1VjCVaM0W5iEETRzHbxs9uikQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/3TX1GMSyX3TTscRoWjCKEmSjIsfk15HaizZFDaaBE=;
        b=ti8U/8/8B57MSCGkH8LIOovo6Lk4YOEfLKhEbPoIS1oVwyicZaLIlpG6yBRMzuug/u
         1TIERBVSeJnhRAFManOWPE9jtXj2DU2Ly7BEP761md1oxme5DXlo63+P1SH0Dizga2+2
         BfPFOsziz6rcu7fOIS0DDsITVdylHWuH3BW/5Jj6nD19hd63dauR5sJ+Oe1tGCcZKiVo
         /uZ0m517bX2oXm8kSUFysv85eRIQJ1VW7xbZHWJyqM0i28Svcst4lnayDWSESqo5dZUV
         g3sVJvT1eD3Q3GFI0ocEqTWiUVgijgUjOGxjseDFwKBcc0OzZAcx98JGlA5MAogUg3TA
         ih2Q==
X-Gm-Message-State: AOAM533XunWPlgyKpo/4jpuwIlUtf5SIIupqcg6MIQ+jbL2no1QlqQs7
        +iAvhaOSi4l3QSBu7yoGaq06Zw==
X-Google-Smtp-Source: ABdhPJwdCt/7ZNtZCdGixklixX9Az48KALTznFLeHTndARzZcL92dOJjSx/TZ8gI3H7fzj4nxnypDw==
X-Received: by 2002:a62:7712:: with SMTP id s18mr16684110pfc.145.1593471753544;
        Mon, 29 Jun 2020 16:02:33 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id i13sm467275pjd.33.2020.06.29.16.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:02:33 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v6 4/6] client: Display wake allowed property with info
Date:   Mon, 29 Jun 2020 16:02:21 -0700
Message-Id: <20200629160206.BlueZ.v6.4.I45dbf8ee15dff6c9346dc9754574a0be9bee1fa1@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200629230223.3538949-1-abhishekpandit@chromium.org>
References: <20200629230223.3538949-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Display whether the device is configured as wake allowed when queried
with cmd_info.

---

Changes in v6: None
Changes in v5: None
Changes in v4:
* Renamed WakeCapable to WakeAllowed

Changes in v3: None
Changes in v2:
* Newly added to show whether device is wake capable
* Removed automatically setting wake capable for HID devices

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 422da5593..4953f50f0 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1637,6 +1637,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Trusted");
 	print_property(proxy, "Blocked");
 	print_property(proxy, "Connected");
+	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
-- 
2.27.0.212.ge8ba1cc988-goog

