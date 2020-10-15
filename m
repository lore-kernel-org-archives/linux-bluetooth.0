Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E2C433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 04:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577DC22243
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 04:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlyB9oV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgJOECF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 00:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOECE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 00:02:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1EEC061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 21:02:04 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id n125so1220975qke.19
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 21:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=wb1FTgrzOHw65Rs8NNO7/pjUWx/BJckuxCmCuap60f8=;
        b=BlyB9oV0gQmbnYdvtH+yw5M6BcCgEewalxz6yETMUzKXwoTuoI2S5VE2V3eE42v4aa
         bCgEw5xaRW7qYylvAJILptgqFIlpYUPP8Dh1SfMNGlbm2Li5jP2VgIQttjEFX0pRfbwo
         Wg8zYp6YybPG2QK/+6kgMt7jhNbIQ2RYzFZ8+mZVRsR+5cQqrfpALWDJxbxvhJq64gEd
         OXmcQXFD/JCVK4fChCX64Vr9e8Aba9VdQoVfoxGbz0iU0CAxcOOCrtqvuIixgY6Fmh4R
         Fgg4pvZ00UEzYLpun2iT1cN+iRKksfzjBPF5hs4ckf40z27G6lus7JE0DJUcAJe7AMX3
         F21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=wb1FTgrzOHw65Rs8NNO7/pjUWx/BJckuxCmCuap60f8=;
        b=epdXjMH3g9o7Cj9C2BURAhzCiV3vQ/r8Zw4n47dhbRp52RJflTxiwDuCLeXTuKfVcR
         o4kx3cJgWxxlsJqcU36QXS7z4mwDLMg7oMOM2KArA+NTso47D+XKp5UDCv/3iXpqRgtb
         tc/CgwrfA99eQPGfettJlgXH8caTDdgi0iVvskKcM0V43Yr7FeAixIfIDBEJzJmHpH8X
         9D7fNHFf8W/JGnA2Iiib1FmYbK8oSE8PHdL2G3Ov3LrFK/wc5mYsPTxDxzc49OJMv+pf
         a9HD7BAysVCzdqV3hFsMXHGXyeEClBqfKuuhTT4My5EtqiUu0WJGfVLhOBE7xDmL5nsR
         6uzQ==
X-Gm-Message-State: AOAM5323lUUPX3k8oTIv3zi0WgRxgiAtE5tLeX5M2J033pevKoQPEyhA
        AKWl+B+SwoSRDJIEqO7Us5sNaOaJgKH+9qpl6SzIvGkTPlOjeKu/CwXAPsscZrdAyd++XRmGN8z
        vx6hNkV6qsaLzvZIEyMjiSYi0c1pyRgV5Oc4e60FW3aNegV42NFWp287KhqBBZP+K4CNVfsjKnG
        uo6K0lPtuFaYw=
X-Google-Smtp-Source: ABdhPJx5K551M+6/FBhDhkjdbiZ2nFNWODAGdPgqDmmP6k3MNmNv7QeUJDtokw3KCO/eSGejQwO6ot8tKn1GnRG1fA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:4353:: with SMTP id
 q19mr2482228qvs.43.1602734523425; Wed, 14 Oct 2020 21:02:03 -0700 (PDT)
Date:   Thu, 15 Oct 2020 12:01:59 +0800
Message-Id: <20201015120151.BlueZ.v2.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [BlueZ PATCH v2] core: Add support of variable length params in mgmt_config
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mmandlik@chromium.org, apusaka@chromium.org, alainm@chromium.org,
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

Changes in v2:
- fix multiple line dereference issue

 src/adapter.c | 268 +++++++++++++++++++-------------------------------
 src/hcid.h    |   1 +
 src/main.c    |  36 ++++++-
 3 files changed, 138 insertions(+), 167 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c0053000ac19..9c61e7bf204f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4163,269 +4163,207 @@ static void probe_devices(void *user_data)
 	device_probe_profiles(device, btd_device_get_uuids(device));
 }
 
