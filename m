Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF1C388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF19B2473C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7WT7oOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgJ1V6z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgJ1V62 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:58:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0FBC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a200so568323pfa.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+DAx8hdp6JVLLyr6zOty6QSRP1prXgjj6JfklUszMvg=;
        b=U7WT7oOp/BMe1bHpjBsWjMk9d0WrWTAE3wrWLQXuRfqnkoH2d3/4atX88xRVV7x3J4
         8k2vfqx75KcLEpQZSnlduahU1yFaeHN9Uyuhc0cBCwjUgvepE7cVbVqyXDVzY+y8+rUf
         sIBLSbVJp/oUHf6GZ0gMjjQpzLTohin8NWc/oTNRTcbHUoq/4C3FKQP2nEUzLtN4wqLH
         sbU5FxWT7vktDKYZI2IbaEsYUqxt1DJECo1JJkQfaYuHXC/TZV5c/+0GCWCwjpeEHsa4
         R7wkFomA02MnFgsFwb1qBcZgmqcGQkAVpGkEqUIUv3BOjaSes+82qurN26YnLXK+JAr+
         ty6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DAx8hdp6JVLLyr6zOty6QSRP1prXgjj6JfklUszMvg=;
        b=rBlFFcLgO+9UPuzK9SIh8k5mDMtP8nhRk0T9pM8HXoXDxQCfEEtH+Uy4PRAPFTM1WP
         tmR4GC5wSVrsO9clvxrq/elU+5ppny7e/Lj39a+jMu8+QOyNLPhGIHEEA9j3tfmRGxDG
         gNQyNnskagt8Hw/vjULL4BOptHOc+54gXEGQEo9moh5YWP+U9+EVvbCFyyvmh4jshp7k
         8fYZMndFzH8NGHr1kLdXQ6BqtJCtsyRe3yaQjTArvB0RYge8gj0EwqhtVK1pVzOxfqvc
         UdkDxQB+CX//sSO/+AKKYZcQi1tEzmwcGVVvv8ShEcTAPs0Lif64ksgLWDOQsd4htPVT
         MJww==
X-Gm-Message-State: AOAM531NFjiA3pkTGo66A/MzwuRGB8K5O0qjOfmlbADqGlgJvDisrw7d
        sWOB7az0vo/6CLuly9wvSiyo6uJnLerSuQ==
X-Google-Smtp-Source: ABdhPJwGOQzwKv+Adtt0AuKcj5L2rjQTb/oxOjidlZcQCDU7c81WTgS5Y3/2kaXXbB2wa81ZfpMB+w==
X-Received: by 2002:a05:6a00:1:b029:164:1cb9:8afd with SMTP id h1-20020a056a000001b02901641cb98afdmr984602pfk.13.1603922307769;
        Wed, 28 Oct 2020 14:58:27 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m13sm355290pjl.45.2020.10.28.14.58.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:58:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] core: Split LE and BR/EDR parameters
Date:   Wed, 28 Oct 2020 14:58:22 -0700
Message-Id: <20201028215824.608794-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028215824.608794-1-luiz.dentz@gmail.com>
References: <20201028215824.608794-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This splits LE and BR/EDR config parameters and checks main_conf.mode
when parsing them.
---
 profiles/scanparam/scan.c |   8 +-
 src/adapter.c             | 392 ++++++++++++++++----------------------
 src/hcid.h                |  86 +++++----
 src/main.c                | 291 +++++++++++++++++-----------
 src/main.conf             |  78 ++++----
 5 files changed, 429 insertions(+), 426 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 004783bf7..258bd3f63 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -64,12 +64,12 @@ static void write_scan_params(struct scan *scan)
 	/* Unless scan parameters are configured, use the known kernel default
 	 * parameters
 	 */
