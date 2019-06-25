Return-Path: <SRS0=Xyfj=UY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31123C48BD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jun 2019 11:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020D9213F2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jun 2019 11:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="UIQ0psqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfFYLov (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:44:51 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:33277 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLov (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jun 2019 07:44:51 -0400
Received: by mail-lf1-f51.google.com with SMTP id y17so12413050lfe.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2019 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXqnctCaDBT7KDHm0GJYvDNs98NBHd1xln5kgDp/WbM=;
        b=UIQ0psqzQoM1bfBNQYyG6GT24fXnYv1K43/VGtleXhk4h3+KR59+Ln8gC5hQKZCOrV
         poDx2RMtgisesdnGwcIKB2lZodPXSSIvRLuX3ViM6D22aa+TrN/sxC9ceXU71wCCqcVV
         TRP6UB0C4zRwspYCKKIxeHhQX71xjgg7nvBoTif6lcQ0nN5o0mE4NKoAej5F2fC09M8S
         kSSuraK+i5uls8DX34gKbZwYPl2XsQS34OEojusBrdjHR332TcWF14fFmFjurV13AuoH
         5lqVg3GfgsyDzZxivsOR4W+UY+Dzq8w3bHL5oj6daB56QoI0XywiHqTXClUFPwZKULJW
         1Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXqnctCaDBT7KDHm0GJYvDNs98NBHd1xln5kgDp/WbM=;
        b=qQbSi/evgtrETQjgMejk5tuMN62Fr2cHykQQ8x/rcYQ1gDseAd10oPbmVaHfzL0t3B
         fmsFK4EvTjJr5kyg9hCenStlT6ZHo5uLrc+jz9QQEKz9ImuKdz1m3wb1Lt5rRH6TCcqS
         eTybIWGJy7ChW9LuN0zFbl0cPVPgMVCxwDRjTOzW87AP5jomq1Sf9Xcj2JgRqMAg73W0
         1EFO/TCN7bDSTx6cmw/MYjcv4hoqILPSITOjQiYFbl6cs+QqDk7GXnK+4k1MZ2NWl0CS
         WXZGP7j6eoAu+KECy7TZ7MNc2/QQoZ/+rh7vs3zn8TG886yNhrfJzSaSJhDkThkR0xEn
         fh/A==
X-Gm-Message-State: APjAAAX5PDdKgQr3S8qStaUbDNZrw/Zz5xIg/5Mp27E+n+uHKNHK3krQ
        SreU2DpTg6JeiwDjPHY25j50b62SYFw=
X-Google-Smtp-Source: APXvYqwr0mKCB0Vtl/oijIYM/OG9ynJjSfAYeIqm02UAMSuGFbGS+wWdKBiFFhiMmZpMJXQmoUgpMw==
X-Received: by 2002:a19:bec1:: with SMTP id o184mr48107483lff.86.1561463089334;
        Tue, 25 Jun 2019 04:44:49 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id l24sm2252119lji.78.2019.06.25.04.44.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:44:48 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v2] mesh: Honor IV Update flag in app layer crypto
Date:   Tue, 25 Jun 2019 13:44:45 +0200
Message-Id: <20190625114445.24898-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since IV Index is used in application nonces, we need to honor IV Update
flag not only in network layer crypto, but also in application layer.
Otherwise, we cannot decode application payloads from nodes that are in
IV Update state.
---
 mesh/net-keys.c |  6 ------
 mesh/net.c      | 20 +++++++++++---------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 25f4caeb7..5be7e0b58 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -209,12 +209,6 @@ static void decrypt_net_pkt(void *a, void *b)
 uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 					uint8_t **plain, size_t *plain_len)
 {
-	bool iv_flag = !!(iv_index & 1);
-	bool iv_pkt = !!(pkt[0] & 0x80);
-
-	if (iv_pkt != iv_flag)
-		iv_index--;
-
 	/* If we already successfully decrypted this packet, use cached data */
 	if (cache_id && cache_len == len && !memcmp(pkt, cache_pkt, len)) {
 		/* IV Index must match what was used to decrypt */
diff --git a/mesh/net.c b/mesh/net.c
index a597b8794..12971a179 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2489,8 +2489,16 @@ static void net_rx(void *net_ptr, void *user_data)
 	size_t out_size;
 	uint32_t key_id;
 	int8_t rssi = 0;
+	uint32_t iv_index;
+	bool iv_flag = !!(net->iv_index & 1);
+	bool iv_pkt = !!(data->data[0] & 0x80);
+
+	if (iv_pkt == iv_flag)
+		iv_index = net->iv_index;
+	else
+		iv_index = net->iv_index - 1;
 
-	key_id = net_key_decrypt(net->iv_index, data->data, data->len,
+	key_id = net_key_decrypt(iv_index, data->data, data->len,
 							&out, &out_size);
 
 	if (!key_id)
@@ -2504,16 +2512,10 @@ static void net_rx(void *net_ptr, void *user_data)
 		rssi = data->info->rssi;
 	}
 
-	relay_advice = packet_received(net, key_id, net->iv_index,
+	relay_advice = packet_received(net, key_id, iv_index,
 							out, out_size, rssi);
 	if (relay_advice > data->relay_advice) {
-		bool iv_flag = !!(net->iv_index & 1);
-		bool iv_pkt = !!(data->data[0] & 0x80);
-
-		data->iv_index = net->iv_index;
-		if (iv_pkt != iv_flag)
-			data->iv_index--;
-
+		data->iv_index = iv_index;
 		data->relay_advice = relay_advice;
 		data->key_id = key_id;
 		data->net = net;
-- 
2.19.1

