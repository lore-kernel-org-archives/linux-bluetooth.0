Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD2C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 22:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349411AbiFCWdC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349402AbiFCWdA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 18:33:00 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860542E9E7
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 15:32:58 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id f12so8418117ilj.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jun 2022 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RlbUKdRYhbuwJ9+pYBI5bv47N10bmhbx1OOaPiYvwaQ=;
        b=iEeNT++T5TxtCWnbb6Q2ERYU3cNGF9ySxdFYzMHxGMIWlRYDfifvpc6G5Rau6Z0ga5
         J8c6V+i2Cu7zbYZei5p4WiGuAx1sJCtJ5OY3visObfzG6qbL0y8ZBAvIJv/RWs4ZZxdm
         TpqIalBhGV1DCT6unCZKF49UloTQUwCA0A9cq9Ta9+3sVFt8IkPXGNCoMkZBdE3B0rEC
         hywJ2DCQki1Yy1WnKuxUBYNrPPkLQiyuLSj9Oph1t300u6tcsIWvRO6y10nZlrHgBLWW
         af4t/mjdFytbrHaoxufJKhDkhd488Zb7rsBJpCsDbrSkpndjkdA0uLUO3B4wxbVU2SdB
         rg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RlbUKdRYhbuwJ9+pYBI5bv47N10bmhbx1OOaPiYvwaQ=;
        b=MKc5dk81yslElHNQFDtMETz2yATAM7xLHh7xpwNIlv4e5sH0MfSP4yNEqBuHr+NpN0
         HqT/kFkJUuSd1IU6nqj6ZnSRq7Kd7N0T6ieSZ3sNnSrTcTi6yougyDlLWfZzLQRFdJUX
         g6nBupkkwHineXepv52FrNpxK9WLK+qKK9e6tV6Fzmyjc2ALvUW+zKWxy5kTeGaXta7r
         e8mmRp0rwUzcn3KlkMv3GHoP3zzIVtimG/M+sG3g4IsSf7+IF4K/dn7HcoReskpnYtG/
         DjX6rYx0oOvDlLfcqZcYWNt1T1dogWG4SJIv87kvLJYsJp+my7VxFiiKVtsSgb9fwUT5
         wfTA==
X-Gm-Message-State: AOAM5302gGKgjb10bYuD+swg3pqEdPm66DFjMIwF32hFeQrlUAO2jmxl
        tkaqnJdc84MNbWRTKvuCCU9N+JKDqX4=
X-Google-Smtp-Source: ABdhPJwQQfzOKralCJVmGkpPO4ebVuYMWPhGzdY1Ti55Mre6Bz04z8O0JdOOHYJYbeyCKaFcxebgug==
X-Received: by 2002:a92:c847:0:b0:2d3:a915:39f7 with SMTP id b7-20020a92c847000000b002d3a91539f7mr6701013ilq.103.1654295577909;
        Fri, 03 Jun 2022 15:32:57 -0700 (PDT)
Received: from localhost.localdomain (c-68-47-51-143.hsd1.mn.comcast.net. [68.47.51.143])
        by smtp.gmail.com with ESMTPSA id f2-20020a02b782000000b003315c00e885sm2825352jam.0.2022.06.03.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 15:32:57 -0700 (PDT)
From:   Michael Brudevold <puffy.taco@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Brudevold <michael.brudevold@veranexsolutions.com>
Subject: [PATCH 1/3] eir: parse data types for LE OOB pairing
Date:   Fri,  3 Jun 2022 17:32:23 -0500
Message-Id: <20220603223225.20296-2-puffy.taco@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603223225.20296-1-puffy.taco@gmail.com>
References: <20220603223225.20296-1-puffy.taco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michael Brudevold <michael.brudevold@veranexsolutions.com>

---
 src/eir.c | 21 +++++++++++++++++++++
 src/eir.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index 2f9ee036f..fabfd6402 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -342,6 +342,15 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
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
@@ -354,6 +363,18 @@ void eir_parse(struct eir_data *eir, const uint8_t *eir_data, uint8_t eir_len)
 			eir_parse_uuid128_data(eir, data, data_len);
 			break;
 
+		case EIR_LE_SC_CONF:
+			if (data_len < 16)
+				break;
+			eir->hash = util_memdup(data, 16);
+			break;
+
+		case EIR_LE_SC_RAND:
+			if (data_len < 16)
+				break;
+			eir->randomizer = util_memdup(data, 16);
+			break;
+
 		case EIR_MANUFACTURER_DATA:
 			eir_parse_msd(eir, data, data_len);
 			break;
diff --git a/src/eir.h b/src/eir.h
index 6154e23ec..241e6fac9 100644
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
 
@@ -80,6 +83,7 @@ struct eir_data {
 	uint8_t *hash;
 	uint8_t *randomizer;
 	bdaddr_t addr;
+	uint8_t addr_type;
 	uint16_t did_vendor;
 	uint16_t did_product;
 	uint16_t did_version;
-- 
2.25.1

