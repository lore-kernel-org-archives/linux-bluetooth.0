Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DD0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Apr 2022 02:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiDECZA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 22:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiDECY7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 22:24:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107311DB8B2
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 18:19:47 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z19so9322945qtw.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Apr 2022 18:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BK/L2Cu+9Ne/PHhGz9BJEq/JD01g/TerpoLSZnxVAGM=;
        b=qlHIefOcqZuA5wLGg5B7TaCgmFhcAsNRL8AWK+wBu9DtlHZYdEhd3Hg/UM2+z1fLAp
         RvQnA90zR8zZGiVD2ycFr6Jr+wIKvzv0fEaWm0E0UlM1L0USbXb2IaRfdhGGFKnEfeVC
         JHDgKbIO9z0p2RG0KOG2TdC2YSrIkV6T76w84AQBo985hEmWABxnGRirscarHJKV4UND
         BRccCjGYYeISE2d2/5zNtKHLoKh+teEgUXtCirpfyJTq6n4e4Wvq8wYN75IbOhMbnfUT
         emnEhvcE54O/N7fDHk1YJJ89b51HWbadDJ8/Qvj9CvcTJ3mird5t/B2n6BA8UzvysWC2
         S18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BK/L2Cu+9Ne/PHhGz9BJEq/JD01g/TerpoLSZnxVAGM=;
        b=GIXMn6Yat2BS6x9c2FoKkFKvYU4bJq9PaYl7ESdrY1jtD/Q8PrHQMLqyCl4J04CeGP
         doS+Oer0cjVnBaWGa8RB9RIs9nVe+/EUoRhGJ/MLytL+5XMIcF3+0035lwOH+jyNDbFO
         N92PvvaTOBaq8qLCWW7aR5b7BcBZBRaYyNuTvUMnQG9nsDLtQawAItFPD4p9iYUY2BU/
         KKW9XPYfAYXYm00AnU4ZZXzkgYVw5NKf+QaBVWxd0vTW7rPlY9JoJQKauhIxuCn+JImE
         Z+fOhUSymJluSSh44dhysbvki+lVUf5LTbq7BTmG+obL+V7I2I2HZ6GAX0KUft9WWVBd
         dWrQ==
X-Gm-Message-State: AOAM530EnB5havD70SxO567CJ7JXrToLZzMR/vh8PUenslad6UfHKQHM
        wpA1N4ibl+odgEBEv0JkMka3zYpR4CY=
X-Google-Smtp-Source: ABdhPJwllxrRRwNLWMCca/+IP+2MgsjujBO8dxh93iJD7Uqit963EPqolbRJ6xrggu5mKrIcOhrkbA==
X-Received: by 2002:a05:6638:d0b:b0:321:6296:340d with SMTP id q11-20020a0566380d0b00b003216296340dmr585922jaj.3.1649119335072;
        Mon, 04 Apr 2022 17:42:15 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v9-20020a92c809000000b002ca351aa12fsm3266020iln.70.2022.04.04.17.42.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 17:42:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor: Add support for LE BIG Info Adverting Report
Date:   Mon,  4 Apr 2022 17:42:12 -0700
Message-Id: <20220405004213.1164595-1-luiz.dentz@gmail.com>
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
index 1f04063d3..6ef2fba3b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10887,6 +10887,25 @@ static void le_req_sca_complete_evt(const void *data, uint8_t size)
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
@@ -11005,6 +11024,10 @@ static const struct subevent_data le_meta_event_table[] = {
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

