Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE40C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A04B610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhHMMUr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhHMMUq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:46 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9F5C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:19 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id u16-20020a05622a14d0b029028ca201eab9so6239504qtx.21
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L48m3nLyvQigWfaVCrVf871Bd1U78w7zQysvResPXY8=;
        b=Fx2OYEp6XQssbI47sD7z8sr5dVSTUiVvMyvXJfmgS1ye3h+sj8ta8n1u6JTHfFIeMc
         4BJIfnI/HBfzFizB91UWj4JcpybBSheEka32ixMyLkxa+9mMXiOaAyC+o8VYP2Ppnhts
         jgwSJ7503jlslMrkJufVSv71vbRg75F0HUMAtY0UpLb/KCaB4hMKeodaA79iAFMr3Aro
         bAqqHplLTMzhjYO8NVnBhSzhnfNsTNoRRXMfA9PUIchODD5OwWRDqBJG29HsFWvWiMGh
         tSUnq7anQTzWbECK34G1YSYwzs9skIekEjiQCq1pl63LnqAE51a4QN0DXCgth0h6WikX
         hPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L48m3nLyvQigWfaVCrVf871Bd1U78w7zQysvResPXY8=;
        b=fLY5DJa1y+64wsNLVThhGJl+aYs9nHFD7TCPGvPiEPljfYUIg931W3pFU5GcOCOdbb
         gcIQ6kIkmnJ1RjHS4iapVTmFSYs23ksBL7lpOp74wQ1wxtAVyXx163p04bj9DmHRTI52
         oh1PFiXoA6Dq+tOAqujuBsMLVWcPwo/+ZJy4tr1kNRU5M9QpKvtaLiLWwVkDkUcSfrAP
         HlnrokdcNVDMhcujxXn5/YhhFtjBOBKrqKzUVjhuLiXfuOfa8AwqK6MBA369Ge0bJONK
         OcnAp1O2oHycSBqoK7ddW+3GSCx0MaHBBVlT/TI5HERsgQHJ7CXjorR2scHuybNGe5Ug
         RcrA==
X-Gm-Message-State: AOAM533uZwPANFTfiNYe0HAi4VUqP1PV7J2lMNjYVMtWNI7tcvNXIYk/
        39W1/74Po/fs9i5V4S36HevJIbmZ02KNS6yXdiKzObOJWLiXhFou0xfoFGtnJeL19m+hiPd5fAJ
        Y30q8hsqnr0+Bwn/qPPcwO/Der2vRjLKnToYUtSGP18WPPP8XQ92V98qnNevnUDVdEdS/WYH+ln
        nv
X-Google-Smtp-Source: ABdhPJyNTFYkORHZWw6LNCPSWk8oVB90D9OlVviK3YOLZCe8n/kS3kypT+GShMLnSBZigFcMAKcvcYWayae0
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:285:: with SMTP id
 l5mr2346032qvv.24.1628857219106; Fri, 13 Aug 2021 05:20:19 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:57 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.12.Iaa507a7e5c90b0ded462cac1363fce9ea916214e@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 12/62] monitor: Inclusive language in struct member
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

 emulator/btdev.c | 34 +++++++++----------
 monitor/bt.h     | 88 ++++++++++++++++++++++++------------------------
 monitor/ll.c     | 32 +++++++++---------
 monitor/packet.c | 64 +++++++++++++++++------------------
 4 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c9ec22ebe5..159ebe6ec5 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5280,24 +5280,24 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		struct btdev *remote = conn->link->dev;
 
 		/* TODO: Figure out if these values makes sense */
-		memcpy(evt.cig_sync_delay, remote->le_cig.params.m_interval,
-				sizeof(remote->le_cig.params.m_interval));
-		memcpy(evt.cis_sync_delay, remote->le_cig.params.s_interval,
-				sizeof(remote->le_cig.params.s_interval));
-		memcpy(evt.m_latency, &remote->le_cig.params.m_latency,
-				sizeof(remote->le_cig.params.m_latency));
-		memcpy(evt.s_latency, &remote->le_cig.params.s_latency,
-				sizeof(remote->le_cig.params.s_latency));
-		evt.m_phy = remote->le_cig.cis[0].m_phy;
-		evt.s_phy = remote->le_cig.cis[0].s_phy;
+		memcpy(evt.cig_sync_delay, remote->le_cig.params.c_interval,
+				sizeof(remote->le_cig.params.c_interval));
+		memcpy(evt.cis_sync_delay, remote->le_cig.params.p_interval,
+				sizeof(remote->le_cig.params.p_interval));
+		memcpy(evt.c_latency, &remote->le_cig.params.c_latency,
+				sizeof(remote->le_cig.params.c_latency));
+		memcpy(evt.p_latency, &remote->le_cig.params.p_latency,
+				sizeof(remote->le_cig.params.p_latency));
+		evt.c_phy = remote->le_cig.cis[0].c_phy;
+		evt.p_phy = remote->le_cig.cis[0].p_phy;
 		evt.nse = 0x01;
