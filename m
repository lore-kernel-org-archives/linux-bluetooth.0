Return-Path: <SRS0=Q1DV=EF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70195C61DD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105DE20825
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozXyMct5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgJ3JVG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgJ3JVF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 05:21:05 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848C7C0613D6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:11:19 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id w189so3444325qkd.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lQ4KBfib0ccEaGKQpjcrLjst4wBoAQNNRSPstCq2R1o=;
        b=ozXyMct52rtlS4r0vot7vhWWI5f0No9Nx8v/Gf8IwXUnU0kCORoSpLWZcjX8/sqKV9
         cobtlSbWrgJAbigHZ86OsKG4FUoiLPlXx/sHq7rR4bWBJ5LZOZd7MKopL6CGQGAd9ruT
         ukDzZo9ZXOZADxsxMPycoohjV5jUb79O+K913Gsre0hJNsGwm5u0qOiqZ+qTQgmh5Ce1
         6+cPvyumTzO1FOv/Xuj81MVuZnRyivbuaqc64lzKyCGPPaLZfzfl0zmi90rl/7o1gKet
         PT4rhdDGf6t+UkBpaeuQlzLdNTei4Y4yYpzmKFBfi2JQ7trW7jnLtI75p0TWk9Gx0xmu
         bgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQ4KBfib0ccEaGKQpjcrLjst4wBoAQNNRSPstCq2R1o=;
        b=F3AmQxuWrw19JN8Am4PgA4Lf1NwylMx/pVn3stGlEad3pFvKE/p+KcYInNYUyjkYq6
         W63knNZM/bQHGS1DInznF1MY5Oz+0h05XE5zEdPF+apaTuapAmuu42On2ZGG+9Gm/o/K
         lSTfAaXIfyN/5/DL8V0EPmW/2ERSIPT9bxss9EAWdhSFUf92lqD8O0BJhPxQsqj6aISf
         GMB/arOEvd4n5mdlm3etsRhh0R9pUFvljQOFz2xIVVELZjV2ZhlT/kjXoLhVmehaX0Vw
         8UpDwQYikutLUnCRfwTfCpyJGxReJCri9XldfRp848l6slWr9bi+515UWQGfz2VXH42n
         xFQw==
X-Gm-Message-State: AOAM533qDUoiz8vKBos2ParzpPT/0IY903GIilpcKjM/+AmSsroGeAfp
        WLMcKHFmchhpiJpUmeO6Ven+EPscUne924yJzsdeacKkNlBuEhFMxL6YoCwT1QTPZSjN0hYTb6t
        xmBOg7oHOnki1uD/3NQAmDT14zWpapyoZ/OzXv+yly1rOMUQ1f0NofW+JAFXv9kbt7Pak8eVO0a
        08oEE7QN8PB9M=
X-Google-Smtp-Source: ABdhPJy5tDsrkOagFHTU76W9EUfFocd8ZUfi7sVsQlXrx2P9TCXOyXrc4jOKg7cKc2oAfO2jS8oaNkErNW4GGYoaIg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:9064:: with SMTP id
 o91mr8418367qvo.28.1604049078700; Fri, 30 Oct 2020 02:11:18 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:11:02 +0800
In-Reply-To: <20201030170932.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Message-Id: <20201030170932.BlueZ.v2.3.I22eddcf44e1bec5295c2e162c0477347d2194958@changeid>
Mime-Version: 1.0
References: <20201030170932.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [BlueZ PATCH v2 3/3] core: Fix mistakes of using mgmt_tlv_add_fixed
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, mmandlik@chromium.org, mcchou@chromium.org,
        alainm@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix mistakes on checking the result of mgmt_tlv_add_fixed.
---

(no changes since v1)

 src/adapter.c | 52 +++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c7b2e0233639..f4d05f3731df 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4187,157 +4187,157 @@ static void load_default_system_params(struct btd_adapter *adapter)
 	}
 
 	if (btd_opts.defaults.br.page_scan_win) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0002,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0002,
 					&btd_opts.defaults.br.page_scan_win))
 			goto done;
 	}
 
 	if (btd_opts.defaults.br.scan_type != 0xFFFF) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0003,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0003,
 					&btd_opts.defaults.br.scan_type))
 			goto done;
 	}
 
 	if (btd_opts.defaults.br.scan_interval) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0004,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0004,
 					&btd_opts.defaults.br.scan_interval))
 			goto done;
 	}
 
 	if (btd_opts.defaults.br.scan_win) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0005,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0005,
 					&btd_opts.defaults.br.scan_win))
 			goto done;
 	}
 
 	if (btd_opts.defaults.br.link_supervision_timeout) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0006,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0006,
 			&btd_opts.defaults.br.link_supervision_timeout))
 			goto done;
 	}
 
 	if (btd_opts.defaults.br.page_timeout) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0007,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0007,
 					&btd_opts.defaults.br.page_timeout))
 			goto done;
 	}
 
 	if (btd_opts.defaults.br.min_sniff_interval) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0008,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0008,
 				&btd_opts.defaults.br.min_sniff_interval))
 			goto done;
 	}
 
 	if (btd_opts.defaults.br.max_sniff_interval) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0009,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0009,
 				&btd_opts.defaults.br.max_sniff_interval))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.min_adv_interval) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x000a,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x000a,
 				&btd_opts.defaults.le.min_adv_interval))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.max_adv_interval) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x000b,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x000b,
 				&btd_opts.defaults.le.max_adv_interval))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.adv_rotation_interval) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x000c,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x000c,
 				&btd_opts.defaults.le.adv_rotation_interval))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_interval_autoconnect) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x000d,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x000d,
 			&btd_opts.defaults.le.scan_interval_autoconnect))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_win_autoconnect) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x000e,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x000e,
 				&btd_opts.defaults.le.scan_win_autoconnect))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_interval_suspend) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x000f,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x000f,
 				&btd_opts.defaults.le.scan_interval_suspend))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_win_suspend) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0010,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0010,
 				&btd_opts.defaults.le.scan_win_suspend))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_interval_discovery) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0011,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0011,
 				&btd_opts.defaults.le.scan_interval_discovery))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_win_discovery) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0012,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0012,
 				&btd_opts.defaults.le.scan_win_discovery))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_interval_adv_monitor) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0013,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0013,
 			&btd_opts.defaults.le.scan_interval_adv_monitor))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_win_adv_monitor) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0014,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0014,
 				&btd_opts.defaults.le.scan_win_adv_monitor))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_interval_connect) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0015,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0015,
 				&btd_opts.defaults.le.scan_interval_connect))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.scan_win_connect) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0016,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0016,
 				&btd_opts.defaults.le.scan_win_connect))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.min_conn_interval) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0017,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0017,
 				&btd_opts.defaults.le.min_conn_interval))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.max_conn_interval) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0018,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0018,
 				&btd_opts.defaults.le.max_conn_interval))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.conn_latency) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x0019,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0019,
 					&btd_opts.defaults.le.conn_latency))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.conn_lsto) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x001a,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x001a,
 					&btd_opts.defaults.le.conn_lsto))
 			goto done;
 	}
 
 	if (btd_opts.defaults.le.autoconnect_timeout) {
-		if (mgmt_tlv_add_fixed(tlv_list, 0x001b,
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x001b,
 				&btd_opts.defaults.le.autoconnect_timeout))
 			goto done;
 	}
-- 
2.29.1.341.ge80a0c044ae-goog

