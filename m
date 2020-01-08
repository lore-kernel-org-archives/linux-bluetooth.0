Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5F9C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B896206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qow/aPts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgAHAds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:48 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:45099 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgAHAdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:47 -0500
Received: by mail-pg1-f176.google.com with SMTP id b9so653527pgk.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YQg2WNzj/S4xESCNpW4vqMS7o4sgCnxBsBwcCP7+PJc=;
        b=qow/aPtsCHtG4R1zoNBGpYxWbK3JZUnApueeLpztBYdx2rKRK02VB9VtACrBq/1CTi
         qxfjQN5Q7exx57cOA8dkVcqStsIAl9RL8GQdsVdN1SSZ8qP2ET8TJMumRd/GncScINP4
         bekgKB/n3AU0wfwFc7lBW73hSzeHOs23T14PrJgzN6kSOVeAVzMLiooog/+qWNvqL82u
         SA1qeBSBABmIMgkUk7Vs38u1PGjZz7ZKMpAybP/+wNdNb0T6Q/jbOTu3zGqA43y3gfEi
         sS9rMO0KDx9vR34yfyDYmoeJRs/+t7kZKpmkkgDBdnhxMrx3erLawE/S0vItKuexdwzl
         rc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQg2WNzj/S4xESCNpW4vqMS7o4sgCnxBsBwcCP7+PJc=;
        b=V8KHIUQY3k4NxjnmD5PWzrSErC+iup4ipbKd/1ud5TEwWZI9VmA6+1UB2K8IbqWt3B
         sDY4P33/fEFWZ3z2rlKCsLvDZTJ0KNnYAN+0/vZuo9iV2PdrQaFf23vI4xOurlnrM6nE
         LPURFgxwDgqmh1aHwmI8Dq4Gl3Byw6bZnPkPnkEtFAxDC9wtzZDHhy/GKhqCH0BAZW8W
         D87c6S+dMb7g3BBYMLI6uBEQrzf8lfgomkdsaKPEhddCupCiGxmIDSarC8vHFSwHNpCX
         ijE7qxxYndo2HzPC06CMmuSEssI2pRRWMHDzqCib3dFDJDyCkEMtfiKWUFs7ZBtKIvtY
         R7XA==
X-Gm-Message-State: APjAAAWx9di5pl4RsQevOtQvYYy1Q+0Pg7ZO8chpwWn29eHcQr2TErN/
        ZwXKfAHXEayGqrP1DXvk+OrYv93qK/E=
X-Google-Smtp-Source: APXvYqzJcJIWnvfjGR0MkrgKO7rj2HQzXd7nDzqxy0sQGXg36VOba+mrlfAGgMJQKPQohCLgprFi/w==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr2320357pgd.135.1578443625828;
        Tue, 07 Jan 2020 16:33:45 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:45 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/22] monitor: Add decoding of ISO related Link Layer PDUs
Date:   Tue,  7 Jan 2020 16:33:22 -0800
Message-Id: <20200108003342.15458-3-luiz.dentz@gmail.com>
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

This adds the decoding of ISO related Link Layer PDUs
---
 monitor/bt.h |  48 ++++++++++++++++++++++++-
 monitor/ll.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 04ad34ea9..0a88aff97 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -28,7 +28,7 @@
 #define BT_HCI_BIT_5_2		(8 * 41) + 5
 #define BT_HCI_SUBEVT_5_2	0x19
 
