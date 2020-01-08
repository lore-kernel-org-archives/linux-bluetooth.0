Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD5DC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282852077B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="CmPUv51e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgAHLr6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:47:58 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:35618 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHLr6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 06:47:58 -0500
Received: by mail-lj1-f173.google.com with SMTP id j1so3021610lja.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OesDWmOQJ38npHVfEaQjvlnmqE7rx0r4/u93ts61DkQ=;
        b=CmPUv51en9VMacNdSvl39d3ALrc9Zm8QCXPSFWB0U13OjHEiF8CVBRv7JrvY/DtrkG
         /HEE3fIxR+zO5YuKHbTG8c285uABFYelxvCtnqMErgWypagYY4xarqH5akOZaHDj5Qbp
         23tWGklUFpvDZJYNLloiIlpG3QI+4WPo1i8jxoXdAEEuOLUA4cD/1t4eR8kQHZkpIsdu
         CjobtGovUo+e05IXMj94gbE7O4Rn07jXQJoD1Ow6lowQtP0ggRyeTMPiELOTIvwTn1fc
         p1w7v178acIMadSe9+gJNlwKLKcg4NFTyym7bWmpETI9hKwqlXM9n34aI88J/JGlyFYf
         AY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OesDWmOQJ38npHVfEaQjvlnmqE7rx0r4/u93ts61DkQ=;
        b=mXAPm5Lf+EkSZ3wgX+3uFaKHwyOMeErjXFaYtcURnfaLqHlRayMsCPtr3ncXK4JhDI
         +Zsvo07TfOVi/QG9zpTGxEEzXpsq83AYPAL3+H1gKTIEOiCHplXIi0aJXy87cXCZ2saL
         bmWcUITASVqLchhJhRa+8Q4VfpBp/SGKLexsg618QnGIjaw59ks5cQHpWTcOLIU3WXEN
         GdSWtWYlmIp/5ITPWb0xWOsN4Re+Ca0IXS95025GrDg9bYhjljOpTgvpV+DJpMWyBCEQ
         ULRs18OWheBNcqx1StsxdQ0ociuXgnzdVfnD9K/10eOIyN3PqTC+ci2OfBjDPjbhQ+14
         0CyA==
X-Gm-Message-State: APjAAAXLpWFcVBG3HSeNvxUw1h6zDQ9SWDSh0HBiT7t6PEPdmwt1LmpU
        tJ4aNkxNz7oY+7I/wH2OF119ygNyj2Q=
X-Google-Smtp-Source: APXvYqysn1yWXC2u2uc2OMF5pQ6ZmHnh/8I4d4d4MmJZbQAVa63tktRBohdvGFeCxKoht0hKfS3eQw==
X-Received: by 2002:a2e:9d0f:: with SMTP id t15mr2545187lji.171.1578484075852;
        Wed, 08 Jan 2020 03:47:55 -0800 (PST)
Received: from tp480.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e17sm1130645ljg.101.2020.01.08.03.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:47:55 -0800 (PST)
From:   Szymon Czapracki <szymon.czapracki@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH v2 1/8] monitor: Update periodic sync commands.
Date:   Wed,  8 Jan 2020 12:47:45 +0100
Message-Id: <20200108114752.133076-1-szymon.czapracki@codecoup.pl>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Change fields in periodic_adv_(create/term)_sync_cmd, according to their
description with 5.1 specification.

< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Options: 0x0001
        Use Periodic Advertiser List
        Reporting initially enabled
        SID: 0x00
        Adv address type: Public (0x00)
        Adv address: 00:00:00:00:00:00 (OUI 00-00-00)
        Skip: 0x0000
        Sync timeout: 0 msec (0x0000)
        Sync CTE type: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Unknown HCI Command (0x01)
