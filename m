Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C014C33C9B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C35206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxVsNqi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgAHAdv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38605 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHAdu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:50 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so299505pje.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tj1sKdxQJv+tVbKXBUsODP4Bl9IqFnM4sCvQBEtKHs0=;
        b=bxVsNqi3yvcUGKh9BG4DI/vR6ZfQsJP6xYxwsk92ZBjJei4D847Ldt2S263nznWBQU
         qH/i1FzW5xcGs92duuQUgag7WwC359VS/Te80QFsf2yF+Qs+IVNu/aNiWIWrr0o8Tvph
         LN1ui0e+u0N9+nFW+J/hBNo8ZEWtclZZeF+V1whsP4JW4HwPJs8oxgqv1DBPWrmcQcno
         hlDDrIUFI7Bq/zK9YDyRsEB3ho/LPvn9wvp58Cpf+wpr3dpQ3FGGJJV1OCwLQK2Xz5GJ
         rZqZEfb61h7ml8SOtMfgJbNzA0L1U30FSgGtXFwjTfcIMpmuLMY3jACD6nCaTYRpMEfL
         AyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tj1sKdxQJv+tVbKXBUsODP4Bl9IqFnM4sCvQBEtKHs0=;
        b=tQMIM8Np231k0EDnPwDdTe61Hg5ySxsq8jAH1UT1cTbaQq+3RFyhxqmSHIkxfIVs+Y
         S5WD6Q4g3JcfXRMTMws15EXcg1H9q/d+bbjidjt4bKfWWuiLuSQ0thDP6lUo6vjBMrfj
         RJOB4TNNDCGGE/Q6BVC0suR7CL+RNZVWNdUfMd7L8w0lrpkIAZ13EHn2NdVT4IQEffPd
         mVPpEcMjwOCG9SMgMu/0txxUjBgMglA86yy3aUeW3AmPJuaDDZOuXCqltYvsVOMY19Tl
         dRFGSPbCuj+RQ4CstRlCZvUlJ954z9CCAkDU+Ico5ydhRZPcKyfbLeJFxoID1/boYHmN
         +z5Q==
X-Gm-Message-State: APjAAAWcsP4QxcOJZJo6cYUlBew0UhJecCOsQ7oVVcHr6z0WpaPE3c4v
        CJACtfW3+g7GU5KFeMJPKzEWKqhmfFg=
X-Google-Smtp-Source: APXvYqzgq4weoNpkx4adsQBkpv3YnnPbSzvNJTkZMc8wje4pMISslF47J9AFtxZwVW6tb/YrC4n4lw==
X-Received: by 2002:a17:902:6501:: with SMTP id b1mr2562627plk.121.1578443629543;
        Tue, 07 Jan 2020 16:33:49 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/22] monitor: Add support for ISO packets