-	put_le16(main_opts.default_params.le_scan_interval_autoconnect ?
-			main_opts.default_params.le_scan_interval_autoconnect :
+	put_le16(main_opts.defaults.le.scan_interval_autoconnect ?
+			main_opts.defaults.le.scan_interval_autoconnect :
 			0x60, &value[0]);
 
-	put_le16(main_opts.default_params.le_scan_win_autoconnect ?
-			main_opts.default_params.le_scan_win_autoconnect :
+	put_le16(main_opts.defaults.le.scan_win_autoconnect ?
+			main_opts.defaults.le.scan_win_autoconnect :
 			0x30, &value[2]);
 
 	bt_gatt_client_write_without_response(scan->client, scan->iwhandle,
diff --git a/src/adapter.c b/src/adapter.c
index c0053000a..c3ce85e48 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4165,267 +4165,193 @@ static void probe_devices(void *user_data)
 
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
 
-	if (!main_opts.default_params.num_entries ||
+	if (!main_opts.defaults.num_entries ||
 	    !btd_has_kernel_features(KERNEL_SET_SYSTEM_CONFIG))
 		return;
 
-	params = malloc0(sizeof(*params) *
-			main_opts.default_params.num_entries);
+	tlv_list = mgmt_tlv_list_new();
 
-	len = sizeof(params->entry) * main_opts.default_params.num_entries;
+	if (main_opts.defaults.br.page_scan_type != 0xFFFF) {
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0000,
+					&main_opts.defaults.br.page_scan_type))
+			goto done;
+	}
 
-	if (main_opts.default_params.br_page_scan_type != 0xFFFF) {
-		params[i].entry.type = 0x0000;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_scan_type;
-		++i;
-		len += sizeof(params[i].u16);
+	if (main_opts.defaults.br.page_scan_interval) {
+		if (!mgmt_tlv_add_fixed(tlv_list, 0x0001,
+				&main_opts.defaults.br.page_scan_interval))
+			goto done;
 	}
 
-	if (main_opts.default_params.br_page_scan_interval) {
-		params[i].entry.type = 0x0001;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_scan_interval;
-		++i;
-		len += sizeof(params[i].u16);
+	if (main_opts.defaults.br.page_scan_win) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0002,
+					&main_opts.defaults.br.page_scan_win))
+			goto done;
 	}
 
-	if (main_opts.default_params.br_page_scan_win) {
-		params[i].entry.type = 0x0002;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_scan_win;
-		++i;
-		len += sizeof(params[i].u16);
+	if (main_opts.defaults.br.scan_type != 0xFFFF) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0003,
+					&main_opts.defaults.br.scan_type))
+			goto done;
 	}
 
-	if (main_opts.default_params.br_scan_type != 0xFFFF) {
-		params[i].entry.type = 0x0003;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_scan_type;
-		++i;
-		len += sizeof(params[i].u16);
+	if (main_opts.defaults.br.scan_interval) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0004,
+					&main_opts.defaults.br.scan_interval))
+			goto done;
 	}
 
-	if (main_opts.default_params.br_scan_interval) {
-		params[i].entry.type = 0x0004;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_scan_interval;
-		++i;
-		len += sizeof(params[i].u16);
+	if (main_opts.defaults.br.scan_win) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0005,
+					&main_opts.defaults.br.scan_win))
+			goto done;
 	}
 
-	if (main_opts.default_params.br_scan_win) {
-		params[i].entry.type = 0x0005;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_scan_win;
-		++i;
-		len += sizeof(params[i].u16);
+	if (main_opts.defaults.br.link_supervision_timeout) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0006,
+			&main_opts.defaults.br.link_supervision_timeout))
+			goto done;
 	}
 
-	if (main_opts.default_params.br_link_supervision_timeout) {
-		params[i].entry.type = 0x0006;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.br_link_supervision_timeout;
-		++i;
-		len += sizeof(params[i].u16);
+	if (main_opts.defaults.br.page_timeout) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0007,
+					&main_opts.defaults.br.page_timeout))
+			goto done;
 	}
-
-	if (main_opts.default_params.br_page_timeout) {
-		params[i].entry.type = 0x0007;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_timeout;
-		++i;
-		len += sizeof(params[i].u16);
+
+	if (main_opts.defaults.br.min_sniff_interval) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0008,
+				&main_opts.defaults.br.min_sniff_interval))
+			goto done;
 	}
-
-	if (main_opts.default_params.br_min_sniff_interval) {
-		params[i].entry.type = 0x0008;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_min_sniff_interval;
-		++i;
-		len += sizeof(params[i].u16);
+
+	if (main_opts.defaults.br.max_sniff_interval) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0009,
+				&main_opts.defaults.br.max_sniff_interval))
+			goto done;
 	}
-
-	if (main_opts.default_params.br_max_sniff_interval) {
-		params[i].entry.type = 0x0009;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_max_sniff_interval;
-		++i;
-		len += sizeof(params[i].u16);
+
+	if (main_opts.defaults.le.min_adv_interval) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x000a,
+				&main_opts.defaults.le.min_adv_interval))
+			goto done;
 	}
-
-	if (main_opts.default_params.le_min_adv_interval) {
-		params[i].entry.type = 0x000a;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_min_adv_interval;
-		++i;
-		len += sizeof(params[i].u16);
+
+	if (main_opts.defaults.le.max_adv_interval) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x000b,
+				&main_opts.defaults.le.max_adv_interval))
+			goto done;
 	}
