Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD90C55179
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAC6207CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpFvTB7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390709AbgJ1Xcz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390461AbgJ1Xcx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:32:53 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EB8C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:32:52 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id s25so181498vsn.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wIEUrtgDYzIAcGyMAX8gDtwyNKYw6+N0l7rAaSZZBO4=;
        b=jpFvTB7++L+eiHOadERX7XmRSM/8omrIF5mnnx7z7Ak5PrLRzzqb0H95kyhxsEBpND
         R8Xp81Hoh5XYJliUJnrb4Er3fQ3RSOrS4fM0i53x1pLFoBiRVc5PVvMHHPjIFQ2uYihU
         bMugia8+gwXOFnGBDY41qHREpepanfd8iXFAS7hLkf0kSxCWGDLgC/RXv0A2rNIrdy5p
         Few81xoDtNTp+0UmHqeGUFgAWrlwc9ufvqiqT1V7wN3O9ALyIkCxYUKIw6BlBarqENsr
         j254q7jPtiuuxFucJ66K2SmS2pmyI8czoAFbdR4N+AhcMZK+ajVPlU+ML0mkLfttPxAN
         8U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wIEUrtgDYzIAcGyMAX8gDtwyNKYw6+N0l7rAaSZZBO4=;
        b=o/RFh+uNVzPBqKGXWy5xFdievJQBiB2ifPjjxpfmIBOEkFYnS5vBr+Axs5wfVQcNqD
         LbGNpB2yU/vP6fe7yJ7ibmY8SVjMNw+6UM4S6GgQ8wtP2XW07FEkT9vcLv06AhoZeiEc
         OPZltrXH+YbVzU9UzoXkh2zHECeAnbwkgnvuzjN07sqY55WDyuGAcyppO2evenMEiuzt
         JkRl955qY4rR+GEDty6cc2PD7WtX4UUeAI9KH20F3ZRhYS4SdGevdh+JssTGug/2MXoi
         ajvNyoeifQOhqF7qkhTH4zPpOlVIvGedxD1RK2nnsAo5151TQTDJ3BqATlssDsbxzJQc
         Eyjg==
X-Gm-Message-State: AOAM533uuOnWxkgIQYbAMtIJAl0IqV7K988WUbHCyxwwo04I4wk+qUKA
        +ciRIXsi7vzACRPHQUgrfdESUXnzBiFktzE7LfiRLLcXxSiUa0JdROHnRkY+AYrJoIjXqioz6wK
        O6GOf/3WFK9knm58ANnjFVj+v6I3eFFhf+2kJ57TauDFgWVkcOK1TMVrNnhpaloVWPmL2uiFK5X
        TrX6+SFSSvIko=
X-Google-Smtp-Source: ABdhPJzhxhs2iw0JHAtEPr7B3go6QPLRnAwALYtcqIcA5Qb0UxyqA18ihDINs0cNWyms9qBbxmspTUV2e1gqLzYS3g==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:cc12:: with SMTP id
 r18mr7303060qvk.2.1603885982267; Wed, 28 Oct 2020 04:53:02 -0700 (PDT)
Date:   Wed, 28 Oct 2020 19:52:47 +0800
In-Reply-To: <20201028195132.BlueZ.v5.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
Message-Id: <20201028195132.BlueZ.v5.2.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
Mime-Version: 1.0
References: <20201028195132.BlueZ.v5.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [BlueZ PATCH v5 2/2] core: Add support of variable length params in mgmt_config
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     apusaka@chromium.org, mmandlik@chromium.org, alainm@chromium.org,
        luiz.dentz@gmail.com, mcchou@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support of variable length parameters in mgmt_config.
Also fixed the endian issue.


Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
Changes in v5:
- use mgmt_tlv api

Changes in v4:
- fix type of buf_len

Changes in v3:
- use iovec to fill buffer

