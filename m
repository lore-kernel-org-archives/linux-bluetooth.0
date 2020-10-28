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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70D2C4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E88C2473C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZN6ykKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgJ1V6c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbgJ1V6a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:58:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD3EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h6so634705pgk.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2/gg+buB1iptUI5skPm9PSf/ExD0aGft35oRSrbOFOM=;
        b=gZN6ykKnubsYTgC8VN/RHCejedCixStGuMHk6FZEJIbh2tAfOPAwTV+b/YGQBDqYRI
         rf7TFV+1eZ7qVjcOoncbtzWXWmIPeNMpKAnuDzEPp8AX7L6Oxmqg8tmq+yjggTsKsgtL
         +OjxdtlhnT1Se710CoFwUwf8cv0K2/4nrVmTAGd6EknpoClVuJCPBI8Lq/Q9QzkwW+JA
         NPdO/SavjlHkCcl4lHmQIdRMKTkYEl3FOJJ0UVEl+5A0f4szprj0aTzebAdDXpj19+n3
         2nnrOnvRuuCPztd5XGPYrdApWOfSYRjS2AaSFGr+Nt77V+2igq/9lmKF5jdDa/ZzShgm
         tojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/gg+buB1iptUI5skPm9PSf/ExD0aGft35oRSrbOFOM=;
        b=WTwtHWOjdRRBcSANsUCdtLufDN7Kkn0xd6k1+LIOBFogvXRL67tIVL2G8brsnpl4n5
         k9gg5BXouESmrUS0LYpxd1TvlfSTURukscEi2cxBP2740iWa0hdQgJmO87XxXwCsAFlm
         V8CvBIVmCz8B26xTvSqzgGbJqQP95fvbLj0PS1F7KSv9mDbV5CbkB31mMETTJh8lSHN5
         +CMMxSQHQEI+pBu+bVP8fNI4+na7bES8dZ9sN5fyp4lOwdATSfbv1UdC70LTUBPGQccY
         j+Hhpp2RaiApTISz7Rt+ee+3yW3AqCThIVUtvFZHVaKz4UI+l9THQ50GRb3sXPiPIXRO
         yrqg==
X-Gm-Message-State: AOAM530SwTRwafhMLPUWffkgfG6uzEf5IM3avlW+FKQ/vbjzTmhWAi7T
        sr3WcBtyXUHxFiSaueBRiN+Yik36IokssQ==
X-Google-Smtp-Source: ABdhPJzj1QWJ62ufU4Vi0vYdQ8+e8dahXtZ8ewseUiS+3IWjO5fXS3Pdj4f/u4kghCm2sVvkKTaf1g==
X-Received: by 2002:a62:7942:0:b029:162:bf9f:6457 with SMTP id u63-20020a6279420000b0290162bf9f6457mr931819pfc.59.1603922308808;
        Wed, 28 Oct 2020 14:58:28 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m13sm355290pjl.45.2020.10.28.14.58.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:58:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] core: Rename main_opts to btd_opts
Date:   Wed, 28 Oct 2020 14:58:23 -0700
Message-Id: <20201028215824.608794-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028215824.608794-1-luiz.dentz@gmail.com>
References: <20201028215824.608794-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use btd_ prefix since this is a daemon API.
---
 plugins/neard.c           |   6 +-
 profiles/audio/a2dp.c     |   2 +-
 profiles/audio/avdtp.c    |   2 +-
 profiles/scanparam/scan.c |   8 +-
 src/adapter.c             | 160 ++++++++++++-------------
 src/device.c              |  24 ++--
 src/gatt-client.c         |  10 +-
 src/gatt-database.c       |  18 +--
 src/hcid.h                |   4 +-
 src/main.c                | 240 +++++++++++++++++++-------------------
 10 files changed, 237 insertions(+), 237 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index ff5de11f4..091b39333 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -220,9 +220,9 @@ static DBusMessage *create_request_oob_reply(struct btd_adapter *adapter,
 	len = eir_create_oob(btd_adapter_get_address(adapter),
 				btd_adapter_get_name(adapter),
 				btd_adapter_get_class(adapter), hash,
-				randomizer, main_opts.did_vendor,
-				main_opts.did_product, main_opts.did_version,
-				main_opts.did_source,
+				randomizer, btd_opts.did_vendor,
+				btd_opts.did_product, btd_opts.did_version,
+				btd_opts.did_source,
 				btd_adapter_get_services(adapter), eir);
 
 	reply = dbus_message_new_method_return(msg);
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 4ec99278a..6e05db103 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2324,7 +2324,7 @@ static bool a2dp_server_listen(struct a2dp_server *server)
 	if (server->io)
 		return true;
 
-	if (main_opts.mps == MPS_OFF)
+	if (btd_opts.mps == MPS_OFF)
 		mode = BT_IO_MODE_BASIC;
 	else
 		mode = BT_IO_MODE_STREAMING;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 97b4d1b44..bcb0c71da 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2438,7 +2438,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 
 	src = btd_adapter_get_address(device_get_adapter(session->device));
 
-	if (main_opts.mps == MPS_OFF)
+	if (btd_opts.mps == MPS_OFF)
 		mode = BT_IO_MODE_BASIC;
 	else
 		mode = BT_IO_MODE_STREAMING;
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 258bd3f63..41350c988 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -64,12 +64,12 @@ static void write_scan_params(struct scan *scan)
 	/* Unless scan parameters are configured, use the known kernel default
 	 * parameters
 	 */
-	put_le16(main_opts.defaults.le.scan_interval_autoconnect ?
-			main_opts.defaults.le.scan_interval_autoconnect :
+	put_le16(btd_opts.defaults.le.scan_interval_autoconnect ?
+			btd_opts.defaults.le.scan_interval_autoconnect :
 			0x60, &value[0]);
 
-	put_le16(main_opts.defaults.le.scan_win_autoconnect ?
-			main_opts.defaults.le.scan_win_autoconnect :
+	put_le16(btd_opts.defaults.le.scan_win_autoconnect ?
+			btd_opts.defaults.le.scan_win_autoconnect :
 			0x30, &value[2]);
 
 	bt_gatt_client_write_without_response(scan->client, scan->iwhandle,
diff --git a/src/adapter.c b/src/adapter.c
index c3ce85e48..676cf97ce 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -474,7 +474,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
 
 	key_file = g_key_file_new();
 
-	if (adapter->pairable_timeout != main_opts.pairto)
+	if (adapter->pairable_timeout != btd_opts.pairto)
 		g_key_file_set_integer(key_file, "General", "PairableTimeout",
 					adapter->pairable_timeout);
 
@@ -487,7 +487,7 @@ static void store_adapter_info(struct btd_adapter *adapter)
 	g_key_file_set_boolean(key_file, "General", "Discoverable",
 							discoverable);
 
-	if (adapter->discoverable_timeout != main_opts.discovto)
+	if (adapter->discoverable_timeout != btd_opts.discovto)
 		g_key_file_set_integer(key_file, "General",
 					"DiscoverableTimeout",
 					adapter->discoverable_timeout);
@@ -4168,177 +4168,177 @@ static void load_default_system_params(struct btd_adapter *adapter)
 	struct mgmt_tlv_list *tlv_list;
 	unsigned int err = 0;
 
-	if (!main_opts.defaults.num_entries ||
+	if (!btd_opts.defaults.num_entries ||
 	    !btd_has_kernel_features(KERNEL_SET_SYSTEM_CONFIG))
 		return;
 
 	tlv_list = mgmt_tlv_list_new();
 
-	if (main_opts.defaults.br.page_scan_type != 0xFFFF) {
+	if (btd_opts.defaults.br.page_scan_type != 0xFFFF) {
 		if (!mgmt_tlv_add_fixed(tlv_list, 0x0000,
-					&main_opts.defaults.br.page_scan_type))
+					&btd_opts.defaults.br.page_scan_type))
 			goto done;
 	}
 
-	if (main_opts.defaults.br.page_scan_interval) {
+	if (btd_opts.defaults.br.page_scan_interval) {
 		if (!mgmt_tlv_add_fixed(tlv_list, 0x0001,
-				&main_opts.defaults.br.page_scan_interval))
+				&btd_opts.defaults.br.page_scan_interval))
 			goto done;
 	}
 
-	if (main_opts.defaults.br.page_scan_win) {
+	if (btd_opts.defaults.br.page_scan_win) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0002,
-					&main_opts.defaults.br.page_scan_win))
+					&btd_opts.defaults.br.page_scan_win))
 			goto done;
 	}
 
