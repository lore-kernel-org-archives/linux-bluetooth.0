Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90C6C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 22:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348857AbiFJWMC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348664AbiFJWMA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 18:12:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD031F7A75
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 15:11:58 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y17so309176ilj.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sskVVK6JzOG7aqmtDXfb/Vju/qskr/CFoR9V2qIT/J4=;
        b=QWziiZ9bdPRc8BM3EkzHlt7tmT/z5Dl6u+hdtFzkH/wtVHnOTBBzvudbEL5gVhzdsL
         FjftJ4IWn6VkOU/HlXa/0/uZvMX5xk0y65NemcYVKuOjAZVTv2+h4vvGlVJYsmF7BLuB
         HbZT4b5ELujSbM/dy0pIc03nNCtPzYEyGRYTG3MfCMTwC3x2zrlpxN+bRPaYJr4f8Oa1
         ANo8RkW+lISSRTTtmKWyBI6b81+9MUs8d6XQvNk96bM4Kn+tX7NbaK+yOObTQxVqJlAP
         AxDu+Ebo4BJKS1xLnUlkTAXjj4evd0nn01pXcyM6u7+zono9GmbtFohu9jALzeb+j0T8
         grig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sskVVK6JzOG7aqmtDXfb/Vju/qskr/CFoR9V2qIT/J4=;
        b=KKFiDcYQbjywH0Kq+FSgYxB4XLkI17J5wLRDv3JSFdvOG+yTCEo4wErFN+l90qeqhc
         8p59HogOyKOJa+M6RJKzFTw0YHyeT8Pc4dvEkwPyPalk0BiQjlcalO9/0g6mCSKlY+bo
         Yfv6b+YMRX0gQlKPex8Azp9TQ2wOyDt/07Ft6ledNbGt5VZHVe8mJK4evcOjUYhCpx+t
         67KjovnoeoRswxl89aSXMRA9ojM3bbz6P7kcSltHrci7kf1qevm/i1PArDYB72d51sd5
         HRSkWv3uh5ibikOGz2vc/9D8iAWOZrtJFNJ+IqWIZWfZep9SQZM45/r8PxdCOEbIEmO0
         1PLQ==
X-Gm-Message-State: AOAM533Nd5arHqB/C5Qho+7DX9ElRGrF+xrZCxjCKgwhwaUo6vxSuCc5
        akb9m1QUuZidtmMvH5aSvR98p31k9Vs=
X-Google-Smtp-Source: ABdhPJxAdjopnKH8QZLy9J7JVzcUJ9RW3OF8c62zbLZXbwuLgopdj1wBC7HFv2EtLJyZB9LbsTLrXw==
X-Received: by 2002:a05:6e02:b4e:b0:2d3:dd2a:5d58 with SMTP id f14-20020a056e020b4e00b002d3dd2a5d58mr26139473ilu.26.1654899117998;
        Fri, 10 Jun 2022 15:11:57 -0700 (PDT)
Received: from localhost.localdomain (c-68-47-51-143.hsd1.mn.comcast.net. [68.47.51.143])
        by smtp.gmail.com with ESMTPSA id k5-20020a026605000000b0032b3a7817b3sm117544jac.119.2022.06.10.15.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 15:11:57 -0700 (PDT)
From:   Michael Brudevold <puffy.taco@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Brudevold <michael.brudevold@veranexsolutions.com>
Subject: [PATCH v2 1/3] eir: parse data types for LE OOB pairing
Date:   Fri, 10 Jun 2022 17:11:22 -0500
Message-Id: <20220610221124.18591-2-puffy.taco@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610221124.18591-1-puffy.taco@gmail.com>
References: <20220610221124.18591-1-puffy.taco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michael Brudevold <michael.brudevold@veranexsolutions.com>

LE support added for P-256 and split out from existing BREDR support for
P-192

Also attempt to free any existing values before setting new values
---
 plugins/neard.c |  8 ++++----
 src/eir.c       | 41 +++++++++++++++++++++++++++++++++++------
 src/eir.h       | 10 ++++++++--
 3 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 99762482c..11d9e91c4 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -352,11 +352,11 @@ static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
 	remote->services = eir_data.services;
 	eir_data.services = NULL;
 
-	remote->hash = eir_data.hash;
-	eir_data.hash = NULL;
+	remote->hash = eir_data.hash192;
+	eir_data.hash192 = NULL;
 