-#define BT_LL_CMD_MILAN		0x1f
+#define BT_LL_CMD_5_2		0x1f
 
 struct bt_ll_hdr {
 	uint8_t  preamble;
@@ -181,6 +181,52 @@ struct bt_ll_clock_acc {
 
 #define BT_LL_CLOCK_ACCURACY_RSP 0x1e
 
+#define BT_LL_CIS_REQ		BT_LL_CMD_5_2
+struct bt_ll_cis_req {
+	uint8_t  cig;
+	uint8_t  cis;
+	uint8_t  m_phy;
+	uint8_t  s_phy;
+	uint16_t m_sdu;
+	uint16_t s_sdu;
+	uint8_t  m_interval[3];
+	uint8_t  s_interval[3];
+	uint8_t  m_pdu;
+	uint8_t  s_pdu;
+	uint8_t  nse;
+	uint8_t  sub_interval[3];
+	uint8_t  bn;
+	uint8_t  m_ft;
+	uint8_t  s_ft;
+	uint16_t iso_interval;
+	uint8_t  offset_min[3];
+	uint8_t  offset_max[3];
+	uint16_t conn_event_count;
+} __attribute__ ((packed));
+
+#define BT_LL_CIS_RSP		BT_LL_CMD_5_2 + 1
+struct bt_ll_cis_rsp {
+	uint8_t  offset_min[3];
+	uint8_t  offset_max[3];
+	uint16_t conn_event_count;
+} __attribute__ ((packed));
+
+#define BT_LL_CIS_IND		BT_LL_CMD_5_2 + 2
+struct bt_ll_cis_ind {
+	uint32_t addr;
+	uint8_t  cis_offset[3];
+	uint8_t  cig_sync_delay[3];
+	uint8_t  cis_sync_delay[3];
+	uint16_t conn_event_count;
+} __attribute__ ((packed));
+
+#define BT_LL_CIS_TERMINATE_IND	BT_LL_CMD_5_2 + 3
+struct bt_ll_cis_term_ind {
+	uint8_t  cig;
+	uint8_t  cis;
+	uint8_t  reason;
+} __attribute__ ((packed));
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
diff --git a/monitor/ll.c b/monitor/ll.c
index 5141f2be6..4b3f567bd 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -601,6 +601,97 @@ static void clock_acc_req_rsp(const void *data, uint8_t size)
 	print_field("SCA: 0x%2.2x", pdu->sca);
 }
 
+static void cis_req(const void *data, uint8_t size)
+{
+	const struct bt_ll_cis_req *cmd = data;
+	uint32_t interval;
+	uint8_t mask;
+
+	print_field("CIG ID: 0x%2.2x", cmd->cig);
+	print_field("CIS ID: 0x%2.2x", cmd->cis);
+	print_field("Master to Slave PHY: 0x%2.2x", cmd->m_phy);
+
+	mask = print_bitfield(2, cmd->m_phy, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_field("Slave To Master PHY: 0x%2.2x", cmd->s_phy);
+
+	mask = print_bitfield(2, cmd->s_phy, le_phys);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%2.2x)", mask);
+
+	print_field("Master to Slave Maximum SDU: %u", cmd->m_sdu);
+	print_field("Slave to Master Maximum SDU: %u", cmd->s_sdu);
+
+	memcpy(&interval, cmd->m_interval, sizeof(cmd->m_interval));
+	print_field("Master to Slave Interval: 0x%6.6x", le32_to_cpu(interval));
+	memcpy(&interval, cmd->s_interval, sizeof(cmd->s_interval));
+	print_field("Slave to Master Interval: 0x%6.6x", le32_to_cpu(interval));
+
+	print_field("Master to Slave Maximum PDU: %u", cmd->m_pdu);
+	print_field("Slave to Master Maximum PDU: %u", cmd->s_pdu);
+
+	print_field("Burst Number: %u us", cmd->bn);
+
+	memcpy(&interval, cmd->sub_interval, sizeof(cmd->sub_interval));
+	print_field("Sub-Interval: 0x%6.6x", le32_to_cpu(interval));
+
+	print_field("Master to Slave Flush Timeout: %u", cmd->m_ft);
+	print_field("Slave to Master Flush Timeout: %u", cmd->s_ft);
+
+	print_field("ISO Interval: 0x%4.4x", le16_to_cpu(cmd->iso_interval));
+
+	memcpy(&interval, cmd->offset_min, sizeof(cmd->offset_min));
+	print_field("CIS Offset Minimum: 0x%6.6x", le32_to_cpu(interval));
+	memcpy(&interval, cmd->offset_max, sizeof(cmd->offset_max));
+	print_field("CIS Offset Maximum: 0x%6.6x", le32_to_cpu(interval));
+
+	print_field("Connection Event Count: %u", cmd->conn_event_count);
+}
+
+static void cis_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_cis_rsp *rsp = data;
+	uint32_t interval;
+
+	memcpy(&interval, rsp->offset_min, sizeof(rsp->offset_min));
+	print_field("CIS Offset Minimum: 0x%6.6x", le32_to_cpu(interval));
+	memcpy(&interval, rsp->offset_max, sizeof(rsp->offset_max));
+	print_field("CIS Offset Maximum: 0x%6.6x", le32_to_cpu(interval));
+
+	print_field("Connection Event Count: %u", rsp->conn_event_count);
+}
+
+static void cis_ind(const void *data, uint8_t size)
+{
+	const struct bt_ll_cis_ind *ind = data;
+	uint32_t interval;
+
+	print_field("CIS Access Address: 0x%4.4x", le32_to_cpu(ind->addr));
+	memcpy(&interval, ind->cis_offset, sizeof(ind->cis_offset));
+	print_field("CIS Offset: 0x%6.6x", le32_to_cpu(interval));
+
+	memcpy(&interval, ind->cig_sync_delay, sizeof(ind->cig_sync_delay));
+	print_field("CIG Synchronization Delay: 0x%6.6x",
+					le32_to_cpu(interval));
+	memcpy(&interval, ind->cis_sync_delay, sizeof(ind->cis_sync_delay));
+	print_field("CIS Synchronization Delay: %u us",
+					le32_to_cpu(interval));
+	print_field("Connection Event Count: %u", ind->conn_event_count);
+}
+
+static void cis_term_ind(const void *data, uint8_t size)
+{
+	const struct bt_ll_cis_term_ind *ind = data;
+
+	print_field("CIG ID: 0x%2.2x", ind->cig);
+	print_field("CIS ID: 0x%2.2x", ind->cis);
+	packet_print_error("Reason", ind->reason);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -641,6 +732,15 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x1c, "LL_PERIODIC_SYNC_IND",     periodic_sync_ind, 34, true },
 	{ 0x1d, "LL_CLOCK_ACCURACY_REQ",    clock_acc_req_rsp,  1, true },
 	{ 0x1e, "LL_CLOCK_ACCURACY_RSP",    clock_acc_req_rsp,  1, true },
+	{ BT_LL_CIS_REQ, "LL_CIS_REQ",      cis_req,
+					sizeof(struct bt_ll_cis_req), true },
+	{ BT_LL_CIS_RSP, "LL_CIS_RSP",      cis_rsp,
+					sizeof(struct bt_ll_cis_rsp), true },
+	{ BT_LL_CIS_IND, "LL_CIS_IND",      cis_ind,
+					sizeof(struct bt_ll_cis_ind), true },
+	{ BT_LL_CIS_TERMINATE_IND, "LL_CIS_TERMINATE_IND", cis_term_ind,
+					sizeof(struct bt_ll_cis_term_ind),
+					true },
 	{ }
 };
 
-- 
2.21.0