Date:   Tue,  7 Jan 2020 16:33:26 -0800
Message-Id: <20200108003342.15458-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables decoding of ISO packets.
---
 monitor/bt.h         | 12 +++++++--
 monitor/packet.c     | 63 +++++++++++++++++++++++++++++++++++++++++++-
 monitor/packet.h     |  2 ++
 src/shared/btsnoop.h |  2 ++
 4 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 0a88aff97..b08f145ab 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -514,7 +514,7 @@ struct bt_hci_sco_hdr {
 
 struct bt_hci_iso_hdr {
 	uint16_t handle;
-	uint8_t  dlen;
+	uint16_t dlen;
 } __attribute__ ((packed));
 
 struct bt_hci_iso_data_start {
@@ -3434,9 +3434,17 @@ struct bt_hci_evt_le_cis_established {
 	uint16_t conn_handle;
 	uint8_t  cig_sync_delay[3];
 	uint8_t  cis_sync_delay[3];
-	uint8_t  latency[3];
+	uint8_t  m_latency[3];
+	uint8_t  s_latency[3];
 	uint8_t  m_phy;
 	uint8_t  s_phy;
+	uint8_t  nse;
+	uint8_t  m_bn;
+	uint8_t  s_bn;
+	uint8_t  m_ft;
+	uint8_t  s_ft;
+	uint16_t m_mtu;
+	uint16_t s_mtu;
 } __attribute__ ((packed));
 
 #define BT_HCI_EVT_LE_CIS_REQ			BT_HCI_SUBEVT_5_2 + 1
diff --git a/monitor/packet.c b/monitor/packet.c
index 8987ed703..0ef8a5b86 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3934,6 +3934,12 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
 	case BTSNOOP_OPCODE_SCO_RX_PKT:
 		packet_hci_scodata(tv, cred, index, true, data, size);
 		break;
+	case BTSNOOP_OPCODE_ISO_TX_PKT:
+		packet_hci_isodata(tv, cred, index, false, data, size);
+		break;
+	case BTSNOOP_OPCODE_ISO_RX_PKT:
+		packet_hci_isodata(tv, cred, index, true, data, size);
+		break;
 	case BTSNOOP_OPCODE_OPEN_INDEX:
 		if (index < MAX_INDEX)
 			addr2str(index_list[index].bdaddr, str);
@@ -10275,9 +10281,17 @@ static void le_cis_established_evt(const void *data, uint8_t size)
 	print_field("Connection Handle: %d", le16_to_cpu(evt->status));
 	print_usec_interval("CIG Synchronization Delay", evt->cig_sync_delay);
 	print_usec_interval("CIS Synchronization Delay", evt->cis_sync_delay);
-	print_usec_interval("Latency", evt->latency);
+	print_usec_interval("Master to Slave Latency", evt->m_latency);
+	print_usec_interval("Slave to Master Latency", evt->s_latency);
 	print_le_phy("Master to Slave PHY", evt->m_phy);
 	print_le_phy("Slave to Master PHY", evt->m_phy);
+	print_field("Number of Subevents: %u", evt->nse);
+	print_field("Master to Slave Burst Number: %u", evt->m_bn);
+	print_field("Slave to Master Burst Number: %u", evt->s_bn);
+	print_field("Master to Slave Flush Timeout: %u", evt->m_ft);
+	print_field("Slave to Master Flush Timeout: %u", evt->s_ft);
+	print_field("Master to Slave MTU: %u", evt->m_ft);
+	print_field("Slave to Master MTU: %u", evt->s_ft);
 }
 
 static void le_req_cis_evt(const void *data, uint8_t size)
@@ -11134,6 +11148,53 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		packet_hexdump(data, size);
 }
 
+void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size)
+{
+	const struct bt_hci_iso_hdr *hdr = data;
+	uint16_t handle = le16_to_cpu(hdr->handle);
+	uint8_t flags = acl_flags(handle);
+	char handle_str[16], extra_str[32];
+
+	if (index > MAX_INDEX) {
+		print_field("Invalid index (%d).", index);
+		return;
+	}
+
+	index_list[index].frame++;
+
+	if (size < sizeof(*hdr)) {
+		if (in)
+			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+				"Malformed ISO Data RX packet", NULL, NULL);
+		else
+			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+				"Malformed ISO Data TX packet", NULL, NULL);
+		packet_hexdump(data, size);
+		return;
+	}
+
+	data += sizeof(*hdr);
+	size -= sizeof(*hdr);
+
+	sprintf(handle_str, "Handle %d", acl_handle(handle));
+	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, hdr->dlen);
+
+	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_SCODATA,
+				in ? "ISO Data RX" : "ISO Data TX",
+						handle_str, extra_str);
+
+	if (size != hdr->dlen) {
+		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
+							size, hdr->dlen);
+		packet_hexdump(data, size);
+		return;
+	}
+
+	if (filter_mask & PACKET_FILTER_SHOW_SCO_DATA)
+		packet_hexdump(data, size);
+}
+
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size)
 {
diff --git a/monitor/packet.h b/monitor/packet.h
index 199e15e58..19ea04c68 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -94,6 +94,8 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
 void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size);
+void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size);
 
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 					const void *data, uint16_t size);
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 3043d33e2..5fb084aa2 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -53,6 +53,8 @@
 #define BTSNOOP_OPCODE_CTRL_CLOSE	15
 #define BTSNOOP_OPCODE_CTRL_COMMAND	16
 #define BTSNOOP_OPCODE_CTRL_EVENT	17
+#define BTSNOOP_OPCODE_ISO_TX_PKT	18
+#define BTSNOOP_OPCODE_ISO_RX_PKT	19
 
 #define BTSNOOP_MAX_PACKET_SIZE		(1486 + 4)
 
-- 
2.21.0

