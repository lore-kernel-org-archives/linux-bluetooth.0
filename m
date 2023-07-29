Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA70FC001DE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 00:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjG2Arb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 20:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjG2Ara (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 20:47:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2744B1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so4865726e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1690591557; x=1691196357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQlKp1Eyp4oMP7RB5G+5J8r+sDCSBfQGnxxo3skLiWY=;
        b=Tf9StyjFhujGM5FdsYgysQgsH7vB6B3fUqpcyZ6Ao47+wHAX1vFdgfdwGJzuNYUDvM
         ieCw5uOaAKZ0/dnrx5wQtVOVSjEE+FjWJaB7K2OhuEHStMcEpRb1IV4EZ0JSm8kkvbcJ
         wI+KwWCqwLWcp5VIdUUFKtrdqUEbALC6+q05aVkqjVOPeeTrS+3oTKN/mWFKs6MUGG+M
         9UgyxWaQ69PCbGFpa9GdThuun9lNQRQdeuwFvxZLa2nlAH8UAxF54yiDhIJtOisIfRiQ
         3dy0m32Sey8ELBqNiK0woGNhNc06L/LeWyQOA1INWGnfF75ihms+oJnG2tHnUodNXNvM
         tSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591557; x=1691196357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQlKp1Eyp4oMP7RB5G+5J8r+sDCSBfQGnxxo3skLiWY=;
        b=VEJW+/JwDlUKtfWAGmaYsLx0pCT7Ohvqi/CWQVh7kcY8jyr84Ft/a/uc6wnuoWxSiw
         4qQuC9B9fWTmFUHQD1HAMP3R4TtgiGFs+y57t/Ms5935KcESlgS+sbFi6AI/Mn3lm768
         CjiI+cpG46YmdZqHvp71ObMddQf7iafqROv7ABBWrWU+BHuzfpuZVx5KlR+hs+0hJW/e
         KbGQvrfjte2cRmVlfstRSPWz/v69/6L9HZTqeZZGo5T9WdvLzEaVftYc+gklA8K3sD6a
         uhya23KjHAcoWuWhuoQJg6R+nL3ZuceKRy0bdPFaKxFOsyGNiaWm537GlKaxJHJpE9zF
         d+fg==
X-Gm-Message-State: ABy/qLYtVVLobQtOGyU71sfsuKnD1i3WX1UEJg6+CrJXZOHw/8k17unU
        QAQIRrNLTdgoytIS7jkyGfrZgA4tBPOhoOOXvCM=
X-Google-Smtp-Source: APBJJlHay+abB08M/bgsi2prkSMExCQ8nqkDIUUaokitXdT9aKEsfglnUbpHQDvBxHzqNQrwAla/0A==
X-Received: by 2002:ac2:5598:0:b0:4f8:6253:540 with SMTP id v24-20020ac25598000000b004f862530540mr1328000lfg.19.1690591556971;
        Fri, 28 Jul 2023 17:45:56 -0700 (PDT)
Received: from rymek.localdomain (217.96.255.138.ipv4.supernova.orange.pl. [217.96.255.138])
        by smtp.gmail.com with ESMTPSA id r25-20020ac24d19000000b004fe1f1c0ee4sm617746lfi.82.2023.07.28.17.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:45:56 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Subject: [PATCH BlueZ 3/5] monitor/ll: Add support for connection parameter command.
Date:   Sat, 29 Jul 2023 02:45:50 +0200
Message-Id: <20230729004552.1422547-4-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
References: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Szymon Czapracki <szymon.czapracki@codecoup.pl>

LL_CONNECTION_PARAM_REQ (0x0f)
  Interval min: 7.50 msec (0x0006)
  Interval max: 7.50 msec (0x0006)
  Latency: 0 (0x0000)
  Timeout: 5000 msec (0x01f4)
  Preffered periodicity: 0.00 (0x00)
  Reference connection event count: 4 (0x04)
  Offset 0: 0.00 msec (0x00)
  Offset 1: 0.00 msec (0x00)
  Offset 2: 1.25 msec (0x01)
  Offset 3: 0.00 msec (0x00)
  Offset 4: 2.50 msec (0x02)
  Offset 5: 0.00 msec (0x00)

LL_CONNECTION_PARAM_RSP (0x10)
  Interval min: 7.50 msec (0x0006)
  Interval max: 7.50 msec (0x0006)
  Latency: 0 (0x0000)
  Timeout: 5000 msec (0x01f4)
  Preffered periodicity: 0.00 (0x00)
  Reference connection event count: 4 (0x04)
  Offset 0: 318.75 msec (0xff)
  Offset 1: 318.75 msec (0xff)
  Offset 2: 318.75 msec (0xff)
  Offset 3: 318.75 msec (0xff)
  Offset 4: 318.75 msec (0xff)
  Offset 5: 318.75 msec (0xff)
---
 monitor/bt.h | 28 ++++++++++++++++++++++++
 monitor/ll.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index fcc5478bf..4482e6e2c 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -95,8 +95,36 @@ struct bt_ll_peripheral_feature_req {
 } __attribute__ ((packed));
 
 #define BT_LL_CONN_PARAM_REQ	0x0f
+struct bt_ll_conn_param_req {
+	uint16_t interval_min;
+	uint16_t interval_max;
+	uint16_t latency;
+	uint16_t timeout;
+	uint8_t pref_period;
+	uint16_t pref_conn_evt_count;
+	uint8_t offset_0;
+	uint8_t offset_1;
+	uint8_t offset_2;
+	uint8_t offset_3;
+	uint8_t offset_4;
+	uint8_t offset_5;
+} __attribute__ ((packed));
 
 #define BT_LL_CONN_PARAM_RSP	0x10
+struct bt_ll_conn_param_rsp {
+	uint16_t interval_min;
+	uint16_t interval_max;
+	uint16_t latency;
+	uint16_t timeout;
+	uint8_t pref_period;
+	uint16_t pref_conn_evt_count;
+	uint8_t offset_0;
+	uint8_t offset_1;
+	uint8_t offset_2;
+	uint8_t offset_3;
+	uint8_t offset_4;
+	uint8_t offset_5;
+} __attribute__ ((packed));
 
 #define BT_LL_REJECT_IND_EXT	0x11
 struct bt_ll_reject_ind_ext {
diff --git a/monitor/ll.c b/monitor/ll.c
index f588d5e99..feeb13e92 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -458,6 +458,64 @@ static void peripheral_feature_req(const void *data, uint8_t size)
 	packet_print_features_ll(pdu->features);
 }
 
+static void conn_param_req(const void *data, uint8_t size)
+{
+	const struct bt_ll_conn_param_req *pdu = data;
+
+	print_field("Interval min: %.2f msec (0x%4.4x)",
+				pdu->interval_min * 1.25, pdu->interval_min);
+	print_field("Interval max: %.2f msec (0x%4.4x)",
+				pdu->interval_max * 1.25, pdu->interval_max);
+	print_field("Latency: %d (0x%4.4x)", pdu->latency, pdu->latency);
+	print_field("Timeout: %d msec (0x%4.4x)", pdu->timeout * 10,
+								pdu->timeout);
+	print_field("Preffered periodicity: %.2f (0x%2.2x)",
+				pdu->pref_period * 1.25, pdu->pref_period);
+	print_field("Reference connection event count: %d (0x%2.2x)",
+			pdu->pref_conn_evt_count, pdu->pref_conn_evt_count);
+	print_field("Offset 0: %.2f msec (0x%2.2x)", pdu->offset_0 * 1.25,
+								pdu->offset_0);
+	print_field("Offset 1: %.2f msec (0x%2.2x)", pdu->offset_1 * 1.25,
+								pdu->offset_1);
+	print_field("Offset 2: %.2f msec (0x%2.2x)", pdu->offset_2 * 1.25,
+								pdu->offset_2);
+	print_field("Offset 3: %.2f msec (0x%2.2x)", pdu->offset_3 * 1.25,
+								pdu->offset_3);
+	print_field("Offset 4: %.2f msec (0x%2.2x)", pdu->offset_4 * 1.25,
+								pdu->offset_4);
+	print_field("Offset 5: %.2f msec (0x%2.2x)", pdu->offset_5 * 1.25,
+								pdu->offset_5);
+}
+
+static void conn_param_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_conn_param_rsp *pdu = data;
+
+	print_field("Interval min: %.2f msec (0x%4.4x)",
+				pdu->interval_min * 1.25, pdu->interval_min);
+	print_field("Interval max: %.2f msec (0x%4.4x)",
+				pdu->interval_max * 1.25, pdu->interval_max);
+	print_field("Latency: %d (0x%4.4x)", pdu->latency, pdu->latency);
+	print_field("Timeout: %d msec (0x%4.4x)", pdu->timeout * 10,
+								pdu->timeout);
+	print_field("Preffered periodicity: %.2f (0x%2.2x)",
+				pdu->pref_period * 1.25, pdu->pref_period);
+	print_field("Reference connection event count: %d (0x%2.2x)",
+			pdu->pref_conn_evt_count, pdu->pref_conn_evt_count);
+	print_field("Offset 0: %.2f msec (0x%2.2x)", pdu->offset_0 * 1.25,
+								pdu->offset_0);
+	print_field("Offset 1: %.2f msec (0x%2.2x)", pdu->offset_1 * 1.25,
+								pdu->offset_1);
+	print_field("Offset 2: %.2f msec (0x%2.2x)", pdu->offset_2 * 1.25,
+								pdu->offset_2);
+	print_field("Offset 3: %.2f msec (0x%2.2x)", pdu->offset_3 * 1.25,
+								pdu->offset_3);
+	print_field("Offset 4: %.2f msec (0x%2.2x)", pdu->offset_4 * 1.25,
+								pdu->offset_4);
+	print_field("Offset 5: %.2f msec (0x%2.2x)", pdu->offset_5 * 1.25,
+								pdu->offset_5);
+}
+
 static void reject_ind_ext(const void *data, uint8_t size)
 {
 	const struct bt_ll_reject_ind_ext *pdu = data;
@@ -707,8 +765,8 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x0c, "LL_VERSION_IND",           version_ind,        5, true },
 	{ 0x0d, "LL_REJECT_IND",            reject_ind,         1, true },
 	{ 0x0e, "LL_PERIPHERAL_FEATURE_REQ", peripheral_feature_req, 8, true },
-	{ 0x0f, "LL_CONNECTION_PARAM_REQ",  NULL,              23, true },
-	{ 0x10, "LL_CONNECTION_PARAM_RSP",  NULL,              23, true },
+	{ 0x0f, "LL_CONNECTION_PARAM_REQ",  conn_param_req,    23, true },
+	{ 0x10, "LL_CONNECTION_PARAM_RSP",  conn_param_rsp,    23, true },
 	{ 0x11, "LL_REJECT_IND_EXT",        reject_ind_ext,     2, true },
 	{ 0x12, "LL_PING_REQ",              null_pdu,           0, true },
 	{ 0x13, "LL_PING_RSP",              null_pdu,           0, true },
-- 
2.34.1