-
-	if (main_opts.default_params.le_max_adv_interval) {
-		params[i].entry.type = 0x000b;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_max_adv_interval;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_multi_adv_rotation_interval) {
-		params[i].entry.type = 0x000c;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_multi_adv_rotation_interval;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_interval_autoconnect) {
-		params[i].entry.type = 0x000d;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_autoconnect;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_win_autoconnect) {
-		params[i].entry.type = 0x000e;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_win_autoconnect;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_interval_suspend) {
-		params[i].entry.type = 0x000f;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_suspend;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_win_suspend) {
-		params[i].entry.type = 0x0010;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_scan_win_suspend;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_interval_discovery) {
-		params[i].entry.type = 0x0011;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_discovery;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_win_discovery) {
-		params[i].entry.type = 0x0012;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_win_discovery;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_interval_adv_monitor) {
-		params[i].entry.type = 0x0013;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_adv_monitor;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_win_adv_monitor) {
-		params[i].entry.type = 0x0014;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_win_adv_monitor;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_interval_connect) {
-		params[i].entry.type = 0x0015;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 =
-			main_opts.default_params.le_scan_interval_connect;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_scan_win_connect) {
-		params[i].entry.type = 0x0016;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_scan_win_connect;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_min_conn_interval) {
-		params[i].entry.type = 0x0017;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_min_conn_interval;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_max_conn_interval) {
-		params[i].entry.type = 0x0018;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_max_conn_interval;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_conn_latency) {
-		params[i].entry.type = 0x0019;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_conn_latency;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_conn_lsto) {
-		params[i].entry.type = 0x001a;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_conn_lsto;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	if (main_opts.default_params.le_autoconnect_timeout) {
-		params[i].entry.type = 0x001b;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_autoconnect_timeout;
-		++i;
-		len += sizeof(params[i].u16);
-	}
-
-	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
-			adapter->dev_id, len, params, NULL, NULL, NULL);
+
+	if (main_opts.defaults.le.adv_rotation_interval) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x000c,
+				&main_opts.defaults.le.adv_rotation_interval))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_interval_autoconnect) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x000d,
+			&main_opts.defaults.le.scan_interval_autoconnect))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_win_autoconnect) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x000e,
+				&main_opts.defaults.le.scan_win_autoconnect))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_interval_suspend) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x000f,
+				&main_opts.defaults.le.scan_interval_suspend))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_win_suspend) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0010,
+				&main_opts.defaults.le.scan_win_suspend))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_interval_discovery) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0011,
+				&main_opts.defaults.le.scan_interval_discovery))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_win_discovery) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0012,
+				&main_opts.defaults.le.scan_win_discovery))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_interval_adv_monitor) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0013,
+			&main_opts.defaults.le.scan_interval_adv_monitor))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_win_adv_monitor) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0014,
+				&main_opts.defaults.le.scan_win_adv_monitor))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_interval_connect) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0015,
+				&main_opts.defaults.le.scan_interval_connect))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.scan_win_connect) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0016,
+				&main_opts.defaults.le.scan_win_connect))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.min_conn_interval) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0017,
+				&main_opts.defaults.le.min_conn_interval))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.max_conn_interval) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0018,
+				&main_opts.defaults.le.max_conn_interval))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.conn_latency) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x0019,
+					&main_opts.defaults.le.conn_latency))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.conn_lsto) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x001a,
+					&main_opts.defaults.le.conn_lsto))
+			goto done;
+	}
+
+	if (main_opts.defaults.le.autoconnect_timeout) {
+		if (mgmt_tlv_add_fixed(tlv_list, 0x001b,
+				&main_opts.defaults.le.autoconnect_timeout))
+			goto done;
+	}
+
+	err = mgmt_send_tlv(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+			adapter->dev_id, tlv_list, NULL, NULL, NULL);
+
+done:
 	if (!err)
 		btd_error(adapter->dev_id,
 				"Failed to set default system config for hci%u",
 				adapter->dev_id);
 
-	free(params);
+	mgmt_tlv_list_free(tlv_list);
 }
 
 static void load_devices(struct btd_adapter *adapter)
diff --git a/src/hcid.h b/src/hcid.h
index 95d4b9665..a00f9e12c 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -34,6 +34,52 @@ enum mps_mode_t {
 	MPS_MULTIPLE,
 };
 
