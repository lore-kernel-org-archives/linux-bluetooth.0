Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F218E610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbhHMMVU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbhHMMVN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A7EC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w200-20020a25c7d10000b02905585436b530so9003452ybe.21
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CmM64fNHZY9Yed14Z40B1/olix7ObnccUkDGcrE7PBE=;
        b=I+iP19G+b4eJ1lZldaQlWhex0fKgu+STwhAb2IhATpc1s8wWEdBOl/wXFY+3RQmXyI
         3Ocv1rWJ1hPP9AHDC38WbVBNGWBFNQPCrcdE3Wdm/6NZAs6Cssy1IpKQRTrtZo4fkaHu
         q1yA5BP0QEtBQIePEENojxDWjLGz335LHa6pMSInFG5fUg8qE1Y8qCtVej5lt2tZJ72L
         zvrbM0M5XBHZ2xcY4SBcDEpSPDfJRBtrgn8PqVNcG6qiVNMWoklAUYdgo4AVZN2KelTr
         xR4qwGx10FL6E3bv8fxbmjjeeJ5TwN0JE+g+jIrXvJpW29xqZ6gTrXMnhbB2skJstuij
         dt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CmM64fNHZY9Yed14Z40B1/olix7ObnccUkDGcrE7PBE=;
        b=bmP5wbq3LUwSxBbSgLkprcNU+6uiDWPUn2CG4XbqX+P5OjQjANPmBMXZ6VF+zzjgaj
         iexT6n8dzd5+BzDaAKrz1Nw+EcXONCE8kLRhv30V1lA0zmCJ0iaGqfejWbPMG2vupCBj
         OnVaNxbpYrtAoNyrX0uCrzO07pXcu2l3pIC0aSAoBWk6mMwnyspzwmg+47kX/7w6fF1I
         pDmjVOufkCXJZwZc9U8cC1ukxn37435whNyXwDmOGI+xSc5zDkxdcE84y1Jzu2IpUEk7
         VxR1z9HcYEQ5Z17PNLEyPOb4B9m9d2j93lUZkahRdFf26t/IzVwQ7pz6qutVeY6esr9e
         pWJg==
X-Gm-Message-State: AOAM5304l299amaDVvjAVLgknv1Iyh10dBO8rOYWP7tfyHk5qTZwjIf1
        TN15Yow2FlNTjj2TNaOSO49Rt/92rnUApWje26CMragYD7hyGZit32uOIptZC69tF2PxHm7JlrE
        sIjTNuinOo3D6hoEuFuzuCyj0x01IEDlPN2n2Q2EFXYUndsZIHDHl5rjgrszMxcgyjE5Hjpu1d+
        8G
X-Google-Smtp-Source: ABdhPJyTRML8SuVipV6BUqST69DYE+y2ocNsSDOCfdrUEVIDbOP8D3azb3JZH3aeprr2rF/G2LV7eaqZxjaE
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:9b03:: with SMTP id
 y3mr2491927ybn.264.1628857245913; Fri, 13 Aug 2021 05:20:45 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:04 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.19.Ie6d2c61363aea99e926343e7b4f6123062d00f83@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 19/62] monitor: Inclusive language in consts and strings
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are preferred, as reflected in the BT
core spec 5.3.
---

 monitor/broadcom.c |   8 ++--
 monitor/control.c  |  10 ++--
 monitor/l2cap.c    |   2 +-
 monitor/ll.c       |  42 +++++++++--------
 monitor/lmp.c      |   2 +-
 monitor/packet.c   | 114 +++++++++++++++++++++++----------------------
 6 files changed, 93 insertions(+), 85 deletions(-)

