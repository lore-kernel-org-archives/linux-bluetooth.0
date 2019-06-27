Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573E6C48BD6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 07:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E33420843
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 07:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="apClMFJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfF0Hkv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:40:51 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:44981 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfF0Hkv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 03:40:51 -0400
Received: by mail-lf1-f49.google.com with SMTP id r15so835750lfm.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2019 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNAmi+o5V6h8qnJ6s87eaDxS9Jq3v3/7EW5K6PDYm4M=;
        b=apClMFJ/JYCPOLf858Xd2jAYmaMecIQbeXT4g5SWs/Q1NNZO8ow5pbz8mEZWM7RvJi
         iBX5wS+1te8v4UtJ9rm/yF9UmaMRyIq+nJaG92EY91DhhyKmrNfRGHDS5udiJYNytrg4
         TeKL9G8P/Jcuz8Q5JUpLujeev+fNGefAltcvxloE0J1+BDKN3lA2mz101xF6zjkQcqg/
         Dh+AFP+757Mx3V9Yx/V4A9JDbq97IKypS0A8JeCQ5nnVXMILe3hU1NN+VLzN2vmzwyGN
         zZBwt3Yp4yUud2VDBev4YOu3Gra2jfuiwTy+SBkpzCBqBvLWQa3rhHQn26Oo7kqVoZ8q
         ufMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNAmi+o5V6h8qnJ6s87eaDxS9Jq3v3/7EW5K6PDYm4M=;
        b=hgkWp5TyLd/X4T254XsNJXG7Z60x/bSkU5WFLmLwTJhFbmnrNeUptZ+qD3d7XmTLwq
         esM2GVNomy2UXCaRb993tDWcKLVSVAd7oIr8erW8xoQoX2HXkcd+v1QV4b7ZKnfY2r4f
         BMxrMl0MnoDjwpO/w6vHIqpnNcN8/mov8VdSwqWhlExS8oKTeSOEk4GSLCblvuFgxgVr
         9S/xRKzvIUXS2jjfx8RpTqygaN0Yzi3JZ+CgxTtlqkgMxSjn0o/2+A0vRC7XmMseBN+4
         m5WZ0HiCe0NIFX8KNVRqTjUNoxLAnNfbBp1A91WXYTh76eQEg6VivXTRmx/3ZChZ5kMI
         EgDA==
X-Gm-Message-State: APjAAAVO7/RghuFXdHfBrUKWafnbsowDl3cEJf6r2Ubm7/NITYSiVK6H
        6EEtm6Lj4r8JQFGbgvt6sQdxDbJle2o=
X-Google-Smtp-Source: APXvYqx9x1/GvO7q+BC4b/WqZ0e7Vhon3PpcC76Yh0JKw2i20KNgXdW2q+Ef9hL/UP7h4p2dNrnVKQ==
X-Received: by 2002:a19:c503:: with SMTP id w3mr1155972lfe.139.1561621249026;
        Thu, 27 Jun 2019 00:40:49 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 199sm223775ljf.44.2019.06.27.00.40.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 00:40:48 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v3 1/2] mesh: Fixed handling of IVI flag in app layer
Date:   Thu, 27 Jun 2019 09:40:42 +0200
Message-Id: <20190627074043.22891-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190627074043.22891-1-michal.lowas-rzechonek@silvair.com>
References: <20190627074043.22891-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since IV Index is used in application nonces, we need to honor IVI flag
not only in network layer crypto, but also in application layer.

This means that if IVI field of incoming packet is different than in
current IV Index, try to decode *both* net and app layers using IV Index
decreased by one.
---
 mesh/net-keys.c |  6 ------
 mesh/net.c      | 17 ++++++++---------
 2 files changed, 8 insertions(+), 15 deletions(-)

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
index a597b8794..a5693f154 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2489,8 +2489,13 @@ static void net_rx(void *net_ptr, void *user_data)
 	size_t out_size;
 	uint32_t key_id;
 	int8_t rssi = 0;
+	bool ivi_net = !!(net->iv_index & 1);
+	bool ivi_pkt = !!(data->data[0] & 0x80);
 
-	key_id = net_key_decrypt(net->iv_index, data->data, data->len,
+	/* if IVI flag differs, use previous IV Index */
+	uint32_t iv_index = net->iv_index - (ivi_pkt ^ ivi_net);
+
+	key_id = net_key_decrypt(iv_index, data->data, data->len,
 							&out, &out_size);
 
 	if (!key_id)
@@ -2504,16 +2509,10 @@ static void net_rx(void *net_ptr, void *user_data)
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

