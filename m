Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB2FC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCF920BED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0rswxM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgGFUZg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGFUZf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 16:25:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB9C08C5DF
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 13:25:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so12442875pjw.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LatEk0g8LQ9EDPYxpI3OOipaRxOzP67SKgN1Taywi8=;
        b=h0rswxM9fGGKb7fWb1RA8CqYAQSY0g4KTkQVjgTXdhC8ClNpny5VVVEZnrCIcgyul9
         trqe99WQMNUjPfqZMGWOZ0Qz23qMYB7p3B5KZKn944uU5f8de/0W2oDGDYyAisDT8/Iw
         vwJASBPafny/VcNzrG4dZ8+6l+9uG+Uh12NyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LatEk0g8LQ9EDPYxpI3OOipaRxOzP67SKgN1Taywi8=;
        b=P2wm+m0LZ7H3tTnoSI1diDwSZRgz0ZS+ITfpSiB0lwztJpIraBr8LjMzPymn3yGx/u
         BY64oTUIaR4lqcOChcc7z4026OkQjnGh3hO+9sEnLjiNdU4jjb3UUq7APs4wfUk5+apc
         9i7coGPiavAmXF8dBJVAR8VBnfI13+RBo1t1smtFO5r+S8OMspO6YqoZ77wQLsmDl0u2
         nshS68qNe0YmPMf5jWdrEvHEt3610Fks1OvTCzglkkuOHbartMcF6sN2c6XiSA8mtczj
         x6DG1jEubUNDwsgqvkAzB+GY9wOXIMC0F9l+vVyp0U+tH0532RB3/w0Q423kaIAut1eQ
         /IvA==
X-Gm-Message-State: AOAM533FhVQmrwGDOxZ8sIctATF2wr3tLmpuT9cAQV3+cqOTtou1ajH0
        BKB1GFzahNX1vKZDG19ht36ieA==
X-Google-Smtp-Source: ABdhPJz/irbGi3WKkdJArD0wq5wK9eVTNJfqtwqTIJCQgjX/dnau3rOffPRsfN3GXLJKGN1dThAqNg==
X-Received: by 2002:a17:902:bcc1:: with SMTP id o1mr41810694pls.246.1594067134774;
        Mon, 06 Jul 2020 13:25:34 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id n25sm3320226pff.51.2020.07.06.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:25:34 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v7 4/6] client: Display wake allowed property with info
Date:   Mon,  6 Jul 2020 13:25:16 -0700
Message-Id: <20200706132503.BlueZ.v7.4.I45dbf8ee15dff6c9346dc9754574a0be9bee1fa1@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200706202518.1153647-1-abhishekpandit@chromium.org>
References: <20200706202518.1153647-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Display whether the device is configured as wake allowed when queried
with cmd_info.

---

Changes in v7: None
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