-		evt.m_bn = 0x01;
-		evt.s_bn = 0x01;
-		evt.m_ft = 0x01;
-		evt.s_ft = 0x01;
-		evt.m_mtu = remote->le_cig.cis[0].m_sdu;
-		evt.s_mtu = remote->le_cig.cis[0].s_sdu;
-		evt.interval = remote->le_cig.params.m_latency;
+		evt.c_bn = 0x01;
+		evt.p_bn = 0x01;
+		evt.c_ft = 0x01;
+		evt.p_ft = 0x01;
+		evt.c_mtu = remote->le_cig.cis[0].c_sdu;
+		evt.p_mtu = remote->le_cig.cis[0].p_sdu;
+		evt.interval = remote->le_cig.params.c_latency;
 	}
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
diff --git a/monitor/bt.h b/monitor/bt.h
index 738bc294b2..cde68d4802 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -127,8 +127,8 @@ struct bt_ll_phy {
 
 #define BT_LL_PHY_UPDATE_IND	0x18
 struct bt_ll_phy_update_ind {
-	uint8_t  m_phy;
-	uint8_t  s_phy;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
 	uint16_t instant;
 } __attribute__ ((packed));
 
@@ -168,19 +168,19 @@ struct bt_ll_clock_acc {
 struct bt_ll_cis_req {
 	uint8_t  cig;
 	uint8_t  cis;
-	uint8_t  m_phy;
-	uint8_t  s_phy;
-	uint16_t m_sdu;
-	uint16_t s_sdu;
-	uint8_t  m_interval[3];
-	uint8_t  s_interval[3];
-	uint8_t  m_pdu;
-	uint8_t  s_pdu;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
+	uint8_t  c_pdu;
+	uint8_t  p_pdu;
 	uint8_t  nse;
 	uint8_t  sub_interval[3];
 	uint8_t  bn;
-	uint8_t  m_ft;
-	uint8_t  s_ft;
+	uint8_t  c_ft;
+	uint8_t  p_ft;
 	uint16_t iso_interval;
 	uint8_t  offset_min[3];
 	uint8_t  offset_max[3];
@@ -2646,23 +2646,23 @@ struct bt_hci_rsp_le_read_iso_tx_sync {
 #define BT_HCI_BIT_LE_SET_CIG_PARAMS		BT_HCI_CMD_BIT(41, 7)
 struct bt_hci_cis_params {
 	uint8_t  cis_id;
-	uint16_t m_sdu;
-	uint16_t s_sdu;
-	uint8_t  m_phy;
-	uint8_t  s_phy;
-	uint8_t  m_rtn;
-	uint8_t  s_rtn;
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint8_t  c_rtn;
+	uint8_t  p_rtn;
 } __attribute__ ((packed));
 
 struct bt_hci_cmd_le_set_cig_params {
 	uint8_t  cig_id;
-	uint8_t  m_interval[3];
-	uint8_t  s_interval[3];
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
 	uint8_t  sca;
 	uint8_t  packing;
 	uint8_t  framing;
-	uint16_t m_latency;
-	uint16_t s_latency;
+	uint16_t c_latency;
+	uint16_t p_latency;
 	uint8_t  num_cis;
 	struct bt_hci_cis_params cis[0];
 } __attribute__ ((packed));
@@ -2679,22 +2679,22 @@ struct bt_hci_rsp_le_set_cig_params {
 struct bt_hci_cis_params_test {
 	uint8_t  cis_id;
 	uint8_t  nse;
-	uint16_t m_sdu;
-	uint16_t s_sdu;
-	uint8_t  m_pdu;
-	uint8_t  s_pdu;
-	uint8_t  m_phy;
-	uint8_t  s_phy;
-	uint8_t  m_bn;
-	uint8_t  s_bn;
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint8_t  c_pdu;
+	uint8_t  p_pdu;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint8_t  c_bn;
+	uint8_t  p_bn;
 } __attribute__ ((packed));
 
 struct bt_hci_cmd_le_set_cig_params_test {
 	uint8_t  cig_id;
-	uint8_t  m_interval[3];
-	uint8_t  s_interval[3];
-	uint8_t  m_ft;
-	uint8_t  s_ft;
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
+	uint8_t  c_ft;
+	uint8_t  p_ft;
 	uint16_t iso_interval;
 	uint8_t  sca;
 	uint8_t  packing;
@@ -3571,17 +3571,17 @@ struct bt_hci_evt_le_cis_established {
 	uint16_t conn_handle;
 	uint8_t  cig_sync_delay[3];
 	uint8_t  cis_sync_delay[3];
-	uint8_t  m_latency[3];
-	uint8_t  s_latency[3];
-	uint8_t  m_phy;
-	uint8_t  s_phy;
+	uint8_t  c_latency[3];
+	uint8_t  p_latency[3];
+	uint8_t  c_phy;
+	uint8_t  p_phy;
 	uint8_t  nse;
-	uint8_t  m_bn;
-	uint8_t  s_bn;
-	uint8_t  m_ft;
-	uint8_t  s_ft;
-	uint16_t m_mtu;
-	uint16_t s_mtu;
+	uint8_t  c_bn;
+	uint8_t  p_bn;
+	uint8_t  c_ft;
+	uint8_t  p_ft;
+	uint16_t c_mtu;
+	uint16_t p_mtu;
 	uint16_t interval;
 } __attribute__ ((packed));
 
diff --git a/monitor/ll.c b/monitor/ll.c
index cf93647e03..d1023c8a3e 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -505,16 +505,16 @@ static void phy_update_ind(const void *data, uint8_t size)
 	const struct bt_ll_phy_update_ind *pdu = data;
 	uint8_t mask;
 
-	print_field("M_TO_S_PHY: 0x%2.2x", pdu->m_phy);
+	print_field("M_TO_S_PHY: 0x%2.2x", pdu->c_phy);
 
-	mask = print_bitfield(2, pdu->m_phy, le_phys);
+	mask = print_bitfield(2, pdu->c_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("S_TO_M_PHY: 0x%2.2x", pdu->s_phy);
+	print_field("S_TO_M_PHY: 0x%2.2x", pdu->p_phy);
 
-	mask = print_bitfield(2, pdu->s_phy, le_phys);
+	mask = print_bitfield(2, pdu->p_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
@@ -596,38 +596,38 @@ static void cis_req(const void *data, uint8_t size)
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig);
 	print_field("CIS ID: 0x%2.2x", cmd->cis);
-	print_field("Master to Slave PHY: 0x%2.2x", cmd->m_phy);
+	print_field("Master to Slave PHY: 0x%2.2x", cmd->c_phy);
 
-	mask = print_bitfield(2, cmd->m_phy, le_phys);
+	mask = print_bitfield(2, cmd->c_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("Slave To Master PHY: 0x%2.2x", cmd->s_phy);
+	print_field("Slave To Master PHY: 0x%2.2x", cmd->p_phy);
 
-	mask = print_bitfield(2, cmd->s_phy, le_phys);
+	mask = print_bitfield(2, cmd->p_phy, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("Master to Slave Maximum SDU: %u", cmd->m_sdu);
-	print_field("Slave to Master Maximum SDU: %u", cmd->s_sdu);
+	print_field("Master to Slave Maximum SDU: %u", cmd->c_sdu);
+	print_field("Slave to Master Maximum SDU: %u", cmd->p_sdu);
 
-	memcpy(&interval, cmd->m_interval, sizeof(cmd->m_interval));
+	memcpy(&interval, cmd->c_interval, sizeof(cmd->c_interval));
 	print_field("Master to Slave Interval: 0x%6.6x", le32_to_cpu(interval));
-	memcpy(&interval, cmd->s_interval, sizeof(cmd->s_interval));
+	memcpy(&interval, cmd->p_interval, sizeof(cmd->p_interval));
 	print_field("Slave to Master Interval: 0x%6.6x", le32_to_cpu(interval));
 
-	print_field("Master to Slave Maximum PDU: %u", cmd->m_pdu);
-	print_field("Slave to Master Maximum PDU: %u", cmd->s_pdu);
+	print_field("Master to Slave Maximum PDU: %u", cmd->c_pdu);
+	print_field("Slave to Master Maximum PDU: %u", cmd->p_pdu);
 
 	print_field("Burst Number: %u us", cmd->bn);
 
 	memcpy(&interval, cmd->sub_interval, sizeof(cmd->sub_interval));
 	print_field("Sub-Interval: 0x%6.6x", le32_to_cpu(interval));
 
-	print_field("Master to Slave Flush Timeout: %u", cmd->m_ft);
-	print_field("Slave to Master Flush Timeout: %u", cmd->s_ft);
+	print_field("Master to Slave Flush Timeout: %u", cmd->c_ft);
+	print_field("Slave to Master Flush Timeout: %u", cmd->p_ft);
 
 	print_field("ISO Interval: 0x%4.4x", le16_to_cpu(cmd->iso_interval));
 
diff --git a/monitor/packet.c b/monitor/packet.c
index 025b7e9b00..b6c7fe7234 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8024,15 +8024,15 @@ static void print_cis_params(const void *data, int i)
 
 	print_field("CIS ID: 0x%2.2x", cis->cis_id);
 	print_field("Master to Slave Maximum SDU Size: %u",
-						le16_to_cpu(cis->m_sdu));
+						le16_to_cpu(cis->c_sdu));
 	print_field("Slave to Master Maximum SDU Size: %u",
-						le16_to_cpu(cis->s_sdu));
-	print_le_phy("Master to Slave PHY", cis->m_phy);
-	print_le_phy("Slave to Master PHY", cis->s_phy);
+						le16_to_cpu(cis->p_sdu));
+	print_le_phy("Master to Slave PHY", cis->c_phy);
+	print_le_phy("Slave to Master PHY", cis->p_phy);
 	print_field("Master to Slave Retransmission attempts: 0x%2.2x",
-							cis->m_rtn);
+							cis->c_rtn);
 	print_field("Slave to Master Retransmission attempts: 0x%2.2x",
-							cis->s_rtn);
+							cis->p_rtn);
 }
 
 static void le_set_cig_params_cmd(const void *data, uint8_t size)
@@ -8040,15 +8040,15 @@ static void le_set_cig_params_cmd(const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_cig_params *cmd = data;
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
-	print_usec_interval("Master to Slave SDU Interval", cmd->m_interval);
-	print_usec_interval("Slave to Master SDU Interval", cmd->s_interval);
+	print_usec_interval("Master to Slave SDU Interval", cmd->c_interval);
+	print_usec_interval("Slave to Master SDU Interval", cmd->p_interval);
 	print_sca(cmd->sca);
 	print_packing(cmd->packing);
 	print_framing(cmd->framing);
 	print_field("Master to Slave Maximum Latency: %d ms (0x%4.4x)",
-		le16_to_cpu(cmd->m_latency), le16_to_cpu(cmd->m_latency));
+		le16_to_cpu(cmd->c_latency), le16_to_cpu(cmd->c_latency));
 	print_field("Slave to Master Maximum Latency: %d ms (0x%4.4x)",
-		le16_to_cpu(cmd->s_latency), le16_to_cpu(cmd->s_latency));
+		le16_to_cpu(cmd->p_latency), le16_to_cpu(cmd->p_latency));
 	print_field("Number of CIS: %u", cmd->num_cis);
 
 	size -= sizeof(*cmd);
@@ -8063,16 +8063,16 @@ static void print_cis_params_test(const void *data, int i)
 
 	print_field("CIS ID: 0x%2.2x", cis->cis_id);
 	print_field("NSE: 0x%2.2x", cis->nse);
-	print_field("Master to Slave Maximum SDU: 0x%4.4x", cis->m_sdu);
+	print_field("Master to Slave Maximum SDU: 0x%4.4x", cis->c_sdu);
 	print_field("Slave to Master Maximum SDU: 0x%4.4x",
-						le16_to_cpu(cis->s_sdu));
+						le16_to_cpu(cis->p_sdu));
 	print_field("Master to Slave Maximum PDU: 0x%2.2x",
-						le16_to_cpu(cis->m_pdu));
-	print_field("Slave to Master Maximum PDU: 0x%2.2x", cis->s_pdu);
-	print_le_phy("Master to Slave PHY", cis->m_phy);
-	print_le_phy("Slave to Master PHY", cis->s_phy);
-	print_field("Master to Slave Burst Number: 0x%2.2x", cis->m_bn);
-	print_field("Slave to Master Burst Number: 0x%2.2x", cis->s_bn);
+						le16_to_cpu(cis->c_pdu));
+	print_field("Slave to Master Maximum PDU: 0x%2.2x", cis->p_pdu);
+	print_le_phy("Master to Slave PHY", cis->c_phy);
+	print_le_phy("Slave to Master PHY", cis->p_phy);
+	print_field("Master to Slave Burst Number: 0x%2.2x", cis->c_bn);
+	print_field("Slave to Master Burst Number: 0x%2.2x", cis->p_bn);
 }
 
 static void le_set_cig_params_test_cmd(const void *data, uint8_t size)