+static uint8_t *set_mgmt_tlv(uint8_t *cur, uint16_t type, uint8_t length,
+								void *value)
+{
+	struct mgmt_tlv *entry = (struct mgmt_tlv *)cur;
+
+	entry->type = htobs(type);
+	entry->length = length;
+	memcpy(entry->value, value, length);
+	cur += sizeof(*entry) + length;
+	return cur;
+}
+
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
+	uint8_t *buf, *cur;
 	unsigned int err;
 
 	if (!main_opts.default_params.num_entries ||
 	    !btd_has_kernel_features(KERNEL_SET_SYSTEM_CONFIG))
 		return;
 
-	params = malloc0(sizeof(*params) *
-			main_opts.default_params.num_entries);
-
-	len = sizeof(params->entry) * main_opts.default_params.num_entries;
+	buf = malloc0(sizeof(struct mgmt_tlv) *
+			main_opts.default_params.num_entries +
+			main_opts.default_params.total_size);
+	cur = buf;
 
 	if (main_opts.default_params.br_page_scan_type != 0xFFFF) {
-		params[i].entry.type = 0x0000;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_scan_type;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0000,
+			sizeof(main_opts.default_params.br_page_scan_type),
+			&main_opts.default_params.br_page_scan_type);
 	}
 
 	if (main_opts.default_params.br_page_scan_interval) {
-		params[i].entry.type = 0x0001;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_scan_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0001,
+			sizeof(main_opts.default_params.br_page_scan_interval),
+			&main_opts.default_params.br_page_scan_interval);
 	}
 
 	if (main_opts.default_params.br_page_scan_win) {
-		params[i].entry.type = 0x0002;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_scan_win;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0002,
+			sizeof(main_opts.default_params.br_page_scan_win),
+			&main_opts.default_params.br_page_scan_win);
 	}
 
 	if (main_opts.default_params.br_scan_type != 0xFFFF) {
-		params[i].entry.type = 0x0003;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_scan_type;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0003,
+			sizeof(main_opts.default_params.br_scan_type),
+			&main_opts.default_params.br_scan_type);
 	}
 
 	if (main_opts.default_params.br_scan_interval) {
-		params[i].entry.type = 0x0004;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_scan_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0004,
+			sizeof(main_opts.default_params.br_scan_interval),
+			&main_opts.default_params.br_scan_interval);
 	}
 
 	if (main_opts.default_params.br_scan_win) {
-		params[i].entry.type = 0x0005;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_scan_win;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0005,
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
+		cur = set_mgmt_tlv(cur, 0x0006,
+			sizeof(main_opts.default_params.br_link_supervision_timeout),
+			&main_opts.default_params.br_link_supervision_timeout);
 	}
 
 	if (main_opts.default_params.br_page_timeout) {
-		params[i].entry.type = 0x0007;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_page_timeout;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0007,
+			sizeof(main_opts.default_params.br_page_timeout),
+			&main_opts.default_params.br_page_timeout);
 	}
 
 	if (main_opts.default_params.br_min_sniff_interval) {
-		params[i].entry.type = 0x0008;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_min_sniff_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0008,
+			sizeof(main_opts.default_params.br_min_sniff_interval),
+			&main_opts.default_params.br_min_sniff_interval);
 	}
 
 	if (main_opts.default_params.br_max_sniff_interval) {
-		params[i].entry.type = 0x0009;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.br_max_sniff_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0009,
+			sizeof(main_opts.default_params.br_max_sniff_interval),
+			&main_opts.default_params.br_max_sniff_interval);
 	}
 
 	if (main_opts.default_params.le_min_adv_interval) {
-		params[i].entry.type = 0x000a;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_min_adv_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x000a,
+			sizeof(main_opts.default_params.le_min_adv_interval),
+			&main_opts.default_params.le_min_adv_interval);
 	}
 
 	if (main_opts.default_params.le_max_adv_interval) {
-		params[i].entry.type = 0x000b;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_max_adv_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x000b,
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
+		cur = set_mgmt_tlv(cur, 0x000c,
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
+		cur = set_mgmt_tlv(cur, 0x000d,
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
+		cur = set_mgmt_tlv(cur, 0x000e,
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
+		cur = set_mgmt_tlv(cur, 0x000f,
+			sizeof(main_opts.default_params.le_scan_interval_suspend),
+			&main_opts.default_params.le_scan_interval_suspend);
 	}
 
 	if (main_opts.default_params.le_scan_win_suspend) {
-		params[i].entry.type = 0x0010;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_scan_win_suspend;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0010,
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
+		cur = set_mgmt_tlv(cur, 0x0011,
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
+		cur = set_mgmt_tlv(cur, 0x0012,
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
+		cur = set_mgmt_tlv(cur, 0x0013,
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
+		cur = set_mgmt_tlv(cur, 0x0014,
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
+		cur = set_mgmt_tlv(cur, 0x0015,
+			sizeof(main_opts.default_params.le_scan_interval_connect),
+			&main_opts.default_params.le_scan_interval_connect);
 	}
 
 	if (main_opts.default_params.le_scan_win_connect) {
-		params[i].entry.type = 0x0016;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_scan_win_connect;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0016,
+			sizeof(main_opts.default_params.le_scan_win_connect),
+			&main_opts.default_params.le_scan_win_connect);
 	}
 
 	if (main_opts.default_params.le_min_conn_interval) {
-		params[i].entry.type = 0x0017;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_min_conn_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0017,
+			sizeof(main_opts.default_params.le_min_conn_interval),
+			&main_opts.default_params.le_min_conn_interval);
 	}
 
 	if (main_opts.default_params.le_max_conn_interval) {
-		params[i].entry.type = 0x0018;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_max_conn_interval;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0018,
+			sizeof(main_opts.default_params.le_max_conn_interval),
+			&main_opts.default_params.le_max_conn_interval);
 	}
 
 	if (main_opts.default_params.le_conn_latency) {
-		params[i].entry.type = 0x0019;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_conn_latency;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x0019,
+			sizeof(main_opts.default_params.le_conn_latency),
+			&main_opts.default_params.le_conn_latency);
 	}
 
 	if (main_opts.default_params.le_conn_lsto) {
-		params[i].entry.type = 0x001a;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_conn_lsto;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x001a,
+			sizeof(main_opts.default_params.le_conn_lsto),
+			&main_opts.default_params.le_conn_lsto);
 	}
 
 	if (main_opts.default_params.le_autoconnect_timeout) {
-		params[i].entry.type = 0x001b;
-		params[i].entry.length = sizeof(params[i].u16);
-		params[i].u16 = main_opts.default_params.le_autoconnect_timeout;
-		++i;
-		len += sizeof(params[i].u16);
+		cur = set_mgmt_tlv(cur, 0x001b,
+			sizeof(main_opts.default_params.le_autoconnect_timeout),
+			&main_opts.default_params.le_autoconnect_timeout);
 	}
 
 	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
-			adapter->dev_id, len, params, NULL, NULL, NULL);
+			adapter->dev_id, cur-buf, buf, NULL, NULL, NULL);
 	if (!err)
 		btd_error(adapter->dev_id,
 				"Failed to set default system config for hci%u",
 				adapter->dev_id);
-
-	free(params);
+	free(buf);
 }
 
 static void load_devices(struct btd_adapter *adapter)
diff --git a/src/hcid.h b/src/hcid.h
index 95d4b9665193..adeb1f92333c 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -45,6 +45,7 @@ struct main_opts {
 
 	struct {
 		uint16_t	num_entries;
+		uint16_t	total_size;
 
 		uint16_t	br_page_scan_type;
 		uint16_t	br_page_scan_interval;
diff --git a/src/main.c b/src/main.c
index 77be776686a8..243470b6eb88 100644
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
@@ -439,7 +468,10 @@ static void parse_controller_config(GKeyFile *config)
 
 			val = MAX(val, params[i].min);
 			val = MIN(val, params[i].max);
-			*params[i].val = val;
+
+			val = htobl(val);
+			memcpy(params[i].val, &val, params[i].size);
+			main_opts.default_params.total_size += params[i].size;
 			++main_opts.default_params.num_entries;
 		}
 	}
-- 
2.29.0.rc1.297.gfa9743e501-goog

