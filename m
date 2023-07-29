Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED70C001E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 00:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjG2Ar3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 20:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbjG2Ar1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 20:47:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7F14497
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so1826415e87.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1690591558; x=1691196358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzeMG6V94if0zmo//RHdve3uNRoFr/DpYxF05Wk0DKo=;
        b=Qtp63OnLN/96IblBcYoFrTxzSwX1fSz/ysskcwzgw9/uor8xzjtfpLLYU/Eu3Apkq9
         12ECqCq5vd+a8wBbrjxrvVJscLQs4liyTs6DImLMnteOdjfPC7sQdKfDSNf9CzRXr3xY
         dqpv0D/yVnt2HLdVpvqhD5fPmN4kKEVH3K+nml96uC7FXFVJu9wfcZPt7eaEo/byVKgO
         NvFDVKS45Uq+Kg5sbY9hTCpywKs1bEFw/qJnsqgusSuv2YMrTreb5dmp1DkoyFDV4bmI
         wMusjBMJIh7zSG1Tk8/66IVADc+hygEXCpHsTUFERNM/eUlWsOJp49CP1Q5xJig3t+I3
         9JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591558; x=1691196358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzeMG6V94if0zmo//RHdve3uNRoFr/DpYxF05Wk0DKo=;
        b=N3QGRLBLbJJhcYluY1SVPjuwFAAWhKYK4SKnQiDOc2uNMLWyvpxltmbQAwfjNt1hzE
         ShfZBcwxH4yzKD/tJJ56unKEkcnWVUGsdGKGPwWngOtgOUse+pKzZJSC67OtyHU2aOQL
         S57LncGgBcCSR+W0tMQ93IQ7Cfj7UH0EpECWLoI+6zf7SO7UwG8UYULr2fLEWaq7bZTE
         cWFZ/UGuNOvxuUf32x184hQQSbpNbhyskyUCQQzQzSq5S16991apZ5subboEE86bBbhw
         1nDmrMBFOTC6xyOhkhOGWpdhfQnIJLS4YT+SCTkAvtZ2noXEaHl9n83ePHxW5UDxN283
         POLQ==
X-Gm-Message-State: ABy/qLYqs8f0ET4wYEfwPG70wSxKAh28b23dvdEMMw8f8ymOFbL59RJr
        oqXorghO6mFT8w0Qoi7hOfq0QA1uQ+IAYJYqKys=
X-Google-Smtp-Source: APBJJlFEqX8B41dg1cC11WPTqfKNwYvYqJC9zfICpgrywFtID8PEVHbJmeNRCfFuDJGlo2/Nm/wvWw==
X-Received: by 2002:a05:6512:3da0:b0:4f8:a858:e60f with SMTP id k32-20020a0565123da000b004f8a858e60fmr3963949lfv.59.1690591558561;
        Fri, 28 Jul 2023 17:45:58 -0700 (PDT)
Received: from rymek.localdomain (217.96.255.138.ipv4.supernova.orange.pl. [217.96.255.138])
        by smtp.gmail.com with ESMTPSA id r25-20020ac24d19000000b004fe1f1c0ee4sm617746lfi.82.2023.07.28.17.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:45:58 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 5/5] monitor: Add parsing Service Data of UUID 128
Date:   Sat, 29 Jul 2023 02:45:52 +0200
Message-Id: <20230729004552.1422547-6-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
References: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the advertising report, instead of deciding EIR 0x21 into this:

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

