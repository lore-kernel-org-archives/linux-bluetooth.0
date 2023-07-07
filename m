Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C27EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 22:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGGWoD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGGWoB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 18:44:01 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5312695
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 15:43:30 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-635fa79d7c0so18331236d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688769803; x=1691361803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8smsReczAsHxwtWCT7SGp8WNfI+1rd5qF6m98dMXbo=;
        b=Jhv2RKFHrQku09r/NhyzU+m79KhCYTGHVHeZZXJ3TKSbCHIfKujf38GpoJMk7rCO1O
         BLhfokQ9frfv+H0ogyrMmCIilbgNj7CBHMz06XxoHbeemV1s+7zkzY64TXS+sTU3kdKk
         mOmpaPRepmv+eU455w9EgDAJcZQSwGWDi4OXb1YJDNJcKWrXrChNs6xZwW1zmpjNEwmo
         w781oGmEBboj+LOUcOGncWk2gomw8KW6hWMlAtQyJqkWoM4286wLn23KIvs7r+AO231T
         /M+g9oqRCc8dqC495k/AFu7n9ogZrQ428Z10hcdBm88WK5WNeeLITZp41s1Eugtuy9ho
         HJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688769803; x=1691361803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8smsReczAsHxwtWCT7SGp8WNfI+1rd5qF6m98dMXbo=;
        b=Zv9U969hfmqo6ltYGdeTEPt4gky6iIAzB4MIAyW0u3e0MHmcgZkYDkrUYenV7P1Jiw
         +UTe0DzAhlhhsr6yiCTS3D1xauGHh/UweV6RxQHHVpD2aEwzM5/EQYpL/HxkgrE21o9w
         qT58v6l4FuwfC8ZYepu1Ku8+fvPh0Qy7F7RJmz4ZzbQiVDk/H0B43uHhb/uv7J2VLAqI
         mJMM1F0Ur531o8o4Y9krwYFt7Y/1/SPJ8QGxNDhVdDLk8UWL2oMtVUAEjCdKCXr5An5N
         r8hfllt/YVXDREDoHNtojhb5VDL/xZtckmhWZ0TpMOx6w9z2KJHxIJuJP8Bk2HHs/Jk5
         9Klw==
X-Gm-Message-State: ABy/qLYmTme1CZLzJ1r+c3NxDjsAH4DOAUqzJfbilTuZQ5N/L9Bva3+o
        9AWnxZrSS4iOGm1A5c+FIRp23/OV/b8=
X-Google-Smtp-Source: APBJJlEchGkqnoXmwJbS4BTxyFNjhjBspL4L4XdxxvISf2Lm44rl4uHcPWJqNPxQTeMtuUJJ3et1Jg==
X-Received: by 2002:a05:6214:1c42:b0:635:f7be:90e1 with SMTP id if2-20020a0562141c4200b00635f7be90e1mr12776034qvb.27.1688769803155;
        Fri, 07 Jul 2023 15:43:23 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id m11-20020ae9e00b000000b00762255dced0sm2291705qkk.0.2023.07.07.15.43.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:43:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Fix using Legacy PDUs with certain advertising
Date:   Fri,  7 Jul 2023 15:43:18 -0700
Message-Id: <20230707224318.677205-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230707224318.677205-1-luiz.dentz@gmail.com>
References: <20230707224318.677205-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the advertising instance is bigger than HCI_MAX_AD_LENGTH than it
cannot use LE_LEGACY_ADV_IND:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 2449:

 'If legacy advertising PDU types are being used, then the parameter
 value shall be one of those specified in Table 7.2. If the advertising
 set already contains data, the type shall be one that supports
 advertising data and the amount of data shall not exceed 31 octets.'

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/eir.c      | 31 ++++++++++++++++++++-----------
 net/bluetooth/hci_sync.c | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 8a85f6cdfbc1..2fc375ddf787 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -302,20 +302,25 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		 * include the "Flags" AD field".
 		 */
 		if (flags) {
-			ptr[0] = 0x02;
-			ptr[1] = EIR_FLAGS;
-			ptr[2] = flags;
+			if (ptr) {
+				ptr[0] = 0x02;
+				ptr[1] = EIR_FLAGS;
+				ptr[2] = flags;
+				ptr += 3;
+			}
 
 			ad_len += 3;
-			ptr += 3;
 		}
 	}
 
 skip_flags:
 	if (adv) {
-		memcpy(ptr, adv->adv_data, adv->adv_data_len);
+		if (ptr) {
+			memcpy(ptr, adv->adv_data, adv->adv_data_len);
+			ptr += adv->adv_data_len;
+		}
+
 		ad_len += adv->adv_data_len;
-		ptr += adv->adv_data_len;
 	}
 
 	if (instance_flags & MGMT_ADV_FLAG_TX_POWER) {
@@ -330,14 +335,18 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 			adv_tx_power = hdev->adv_tx_power;
 		}
 
-		/* Provide Tx Power only if we can provide a valid value for it */
+		/* Provide Tx Power only if we can provide a valid value for
+		 * it.
+		 */
 		if (adv_tx_power != HCI_TX_POWER_INVALID) {
-			ptr[0] = 0x02;
-			ptr[1] = EIR_TX_POWER;
-			ptr[2] = (u8)adv_tx_power;
+			if (ptr) {
+				ptr[0] = 0x02;
+				ptr[1] = EIR_TX_POWER;
+				ptr[2] = (u8)adv_tx_power;
+				ptr += 3;
+			}
 
 			ad_len += 3;
-			ptr += 3;
 		}
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3348a1b0e3f7..f57bf554155e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1113,6 +1113,22 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 
 	secondary_adv = (flags & MGMT_ADV_FLAG_SEC_MASK);
 
+	/* Force use of EA if advertising data is bigger than maximum allowed
+	 * over Legacy PDUS:
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2449:
+	 *
+	 * 'If legacy advertising PDU types are being used, then the parameter
+	 * value shall be one of those specified in Table 7.2. If the
+	 * advertising set already contains data, the type shall be one that
+	 * supports advertising data and the amount of data shall not exceed
+	 * 31 octets.'
+	 */
+	if (!secondary_adv &&
+	    eir_create_adv_data(hdev, instance, NULL) > HCI_MAX_AD_LENGTH)
+		secondary_adv = true;
+
 	if (connectable) {
 		if (secondary_adv)
 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
-- 
2.40.1