---
 monitor/bt.h     |  6 +--
 monitor/packet.c | 96 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 8edc895e8..ecf3782c9 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2371,13 +2371,13 @@ struct bt_hci_le_ext_create_conn {
 
 #define BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC		0x2044
 struct bt_hci_cmd_le_periodic_adv_create_sync {
-	uint8_t  filter_policy;
+	uint8_t  options;
 	uint8_t  sid;
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 	uint16_t skip;
 	uint16_t sync_timeout;
-	uint8_t  unused;
+	uint8_t  sync_cte_type;
 } __attribute__ ((packed));
 
 #define BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL		0x2045
@@ -3108,7 +3108,7 @@ struct bt_hci_le_per_adv_report {
 	uint16_t handle;
 	uint8_t  tx_power;
 	int8_t   rssi;
-	uint8_t  unused;
+	uint8_t  cte_type;
 	uint8_t  data_status;
 	uint8_t  data_len;
 	uint8_t  data[0];
diff --git a/monitor/packet.c b/monitor/packet.c
index ab8bbdee5..64f75cf8e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7321,24 +7321,70 @@ static void le_ext_create_conn_cmd(const void *data, uint8_t size)
 	print_ext_conn_phys(cmd->data, cmd->phys);
 }
 
-static void le_periodic_adv_create_sync_cmd(const void *data, uint8_t size)
+static const struct bitfield_data create_sync_cte_type[] = {
+	{  0, "Do not sync to packets with AoA CTE"	},
+	{  1, "Do not sync to packets with AoD CTE 1us"	},
+	{  2, "Do not sync to packets with AoD CTE 2us"	},
+	{  3, "Do not sync to packets with type 3 AoD"	},
+	{  4, "Do not sync to packets without CTE"	},
+	{ },
+};
+
+static const struct bitfield_data create_sync_options[] = {
+	{  0, "Use Periodic Advertiser List"	},
+	{  1, "Reporting initially disabled"	},
+	{ },
+};
+
+static const struct bitfield_data create_sync_options_alt[] = {
+	{  0, "Use advertising SID, Advertiser Address Type and address"},
+	{  1, "Reporting initially enabled"				},
+	{ },
+};
+
+static void print_create_sync_cte_type(uint8_t flags)
 {
-	const struct bt_hci_cmd_le_periodic_adv_create_sync *cmd = data;
-	const char *str;
+	uint8_t mask = flags;
 
-	switch (cmd->filter_policy) {
-	case 0x00:
-		str = "Use specified advertising parameters";
-		break;
-	case 0x01:
-		str = "Use Periodic Advertiser List";
-		break;
-	default:
-		str = "Reserved";
-		break;
+	print_field("Sync CTE type: 0x%4.4x", flags);
+
+	mask = print_bitfield(2, flags, create_sync_cte_type);
+
+	if (mask) {
+		print_text(COLOR_UNKNOWN_ADV_FLAG,
+				"Unknown sync CTE type properties (0x%4.4x)",
+									mask);
 	}
+}
 
-	print_field("Filter policy: %s (0x%2.2x)", str, cmd->filter_policy);
+static void print_create_sync_options(uint8_t flags)
+{
+	uint8_t mask = flags;
+	int i;
+
+	print_field("Options: 0x%4.4x", flags);
+
+	for (i = 0; create_sync_options[i].str; i++) {
+		if (flags & (1 << create_sync_options[i].bit)) {
+			print_field("%s", create_sync_options[i].str);
+			mask  &= ~(1 << create_sync_options[i].bit);
+		} else {
+			print_field("%s", create_sync_options_alt[i].str);
+			mask  &= ~(1 << create_sync_options_alt[i].bit);
+		}
+	}
+
+	if (mask) {
+		print_text(COLOR_UNKNOWN_ADV_FLAG,
+					"  Unknown options (0x%4.4x)", mask);
+	}
+}
+
+static void le_periodic_adv_create_sync_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_periodic_adv_create_sync *cmd = data;
+
+	print_create_sync_options(cmd->options);
 	print_field("SID: 0x%2.2x", cmd->sid);
 	print_addr_type("Adv address type", cmd->addr_type);
 	print_addr("Adv address", cmd->addr, cmd->addr_type);
@@ -7346,7 +7392,7 @@ static void le_periodic_adv_create_sync_cmd(const void *data, uint8_t size)
 	print_field("Sync timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(cmd->sync_timeout) * 10,
 					le16_to_cpu(cmd->sync_timeout));
-	print_field("Unused: 0x%2.2x", cmd->unused);
+	print_create_sync_cte_type(cmd->sync_cte_type);
 }
 
 static void le_periodic_adv_term_sync_cmd(const void *data, uint8_t size)
@@ -9648,7 +9694,25 @@ static void le_per_adv_report_evt(const void *data, uint8_t size)
 	else
 		print_field("RSSI: reserved (0x%2.2x)",
 						(uint8_t) evt->rssi);
-	print_field("Unused: (0x%2.2x)", evt->unused);
+
+	switch (evt->cte_type) {
+	case 0x00:
+		str = "AoA Constant Tone Extension";
+		break;
+	case 0x01:
+		str = "AoA Constant Tone Extension with 1us slots";
+		break;
+	case 0x02:
+		str = "AoD Constant Tone Extension with 2us slots";
+		break;
+	case 0xff:
+		str = "No Constant Tone Extension";
+		break;
+	default:
+		str = "Reserved";
+		color_on = COLOR_RED;
+		break;
+	}
 
 	switch (evt->data_status) {
 	case 0x00:
-- 
2.24.1