-	remote->randomizer = eir_data.randomizer;
-	eir_data.randomizer = NULL;
+	remote->randomizer = eir_data.randomizer192;
+	eir_data.randomizer192 = NULL;
 
 	eir_data_free(&eir_data);
 
diff --git a/src/eir.c b/src/eir.c
index 2f9ee036f..79d423074 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -53,10 +53,14 @@ void eir_data_free(struct eir_data *eir)
 	eir->services = NULL;
 	g_free(eir->name);
 	eir->name = NULL;
-	free(eir->hash);
-	eir->hash = NULL;
-	free(eir->randomizer);
-	eir->randomizer = NULL;
+	free(eir->hash192);
+	eir->hash192 = NULL;
+	free(eir->randomizer192);
+	eir->randomizer192 = NULL;
+	free(eir->hash256);
+	eir->hash256 = NULL;
+	free(eir->randomizer256);
+	eir->randomizer256 = NULL;
 	g_slist_free_full(eir->msd_list, g_free);
 	eir->msd_list = NULL;
 	g_slist_free_full(eir->sd_list, sd_free);
@@ -323,13 +327,15 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 		case EIR_SSP_HASH:
 			if (data_len < 16)
 				break;
-			eir->hash = util_memdup(data, 16);
+			free(eir->hash192);
+			eir->hash192 = util_memdup(data, 16);
 			break;
 
 		case EIR_SSP_RANDOMIZER:
 			if (data_len < 16)
 				break;
-			eir->randomizer = util_memdup(data, 16);
+			free(eir->randomizer192);
+			eir->randomizer192 = util_memdup(data, 16);
 			break;
 
 		case EIR_DEVICE_ID:
@@ -342,6 +348,15 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir->did_version = data[6] | (data[7] << 8);
 			break;
 
+		case EIR_LE_DEVICE_ADDRESS:
+			if (data_len < sizeof(bdaddr_t) + 1)
+				break;
+
+			memcpy(&eir->addr, data, sizeof(bdaddr_t));
+			eir->addr_type = data[sizeof(bdaddr_t)] & 0x1 ?
+					BDADDR_LE_RANDOM : BDADDR_LE_PUBLIC;
+			break;
+
 		case EIR_SVC_DATA16:
 			eir_parse_uuid16_data(eir, data, data_len);
 			break;
@@ -354,6 +369,20 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir_parse_uuid128_data(eir, data, data_len);
 			break;
 
+		case EIR_LE_SC_CONF:
+			if (data_len < 16)
+				break;
+			free(eir->hash256);
+			eir->hash256 = util_memdup(data, 16);
+			break;
+
+		case EIR_LE_SC_RAND:
+			if (data_len < 16)
+				break;
+			free(eir->randomizer256);
+			eir->randomizer256 = util_memdup(data, 16);
+			break;
+
 		case EIR_MANUFACTURER_DATA:
 			eir_parse_msd(eir, data, data_len);
 			break;
diff --git a/src/eir.h b/src/eir.h
index 6154e23ec..b2cf00f37 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -33,9 +33,12 @@
 #define EIR_PUB_TRGT_ADDR           0x17  /* LE: Public Target Address */
 #define EIR_RND_TRGT_ADDR           0x18  /* LE: Random Target Address */
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
+#define EIR_LE_DEVICE_ADDRESS       0x1B  /* LE: Bluetooth Device Address */
 #define EIR_SOLICIT32               0x1F  /* LE: Solicit UUIDs, 32-bit */
 #define EIR_SVC_DATA32              0x20  /* LE: Service data, 32-bit UUID */
 #define EIR_SVC_DATA128             0x21  /* LE: Service data, 128-bit UUID */
+#define EIR_LE_SC_CONF              0x22  /* LE: Secure Connections Confirmation Value */
+#define EIR_LE_SC_RAND              0x23  /* LE: Secure Connections Random Value */
 #define EIR_TRANSPORT_DISCOVERY     0x26  /* Transport Discovery Service */
 #define EIR_MANUFACTURER_DATA       0xFF  /* Manufacturer Specific Data */
 
@@ -77,9 +80,12 @@ struct eir_data {
 	uint16_t appearance;
 	bool name_complete;
 	int8_t tx_power;
-	uint8_t *hash;
-	uint8_t *randomizer;
+	uint8_t *hash192;
+	uint8_t *randomizer192;
+	uint8_t *hash256;
+	uint8_t *randomizer256;
 	bdaddr_t addr;
+	uint8_t addr_type;
 	uint16_t did_vendor;
 	uint16_t did_product;
 	uint16_t did_version;
-- 
2.25.1

