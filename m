Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D1AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 21:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiDFVt1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiDFVsu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 17:48:50 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6208513CCEA
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 14:33:57 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e22so4566568ioe.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Apr 2022 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzekHFUq7wdvG+NgGO9dzUSt4G1nBy7NKbCXKP0d0kc=;
        b=ab75Q53fp8jMf/cAqTk+lzFiYARXjsHVPNgs7pH/AisSYXmOgi80yNroFAMRmLqS1/
         kuxxpvJfDPRNpq/QE5cf5hDaisYT4CU7jaU2VbCZS1CQlnwuVn56fow0bY/x5M0l14h8
         /mvTBotGSN5TufkE4sHGXheffUXcRR5NYt8BtH0UsZqVerY8rJOF7hHvpl+zcaLxCedM
         usunMmcxGSJuZuhy+6wG3MG8obnwj/iUh97aZTJGExl44T6PngbpYDvc5pvWQL5ecYkk
         XElLA515RLQV+2j1WaGY7xhh6jHQPPQ2ZXrCzafcB0w+Cpxx7Zjdfz8ZGb9JSyW1hGgd
         +Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzekHFUq7wdvG+NgGO9dzUSt4G1nBy7NKbCXKP0d0kc=;
        b=0wSrwHmQc6TEOMpTG6L8JquGraFlHlwYLludVdvJnnMOQlplq9hDcDthr6u9dop7O8
         O6EXWh0RlLFu6bouiG7oO67X3t8KOmvoIR/RFkm2FT6UxR4gq98c+lmywlZE15q5lLjQ
         gqXn1cp2vKUsfn+u7VWWwxLn/Crli3TEkq6XurRE41RE82J87Fu+wNMBAabozhSoGOkg
         BUWgvPvPm/JWoA58kQemchHPzzIoOUC8YoyWcmWVGILDEQEC7W636kMJezRtvMRKYjy7
         79NGCah9JkMO+46YslA+OWo5p8WJT/fW+ZvOoQE1B+3ztsO0ieUDJnCKwU8fb2If8ebS
         fmtw==
X-Gm-Message-State: AOAM531xzGjSIPU+kPobyif+m+gggF2tde8rTXgFnd3mSsEjki5cucGL
        QwxLG0XqgEtc7nN5UdzxKhKE/qjqvnw=
X-Google-Smtp-Source: ABdhPJxAN1fYVlADU257YD3INKtTlZoEWnuH80U910jDniczPd2n8e6KU0Fne17Y8DKvUx46iT9avA==
X-Received: by 2002:a05:6602:2bc4:b0:645:eb96:6495 with SMTP id s4-20020a0566022bc400b00645eb966495mr5031607iov.166.1649280837109;
        Wed, 06 Apr 2022 14:33:57 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v12-20020a92cd4c000000b002ca50ef78e4sm4726322ilq.62.2022.04.06.14.33.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:33:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] monitor: Add support for LE BIG Info Adverting Report
Date:   Wed,  6 Apr 2022 14:33:53 -0700
Message-Id: <20220406213355.1918220-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for LE BIG Info Advertising Report.
---
 monitor/bt.h     | 17 +++++++++++++++++
 monitor/packet.c | 23 +++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 704c70fba..e9f72de36 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3653,6 +3653,23 @@ struct bt_hci_evt_le_req_peer_sca_complete {
 	uint8_t  sca;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_BIG_INFO_ADV_REPORT	0x22
+struct bt_hci_evt_le_big_info_adv_report {
+	uint16_t sync_handle;
+	uint8_t  num_bis;
+	uint8_t  nse;
+	uint16_t iso_interval;
+	uint8_t  bn;
+	uint8_t  pto;
+	uint8_t  irc;
+	uint16_t max_pdu;
+	uint8_t  sdu_interval[3];
+	uint16_t max_sdu;
+	uint8_t  phy;
+	uint8_t  framing;
+	uint8_t  encryption;
+} __attribute__ ((packed));
+
 #define BT_HCI_ERR_SUCCESS			0x00
 #define BT_HCI_ERR_UNKNOWN_COMMAND		0x01
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
diff --git a/monitor/packet.c b/monitor/packet.c
index b7431b57d..775b4276e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10886,6 +10886,25 @@ static void le_req_sca_complete_evt(const void *data, uint8_t size)
 	print_sca(evt->sca);
 }
 
+static void le_big_info_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_big_info_adv_report *evt = data;
+
+	print_field("Sync Handle: 0x%4.4x", evt->sync_handle);
+	print_field("Number BIS: %u", evt->num_bis);
+	print_field("NSE: %u", evt->nse);
+	print_slot_125("ISO Interval", evt->iso_interval);
+	print_field("BN: %u", evt->bn);
+	print_field("PTO: %u", evt->bn);
+	print_field("IRC: %u", evt->irc);
+	print_field("Maximum PDU: %u", evt->max_pdu);
+	print_usec_interval("SDU Interval", evt->sdu_interval);
+	print_field("Maximum SDU: %u", evt->max_sdu);
+	print_le_phy("PHY", evt->phy);
+	print_framing(evt->framing);
+	print_field("Encryption: 0x%02x", evt->encryption);
+}
+
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
@@ -11004,6 +11023,10 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_req_sca_complete_evt,
 				sizeof(
 				struct bt_hci_evt_le_req_peer_sca_complete)},
+	{ BT_HCI_EVT_LE_BIG_INFO_ADV_REPORT,
+		"LE Broadcast Isochronous Group Info Advertising Report",
+		le_big_info_evt,
+		sizeof(struct bt_hci_evt_le_big_info_adv_report) },
 	{ }
 };
 
-- 
2.35.1