+struct btd_br_defaults {
+	uint16_t	page_scan_type;
+	uint16_t	page_scan_interval;
+	uint16_t	page_scan_win;
+
+	uint16_t	scan_type;
+	uint16_t	scan_interval;
+	uint16_t	scan_win;
+
+	uint16_t	link_supervision_timeout;
+	uint16_t	page_timeout;
+
+	uint16_t	min_sniff_interval;
+	uint16_t	max_sniff_interval;
+};
+
+struct btd_le_defaults {
+	uint16_t	min_adv_interval;
+	uint16_t	max_adv_interval;
+	uint16_t	adv_rotation_interval;
+
+	uint16_t	scan_interval_autoconnect;
+	uint16_t	scan_win_autoconnect;
+	uint16_t	scan_interval_suspend;
+	uint16_t	scan_win_suspend;
+	uint16_t	scan_interval_discovery;
+	uint16_t	scan_win_discovery;
+	uint16_t	scan_interval_adv_monitor;
+	uint16_t	scan_win_adv_monitor;
+	uint16_t	scan_interval_connect;
+	uint16_t	scan_win_connect;
+
+	uint16_t	min_conn_interval;
+	uint16_t	max_conn_interval;
+	uint16_t	conn_latency;
+	uint16_t	conn_lsto;
+	uint16_t	autoconnect_timeout;
+};
+
+struct btd_defaults {
+	uint16_t	num_entries;
+
+	struct btd_br_defaults br;
+	struct btd_le_defaults le;
+};
+
 struct main_opts {
 	char		*name;
 	uint32_t	class;
@@ -43,45 +89,7 @@ struct main_opts {
 	uint32_t	tmpto;
 	uint8_t		privacy;
 
-	struct {
-		uint16_t	num_entries;
-
-		uint16_t	br_page_scan_type;
-		uint16_t	br_page_scan_interval;
-		uint16_t	br_page_scan_win;
-
-		uint16_t	br_scan_type;
-		uint16_t	br_scan_interval;
-		uint16_t	br_scan_win;
-
-		uint16_t	br_link_supervision_timeout;
-		uint16_t	br_page_timeout;
-
-		uint16_t	br_min_sniff_interval;
-		uint16_t	br_max_sniff_interval;
-
-		uint16_t	le_min_adv_interval;
-		uint16_t	le_max_adv_interval;
-		uint16_t	le_multi_adv_rotation_interval;
-
-		uint16_t	le_scan_interval_autoconnect;
-		uint16_t	le_scan_win_autoconnect;
-		uint16_t	le_scan_interval_suspend;
-		uint16_t	le_scan_win_suspend;
-		uint16_t	le_scan_interval_discovery;
-		uint16_t	le_scan_win_discovery;
-		uint16_t	le_scan_interval_adv_monitor;
-		uint16_t	le_scan_win_adv_monitor;
-		uint16_t	le_scan_interval_connect;
-		uint16_t	le_scan_win_connect;
-
-		uint16_t	le_min_conn_interval;
-		uint16_t	le_max_conn_interval;
-		uint16_t	le_conn_latency;
-		uint16_t	le_conn_lsto;
-		uint16_t	le_autoconnect_timeout;
-	} default_params;
-
+	struct btd_defaults defaults;
 
 	gboolean	reverse_discovery;
 	gboolean	name_resolv;
diff --git a/src/main.c b/src/main.c
index 77be77668..6f73eb331 100644
--- a/src/main.c
+++ b/src/main.c
@@ -81,35 +81,39 @@ static const char *supported_options[] = {
 	NULL
 };
 
-static const char *controller_options[] = {
-	"BRPageScanType",
-	"BRPageScanInterval",
-	"BRPageScanWindow",
-	"BRInquiryScanType",
-	"BRInquiryScanInterval",
-	"BRInquiryScanWindow",
-	"BRLinkSupervisionTimeout",
-	"BRPageTimeout",
-	"BRMinSniffInterval",
-	"BRMaxSniffInterval",
-	"LEMinAdvertisementInterval",
-	"LEMaxAdvertisementInterval",
-	"LEMultiAdvertisementRotationInterval",
-	"LEScanIntervalAutoConnect",
-	"LEScanWindowAutoConnect",
-	"LEScanIntervalSuspend",
-	"LEScanWindowSuspend",
-	"LEScanIntervalDiscovery",
-	"LEScanWindowDiscovery",
-	"LEScanIntervalAdvMonitoring",
-	"LEScanWindowAdvMonitoring",
-	"LEScanIntervalConnect",
-	"LEScanWindowConnect",
-	"LEMinConnectionInterval",
-	"LEMaxConnectionInterval",
-	"LEConnectionLatency",
-	"LEConnectionSupervisionTimeout",
-	"LEAutoconnecttimeout",
+static const char *br_options[] = {
+	"PageScanType",
+	"PageScanInterval",
+	"PageScanWindow",
+	"InquiryScanType",
+	"InquiryScanInterval",
+	"InquiryScanWindow",
+	"LinkSupervisionTimeout",
+	"PageTimeout",
+	"MinSniffInterval",
+	"MaxSniffInterval",
+	NULL
+};
+
+static const char *le_options[] = {
+	"MinAdvertisementInterval",
+	"MaxAdvertisementInterval",
+	"MultiAdvertisementRotationInterval",
+	"ScanIntervalAutoConnect",
+	"ScanWindowAutoConnect",
+	"ScanIntervalSuspend",
+	"ScanWindowSuspend",
+	"ScanIntervalDiscovery",
+	"ScanWindowDiscovery",
+	"ScanIntervalAdvMonitoring",
+	"ScanWindowAdvMonitoring",
+	"ScanIntervalConnect",
+	"ScanWindowConnect",
+	"MinConnectionInterval",
+	"MaxConnectionInterval",
+	"ConnectionLatency",
+	"ConnectionSupervisionTimeout",
+	"Autoconnecttimeout",
 	NULL
 };
 
@@ -135,7 +139,8 @@ static const struct group_table {
 	const char **options;
 } valid_groups[] = {
 	{ "General",	supported_options },
-	{ "Controller", controller_options },
+	{ "BR",		br_options },
+	{ "LE",		le_options },
 	{ "Policy",	policy_options },
 	{ "GATT",	gatt_options },
 	{ }
@@ -301,148 +306,203 @@ static int get_mode(const char *str)
 	return BT_MODE_DUAL;
 }
 
-static void parse_controller_config(GKeyFile *config)
+struct config_param {
+	const char * const val_name;
+	void * const val;
+	const size_t size;
+	const uint16_t min;
+	const uint16_t max;
+};
+
+static void parse_mode_config(GKeyFile *config, const char *group,
+				const struct config_param *params,
+				size_t params_len)
 {
-	static const struct {
-		const char * const val_name;
-		uint16_t * const val;
-		const uint16_t min;
-		const uint16_t max;
-	} params[] = {
-		{ "BRPageScanType",
-		  &main_opts.default_params.br_page_scan_type,
+	uint16_t i;
+
+	if (!config)
+		return;
+
+	for (i = 0; i < params_len; ++i) {
+		GError *err = NULL;
+		int val = g_key_file_get_integer(config, group,
+						params[i].val_name, &err);
+		if (err) {
+			warn("%s", err->message);
+			g_clear_error(&err);
+		} else {
+			info("%s=%d", params[i].val_name, val);
+
+			val = MAX(val, params[i].min);
+			val = MIN(val, params[i].max);
+
+			val = htobl(val);
+			memcpy(params[i].val, &val, params[i].size);
+			++main_opts.defaults.num_entries;
+		}
+	}
+}
+
+static void parse_br_config(GKeyFile *config)
+{
+	static const struct config_param params[] = {
+		{ "PageScanType",
+		  &main_opts.defaults.br.page_scan_type,
+		  sizeof(main_opts.defaults.br.page_scan_type),
 		  0,
 		  1},
-		{ "BRPageScanInterval",
-		  &main_opts.default_params.br_page_scan_interval,
+		{ "PageScanInterval",
+		  &main_opts.defaults.br.page_scan_interval,
+		  sizeof(main_opts.defaults.br.page_scan_interval),
 		  0x0012,
 		  0x1000},
-		{ "BRPageScanWindow",
-		  &main_opts.default_params.br_page_scan_win,
+		{ "PageScanWindow",
+		  &main_opts.defaults.br.page_scan_win,
+		  sizeof(main_opts.defaults.br.page_scan_win),
 		  0x0011,
 		  0x1000},
-		{ "BRInquiryScanType",
-		  &main_opts.default_params.br_scan_type,
+		{ "InquiryScanType",
+		  &main_opts.defaults.br.scan_type,
+		  sizeof(main_opts.defaults.br.scan_type),
 		  0,
 		  1},
-		{ "BRInquiryScanInterval",
-		  &main_opts.default_params.br_scan_interval,
+		{ "InquiryScanInterval",
+		  &main_opts.defaults.br.scan_interval,
+		  sizeof(main_opts.defaults.br.scan_interval),
 		  0x0012,
 		  0x1000},
-		{ "BRInquiryScanWindow",
-		  &main_opts.default_params.br_scan_win,
+		{ "InquiryScanWindow",
+		  &main_opts.defaults.br.scan_win,
+		  sizeof(main_opts.defaults.br.scan_win),
 		  0x0011,
 		  0x1000},
-		{ "BRLinkSupervisionTimeout",
-		  &main_opts.default_params.br_link_supervision_timeout,
+		{ "LinkSupervisionTimeout",
+		  &main_opts.defaults.br.link_supervision_timeout,
+		  sizeof(main_opts.defaults.br.link_supervision_timeout),
 		  0x0001,
 		  0xFFFF},
-		{ "BRPageTimeout",
-		  &main_opts.default_params.br_page_timeout,
+		{ "PageTimeout",
+		  &main_opts.defaults.br.page_timeout,
+		  sizeof(main_opts.defaults.br.page_scan_win),
 		  0x0001,
 		  0xFFFF},
-		{ "BRMinSniffInterval",
-		  &main_opts.default_params.br_min_sniff_interval,
+		{ "MinSniffInterval",
+		  &main_opts.defaults.br.min_sniff_interval,
+		  sizeof(main_opts.defaults.br.min_sniff_interval),
 		  0x0001,
 		  0xFFFE},
-		{ "BRMaxSniffInterval",
-		  &main_opts.default_params.br_max_sniff_interval,
+		{ "MaxSniffInterval",
+		  &main_opts.defaults.br.max_sniff_interval,
+		  sizeof(main_opts.defaults.br.max_sniff_interval),
 		  0x0001,
 		  0xFFFE},
-		{ "LEMinAdvertisementInterval",
-		  &main_opts.default_params.le_min_adv_interval,
+	};
+
+	if (main_opts.mode == BT_MODE_LE)
+		return;
+
+	parse_mode_config(config, "BREDR", params, ARRAY_SIZE(params));
+}
+
+static void parse_le_config(GKeyFile *config)
+{
+	static const struct config_param params[] = {
+		{ "MinAdvertisementInterval",
+		  &main_opts.defaults.le.min_adv_interval,
+		  sizeof(main_opts.defaults.le.min_adv_interval),
 		  0x0020,
 		  0x4000},
-		{ "LEMaxAdvertisementInterval",
-		  &main_opts.default_params.le_max_adv_interval,
+		{ "MaxAdvertisementInterval",
+		  &main_opts.defaults.le.max_adv_interval,
+		  sizeof(main_opts.defaults.le.max_adv_interval),
 		  0x0020,
 		  0x4000},
-		{ "LEMultiAdvertisementRotationInterval",
-		  &main_opts.default_params.le_multi_adv_rotation_interval,
+		{ "MultiAdvertisementRotationInterval",
+		  &main_opts.defaults.le.adv_rotation_interval,
+		  sizeof(main_opts.defaults.le.adv_rotation_interval),
 		  0x0001,
 		  0xFFFF},
-		{ "LEScanIntervalAutoConnect",
-		  &main_opts.default_params.le_scan_interval_autoconnect,
+		{ "ScanIntervalAutoConnect",
+		  &main_opts.defaults.le.scan_interval_autoconnect,
+		  sizeof(main_opts.defaults.le.scan_interval_autoconnect),
 		  0x0004,
 		  0x4000},
-		{ "LEScanWindowAutoConnect",
-		  &main_opts.default_params.le_scan_win_autoconnect,
+		{ "ScanWindowAutoConnect",
+		  &main_opts.defaults.le.scan_win_autoconnect,
+		  sizeof(main_opts.defaults.le.scan_win_autoconnect),
 		  0x0004,
 		  0x4000},
-		{ "LEScanIntervalSuspend",
-		  &main_opts.default_params.le_scan_interval_suspend,
+		{ "ScanIntervalSuspend",
+		  &main_opts.defaults.le.scan_interval_suspend,
+		  sizeof(main_opts.defaults.le.scan_interval_suspend),
 		  0x0004,
 		  0x4000},
-		{ "LEScanWindowSuspend",
-		  &main_opts.default_params.le_scan_win_suspend,
+		{ "ScanWindowSuspend",
+		  &main_opts.defaults.le.scan_win_suspend,
+		  sizeof(main_opts.defaults.le.scan_win_suspend),
 		  0x0004,
 		  0x4000},
-		{ "LEScanIntervalDiscovery",
-		  &main_opts.default_params.le_scan_interval_discovery,
+		{ "ScanIntervalDiscovery",
+		  &main_opts.defaults.le.scan_interval_discovery,
+		  sizeof(main_opts.defaults.le.scan_interval_discovery),
 		  0x0004,
 		  0x4000},
-		{ "LEScanWindowDiscovery",
-		  &main_opts.default_params.le_scan_win_discovery,
+		{ "ScanWindowDiscovery",
+		  &main_opts.defaults.le.scan_win_discovery,
+		  sizeof(main_opts.defaults.le.scan_win_discovery),
 		  0x0004,
 		  0x4000},
-		{ "LEScanIntervalAdvMonitor",
-		  &main_opts.default_params.le_scan_interval_adv_monitor,
+		{ "ScanIntervalAdvMonitor",
+		  &main_opts.defaults.le.scan_interval_adv_monitor,
+		  sizeof(main_opts.defaults.le.scan_interval_adv_monitor),
 		  0x0004,
 		  0x4000},
-		{ "LEScanWindowAdvMonitor",
-		  &main_opts.default_params.le_scan_win_adv_monitor,
+		{ "ScanWindowAdvMonitor",
+		  &main_opts.defaults.le.scan_win_adv_monitor,
+		  sizeof(main_opts.defaults.le.scan_win_adv_monitor),
 		  0x0004,
 		  0x4000},
-		{ "LEScanIntervalConnect",
-		  &main_opts.default_params.le_scan_interval_connect,
+		{ "ScanIntervalConnect",
+		  &main_opts.defaults.le.scan_interval_connect,
+		  sizeof(main_opts.defaults.le.scan_interval_connect),
 		  0x0004,
 		  0x4000},
-		{ "LEScanWindowConnect",
-		  &main_opts.default_params.le_scan_win_connect,
+		{ "ScanWindowConnect",
+		  &main_opts.defaults.le.scan_win_connect,
+		  sizeof(main_opts.defaults.le.scan_win_connect),
 		  0x0004,
 		  0x4000},
-		{ "LEMinConnectionInterval",
-		  &main_opts.default_params.le_min_conn_interval,
+		{ "MinConnectionInterval",
+		  &main_opts.defaults.le.min_conn_interval,
+		  sizeof(main_opts.defaults.le.min_conn_interval),
 		  0x0006,
 		  0x0C80},
-		{ "LEMaxConnectionInterval",
-		  &main_opts.default_params.le_max_conn_interval,
+		{ "MaxConnectionInterval",
+		  &main_opts.defaults.le.max_conn_interval,
+		  sizeof(main_opts.defaults.le.max_conn_interval),
 		  0x0006,
 		  0x0C80},
-		{ "LEConnectionLatency",
-		  &main_opts.default_params.le_conn_latency,
+		{ "ConnectionLatency",
+		  &main_opts.defaults.le.conn_latency,
+		  sizeof(main_opts.defaults.le.conn_latency),
 		  0x0000,
 		  0x01F3},
-		{ "LEConnectionSupervisionTimeout",
-		  &main_opts.default_params.le_conn_lsto,
+		{ "ConnectionSupervisionTimeout",
+		  &main_opts.defaults.le.conn_lsto,
+		  sizeof(main_opts.defaults.le.conn_lsto),
 		  0x000A,
 		  0x0C80},
-		{ "LEAutoconnecttimeout",
-		  &main_opts.default_params.le_autoconnect_timeout,
+		{ "Autoconnecttimeout",
+		  &main_opts.defaults.le.autoconnect_timeout,
+		  sizeof(main_opts.defaults.le.autoconnect_timeout),
 		  0x0001,
 		  0x4000},
 	};
-	uint16_t i;
 
-	if (!config)
+	if (main_opts.mode == BT_MODE_BREDR)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(params); ++i) {
-		GError *err = NULL;
-		int val = g_key_file_get_integer(config, "Controller",
-						params[i].val_name, &err);
-		if (err) {
-			warn("%s", err->message);
-			g_clear_error(&err);
-		} else {
-			info("%s=%d", params[i].val_name, val);
-
-			val = MAX(val, params[i].min);
-			val = MIN(val, params[i].max);
-			*params[i].val = val;
-			++main_opts.default_params.num_entries;
-		}
-	}
+	parse_mode_config(config, "LE", params, ARRAY_SIZE(params));
 }
 
 static void parse_config(GKeyFile *config)
@@ -666,7 +726,8 @@ static void parse_config(GKeyFile *config)
 		main_opts.gatt_channels = val;
 	}
 
-	parse_controller_config(config);
+	parse_br_config(config);
+	parse_le_config(config);
 }
 
 static void init_defaults(void)
@@ -685,9 +746,9 @@ static void init_defaults(void)
 	main_opts.debug_keys = FALSE;
 	main_opts.refresh_discovery = TRUE;
 
-	main_opts.default_params.num_entries = 0;
-	main_opts.default_params.br_page_scan_type = 0xFFFF;
-	main_opts.default_params.br_scan_type = 0xFFFF;
+	main_opts.defaults.num_entries = 0;
+	main_opts.defaults.br.page_scan_type = 0xFFFF;
+	main_opts.defaults.br.scan_type = 0xFFFF;
 
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
diff --git a/src/main.conf b/src/main.conf
index 8d85702d4..1b3498212 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -86,71 +86,79 @@
 # profile is connected. Defaults to true.
 #RefreshDiscovery = true
 
-[Controller]
-# The following values are used to load default adapter parameters.  BlueZ loads
-# the values into the kernel before the adapter is powered if the kernel
-# supports the MGMT_LOAD_DEFAULT_PARAMETERS command. If a value isn't provided,
-# the kernel will be initialized to it's default value.  The actual value will
-# vary based on the kernel version and thus aren't provided here.
+[BREDR]
+# The following values are used to load default adapter parameters for BR/EDR.
+# BlueZ loads the values into the kernel before the adapter is powered if the
+# kernel supports the MGMT_LOAD_DEFAULT_PARAMETERS command. If a value isn't
+# provided, the kernel will be initialized to it's default value.  The actual
+# value will vary based on the kernel version and thus aren't provided here.
 # The Bluetooth Core Specification should be consulted for the meaning and valid
 # domain of each of these values.
 
 # BR/EDR Page scan activity configuration
-#BRPageScanType=
-#BRPageScanInterval=
-#BRPageScanWindow=
+#PageScanType=
+#PageScanInterval=
+#PageScanWindow=
 
 # BR/EDR Inquiry scan activity configuration
-#BRInquiryScanType=
-#BRInquiryScanInterval=
-#BRInquiryScanWindow=
+#InquiryScanType=
+#InquiryScanInterval=
+#InquiryScanWindow=
 
 # BR/EDR Link supervision timeout
-#BRLinkSupervisionTimeout=
+#LinkSupervisionTimeout=
 
 # BR/EDR Page Timeout
-#BRPageTimeout=
+#PageTimeout=
 
 # BR/EDR Sniff Intervals
-#BRMinSniffInterval=
-#BRMaxSniffInterval=
-
+#MinSniffInterval=
+#MaxSniffInterval=
+
+[LE]
+# The following values are used to load default adapter parameters for LE.
+# BlueZ loads the values into the kernel before the adapter is powered if the
+# kernel supports the MGMT_LOAD_DEFAULT_PARAMETERS command. If a value isn't
+# provided, the kernel will be initialized to it's default value.  The actual
+# value will vary based on the kernel version and thus aren't provided here.
+# The Bluetooth Core Specification should be consulted for the meaning and valid
+# domain of each of these values.
 # LE advertisement interval (used for legacy advertisement interface only)
-#LEMinAdvertisementInterval=
-#LEMaxAdvertisementInterval=
-#LEMultiAdvertisementRotationInterval=
+#MinAdvertisementInterval=
+#MaxAdvertisementInterval=
+#MultiAdvertisementRotationInterval=
 
 # LE scanning parameters used for passive scanning supporting auto connect
 # scenarios
-#LEScanIntervalAutoConnect=
-#LEScanWindowAutoConnect=
+#ScanIntervalAutoConnect=
+#ScanWindowAutoConnect=
 
 # LE scanning parameters used for passive scanning supporting wake from suspend
 # scenarios
-#LEScanIntervalSuspend=
-#LEScanWindowSuspend=
+#ScanIntervalSuspend=
+#ScanWindowSuspend=
 
 # LE scanning parameters used for active scanning supporting discovery
 # proceedure
-#LEScanIntervalDiscovery=
-#LEScanWindowDiscovery=
+#ScanIntervalDiscovery=
+#ScanWindowDiscovery=
 
 # LE scanning parameters used for passive scanning supporting the advertisement
 # monitor Apis
-#LEScanIntervalAdvMonitor=
-#LEScanWindowAdvMonitor=
+#ScanIntervalAdvMonitor=
+#ScanWindowAdvMonitor=
 
 # LE scanning parameters used for connection establishment.
-#LEScanIntervalConnect=
-#LEScanWindowConnect=
+#ScanIntervalConnect=
+#ScanWindowConnect=
 
 # LE default connection parameters.  These values are superceeded by any
 # specific values provided via the Load Connection Parameters interface
-#LEMinConnectionInterval=
-#LEMaxConnectionInterval=
-#LEConnectionLatency=
-#LEConnectionSupervisionTimeout=
-#LEAutoconnecttimeout=
+#MinConnectionInterval=
+#MaxConnectionInterval=
+#ConnectionLatency=
+#ConnectionSupervisionTimeout=
+#Autoconnecttimeout=
 
 [GATT]
 # GATT attribute cache.
-- 
2.26.2