-	if (main_opts.defaults.br.scan_type != 0xFFFF) {
+	if (btd_opts.defaults.br.scan_type != 0xFFFF) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0003,
-					&main_opts.defaults.br.scan_type))
+					&btd_opts.defaults.br.scan_type))
 			goto done;
 	}
 
-	if (main_opts.defaults.br.scan_interval) {
+	if (btd_opts.defaults.br.scan_interval) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0004,
-					&main_opts.defaults.br.scan_interval))
+					&btd_opts.defaults.br.scan_interval))
 			goto done;
 	}
 
-	if (main_opts.defaults.br.scan_win) {
+	if (btd_opts.defaults.br.scan_win) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0005,
-					&main_opts.defaults.br.scan_win))
+					&btd_opts.defaults.br.scan_win))
 			goto done;
 	}
 
-	if (main_opts.defaults.br.link_supervision_timeout) {
+	if (btd_opts.defaults.br.link_supervision_timeout) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0006,
-			&main_opts.defaults.br.link_supervision_timeout))
+			&btd_opts.defaults.br.link_supervision_timeout))
 			goto done;
 	}
 
-	if (main_opts.defaults.br.page_timeout) {
+	if (btd_opts.defaults.br.page_timeout) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0007,
-					&main_opts.defaults.br.page_timeout))
+					&btd_opts.defaults.br.page_timeout))
 			goto done;
 	}
 
-	if (main_opts.defaults.br.min_sniff_interval) {
+	if (btd_opts.defaults.br.min_sniff_interval) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0008,
-				&main_opts.defaults.br.min_sniff_interval))
+				&btd_opts.defaults.br.min_sniff_interval))
 			goto done;
 	}
 
-	if (main_opts.defaults.br.max_sniff_interval) {
+	if (btd_opts.defaults.br.max_sniff_interval) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0009,
-				&main_opts.defaults.br.max_sniff_interval))
+				&btd_opts.defaults.br.max_sniff_interval))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.min_adv_interval) {
+	if (btd_opts.defaults.le.min_adv_interval) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x000a,
-				&main_opts.defaults.le.min_adv_interval))
+				&btd_opts.defaults.le.min_adv_interval))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.max_adv_interval) {
+	if (btd_opts.defaults.le.max_adv_interval) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x000b,
-				&main_opts.defaults.le.max_adv_interval))
+				&btd_opts.defaults.le.max_adv_interval))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.adv_rotation_interval) {
+	if (btd_opts.defaults.le.adv_rotation_interval) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x000c,
-				&main_opts.defaults.le.adv_rotation_interval))
+				&btd_opts.defaults.le.adv_rotation_interval))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_interval_autoconnect) {
+	if (btd_opts.defaults.le.scan_interval_autoconnect) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x000d,
-			&main_opts.defaults.le.scan_interval_autoconnect))
+			&btd_opts.defaults.le.scan_interval_autoconnect))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_win_autoconnect) {
+	if (btd_opts.defaults.le.scan_win_autoconnect) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x000e,
-				&main_opts.defaults.le.scan_win_autoconnect))
+				&btd_opts.defaults.le.scan_win_autoconnect))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_interval_suspend) {
+	if (btd_opts.defaults.le.scan_interval_suspend) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x000f,
-				&main_opts.defaults.le.scan_interval_suspend))
+				&btd_opts.defaults.le.scan_interval_suspend))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_win_suspend) {
+	if (btd_opts.defaults.le.scan_win_suspend) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0010,
-				&main_opts.defaults.le.scan_win_suspend))
+				&btd_opts.defaults.le.scan_win_suspend))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_interval_discovery) {
+	if (btd_opts.defaults.le.scan_interval_discovery) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0011,
-				&main_opts.defaults.le.scan_interval_discovery))
+				&btd_opts.defaults.le.scan_interval_discovery))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_win_discovery) {
+	if (btd_opts.defaults.le.scan_win_discovery) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0012,
-				&main_opts.defaults.le.scan_win_discovery))
+				&btd_opts.defaults.le.scan_win_discovery))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_interval_adv_monitor) {
+	if (btd_opts.defaults.le.scan_interval_adv_monitor) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0013,
-			&main_opts.defaults.le.scan_interval_adv_monitor))
+			&btd_opts.defaults.le.scan_interval_adv_monitor))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_win_adv_monitor) {
+	if (btd_opts.defaults.le.scan_win_adv_monitor) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0014,
-				&main_opts.defaults.le.scan_win_adv_monitor))
+				&btd_opts.defaults.le.scan_win_adv_monitor))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_interval_connect) {
+	if (btd_opts.defaults.le.scan_interval_connect) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0015,
-				&main_opts.defaults.le.scan_interval_connect))
+				&btd_opts.defaults.le.scan_interval_connect))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.scan_win_connect) {
+	if (btd_opts.defaults.le.scan_win_connect) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0016,
-				&main_opts.defaults.le.scan_win_connect))
+				&btd_opts.defaults.le.scan_win_connect))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.min_conn_interval) {
+	if (btd_opts.defaults.le.min_conn_interval) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0017,
-				&main_opts.defaults.le.min_conn_interval))
+				&btd_opts.defaults.le.min_conn_interval))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.max_conn_interval) {
+	if (btd_opts.defaults.le.max_conn_interval) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0018,
-				&main_opts.defaults.le.max_conn_interval))
+				&btd_opts.defaults.le.max_conn_interval))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.conn_latency) {
+	if (btd_opts.defaults.le.conn_latency) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x0019,
-					&main_opts.defaults.le.conn_latency))
+					&btd_opts.defaults.le.conn_latency))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.conn_lsto) {
+	if (btd_opts.defaults.le.conn_lsto) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x001a,
-					&main_opts.defaults.le.conn_lsto))
+					&btd_opts.defaults.le.conn_lsto))
 			goto done;
 	}
 