diff --git a/monitor/broadcom.c b/monitor/broadcom.c
index b144032c3e..e30116735b 100644
--- a/monitor/broadcom.c
+++ b/monitor/broadcom.c
@@ -120,10 +120,10 @@ static void print_sync_mode(uint8_t mode)
 
 	switch (mode) {
 	case 0x00:
-		str = "Slave";
+		str = "Peripheral";
 		break;
 	case 0x01:
-		str = "Master";
+		str = "Central";
 		break;
 	default:
 		str = "Reserved";
@@ -139,10 +139,10 @@ static void print_clock_mode(uint8_t mode)
 
 	switch (mode) {
 	case 0x00:
-		str = "Slave";
+		str = "Peripheral";
 		break;
 	case 0x01:
-		str = "Master";
+		str = "Central";
 		break;
 	default:
 		str = "Reserved";
diff --git a/monitor/control.c b/monitor/control.c
index 97d7e789c4..fac1f8e1ff 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -305,19 +305,19 @@ static void mgmt_new_long_term_key(uint16_t len, const void *buf)
 		return;
 	}
 
-	/* LE SC keys are both for master and slave */
+	/* LE SC keys are both for central and peripheral */
 	switch (ev->key.type) {
 	case 0x00:
 		if (ev->key.central)
-			type = "Master (Unauthenticated)";
+			type = "Central (Unauthenticated)";
 		else
-			type = "Slave (Unauthenticated)";
+			type = "Peripheral (Unauthenticated)";
 		break;
 	case 0x01:
 		if (ev->key.central)
-			type = "Master (Authenticated)";
+			type = "Central (Authenticated)";
 		else
-			type = "Slave (Authenticated)";
+			type = "Peripheral (Authenticated)";
 		break;
 	case 0x02:
 		type = "SC (Unauthenticated)";
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 109bc16b44..646f0f66cb 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -1280,7 +1280,7 @@ static void sig_conn_param_req(const struct l2cap_frame *frame)
 
 	print_field("Min interval: %d", le16_to_cpu(pdu->min_interval));
 	print_field("Max interval: %d", le16_to_cpu(pdu->max_interval));
-	print_field("Slave latency: %d", le16_to_cpu(pdu->latency));
+	print_field("Peripheral latency: %d", le16_to_cpu(pdu->latency));
 	print_field("Timeout multiplier: %d", le16_to_cpu(pdu->timeout));
 }
 
diff --git a/monitor/ll.c b/monitor/ll.c
index d0db9194bd..f588d5e992 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -186,7 +186,7 @@ static void advertising_packet(const void *data, uint8_t size)
 		print_field("Transmit window size: %u", win_size);
 		print_field("Transmit window offset: %u", win_offset);
 		print_field("Connection interval: %u", interval);
-		print_field("Connection slave latency: %u", latency);
+		print_field("Connection peripheral latency: %u", latency);
 		print_field("Connection supervision timeout: %u", timeout);
 
 		packet_print_channel_map_ll(ptr + 30);
@@ -371,8 +371,10 @@ static void conn_update_req(const void *data, uint8_t size)
 	print_field("Transmit window size: %u", pdu->win_size);
 	print_field("Transmit window offset: %u", le16_to_cpu(pdu->win_offset));
 	print_field("Connection interval: %u", le16_to_cpu(pdu->interval));
-	print_field("Connection slave latency: %u", le16_to_cpu(pdu->latency));
-	print_field("Connection supervision timeout: %u", le16_to_cpu(pdu->timeout));
+	print_field("Connection peripheral latency: %u",
+						le16_to_cpu(pdu->latency));
+	print_field("Connection supervision timeout: %u",
+						le16_to_cpu(pdu->timeout));
 	print_field("Connection instant: %u", le16_to_cpu(pdu->instant));
 }
 
@@ -397,16 +399,16 @@ static void enc_req(const void *data, uint8_t size)
 
 	print_field("Rand: 0x%16.16" PRIx64, le64_to_cpu(pdu->rand));
 	print_field("EDIV: 0x%4.4x", le16_to_cpu(pdu->ediv));