Changes in v2:
- fix multiple line dereference issue

 src/adapter.c | 264 +++++++++++++++++++-------------------------------
 src/main.c    |  35 ++++++-
 2 files changed, 130 insertions(+), 169 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c0053000ac19..62b7bfbae021 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4165,267 +4165,197 @@ static void probe_devices(void *user_data)
 
 static void load_default_system_params(struct btd_adapter *adapter)
 {
-	struct {
-		struct mgmt_tlv entry;
-		union {
-			uint16_t u16;
-		};
-	} __packed *params;
-	uint16_t i = 0;
-	size_t len = 0;
-	unsigned int err;
+	struct mgmt_tlv_list *tlv_list;
+	unsigned int err = 0;
 
 	if (!main_opts.default_params.num_entries ||
 	    !btd_has_kernel_features(KERNEL_SET_SYSTEM_CONFIG))
 		return;
 
-	params = malloc0(sizeof(*params) *
-			main_opts.default_params.num_entries);
-
-	len = sizeof(params->entry) * main_opts.default_params.num_entries;
+	tlv_list = mgmt_tlv_list_new();
 
 	if (main_opts.default_params.br_page_scan_type != 0xFFFF) {
-		params[i].entry.type = 0x0000;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_scan_type;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0000,
+			sizeof(main_opts.default_params.br_page_scan_type),
+			&main_opts.default_params.br_page_scan_type);
 	}
 
 	if (main_opts.default_params.br_page_scan_interval) {
-		params[i].entry.type = 0x0001;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_scan_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0001,
+			sizeof(main_opts.default_params.br_page_scan_interval),
+			&main_opts.default_params.br_page_scan_interval);
 	}
 
 	if (main_opts.default_params.br_page_scan_win) {
-		params[i].entry.type = 0x0002;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_scan_win;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0002,
+			sizeof(main_opts.default_params.br_page_scan_win),
+			&main_opts.default_params.br_page_scan_win);
 	}
 
 	if (main_opts.default_params.br_scan_type != 0xFFFF) {
-		params[i].entry.type = 0x0003;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_scan_type;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0003,
+			sizeof(main_opts.default_params.br_scan_type),
+			&main_opts.default_params.br_scan_type);
 	}
 
 	if (main_opts.default_params.br_scan_interval) {
-		params[i].entry.type = 0x0004;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_scan_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0004,
+			sizeof(main_opts.default_params.br_scan_interval),
+			&main_opts.default_params.br_scan_interval);
 	}
 
 	if (main_opts.default_params.br_scan_win) {
-		params[i].entry.type = 0x0005;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_scan_win;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0005,
+			sizeof(main_opts.default_params.br_scan_win),
+			&main_opts.default_params.br_scan_win);
 	}
 
 	if (main_opts.default_params.br_link_supervision_timeout) {
-		params[i].entry.type = 0x0006;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.br_link_supervision_timeout;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0006,
+			sizeof(main_opts.default_params.br_link_supervision_timeout),
+			&main_opts.default_params.br_link_supervision_timeout);
 	}
 
 	if (main_opts.default_params.br_page_timeout) {
-		params[i].entry.type = 0x0007;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_timeout;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0007,
+			sizeof(main_opts.default_params.br_page_timeout),
+			&main_opts.default_params.br_page_timeout);
 	}
 
 	if (main_opts.default_params.br_min_sniff_interval) {
-		params[i].entry.type = 0x0008;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_min_sniff_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0008,
+			sizeof(main_opts.default_params.br_min_sniff_interval),
+			&main_opts.default_params.br_min_sniff_interval);
 	}
 
 	if (main_opts.default_params.br_max_sniff_interval) {
-		params[i].entry.type = 0x0009;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_max_sniff_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0009,
+			sizeof(main_opts.default_params.br_max_sniff_interval),
+			&main_opts.default_params.br_max_sniff_interval);
 	}
 
 	if (main_opts.default_params.le_min_adv_interval) {
-		params[i].entry.type = 0x000a;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_min_adv_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x000a,
+			sizeof(main_opts.default_params.le_min_adv_interval),
+			&main_opts.default_params.le_min_adv_interval);
 	}
 
 	if (main_opts.default_params.le_max_adv_interval) {
-		params[i].entry.type = 0x000b;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_max_adv_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x000b,
+			sizeof(main_opts.default_params.le_max_adv_interval),
+			&main_opts.default_params.le_max_adv_interval);
 	}
 
 	if (main_opts.default_params.le_multi_adv_rotation_interval) {
-		params[i].entry.type = 0x000c;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_multi_adv_rotation_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x000c,
+			sizeof(main_opts.default_params.le_multi_adv_rotation_interval),
+			&main_opts.default_params.le_multi_adv_rotation_interval);
 	}
 
 	if (main_opts.default_params.le_scan_interval_autoconnect) {
-		params[i].entry.type = 0x000d;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_autoconnect;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x000d,
+			sizeof(main_opts.default_params.le_scan_interval_autoconnect),
+			&main_opts.default_params.le_scan_interval_autoconnect);
 	}
 
 	if (main_opts.default_params.le_scan_win_autoconnect) {
-		params[i].entry.type = 0x000e;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_win_autoconnect;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x000e,
+			sizeof(main_opts.default_params.le_scan_win_autoconnect),
+			&main_opts.default_params.le_scan_win_autoconnect);
 	}
 
 	if (main_opts.default_params.le_scan_interval_suspend) {
-		params[i].entry.type = 0x000f;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_suspend;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x000f,
+			sizeof(main_opts.default_params.le_scan_interval_suspend),
+			&main_opts.default_params.le_scan_interval_suspend);
 	}
 
 	if (main_opts.default_params.le_scan_win_suspend) {
-		params[i].entry.type = 0x0010;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_scan_win_suspend;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0010,
+			sizeof(main_opts.default_params.le_scan_win_suspend),
+			&main_opts.default_params.le_scan_win_suspend);
 	}
 
 	if (main_opts.default_params.le_scan_interval_discovery) {
-		params[i].entry.type = 0x0011;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_discovery;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0011,
+			sizeof(main_opts.default_params.le_scan_interval_discovery),
+			&main_opts.default_params.le_scan_interval_discovery);
 	}
 
 	if (main_opts.default_params.le_scan_win_discovery) {
-		params[i].entry.type = 0x0012;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_win_discovery;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0012,
+			sizeof(main_opts.default_params.le_scan_win_discovery),
+			&main_opts.default_params.le_scan_win_discovery);
 	}
 
 	if (main_opts.default_params.le_scan_interval_adv_monitor) {
-		params[i].entry.type = 0x0013;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_adv_monitor;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0013,
+			sizeof(main_opts.default_params.le_scan_interval_adv_monitor),
+			&main_opts.default_params.le_scan_interval_adv_monitor);
 	}
 
 	if (main_opts.default_params.le_scan_win_adv_monitor) {
-		params[i].entry.type = 0x0014;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_win_adv_monitor;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0014,
+			sizeof(main_opts.default_params.le_scan_win_adv_monitor),
+			&main_opts.default_params.le_scan_win_adv_monitor);
 	}
 
 	if (main_opts.default_params.le_scan_interval_connect) {
-		params[i].entry.type = 0x0015;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_connect;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0015,
+			sizeof(main_opts.default_params.le_scan_interval_connect),
+			&main_opts.default_params.le_scan_interval_connect);
 	}
 
 	if (main_opts.default_params.le_scan_win_connect) {
-		params[i].entry.type = 0x0016;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_scan_win_connect;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0016,
+			sizeof(main_opts.default_params.le_scan_win_connect),
+			&main_opts.default_params.le_scan_win_connect);
 	}
 
 	if (main_opts.default_params.le_min_conn_interval) {
-		params[i].entry.type = 0x0017;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_min_conn_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0017,
+			sizeof(main_opts.default_params.le_min_conn_interval),
+			&main_opts.default_params.le_min_conn_interval);
 	}
 
 	if (main_opts.default_params.le_max_conn_interval) {
-		params[i].entry.type = 0x0018;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_max_conn_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0018,
+			sizeof(main_opts.default_params.le_max_conn_interval),
+			&main_opts.default_params.le_max_conn_interval);
 	}
 
 	if (main_opts.default_params.le_conn_latency) {
-		params[i].entry.type = 0x0019;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_conn_latency;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x0019,
+			sizeof(main_opts.default_params.le_conn_latency),
+			&main_opts.default_params.le_conn_latency);
 	}
 
 	if (main_opts.default_params.le_conn_lsto) {
-		params[i].entry.type = 0x001a;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_conn_lsto;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x001a,
+			sizeof(main_opts.default_params.le_conn_lsto),
+			&main_opts.default_params.le_conn_lsto);
 	}
 
 	if (main_opts.default_params.le_autoconnect_timeout) {
-		params[i].entry.type = 0x001b;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_autoconnect_timeout;
-		++i;
-		len += sizeof(params[i].u16);
+		err |= !mgmt_tlv_add(tlv_list, 0x001b,
+			sizeof(main_opts.default_params.le_autoconnect_timeout),
+			&main_opts.default_params.le_autoconnect_timeout);
+	}
+
+	if (err) {
+		btd_error(adapter->dev_id, "Failed to add tlv to list");
+		goto done;
 	}
 