-	if (main_opts.defaults.le.autoconnect_timeout) {
+	if (btd_opts.defaults.le.autoconnect_timeout) {
 		if (mgmt_tlv_add_fixed(tlv_list, 0x001b,
-				&main_opts.defaults.le.autoconnect_timeout))
+				&btd_opts.defaults.le.autoconnect_timeout))
 			goto done;
 	}
 
@@ -4501,7 +4501,7 @@ free:
 
 	closedir(dir);
 
-	load_link_keys(adapter, keys, main_opts.debug_keys);
+	load_link_keys(adapter, keys, btd_opts.debug_keys);
 	g_slist_free_full(keys, g_free);
 
 	load_ltks(adapter, ltks);
@@ -6171,7 +6171,7 @@ static void load_config(struct btd_adapter *adapter)
 	adapter->pairable_timeout = g_key_file_get_integer(key_file, "General",
 						"PairableTimeout", &gerr);
 	if (gerr) {
-		adapter->pairable_timeout = main_opts.pairto;
+		adapter->pairable_timeout = btd_opts.pairto;
 		g_error_free(gerr);
 		gerr = NULL;
 	}
@@ -6189,7 +6189,7 @@ static void load_config(struct btd_adapter *adapter)
 	adapter->discoverable_timeout = g_key_file_get_integer(key_file,
 				"General", "DiscoverableTimeout", &gerr);
 	if (gerr) {
-		adapter->discoverable_timeout = main_opts.discovto;
+		adapter->discoverable_timeout = btd_opts.discovto;
 		g_error_free(gerr);
 		gerr = NULL;
 	}
@@ -6217,15 +6217,15 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 	 * configuration. This is to make sure that sane defaults are
 	 * always present.
 	 */
-	adapter->system_name = g_strdup(main_opts.name);
-	adapter->major_class = (main_opts.class & 0x001f00) >> 8;
-	adapter->minor_class = (main_opts.class & 0x0000fc) >> 2;
-	adapter->modalias = bt_modalias(main_opts.did_source,
-						main_opts.did_vendor,
-						main_opts.did_product,
-						main_opts.did_version);
-	adapter->discoverable_timeout = main_opts.discovto;
-	adapter->pairable_timeout = main_opts.pairto;
+	adapter->system_name = g_strdup(btd_opts.name);
+	adapter->major_class = (btd_opts.class & 0x001f00) >> 8;
+	adapter->minor_class = (btd_opts.class & 0x0000fc) >> 2;
+	adapter->modalias = bt_modalias(btd_opts.did_source,
+						btd_opts.did_vendor,
+						btd_opts.did_product,
+						btd_opts.did_version);
+	adapter->discoverable_timeout = btd_opts.discovto;
+	adapter->pairable_timeout = btd_opts.pairto;
 
 	DBG("System name: %s", adapter->system_name);
 	DBG("Major class: %u", adapter->major_class);