-	print_field("SKD (master): 0x%16.16" PRIx64, le64_to_cpu(pdu->skd));
-	print_field("IV (master): 0x%8.8x", le32_to_cpu(pdu->iv));
+	print_field("SKD (central): 0x%16.16" PRIx64, le64_to_cpu(pdu->skd));
+	print_field("IV (central): 0x%8.8x", le32_to_cpu(pdu->iv));
 }
 
 static void enc_rsp(const void *data, uint8_t size)
 {
 	const struct bt_ll_enc_rsp *pdu = data;
 
-	print_field("SKD (slave): 0x%16.16" PRIx64, le64_to_cpu(pdu->skd));
-	print_field("IV (slave): 0x%8.8x", le32_to_cpu(pdu->iv));
+	print_field("SKD (peripheral): 0x%16.16" PRIx64, le64_to_cpu(pdu->skd));
+	print_field("IV (peripheral): 0x%8.8x", le32_to_cpu(pdu->iv));
 }
 
 static const char *opcode_to_string(uint8_t opcode);
@@ -505,14 +507,14 @@ static void phy_update_ind(const void *data, uint8_t size)
 	const struct bt_ll_phy_update_ind *pdu = data;
 	uint8_t mask;
 
-	print_field("M_TO_S_PHY: 0x%2.2x", pdu->c_phy);
+	print_field("C_TO_P_PHY: 0x%2.2x", pdu->c_phy);
 
 	mask = print_bitfield(2, pdu->c_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("S_TO_M_PHY: 0x%2.2x", pdu->p_phy);
+	print_field("P_TO_C_PHY: 0x%2.2x", pdu->p_phy);
 
 	mask = print_bitfield(2, pdu->p_phy, le_phys);
 	if (mask)
@@ -596,38 +598,40 @@ static void cis_req(const void *data, uint8_t size)
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig);
 	print_field("CIS ID: 0x%2.2x", cmd->cis);
