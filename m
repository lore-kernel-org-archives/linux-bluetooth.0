Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EE4C4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652922076C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CJYztvqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCTBub (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:50:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36853 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCTBua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Mar 2020 21:50:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so1853564plo.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2020 18:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+Juhpb0+ZK6h8BgiB7H9s+Tupk9orFVQTeAOyei+Hc=;
        b=CJYztvquMIiRPHHYic098oNanMhWn3lwTtlYFurEXrwkEKiCLvMnGRWyR4dq2nIbQ9
         xqp+bmbp4Noa9QrH7Y2oeu8AiE9vGtPTJ0PAM2nY37zMBp39N4Zn724mQAEyLHXxAAxc
         9zGqfsXX6y3viRaSE5OnImdVtfutgzLn02yyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+Juhpb0+ZK6h8BgiB7H9s+Tupk9orFVQTeAOyei+Hc=;
        b=bqlk9KUrIecYrJpkiQeCmivs8LKCsftcrLU/8o4A/Y0QxN8l8+BTHsKYz0FduI9Ml8
         idqjrie/Lhu8pjFSckUExHwR7rAZmVf8CVMOikMgnYI4x25Ui3W6TGeuhsU1C2HASV5u
         dAx9B6C/2Id+kYCvv385mpX69/f5Y17TuTRrcA0biMxvZ5oFlE3fO3lLRjdufmXG3qSq
         nMz1ZC7PYtzVJSPRkXuIjvynXaoFEY++Ff0XQYwEwJYOPngTGV+Yo3SVbOK5NLbMrAGd
         L6G9/h3tymiM19ki1e/H9kJv2WDgc+IoUSUVLZk+pvSoHOyY6CRf6kFkET+PJYjWiYCh
         gLTQ==
X-Gm-Message-State: ANhLgQ2ta5jcKpwiOtV3AKhdsE/WjcZwt5D/Kj1KWeQuR3Ci3pZ1rWQP
        hYjckzfLfRocdPlAemK8xrijLQ==
X-Google-Smtp-Source: ADFU+vsdLLBE+F44K3pxWGom3wFCTpT8WNHNxQiAx50PCbBuVYOK25uePIVvU+7UHpJ3fVpew5oODg==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr6188632plz.239.1584669029639;
        Thu, 19 Mar 2020 18:50:29 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 136sm3410485pgh.26.2020.03.19.18.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:50:29 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v4 3/5] client: Display wake allowed property with info
Date:   Thu, 19 Mar 2020 18:50:21 -0700
Message-Id: <20200319185000.BlueZ.v4.3.I80d0e557c53f464415742324eb3ff2cc4cdcbc2a@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320015023.85896-1-abhishekpandit@chromium.org>
References: <20200320015023.85896-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Display whether the device is configured as wake allowed when queried
with cmd_info.
---

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
2.25.1.696.g5e7596f4ac-goog