@@ -8279,7 +8279,7 @@ int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap)
 {
 	struct mgmt_cp_set_io_capability cp;
 
-	if (!main_opts.pairable) {
+	if (!btd_opts.pairable) {
 		if (io_cap == IO_CAPABILITY_INVALID) {
 			if (adapter->current_settings & MGMT_SETTING_BONDABLE)
 				set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x00);
@@ -8532,7 +8532,7 @@ static int adapter_register(struct btd_adapter *adapter)
 	 * non-LE controllers.
 	 */
 	if (!(adapter->supported_settings & MGMT_SETTING_LE) ||
-					main_opts.mode == BT_MODE_BREDR)
+					btd_opts.mode == BT_MODE_BREDR)
 		goto load;
 
 	adapter->database = btd_gatt_database_new(adapter);
@@ -8591,12 +8591,12 @@ load:
 
 	adapter->initialized = TRUE;
 
-	if (main_opts.did_source) {
+	if (btd_opts.did_source) {
 		/* DeviceID record is added by sdpd-server before any other
 		 * record is registered. */
 		adapter_service_insert(adapter, sdp_record_find(0x10000));
-		set_did(adapter, main_opts.did_vendor, main_opts.did_product,
-				main_opts.did_version, main_opts.did_source);
+		set_did(adapter, btd_opts.did_vendor, btd_opts.did_product,
+				btd_opts.did_version, btd_opts.did_source);
 	}
 
 	DBG("Adapter %s registered", adapter->path);
@@ -9191,7 +9191,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	missing_settings = adapter->current_settings ^
 						adapter->supported_settings;
 
-	switch (main_opts.mode) {
+	switch (btd_opts.mode) {
 	case BT_MODE_DUAL:
 		if (missing_settings & MGMT_SETTING_SSP)
 			set_mode(adapter, MGMT_OP_SET_SSP, 0x01);
@@ -9232,9 +9232,9 @@ static void read_info_complete(uint8_t status, uint16_t length,
 		set_mode(adapter, MGMT_OP_SET_SECURE_CONN, 0x01);
 
 	if (adapter->supported_settings & MGMT_SETTING_PRIVACY)
-		set_privacy(adapter, main_opts.privacy);
+		set_privacy(adapter, btd_opts.privacy);
 
-	if (main_opts.fast_conn &&
+	if (btd_opts.fast_conn &&
 			(missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
 		set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
 
@@ -9372,7 +9372,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 		goto failed;
 	}
 
-	if (main_opts.pairable &&
+	if (btd_opts.pairable &&
 			!(adapter->current_settings & MGMT_SETTING_BONDABLE))
 		set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
 
diff --git a/src/device.c b/src/device.c
index 2800b276a..de7f1c57d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -553,7 +553,7 @@ static void browse_request_free(struct browse_req *req)
 
 static bool gatt_cache_is_enabled(struct btd_device *device)
 {
-	switch (main_opts.gatt_cache) {
+	switch (btd_opts.gatt_cache) {
 	case BT_GATT_CACHE_YES:
 		return device_is_paired(device, device->bdaddr_type);
 	case BT_GATT_CACHE_NO:
@@ -4084,7 +4084,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	device->db_id = gatt_db_register(device->db, gatt_service_added,
 					gatt_service_removed, device, NULL);
 
-	device->refresh_discovery = main_opts.refresh_discovery;
+	device->refresh_discovery = btd_opts.refresh_discovery;
 
 	return btd_device_ref(device);
 }
@@ -4284,7 +4284,7 @@ void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
 	if (device->temporary_timer)
 		g_source_remove(device->temporary_timer);
 
-	device->temporary_timer = g_timeout_add_seconds(main_opts.tmpto,
+	device->temporary_timer = g_timeout_add_seconds(btd_opts.tmpto,
 							device_disappeared,
 							device);
 }
@@ -5169,7 +5169,7 @@ static void gatt_client_init(struct btd_device *device)
 {
 	gatt_client_cleanup(device);
 
-	if (!device->connect && !main_opts.reverse_discovery) {
+	if (!device->connect && !btd_opts.reverse_discovery) {
 		DBG("Reverse service discovery disabled: skipping GATT client");
 		return;
 	}
@@ -5222,7 +5222,7 @@ static void gatt_server_init(struct btd_device *device,
 	gatt_server_cleanup(device);
 
 	device->server = bt_gatt_server_new(db, device->att, device->att_mtu,
-						main_opts.key_size);
+						btd_opts.key_size);
 	if (!device->server) {
 		error("Failed to initialize bt_gatt_server");
 		return;
@@ -5285,7 +5285,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	}
 
 	if (dev->att) {
-		if (main_opts.gatt_channels == bt_att_get_channels(dev->att)) {
+		if (btd_opts.gatt_channels == bt_att_get_channels(dev->att)) {
 			DBG("EATT channel limit reached");
 			return false;
 		}
@@ -5313,7 +5313,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		}
 	}
 
-	dev->att_mtu = MIN(mtu, main_opts.gatt_mtu);
+	dev->att_mtu = MIN(mtu, btd_opts.gatt_mtu);
 	attrib = g_attrib_new(io,
 			cid == ATT_CID ? BT_ATT_DEFAULT_LE_MTU : dev->att_mtu,
 			false);
@@ -5690,7 +5690,7 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 			device->disable_auto_connect = TRUE;
 			device_set_auto_connect(device, FALSE);
 		}
-		device->temporary_timer = g_timeout_add_seconds(main_opts.tmpto,
+		device->temporary_timer = g_timeout_add_seconds(btd_opts.tmpto,
 							device_disappeared,
 							device);
 		return;
@@ -6091,7 +6091,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		bonding_request_free(bonding);
 	} else if (!state->svc_resolved) {
 		if (!device->browse && !device->discov_timer &&
-				main_opts.reverse_discovery) {
+				btd_opts.reverse_discovery) {
 			/* If we are not initiators and there is no currently
 			 * active discovery or discovery timer, set discovery
 			 * timer */
@@ -6135,7 +6135,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 
 	dev->svc_callbacks = g_slist_prepend(dev->svc_callbacks, cb);
 
-	if (state->svc_resolved || !main_opts.reverse_discovery)
+	if (state->svc_resolved || !btd_opts.reverse_discovery)
 		cb->idle_id = g_idle_add(svc_idle_cb, cb);
 	else if (dev->discov_timer > 0) {
 		g_source_remove(dev->discov_timer);
@@ -6415,12 +6415,12 @@ int device_confirm_passkey(struct btd_device *device, uint8_t type,
 
 	/* Just-Works repairing policy */
 	if (confirm_hint && device_is_paired(device, type)) {
-		if (main_opts.jw_repairing == JW_REPAIRING_NEVER) {
+		if (btd_opts.jw_repairing == JW_REPAIRING_NEVER) {
 			btd_adapter_confirm_reply(device->adapter,
 						  &device->bdaddr,
 						  type, FALSE);
 			return 0;
-		} else if (main_opts.jw_repairing == JW_REPAIRING_ALWAYS) {
+		} else if (btd_opts.jw_repairing == JW_REPAIRING_ALWAYS) {
 			btd_adapter_confirm_reply(device->adapter,
 						  &device->bdaddr,
 						  type, TRUE);
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 38b0b5170..7fbf0093b 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2174,13 +2174,13 @@ static void eatt_connect(struct btd_gatt_client *client)
 	char addr[18];
 	int i;
 
-	if (bt_att_get_channels(att) == main_opts.gatt_channels)
+	if (bt_att_get_channels(att) == btd_opts.gatt_channels)
 		return;
 
 	ba2str(device_get_address(dev), addr);
 
-	for (i = bt_att_get_channels(att); i < main_opts.gatt_channels; i++) {
-		int defer_timeout = i + 1 < main_opts.gatt_channels ? 1 : 0;
+	for (i = bt_att_get_channels(att); i < btd_opts.gatt_channels; i++) {
+		int defer_timeout = i + 1 < btd_opts.gatt_channels ? 1 : 0;
 
 		DBG("Connection attempt to: %s defer %s", addr,
 					defer_timeout ? "true" : "false");
@@ -2198,7 +2198,7 @@ static void eatt_connect(struct btd_gatt_client *client)
 					BT_IO_OPT_MODE, BT_IO_MODE_EXT_FLOWCTL,
 					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_MTU, btd_opts.gatt_mtu,
 					BT_IO_OPT_DEFER_TIMEOUT, defer_timeout,
 					BT_IO_OPT_INVALID);
 		if (!io) {
@@ -2216,7 +2216,7 @@ static void eatt_connect(struct btd_gatt_client *client)
 					device_get_le_address_type(dev),
 					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_MTU, btd_opts.gatt_mtu,
 					BT_IO_OPT_INVALID);
 			if (!io) {
 				error("EATT bt_io_connect(%s): %s", addr,
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 2b22add88..d8b7d261a 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1232,10 +1232,10 @@ static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
 {
 	uint8_t pdu[7];
 
-	pdu[0] = main_opts.did_source;
-	put_le16(main_opts.did_vendor, &pdu[1]);
-	put_le16(main_opts.did_product, &pdu[3]);
-	put_le16(main_opts.did_version, &pdu[5]);
+	pdu[0] = btd_opts.did_source;
+	put_le16(btd_opts.did_vendor, &pdu[1]);
+	put_le16(btd_opts.did_product, &pdu[3]);
+	put_le16(btd_opts.did_version, &pdu[5]);
 
 	gatt_db_attribute_read_result(attrib, id, 0, pdu, sizeof(pdu));
 }
@@ -1248,7 +1248,7 @@ static void populate_devinfo_service(struct btd_gatt_database *database)
 	bt_uuid16_create(&uuid, UUID_DIS);
 	service = gatt_db_add_service(database->db, &uuid, true, 3);
 
-	if (main_opts.did_source > 0) {
+	if (btd_opts.did_source > 0) {
 		bt_uuid16_create(&uuid, GATT_CHARAC_PNP_ID);
 		gatt_db_service_add_characteristic(service, &uuid,
 						BT_ATT_PERM_READ,
@@ -1267,7 +1267,7 @@ static void register_core_services(struct btd_gatt_database *database)
 	populate_gap_service(database);
 	populate_gatt_service(database);
 
-	if (main_opts.did_source > 0)
+	if (btd_opts.did_source > 0)
 		populate_devinfo_service(database);
 
 }
@@ -3639,7 +3639,7 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 	}
 
 	/* If just just 1 channel is enabled EATT is not required */
-	if (main_opts.gatt_channels == 1)
+	if (btd_opts.gatt_channels == 1)
 		goto bredr;
 
 	/* EATT socket */
@@ -3650,7 +3650,7 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 					btd_adapter_get_address_type(adapter),
 					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_MTU, btd_opts.gatt_mtu,
 					BT_IO_OPT_INVALID);
 	if (!database->eatt_io) {
 		g_error_free(gerr);
@@ -3663,7 +3663,7 @@ bredr:
 					BT_IO_OPT_SOURCE_BDADDR, addr,
 					BT_IO_OPT_PSM, BT_ATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_MTU, btd_opts.gatt_mtu,
 					BT_IO_OPT_INVALID);
 	if (database->bredr_io == NULL) {
 		error("Failed to start listening: %s", gerr->message);
diff --git a/src/hcid.h b/src/hcid.h
index a00f9e12c..4cd117538 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -80,7 +80,7 @@ struct btd_defaults {
 	struct btd_le_defaults le;
 };
 
-struct main_opts {
+struct btd_opts {
 	char		*name;
 	uint32_t	class;
 	gboolean	pairable;
@@ -113,7 +113,7 @@ struct main_opts {
 	enum jw_repairing_t jw_repairing;
 };
 
-extern struct main_opts main_opts;
+extern struct btd_opts btd_opts;
 
 gboolean plugin_init(const char *enable, const char *disable);
 void plugin_cleanup(void);
diff --git a/src/main.c b/src/main.c
index 6f73eb331..6e18d5ef1 100644
--- a/src/main.c
+++ b/src/main.c
@@ -58,7 +58,7 @@
 
 #define SHUTDOWN_GRACE_SECONDS 10
 
-struct main_opts main_opts;
+struct btd_opts btd_opts;
 static GKeyFile *main_conf;
 static char *main_conf_file_path;
 
@@ -198,10 +198,10 @@ static void parse_did(const char *did)
 		return;
 
 done:
-	main_opts.did_source = source;
-	main_opts.did_vendor = vendor;
-	main_opts.did_product = product;
-	main_opts.did_version = version;
+	btd_opts.did_source = source;
+	btd_opts.did_vendor = vendor;
+	btd_opts.did_product = product;
+	btd_opts.did_version = version;
 }
 
 static bt_gatt_cache_t parse_gatt_cache(const char *cache)
@@ -338,7 +338,7 @@ static void parse_mode_config(GKeyFile *config, const char *group,
 
 			val = htobl(val);
 			memcpy(params[i].val, &val, params[i].size);
-			++main_opts.defaults.num_entries;
+			++btd_opts.defaults.num_entries;
 		}
 	}
 }
@@ -347,58 +347,58 @@ static void parse_br_config(GKeyFile *config)
 {
 	static const struct config_param params[] = {
 		{ "PageScanType",
-		  &main_opts.defaults.br.page_scan_type,
-		  sizeof(main_opts.defaults.br.page_scan_type),
+		  &btd_opts.defaults.br.page_scan_type,
+		  sizeof(btd_opts.defaults.br.page_scan_type),
 		  0,
 		  1},
 		{ "PageScanInterval",
-		  &main_opts.defaults.br.page_scan_interval,
-		  sizeof(main_opts.defaults.br.page_scan_interval),
+		  &btd_opts.defaults.br.page_scan_interval,
+		  sizeof(btd_opts.defaults.br.page_scan_interval),
 		  0x0012,
 		  0x1000},
 		{ "PageScanWindow",
-		  &main_opts.defaults.br.page_scan_win,
-		  sizeof(main_opts.defaults.br.page_scan_win),
+		  &btd_opts.defaults.br.page_scan_win,
+		  sizeof(btd_opts.defaults.br.page_scan_win),
 		  0x0011,
 		  0x1000},
 		{ "InquiryScanType",
-		  &main_opts.defaults.br.scan_type,
-		  sizeof(main_opts.defaults.br.scan_type),
+		  &btd_opts.defaults.br.scan_type,
+		  sizeof(btd_opts.defaults.br.scan_type),
 		  0,
 		  1},
 		{ "InquiryScanInterval",
-		  &main_opts.defaults.br.scan_interval,
-		  sizeof(main_opts.defaults.br.scan_interval),
+		  &btd_opts.defaults.br.scan_interval,
+		  sizeof(btd_opts.defaults.br.scan_interval),
 		  0x0012,
 		  0x1000},
 		{ "InquiryScanWindow",
-		  &main_opts.defaults.br.scan_win,
-		  sizeof(main_opts.defaults.br.scan_win),
+		  &btd_opts.defaults.br.scan_win,
+		  sizeof(btd_opts.defaults.br.scan_win),
 		  0x0011,
 		  0x1000},
 		{ "LinkSupervisionTimeout",
-		  &main_opts.defaults.br.link_supervision_timeout,
-		  sizeof(main_opts.defaults.br.link_supervision_timeout),
+		  &btd_opts.defaults.br.link_supervision_timeout,
+		  sizeof(btd_opts.defaults.br.link_supervision_timeout),
 		  0x0001,
 		  0xFFFF},
 		{ "PageTimeout",
-		  &main_opts.defaults.br.page_timeout,
-		  sizeof(main_opts.defaults.br.page_scan_win),
+		  &btd_opts.defaults.br.page_timeout,
+		  sizeof(btd_opts.defaults.br.page_scan_win),
 		  0x0001,
 		  0xFFFF},
 		{ "MinSniffInterval",
-		  &main_opts.defaults.br.min_sniff_interval,
-		  sizeof(main_opts.defaults.br.min_sniff_interval),
+		  &btd_opts.defaults.br.min_sniff_interval,
+		  sizeof(btd_opts.defaults.br.min_sniff_interval),
 		  0x0001,
 		  0xFFFE},
 		{ "MaxSniffInterval",
-		  &main_opts.defaults.br.max_sniff_interval,
-		  sizeof(main_opts.defaults.br.max_sniff_interval),
+		  &btd_opts.defaults.br.max_sniff_interval,
+		  sizeof(btd_opts.defaults.br.max_sniff_interval),
 		  0x0001,
 		  0xFFFE},
 	};
 
-	if (main_opts.mode == BT_MODE_LE)
+	if (btd_opts.mode == BT_MODE_LE)
 		return;
 
 	parse_mode_config(config, "BREDR", params, ARRAY_SIZE(params));
@@ -408,98 +408,98 @@ static void parse_le_config(GKeyFile *config)
 {
 	static const struct config_param params[] = {
 		{ "MinAdvertisementInterval",
-		  &main_opts.defaults.le.min_adv_interval,
-		  sizeof(main_opts.defaults.le.min_adv_interval),
+		  &btd_opts.defaults.le.min_adv_interval,
+		  sizeof(btd_opts.defaults.le.min_adv_interval),
 		  0x0020,
 		  0x4000},
 		{ "MaxAdvertisementInterval",
-		  &main_opts.defaults.le.max_adv_interval,
-		  sizeof(main_opts.defaults.le.max_adv_interval),
+		  &btd_opts.defaults.le.max_adv_interval,
+		  sizeof(btd_opts.defaults.le.max_adv_interval),
 		  0x0020,
 		  0x4000},
 		{ "MultiAdvertisementRotationInterval",
-		  &main_opts.defaults.le.adv_rotation_interval,
-		  sizeof(main_opts.defaults.le.adv_rotation_interval),
+		  &btd_opts.defaults.le.adv_rotation_interval,
+		  sizeof(btd_opts.defaults.le.adv_rotation_interval),
 		  0x0001,
 		  0xFFFF},
 		{ "ScanIntervalAutoConnect",
-		  &main_opts.defaults.le.scan_interval_autoconnect,
-		  sizeof(main_opts.defaults.le.scan_interval_autoconnect),
+		  &btd_opts.defaults.le.scan_interval_autoconnect,
+		  sizeof(btd_opts.defaults.le.scan_interval_autoconnect),
 		  0x0004,
 		  0x4000},
 		{ "ScanWindowAutoConnect",
-		  &main_opts.defaults.le.scan_win_autoconnect,
-		  sizeof(main_opts.defaults.le.scan_win_autoconnect),
+		  &btd_opts.defaults.le.scan_win_autoconnect,
+		  sizeof(btd_opts.defaults.le.scan_win_autoconnect),
 		  0x0004,
 		  0x4000},
 		{ "ScanIntervalSuspend",
-		  &main_opts.defaults.le.scan_interval_suspend,
-		  sizeof(main_opts.defaults.le.scan_interval_suspend),
+		  &btd_opts.defaults.le.scan_interval_suspend,
+		  sizeof(btd_opts.defaults.le.scan_interval_suspend),
 		  0x0004,
 		  0x4000},
 		{ "ScanWindowSuspend",
-		  &main_opts.defaults.le.scan_win_suspend,
-		  sizeof(main_opts.defaults.le.scan_win_suspend),
+		  &btd_opts.defaults.le.scan_win_suspend,
+		  sizeof(btd_opts.defaults.le.scan_win_suspend),
 		  0x0004,
 		  0x4000},
 		{ "ScanIntervalDiscovery",
-		  &main_opts.defaults.le.scan_interval_discovery,
-		  sizeof(main_opts.defaults.le.scan_interval_discovery),
+		  &btd_opts.defaults.le.scan_interval_discovery,
+		  sizeof(btd_opts.defaults.le.scan_interval_discovery),
 		  0x0004,
 		  0x4000},
 		{ "ScanWindowDiscovery",
-		  &main_opts.defaults.le.scan_win_discovery,
-		  sizeof(main_opts.defaults.le.scan_win_discovery),
+		  &btd_opts.defaults.le.scan_win_discovery,
+		  sizeof(btd_opts.defaults.le.scan_win_discovery),
 		  0x0004,
 		  0x4000},
 		{ "ScanIntervalAdvMonitor",
-		  &main_opts.defaults.le.scan_interval_adv_monitor,
-		  sizeof(main_opts.defaults.le.scan_interval_adv_monitor),
+		  &btd_opts.defaults.le.scan_interval_adv_monitor,
+		  sizeof(btd_opts.defaults.le.scan_interval_adv_monitor),
 		  0x0004,
 		  0x4000},
 		{ "ScanWindowAdvMonitor",
-		  &main_opts.defaults.le.scan_win_adv_monitor,
-		  sizeof(main_opts.defaults.le.scan_win_adv_monitor),
+		  &btd_opts.defaults.le.scan_win_adv_monitor,
+		  sizeof(btd_opts.defaults.le.scan_win_adv_monitor),
 		  0x0004,
 		  0x4000},
 		{ "ScanIntervalConnect",
-		  &main_opts.defaults.le.scan_interval_connect,
-		  sizeof(main_opts.defaults.le.scan_interval_connect),
+		  &btd_opts.defaults.le.scan_interval_connect,
+		  sizeof(btd_opts.defaults.le.scan_interval_connect),
 		  0x0004,
 		  0x4000},
 		{ "ScanWindowConnect",
-		  &main_opts.defaults.le.scan_win_connect,
-		  sizeof(main_opts.defaults.le.scan_win_connect),
+		  &btd_opts.defaults.le.scan_win_connect,
+		  sizeof(btd_opts.defaults.le.scan_win_connect),
 		  0x0004,
 		  0x4000},
 		{ "MinConnectionInterval",
-		  &main_opts.defaults.le.min_conn_interval,
-		  sizeof(main_opts.defaults.le.min_conn_interval),
+		  &btd_opts.defaults.le.min_conn_interval,
+		  sizeof(btd_opts.defaults.le.min_conn_interval),
 		  0x0006,
 		  0x0C80},
 		{ "MaxConnectionInterval",
-		  &main_opts.defaults.le.max_conn_interval,
-		  sizeof(main_opts.defaults.le.max_conn_interval),
+		  &btd_opts.defaults.le.max_conn_interval,
+		  sizeof(btd_opts.defaults.le.max_conn_interval),
 		  0x0006,
 		  0x0C80},
 		{ "ConnectionLatency",
-		  &main_opts.defaults.le.conn_latency,
-		  sizeof(main_opts.defaults.le.conn_latency),
+		  &btd_opts.defaults.le.conn_latency,
+		  sizeof(btd_opts.defaults.le.conn_latency),
 		  0x0000,
 		  0x01F3},
 		{ "ConnectionSupervisionTimeout",
-		  &main_opts.defaults.le.conn_lsto,
-		  sizeof(main_opts.defaults.le.conn_lsto),
+		  &btd_opts.defaults.le.conn_lsto,
+		  sizeof(btd_opts.defaults.le.conn_lsto),
 		  0x000A,
 		  0x0C80},
 		{ "Autoconnecttimeout",
-		  &main_opts.defaults.le.autoconnect_timeout,
-		  sizeof(main_opts.defaults.le.autoconnect_timeout),
+		  &btd_opts.defaults.le.autoconnect_timeout,
+		  sizeof(btd_opts.defaults.le.autoconnect_timeout),
 		  0x0001,
 		  0x4000},
 	};
 
-	if (main_opts.mode == BT_MODE_BREDR)
+	if (btd_opts.mode == BT_MODE_BREDR)
 		return;
 
 	parse_mode_config(config, "LE", params, ARRAY_SIZE(params));
@@ -526,7 +526,7 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		DBG("discovto=%d", val);
-		main_opts.discovto = val;
+		btd_opts.discovto = val;
 	}
 
 	boolean = g_key_file_get_boolean(config, "General",
@@ -536,7 +536,7 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		DBG("pairable=%s", boolean ? "true" : "false");
-		main_opts.pairable = boolean;
+		btd_opts.pairable = boolean;
 	}
 
 	val = g_key_file_get_integer(config, "General",
@@ -546,24 +546,24 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		DBG("pairto=%d", val);
-		main_opts.pairto = val;
+		btd_opts.pairto = val;
 	}
 
 	str = g_key_file_get_string(config, "General", "Privacy", &err);
 	if (err) {
 		DBG("%s", err->message);
 		g_clear_error(&err);
-		main_opts.privacy = 0x00;
+		btd_opts.privacy = 0x00;
 	} else {
 		DBG("privacy=%s", str);
 
 		if (!strcmp(str, "device"))
-			main_opts.privacy = 0x01;
+			btd_opts.privacy = 0x01;
 		else if (!strcmp(str, "off"))
-			main_opts.privacy = 0x00;
+			btd_opts.privacy = 0x00;
 		else {
 			DBG("Invalid privacy option: %s", str);
-			main_opts.privacy = 0x00;
+			btd_opts.privacy = 0x00;
 		}
 
 		g_free(str);
@@ -574,10 +574,10 @@ static void parse_config(GKeyFile *config)
 	if (err) {
 		DBG("%s", err->message);
 		g_clear_error(&err);
-		main_opts.jw_repairing = JW_REPAIRING_NEVER;
+		btd_opts.jw_repairing = JW_REPAIRING_NEVER;
 	} else {
 		DBG("just_works_repairing=%s", str);
-		main_opts.jw_repairing = parse_jw_repairing(str);
+		btd_opts.jw_repairing = parse_jw_repairing(str);
 		g_free(str);
 	}
 
@@ -588,7 +588,7 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		DBG("tmpto=%d", val);
-		main_opts.tmpto = val;
+		btd_opts.tmpto = val;
 	}
 
 	str = g_key_file_get_string(config, "General", "Name", &err);
@@ -597,8 +597,8 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		DBG("name=%s", str);
-		g_free(main_opts.name);
-		main_opts.name = str;
+		g_free(btd_opts.name);
+		btd_opts.name = str;
 	}
 
 	str = g_key_file_get_string(config, "General", "Class", &err);
@@ -607,7 +607,7 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		DBG("class=%s", str);
-		main_opts.class = strtol(str, NULL, 16);
+		btd_opts.class = strtol(str, NULL, 16);
 		g_free(str);
 	}
 
@@ -627,28 +627,28 @@ static void parse_config(GKeyFile *config)
 		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else
-		main_opts.reverse_discovery = boolean;
+		btd_opts.reverse_discovery = boolean;
 
 	boolean = g_key_file_get_boolean(config, "General",
 						"NameResolving", &err);
 	if (err)
 		g_clear_error(&err);
 	else
-		main_opts.name_resolv = boolean;
+		btd_opts.name_resolv = boolean;
 
 	boolean = g_key_file_get_boolean(config, "General",
 						"DebugKeys", &err);
 	if (err)
 		g_clear_error(&err);
 	else
-		main_opts.debug_keys = boolean;
+		btd_opts.debug_keys = boolean;
 
 	str = g_key_file_get_string(config, "General", "ControllerMode", &err);
 	if (err) {
 		g_clear_error(&err);
 	} else {
 		DBG("ControllerMode=%s", str);
-		main_opts.mode = get_mode(str);
+		btd_opts.mode = get_mode(str);
 		g_free(str);
 	}
 
@@ -659,11 +659,11 @@ static void parse_config(GKeyFile *config)
 		DBG("MultiProfile=%s", str);
 
 		if (!strcmp(str, "single"))
-			main_opts.mps = MPS_SINGLE;
+			btd_opts.mps = MPS_SINGLE;
 		else if (!strcmp(str, "multiple"))
-			main_opts.mps = MPS_MULTIPLE;
+			btd_opts.mps = MPS_MULTIPLE;
 		else
-			main_opts.mps = MPS_OFF;
+			btd_opts.mps = MPS_OFF;
 
 		g_free(str);
 	}
@@ -673,21 +673,21 @@ static void parse_config(GKeyFile *config)
 	if (err)
 		g_clear_error(&err);
 	else
-		main_opts.fast_conn = boolean;
+		btd_opts.fast_conn = boolean;
 
 	boolean = g_key_file_get_boolean(config, "General",
 						"RefreshDiscovery", &err);
 	if (err)
 		g_clear_error(&err);
 	else
-		main_opts.refresh_discovery = boolean;
+		btd_opts.refresh_discovery = boolean;
 
 	str = g_key_file_get_string(config, "GATT", "Cache", &err);
 	if (err) {
 		DBG("%s", err->message);
 		g_clear_error(&err);
 	} else {
-		main_opts.gatt_cache = parse_gatt_cache(str);
+		btd_opts.gatt_cache = parse_gatt_cache(str);
 		g_free(str);
 	}
 
@@ -699,7 +699,7 @@ static void parse_config(GKeyFile *config)
 		DBG("KeySize=%d", val);
 
 		if (val >=7 && val <= 16)
-			main_opts.key_size = val;
+			btd_opts.key_size = val;
 	}
 
 	val = g_key_file_get_integer(config, "GATT", "ExchangeMTU", &err);
@@ -711,7 +711,7 @@ static void parse_config(GKeyFile *config)
 		val = MIN(val, BT_ATT_MAX_LE_MTU);
 		val = MAX(val, BT_ATT_DEFAULT_LE_MTU);
 		DBG("ExchangeMTU=%d", val);
-		main_opts.gatt_mtu = val;
+		btd_opts.gatt_mtu = val;
 	}
 
 	val = g_key_file_get_integer(config, "GATT", "Channels", &err);
@@ -723,7 +723,7 @@ static void parse_config(GKeyFile *config)
 		/* Ensure the channels is within a valid range. */
 		val = MIN(val, 5);
 		val = MAX(val, 1);
-		main_opts.gatt_channels = val;
+		btd_opts.gatt_channels = val;
 	}
 
 	parse_br_config(config);
@@ -735,32 +735,32 @@ static void init_defaults(void)
 	uint8_t major, minor;
 
 	/* Default HCId settings */
-	memset(&main_opts, 0, sizeof(main_opts));
-	main_opts.name = g_strdup_printf("BlueZ %s", VERSION);
-	main_opts.class = 0x000000;
-	main_opts.pairto = DEFAULT_PAIRABLE_TIMEOUT;
-	main_opts.discovto = DEFAULT_DISCOVERABLE_TIMEOUT;
-	main_opts.tmpto = DEFAULT_TEMPORARY_TIMEOUT;
-	main_opts.reverse_discovery = TRUE;
-	main_opts.name_resolv = TRUE;
-	main_opts.debug_keys = FALSE;
-	main_opts.refresh_discovery = TRUE;
-
-	main_opts.defaults.num_entries = 0;
-	main_opts.defaults.br.page_scan_type = 0xFFFF;
-	main_opts.defaults.br.scan_type = 0xFFFF;
+	memset(&btd_opts, 0, sizeof(btd_opts));
+	btd_opts.name = g_strdup_printf("BlueZ %s", VERSION);
+	btd_opts.class = 0x000000;
+	btd_opts.pairto = DEFAULT_PAIRABLE_TIMEOUT;
+	btd_opts.discovto = DEFAULT_DISCOVERABLE_TIMEOUT;
+	btd_opts.tmpto = DEFAULT_TEMPORARY_TIMEOUT;
+	btd_opts.reverse_discovery = TRUE;
+	btd_opts.name_resolv = TRUE;
+	btd_opts.debug_keys = FALSE;
+	btd_opts.refresh_discovery = TRUE;
+
+	btd_opts.defaults.num_entries = 0;
+	btd_opts.defaults.br.page_scan_type = 0xFFFF;
+	btd_opts.defaults.br.scan_type = 0xFFFF;
 
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
 
-	main_opts.did_source = 0x0002;		/* USB */
-	main_opts.did_vendor = 0x1d6b;		/* Linux Foundation */
-	main_opts.did_product = 0x0246;		/* BlueZ */
-	main_opts.did_version = (major << 8 | minor);
+	btd_opts.did_source = 0x0002;		/* USB */
+	btd_opts.did_vendor = 0x1d6b;		/* Linux Foundation */
+	btd_opts.did_product = 0x0246;		/* BlueZ */
+	btd_opts.did_version = (major << 8 | minor);
 
-	main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
-	main_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
-	main_opts.gatt_channels = 3;
+	btd_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
+	btd_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
+	btd_opts.gatt_channels = 3;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
@@ -985,21 +985,21 @@ int main(int argc, char *argv[])
 	btd_agent_init();
 	btd_profile_init();
 
-	if (main_opts.mode != BT_MODE_LE) {
+	if (btd_opts.mode != BT_MODE_LE) {
 		if (option_compat == TRUE)
 			sdp_flags |= SDP_SERVER_COMPAT;
 
 		start_sdp_server(sdp_mtu, sdp_flags);
 
-		if (main_opts.did_source > 0)
-			register_device_id(main_opts.did_source,
-						main_opts.did_vendor,
-						main_opts.did_product,
-						main_opts.did_version);
+		if (btd_opts.did_source > 0)
+			register_device_id(btd_opts.did_source,
+						btd_opts.did_vendor,
+						btd_opts.did_product,
+						btd_opts.did_version);
 	}
 
-	if (main_opts.mps != MPS_OFF)
-		register_mps(main_opts.mps == MPS_MULTIPLE);
+	if (btd_opts.mps != MPS_OFF)
+		register_mps(btd_opts.mps == MPS_MULTIPLE);
 
 	/* Loading plugins has to be done after D-Bus has been setup since
 	 * the plugins might wanna expose some paths on the bus. However the
@@ -1031,7 +1031,7 @@ int main(int argc, char *argv[])
 
 	rfkill_exit();
 
-	if (main_opts.mode != BT_MODE_LE)
+	if (btd_opts.mode != BT_MODE_LE)
 		stop_sdp_server();
 
 	if (main_conf)
-- 
2.26.2