@@ -8080,10 +8080,10 @@ static void le_set_cig_params_test_cmd(const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_cig_params_test *cmd = data;
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
-	print_usec_interval("Master to Slave SDU Interval", cmd->m_interval);
-	print_usec_interval("Master to Slave SDU Interval", cmd->s_interval);
-	print_field("Master to Slave Flush Timeout: 0x%2.2x", cmd->m_ft);
-	print_field("Slave to Master Flush Timeout: 0x%2.2x", cmd->s_ft);
+	print_usec_interval("Master to Slave SDU Interval", cmd->c_interval);
+	print_usec_interval("Master to Slave SDU Interval", cmd->p_interval);
+	print_field("Master to Slave Flush Timeout: 0x%2.2x", cmd->c_ft);
+	print_field("Slave to Master Flush Timeout: 0x%2.2x", cmd->p_ft);
 	print_field("ISO Interval: %.2f ms (0x%4.4x)",
 				le16_to_cpu(cmd->iso_interval) * 1.25,
 				le16_to_cpu(cmd->iso_interval));
@@ -10775,17 +10775,17 @@ static void le_cis_established_evt(const void *data, uint8_t size)
 	print_field("Connection Handle: %d", le16_to_cpu(evt->conn_handle));
 	print_usec_interval("CIG Synchronization Delay", evt->cig_sync_delay);
 	print_usec_interval("CIS Synchronization Delay", evt->cis_sync_delay);
-	print_usec_interval("Master to Slave Latency", evt->m_latency);
-	print_usec_interval("Slave to Master Latency", evt->s_latency);
-	print_le_phy("Master to Slave PHY", evt->m_phy);
-	print_le_phy("Slave to Master PHY", evt->s_phy);
+	print_usec_interval("Master to Slave Latency", evt->c_latency);
+	print_usec_interval("Slave to Master Latency", evt->p_latency);
+	print_le_phy("Master to Slave PHY", evt->c_phy);
+	print_le_phy("Slave to Master PHY", evt->p_phy);
 	print_field("Number of Subevents: %u", evt->nse);
-	print_field("Master to Slave Burst Number: %u", evt->m_bn);
-	print_field("Slave to Master Burst Number: %u", evt->s_bn);
-	print_field("Master to Slave Flush Timeout: %u", evt->m_ft);
-	print_field("Slave to Master Flush Timeout: %u", evt->s_ft);
-	print_field("Master to Slave MTU: %u", le16_to_cpu(evt->m_mtu));
-	print_field("Slave to Master MTU: %u", le16_to_cpu(evt->s_mtu));
+	print_field("Master to Slave Burst Number: %u", evt->c_bn);
+	print_field("Slave to Master Burst Number: %u", evt->p_bn);
+	print_field("Master to Slave Flush Timeout: %u", evt->c_ft);
+	print_field("Slave to Master Flush Timeout: %u", evt->p_ft);
+	print_field("Master to Slave MTU: %u", le16_to_cpu(evt->c_mtu));
+	print_field("Slave to Master MTU: %u", le16_to_cpu(evt->p_mtu));
 	print_field("ISO Interval: %u", le16_to_cpu(evt->interval));
 }
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

