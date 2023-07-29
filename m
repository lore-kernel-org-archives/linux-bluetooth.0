Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1934FC0015E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 19:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjG2TJy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Jul 2023 15:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjG2TJx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Jul 2023 15:09:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C84730FA
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jul 2023 12:09:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso48576991fa.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jul 2023 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1690657789; x=1691262589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2f9G3S3gQHFDX8koiPrvowoAowEL/8UCFombGPSuuI=;
        b=0dIY32HqiixFcLZrUI3TM0WepE+WjqZlBAej5bPAIAivIqYs/qP4uSccl44H1SKgZU
         jnUHqz+GwsKqB5Q7DziqvMgpBvLCjEeHDspST6UpnRWp7Q6SCrjrFzoOY5IUbpIKP8/4
         /k8imn5cojETRbc7ggai7JWWBzyA5PsycEOWhCmtiYi7Bz32ZcqA/cNBWeq+JYhJkrC8
         l61FuBMfFm7XNtvWMyXgimIfL+ew56IP+nX/0Vp4nVS10usGmvDywjUet68/JRIasz1c
         v/DbGX14h7/JT5kQJv6/aU1JyxCMGSavlZk3SDPIz2iq7eiGfofi6k30MTtvraMn9aLx
         FdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690657789; x=1691262589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2f9G3S3gQHFDX8koiPrvowoAowEL/8UCFombGPSuuI=;
        b=kEPYl6TojfHVt1tlR2q6xEj5/eBPH5Jv6xbBdaSP/6/9UV0WANClJJn0LDD4xww0FR
         qzBAkBQPw0PsSq/Dp58SX8kCTzRBV0lV1Ajiho987fV69Dpa8Eo/WsopWUSI2WghMDEN
         yrGxIc0PKY0TZU5ELyZXwwkQtzckk8Vd2BTzxEPyuXcIcIYbcDLtgHkZNQMkET4ExJdY
         Wu8PKyo8HKUIRrah8LQzJbAAZ2BfL+tNjWqMqah4IPGDyHkkqd+KN6YoPvcfT8ba/mXu
         LUVSfNYd1emiC43G8DPCnE7hpbnLYlNfLBBdJexa+6s1rj4YwXvyoFyeVOLUh+10hDLq
         gTpw==
X-Gm-Message-State: ABy/qLaC2CCOeqi/HtGX3Ucmkf0iGreWLCXxkhAj2Ni/QvDAkhM40r4P
        lIh4oIlJD2sd+gfegFZWtv/wmsoMl8LEGDAsRCg=
X-Google-Smtp-Source: APBJJlGWNBlNE6b9grgsAIPaBd5WKOpPWVTl8xGXNp7dPcCjnmAsMpsnS9O94xmbxw6X05CaW01izA==
X-Received: by 2002:a2e:90c8:0:b0:2b7:7ab:3c60 with SMTP id o8-20020a2e90c8000000b002b707ab3c60mr4440642ljg.32.1690657789438;
        Sat, 29 Jul 2023 12:09:49 -0700 (PDT)
Received: from localhost.localdomain (217.96.255.138.ipv4.supernova.orange.pl. [217.96.255.138])
        by smtp.gmail.com with ESMTPSA id l14-20020a2e3e0e000000b002b6e13fcedcsm1663531lja.122.2023.07.29.12.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 12:09:49 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v2 5/5] monitor: Add parsing Service Data of UUID 128
Date:   Sat, 29 Jul 2023 21:09:45 +0200
Message-Id: <20230729190945.1427101-1-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the advertising report, instead of parsing EIR 0x21 like this:

	Unknown EIR field 0x21: 3a048f2ba97ea6ae1b49c619e973a4a701480d130d

We can do bit better

        Service Data UUID 128: Vendor specific
          Data: 01480d130d
---
 monitor/packet.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 3031b028f..21e08ccef 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3997,6 +3997,18 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
 			print_service_data(data, data_len);
 			break;
 
+		case BT_EIR_SERVICE_DATA128:
+			if (data_len <= 16)
+				break;
+
+			print_field("Service Data UUID 128: %s ",
+						bt_uuid128_to_str(&data[0]));
+
+			if (data_len > 16)
+				print_hex_field("  Data", &data[16],
+								data_len - 16);
+
+			break;
 		case BT_EIR_RANDOM_ADDRESS:
 			if (data_len < 6)
 				break;
-- 
2.34.1