-	print_field("Master to Slave PHY: 0x%2.2x", cmd->c_phy);
+	print_field("Central to Peripheral PHY: 0x%2.2x", cmd->c_phy);
 
 	mask = print_bitfield(2, cmd->c_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("Slave To Master PHY: 0x%2.2x", cmd->p_phy);
+	print_field("Peripheral To Central PHY: 0x%2.2x", cmd->p_phy);
 
 	mask = print_bitfield(2, cmd->p_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("Master to Slave Maximum SDU: %u", cmd->c_sdu);
-	print_field("Slave to Master Maximum SDU: %u", cmd->p_sdu);
+	print_field("Central to Peripheral Maximum SDU: %u", cmd->c_sdu);
+	print_field("Peripheral to Central Maximum SDU: %u", cmd->p_sdu);
 
 	memcpy(&interval, cmd->c_interval, sizeof(cmd->c_interval));
-	print_field("Master to Slave Interval: 0x%6.6x", le32_to_cpu(interval));
+	print_field("Central to Peripheral Interval: 0x%6.6x",
+							le32_to_cpu(interval));
 	memcpy(&interval, cmd->p_interval, sizeof(cmd->p_interval));
-	print_field("Slave to Master Interval: 0x%6.6x", le32_to_cpu(interval));
+	print_field("Peripheral to Central Interval: 0x%6.6x",
+							le32_to_cpu(interval));
 
-	print_field("Master to Slave Maximum PDU: %u", cmd->c_pdu);
-	print_field("Slave to Master Maximum PDU: %u", cmd->p_pdu);
+	print_field("Central to Peripheral Maximum PDU: %u", cmd->c_pdu);
+	print_field("Peripheral to Central Maximum PDU: %u", cmd->p_pdu);
 
 	print_field("Burst Number: %u us", cmd->bn);
 
 	memcpy(&interval, cmd->sub_interval, sizeof(cmd->sub_interval));
 	print_field("Sub-Interval: 0x%6.6x", le32_to_cpu(interval));
 
-	print_field("Master to Slave Flush Timeout: %u", cmd->c_ft);
-	print_field("Slave to Master Flush Timeout: %u", cmd->p_ft);
+	print_field("Central to Peripheral Flush Timeout: %u", cmd->c_ft);
+	print_field("Peripheral to Central Flush Timeout: %u", cmd->p_ft);
 
 	print_field("ISO Interval: 0x%4.4x", le16_to_cpu(cmd->iso_interval));
 
diff --git a/monitor/lmp.c b/monitor/lmp.c
index 0d17f5c986..f6ad3f2568 100644
--- a/monitor/lmp.c
+++ b/monitor/lmp.c
@@ -839,7 +839,7 @@ void lmp_packet(const void *data, uint8_t size, bool padded)
 	tid = ((const uint8_t *) data)[0] & 0x01;
 	opcode = (((const uint8_t *) data)[0] & 0xfe) >> 1;
 
-	tid_str = tid == 0x00 ? "Master" : "Slave";
+	tid_str = tid == 0x00 ? "Central" : "Peripheral";
 
 	switch (opcode) {
 	case 127:
diff --git a/monitor/packet.c b/monitor/packet.c
index 55f275ab3a..17da5a08d9 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2227,10 +2227,10 @@ static void print_role(uint8_t role)
 
 	switch (role) {
 	case 0x00:
-		str = "Master";
+		str = "Central";
 		break;
 	case 0x01:
-		str = "Slave";
+		str = "Peripheral";
 		break;
 	default:
 		str = "Reserved";
@@ -2549,16 +2549,16 @@ static const struct bitfield_data features_page0[] = {
 	{ 31, "Extended SCO link (EV3 packets)"		},
 	{ 32, "EV4 packets"				},
 	{ 33, "EV5 packets"				},
-	{ 35, "AFH capable slave"			},
-	{ 36, "AFH classification slave"		},
+	{ 35, "AFH capable peripheral"			},
+	{ 36, "AFH classification peripheral"		},
 	{ 37, "BR/EDR Not Supported"			},
 	{ 38, "LE Supported (Controller)"		},
 	{ 39, "3-slot Enhanced Data Rate ACL packets"	},
 	{ 40, "5-slot Enhanced Data Rate ACL packets"	},
 	{ 41, "Sniff subrating"				},
 	{ 42, "Pause encryption"			},
-	{ 43, "AFH capable master"			},
-	{ 44, "AFH classification master"		},
+	{ 43, "AFH capable central"			},
+	{ 44, "AFH classification central"		},
 	{ 45, "Enhanced Data Rate eSCO 2 Mbps mode"	},
 	{ 46, "Enhanced Data Rate eSCO 3 Mbps mode"	},
 	{ 47, "3-slot Enhanced Data Rate eSCO packets"	},
@@ -2602,7 +2602,7 @@ static const struct bitfield_data features_le[] = {
 	{  0, "LE Encryption"					},
 	{  1, "Connection Parameter Request Procedure"		},
 	{  2, "Extended Reject Indication"			},
-	{  3, "Slave-initiated Features Exchange"		},
+	{  3, "Peripheral-initiated Features Exchange"		},
 	{  4, "LE Ping"						},
 	{  5, "LE Data Packet Length Extension"			},
 	{  6, "LL Privacy"					},
@@ -2627,8 +2627,8 @@ static const struct bitfield_data features_le[] = {
 	{ 25, "Periodic Advertising Sync Transfer - Recipient"	},
 	{ 26, "Sleep Clock Accuracy Updates"			},
 	{ 27, "Remote Public Key Validation"			},
-	{ 28, "Connected Isochronous Stream - Master"		},
-	{ 29, "Connected Isochronous Stream - Slave"		},
+	{ 28, "Connected Isochronous Stream - Central"		},
+	{ 29, "Connected Isochronous Stream - Peripheral"	},
 	{ 30, "Isochronous Broadcaster"				},
 	{ 31, "Synchronized Receiver"				},
 	{ 32, "Isochronous Channels (Host Support)"		},
@@ -2737,11 +2737,11 @@ static const struct bitfield_data le_states_desc_table[] = {
 	{  5, "Active Scanning State"				},
 	{  6, "Passive Scanning State"				},
 	{  7, "Initiating State"				},
-	{  8, "Connection State (Master Role)"			},
-	{  9, "Connection State (Slave Role)"			},
-	{ 10, "Master Role & Master Role"			},
-	{ 11, "Slave Role & Slave Role"				},
-	{ 12, "Master Role & Slave Role"			},
+	{  8, "Connection State (Central Role)"			},
+	{  9, "Connection State (Peripheral Role)"		},
+	{ 10, "Central Role & Central Role"			},
+	{ 11, "Peripheral Role & Peripheral Role"		},
+	{ 12, "Central Role & Peripheral Role"			},
 	{ }
 };
 
@@ -3058,7 +3058,7 @@ static void print_fec(uint8_t fec)
 #define BT_EIR_DEVICE_ID		0x10
 #define BT_EIR_SMP_TK			0x10
 #define BT_EIR_SMP_OOB_FLAGS		0x11
-#define BT_EIR_SLAVE_CONN_INTERVAL	0x12
+#define BT_EIR_PERIPHERAL_CONN_INTERVAL	0x12
 #define BT_EIR_SERVICE_UUID16		0x14
 #define BT_EIR_SERVICE_UUID128		0x15
 #define BT_EIR_SERVICE_DATA		0x16
@@ -3668,10 +3668,10 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			print_field("SMP OOB Flags: 0x%2.2x", *data);
 			break;
 
-		case BT_EIR_SLAVE_CONN_INTERVAL:
+		case BT_EIR_PERIPHERAL_CONN_INTERVAL:
 			if (data_len < 4)
 				break;
-			print_field("Slave Conn. Interval: 0x%4.4x - 0x%4.4x",
+			print_field("Peripheral Conn. Interval: 0x%4.4x - 0x%4.4x",
 							get_le16(&data[0]),
 							get_le16(&data[2]));
 			break;
@@ -4140,10 +4140,10 @@ static void create_conn_cmd(const void *data, uint8_t size)
 
 	switch (cmd->role_switch) {
 	case 0x00:
-		str = "Stay master";
+		str = "Stay central";
 		break;
 	case 0x01:
-		str = "Allow slave";
+		str = "Allow peripheral";
 		break;
 	default:
 		str = "Reserved";
@@ -8023,15 +8023,15 @@ static void print_cis_params(const void *data, int i)
 	const struct bt_hci_cis_params *cis = data;
 
 	print_field("CIS ID: 0x%2.2x", cis->cis_id);
-	print_field("Master to Slave Maximum SDU Size: %u",
+	print_field("Central to Peripheral Maximum SDU Size: %u",
 						le16_to_cpu(cis->c_sdu));
-	print_field("Slave to Master Maximum SDU Size: %u",
+	print_field("Peripheral to Central Maximum SDU Size: %u",
 						le16_to_cpu(cis->p_sdu));
-	print_le_phy("Master to Slave PHY", cis->c_phy);
-	print_le_phy("Slave to Master PHY", cis->p_phy);
-	print_field("Master to Slave Retransmission attempts: 0x%2.2x",
+	print_le_phy("Central to Peripheral PHY", cis->c_phy);
+	print_le_phy("Peripheral to Central PHY", cis->p_phy);
+	print_field("Central to Peripheral Retransmission attempts: 0x%2.2x",
 							cis->c_rtn);
-	print_field("Slave to Master Retransmission attempts: 0x%2.2x",
+	print_field("Peripheral to Central Retransmission attempts: 0x%2.2x",
 							cis->p_rtn);
 }
 
@@ -8040,14 +8040,16 @@ static void le_set_cig_params_cmd(const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_cig_params *cmd = data;
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
-	print_usec_interval("Master to Slave SDU Interval", cmd->c_interval);
-	print_usec_interval("Slave to Master SDU Interval", cmd->p_interval);
+	print_usec_interval("Central to Peripheral SDU Interval",
+							cmd->c_interval);
+	print_usec_interval("Peripheral to Central SDU Interval",
+							cmd->p_interval);
 	print_sca(cmd->sca);
 	print_packing(cmd->packing);
 	print_framing(cmd->framing);
-	print_field("Master to Slave Maximum Latency: %d ms (0x%4.4x)",
+	print_field("Central to Peripheral Maximum Latency: %d ms (0x%4.4x)",
 		le16_to_cpu(cmd->c_latency), le16_to_cpu(cmd->c_latency));
-	print_field("Slave to Master Maximum Latency: %d ms (0x%4.4x)",
+	print_field("Peripheral to Central Maximum Latency: %d ms (0x%4.4x)",
 		le16_to_cpu(cmd->p_latency), le16_to_cpu(cmd->p_latency));
 	print_field("Number of CIS: %u", cmd->num_cis);
 
@@ -8063,16 +8065,16 @@ static void print_cis_params_test(const void *data, int i)
 
 	print_field("CIS ID: 0x%2.2x", cis->cis_id);
 	print_field("NSE: 0x%2.2x", cis->nse);
-	print_field("Master to Slave Maximum SDU: 0x%4.4x", cis->c_sdu);
-	print_field("Slave to Master Maximum SDU: 0x%4.4x",
+	print_field("Central to Peripheral Maximum SDU: 0x%4.4x", cis->c_sdu);
+	print_field("Peripheral to Central Maximum SDU: 0x%4.4x",
 						le16_to_cpu(cis->p_sdu));
-	print_field("Master to Slave Maximum PDU: 0x%2.2x",
+	print_field("Central to Peripheral Maximum PDU: 0x%2.2x",
 						le16_to_cpu(cis->c_pdu));
-	print_field("Slave to Master Maximum PDU: 0x%2.2x", cis->p_pdu);
-	print_le_phy("Master to Slave PHY", cis->c_phy);
-	print_le_phy("Slave to Master PHY", cis->p_phy);
-	print_field("Master to Slave Burst Number: 0x%2.2x", cis->c_bn);
-	print_field("Slave to Master Burst Number: 0x%2.2x", cis->p_bn);
+	print_field("Peripheral to Central Maximum PDU: 0x%2.2x", cis->p_pdu);
+	print_le_phy("Central to Peripheral PHY", cis->c_phy);
+	print_le_phy("Peripheral to Central PHY", cis->p_phy);
+	print_field("Central to Peripheral Burst Number: 0x%2.2x", cis->c_bn);
+	print_field("Peripheral to Central Burst Number: 0x%2.2x", cis->p_bn);
 }
 
 static void le_set_cig_params_test_cmd(const void *data, uint8_t size)
@@ -8080,10 +8082,12 @@ static void le_set_cig_params_test_cmd(const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_cig_params_test *cmd = data;
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
-	print_usec_interval("Master to Slave SDU Interval", cmd->c_interval);
-	print_usec_interval("Master to Slave SDU Interval", cmd->p_interval);
-	print_field("Master to Slave Flush Timeout: 0x%2.2x", cmd->c_ft);
-	print_field("Slave to Master Flush Timeout: 0x%2.2x", cmd->p_ft);
+	print_usec_interval("Central to Peripheral SDU Interval",
+							cmd->c_interval);
+	print_usec_interval("Peripheral to Central SDU Interval",
+							cmd->p_interval);
+	print_field("Central to Peripheral Flush Timeout: 0x%2.2x", cmd->c_ft);
+	print_field("Peripheral to Central Flush Timeout: 0x%2.2x", cmd->p_ft);
 	print_field("ISO Interval: %.2f ms (0x%4.4x)",
 				le16_to_cpu(cmd->iso_interval) * 1.25,
 				le16_to_cpu(cmd->iso_interval));
@@ -10279,7 +10283,7 @@ static void le_conn_complete_evt(const void *data, uint8_t size)
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
-	print_field("Master clock accuracy: 0x%2.2x", evt->clock_accuracy);
+	print_field("Central clock accuracy: 0x%2.2x", evt->clock_accuracy);
 
 	if (evt->status == 0x00)
 		assign_handle(le16_to_cpu(evt->handle), 0x01);
@@ -10400,7 +10404,7 @@ static void le_enhanced_conn_complete_evt(const void *data, uint8_t size)
 	print_field("Supervision timeout: %d msec (0x%4.4x)",
 					le16_to_cpu(evt->supv_timeout) * 10,
 					le16_to_cpu(evt->supv_timeout));
-	print_field("Master clock accuracy: 0x%2.2x", evt->clock_accuracy);
+	print_field("Central clock accuracy: 0x%2.2x", evt->clock_accuracy);
 
 	if (evt->status == 0x00)
 		assign_handle(le16_to_cpu(evt->handle), 0x01);
@@ -10776,17 +10780,17 @@ static void le_cis_established_evt(const void *data, uint8_t size)
 	print_field("Connection Handle: %d", le16_to_cpu(evt->conn_handle));
 	print_usec_interval("CIG Synchronization Delay", evt->cig_sync_delay);
 	print_usec_interval("CIS Synchronization Delay", evt->cis_sync_delay);
-	print_usec_interval("Master to Slave Latency", evt->c_latency);
-	print_usec_interval("Slave to Master Latency", evt->p_latency);
-	print_le_phy("Master to Slave PHY", evt->c_phy);
-	print_le_phy("Slave to Master PHY", evt->p_phy);
+	print_usec_interval("Central to Peripheral Latency", evt->c_latency);
+	print_usec_interval("Peripheral to Central Latency", evt->p_latency);
+	print_le_phy("Central to Peripheral PHY", evt->c_phy);
+	print_le_phy("Peripheral to Central PHY", evt->p_phy);
 	print_field("Number of Subevents: %u", evt->nse);
-	print_field("Master to Slave Burst Number: %u", evt->c_bn);
-	print_field("Slave to Master Burst Number: %u", evt->p_bn);
-	print_field("Master to Slave Flush Timeout: %u", evt->c_ft);
-	print_field("Slave to Master Flush Timeout: %u", evt->p_ft);
-	print_field("Master to Slave MTU: %u", le16_to_cpu(evt->c_mtu));
-	print_field("Slave to Master MTU: %u", le16_to_cpu(evt->p_mtu));
+	print_field("Central to Peripheral Burst Number: %u", evt->c_bn);
+	print_field("Peripheral to Central Burst Number: %u", evt->p_bn);
+	print_field("Central to Peripheral Flush Timeout: %u", evt->c_ft);
+	print_field("Peripheral to Central Flush Timeout: %u", evt->p_ft);
+	print_field("Central to Peripheral MTU: %u", le16_to_cpu(evt->c_mtu));
+	print_field("Peripheral to Central MTU: %u", le16_to_cpu(evt->p_mtu));
 	print_field("ISO Interval: %u", le16_to_cpu(evt->interval));
 }
 
@@ -12163,7 +12167,7 @@ static void mgmt_print_long_term_key(const void *data)
 {
 	uint8_t address_type = get_u8(data + 6);
 	uint8_t key_type = get_u8(data + 7);
-	uint8_t master = get_u8(data + 8);
+	uint8_t central = get_u8(data + 8);
 	uint8_t enc_size = get_u8(data + 9);
 	const char *str;
 
@@ -12191,7 +12195,7 @@ static void mgmt_print_long_term_key(const void *data)
 	}
 
 	print_field("Key type: %s (0x%2.2x)", str, key_type);
-	print_field("Master: 0x%2.2x", master);
+	print_field("Central: 0x%2.2x", central);
 	print_field("Encryption size: %u", enc_size);
 	print_hex_field("Diversifier", data + 10, 2);
 	print_hex_field("Randomizer", data + 12, 8);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