-	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
-			adapter->dev_id, len, params, NULL, NULL, NULL);
+	err = mgmt_send_tlv(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+			adapter->dev_id, tlv_list, NULL, NULL, NULL);
+
 	if (!err)
 		btd_error(adapter->dev_id,
 				"Failed to set default system config for hci%u",
 				adapter->dev_id);
-
-	free(params);
+done:
+	mgmt_tlv_list_free(tlv_list);
 }
 
 static void load_devices(struct btd_adapter *adapter)
diff --git a/src/main.c b/src/main.c
index 77be776686a8..b83f7bffb485 100644
--- a/src/main.c
+++ b/src/main.c
@@ -305,120 +305,149 @@ static void parse_controller_config(GKeyFile *config)
 {
 	static const struct {
 		const char * const val_name;
-		uint16_t * const val;
+		void * const val;
+		const size_t size;
 		const uint16_t min;
 		const uint16_t max;
 	} params[] = {
 		{ "BRPageScanType",
 		  &main_opts.default_params.br_page_scan_type,
+		  sizeof(main_opts.default_params.br_page_scan_type),
 		  0,
 		  1},
 		{ "BRPageScanInterval",
 		  &main_opts.default_params.br_page_scan_interval,
+		  sizeof(main_opts.default_params.br_page_scan_interval),
 		  0x0012,
 		  0x1000},
 		{ "BRPageScanWindow",
 		  &main_opts.default_params.br_page_scan_win,
+		  sizeof(main_opts.default_params.br_page_scan_win),
 		  0x0011,
 		  0x1000},
 		{ "BRInquiryScanType",
 		  &main_opts.default_params.br_scan_type,
+		  sizeof(main_opts.default_params.br_scan_type),
 		  0,
 		  1},
 		{ "BRInquiryScanInterval",
 		  &main_opts.default_params.br_scan_interval,
+		  sizeof(main_opts.default_params.br_scan_interval),
 		  0x0012,
 		  0x1000},
 		{ "BRInquiryScanWindow",
 		  &main_opts.default_params.br_scan_win,
+		  sizeof(main_opts.default_params.br_scan_win),
 		  0x0011,
 		  0x1000},
 		{ "BRLinkSupervisionTimeout",
 		  &main_opts.default_params.br_link_supervision_timeout,
+		  sizeof(main_opts.default_params.br_link_supervision_timeout),
 		  0x0001,
 		  0xFFFF},
 		{ "BRPageTimeout",
 		  &main_opts.default_params.br_page_timeout,
+		  sizeof(main_opts.default_params.br_page_scan_win),
 		  0x0001,
 		  0xFFFF},
 		{ "BRMinSniffInterval",
 		  &main_opts.default_params.br_min_sniff_interval,
+		  sizeof(main_opts.default_params.br_min_sniff_interval),
 		  0x0001,
 		  0xFFFE},
 		{ "BRMaxSniffInterval",
 		  &main_opts.default_params.br_max_sniff_interval,
+		  sizeof(main_opts.default_params.br_max_sniff_interval),
 		  0x0001,
 		  0xFFFE},
 		{ "LEMinAdvertisementInterval",
 		  &main_opts.default_params.le_min_adv_interval,
+		  sizeof(main_opts.default_params.le_min_adv_interval),
 		  0x0020,
 		  0x4000},
 		{ "LEMaxAdvertisementInterval",
 		  &main_opts.default_params.le_max_adv_interval,
+		  sizeof(main_opts.default_params.le_max_adv_interval),
 		  0x0020,
 		  0x4000},
 		{ "LEMultiAdvertisementRotationInterval",
 		  &main_opts.default_params.le_multi_adv_rotation_interval,
+		  sizeof(main_opts.default_params.le_multi_adv_rotation_interval),
 		  0x0001,
 		  0xFFFF},
 		{ "LEScanIntervalAutoConnect",
 		  &main_opts.default_params.le_scan_interval_autoconnect,
+		  sizeof(main_opts.default_params.le_scan_interval_autoconnect),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowAutoConnect",
 		  &main_opts.default_params.le_scan_win_autoconnect,
+		  sizeof(main_opts.default_params.le_scan_win_autoconnect),
 		  0x0004,
 		  0x4000},
 		{ "LEScanIntervalSuspend",
 		  &main_opts.default_params.le_scan_interval_suspend,
+		  sizeof(main_opts.default_params.le_scan_interval_suspend),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowSuspend",
 		  &main_opts.default_params.le_scan_win_suspend,
+		  sizeof(main_opts.default_params.le_scan_win_suspend),
 		  0x0004,
 		  0x4000},
 		{ "LEScanIntervalDiscovery",
 		  &main_opts.default_params.le_scan_interval_discovery,
+		  sizeof(main_opts.default_params.le_scan_interval_discovery),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowDiscovery",
 		  &main_opts.default_params.le_scan_win_discovery,
+		  sizeof(main_opts.default_params.le_scan_win_discovery),
 		  0x0004,
 		  0x4000},
 		{ "LEScanIntervalAdvMonitor",
 		  &main_opts.default_params.le_scan_interval_adv_monitor,
+		  sizeof(main_opts.default_params.le_scan_interval_adv_monitor),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowAdvMonitor",
 		  &main_opts.default_params.le_scan_win_adv_monitor,
+		  sizeof(main_opts.default_params.le_scan_win_adv_monitor),
 		  0x0004,
 		  0x4000},
 		{ "LEScanIntervalConnect",
 		  &main_opts.default_params.le_scan_interval_connect,
+		  sizeof(main_opts.default_params.le_scan_interval_connect),
 		  0x0004,
 		  0x4000},
 		{ "LEScanWindowConnect",
 		  &main_opts.default_params.le_scan_win_connect,
+		  sizeof(main_opts.default_params.le_scan_win_connect),
 		  0x0004,
 		  0x4000},
 		{ "LEMinConnectionInterval",
 		  &main_opts.default_params.le_min_conn_interval,
+		  sizeof(main_opts.default_params.le_min_conn_interval),
 		  0x0006,
 		  0x0C80},
 		{ "LEMaxConnectionInterval",
 		  &main_opts.default_params.le_max_conn_interval,
+		  sizeof(main_opts.default_params.le_max_conn_interval),
 		  0x0006,
 		  0x0C80},
 		{ "LEConnectionLatency",
 		  &main_opts.default_params.le_conn_latency,
+		  sizeof(main_opts.default_params.le_conn_latency),
 		  0x0000,
 		  0x01F3},
 		{ "LEConnectionSupervisionTimeout",
 		  &main_opts.default_params.le_conn_lsto,
+		  sizeof(main_opts.default_params.le_conn_lsto),
 		  0x000A,
 		  0x0C80},
 		{ "LEAutoconnecttimeout",
 		  &main_opts.default_params.le_autoconnect_timeout,
+		  sizeof(main_opts.default_params.le_autoconnect_timeout),
 		  0x0001,
 		  0x4000},
 	};
@@ -439,7 +468,9 @@ static void parse_controller_config(GKeyFile *config)
 
 			val = MAX(val, params[i].min);
 			val = MIN(val, params[i].max);
-			*params[i].val = val;
+
+			val = htobl(val);
+			memcpy(params[i].val, &val, params[i].size);
 			++main_opts.default_params.num_entries;
 		}
 	}
-- 
2.29.0.rc2.309.g374f81d7ae-goog

