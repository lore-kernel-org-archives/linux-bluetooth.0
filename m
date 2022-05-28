Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8DAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 May 2022 00:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiE1Afd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 May 2022 20:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiE1Afc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 May 2022 20:35:32 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC7FFD369
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 17:35:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id f14so4064199ilj.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skLWkT/iLiyO+ZJaBBi68hpqA9oX7BHCtwP4O3+Wrsc=;
        b=WzIEtwmwGatBrVRR7F1YG3pyczFweKfUEj3L7mEB8Q5fJinMW4E8+HUG3arfjOFiTy
         rJMlJjtkeDOO44BOoGbC0UBUsGj9pLDHPk9/4T868uG+WE0LhgSBiLb/aJHfCfGEB5Hj
         SSagsJD1ldrC++sxRgNkwRcPsAeYdTE6piCyX/s2P4+BDOeOEQ+S8PsgjQx8YxaN7atG
         cJNn7Ol0CollHEqrv+OUu9cI48tVFcknjAr/1eoL4cN6dQjKRzY/SjGGs0SpbmfkSGY+
         lKuFt4XhwKUIkZovL4HJxFHeK4EmSMFt6bmktoX3ndlaYNTt04nUWxC+/I3Jz+ktk3A3
         SHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skLWkT/iLiyO+ZJaBBi68hpqA9oX7BHCtwP4O3+Wrsc=;
        b=JpIHklezxZ7dOdGcjP4LaHnMbHoDgmyTp4bwcUpYL0OwC/PaV8lS78wllplXD8EoFD
         ETIgW6qRCICX/ePjGiwFYkpIfI9xFjkOjT4asjIFcT7gtWxISeU/8U3Hb7MZfQvVCo11
         t9WFI4hDbgrOD/R5XW8taKQFrnUIGU6sS4Jt04+siCoaTWD7Snhbl8avBMvk2BnxXxdi
         qE32SccQWyWv3mPQEBkivR8g5JMgfF8VeCyFhGh51kDCTjW+kgb4lrz5wW9zgdySBA0u
         IKAL6XAzUZcOeMqgQjwi1O0PI4Kgu+SVTEN/FpEc6EC+R6JoqUThGHHsCr8MvyfcCWtg
         8O8Q==
X-Gm-Message-State: AOAM530vN82JodTNfjhQNsFo+P9+UAirpGvbUCs4sjuHCERumS3j7n6T
        rmC93iWJJ49Iyg1BcySHu69B5pZv49A=
X-Google-Smtp-Source: ABdhPJz8wTbwcESn0iW+2sSOYaVOfiOwhRwmQurL1rVC94wHmV1u7RM08ew6sVR89CMBRz93GlGQ+Q==
X-Received: by 2002:a05:6e02:1bea:b0:2d1:ae3c:d041 with SMTP id y10-20020a056e021bea00b002d1ae3cd041mr15203456ilv.7.1653698130507;
        Fri, 27 May 2022 17:35:30 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m11-20020a056602314b00b0066579afd3cbsm1533714ioy.50.2022.05.27.17.35.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 17:35:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH-stable v2] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
Date:   Fri, 27 May 2022 17:35:28 -0700
Message-Id: <20220528003528.571351-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both dev_name and short_name are not guaranteed to be NULL terminated so
this instead use strnlen and then attempt to determine if the resulting
string needs to be truncated or not.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216018
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/eir.c  | 41 ++++++++++++++++++++++++++---------------
 net/bluetooth/mgmt.c |  4 ++--
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 7d77fb00c2bf..776d27f7e18d 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -13,6 +13,20 @@
 
 #define PNP_INFO_SVCLASS_ID		0x1200
 
+static u8 eir_append_name(u8 *eir, u16 eir_len, u8 type, u8 *data, u8 data_len)
+{
+	u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
+
+	/* If data is already NULL terminated just pass it directly */
+	if (data[data_len - 1] == '\0')
+		return eir_append_data(eir, eir_len, type, data, data_len);
+
+	memcpy(name, data, HCI_MAX_SHORT_NAME_LENGTH);
+	name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
+
+	return eir_append_data(eir, eir_len, type, name, sizeof(name));
+}
+
 u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 {
 	size_t short_len;
@@ -23,29 +37,26 @@ u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 		return ad_len;
 
 	/* use complete name if present and fits */
-	complete_len = strlen(hdev->dev_name);
+	complete_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
 	if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
-		return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
+		return eir_append_name(ptr, ad_len, EIR_NAME_COMPLETE,
 				       hdev->dev_name, complete_len + 1);
 
 	/* use short name if present */
-	short_len = strlen(hdev->short_name);
+	short_len = strnlen(hdev->short_name, sizeof(hdev->short_name));
 	if (short_len)
-		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
-				       hdev->short_name, short_len + 1);
+		return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
+				       hdev->short_name,
+				       short_len == HCI_MAX_SHORT_NAME_LENGTH ?
+				       short_len : short_len + 1);
 
 	/* use shortened full name if present, we already know that name
 	 * is longer then HCI_MAX_SHORT_NAME_LENGTH
 	 */
-	if (complete_len) {
-		u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
-
-		memcpy(name, hdev->dev_name, HCI_MAX_SHORT_NAME_LENGTH);
-		name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
-
-		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT, name,
-				       sizeof(name));
-	}
+	if (complete_len)
+		return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
+				       hdev->dev_name,
+				       HCI_MAX_SHORT_NAME_LENGTH);
 
 	return ad_len;
 }
@@ -181,7 +192,7 @@ void eir_create(struct hci_dev *hdev, u8 *data)
 	u8 *ptr = data;
 	size_t name_len;
 
-	name_len = strlen(hdev->dev_name);
+	name_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
 
 	if (name_len > 0) {
 		/* EIR Data type */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cd1b300b9be7..82cc645193f2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1082,11 +1082,11 @@ static u16 append_eir_data_to_buf(struct hci_dev *hdev, u8 *eir)
 		eir_len = eir_append_le16(eir, eir_len, EIR_APPEARANCE,
 					  hdev->appearance);
 
-	name_len = strlen(hdev->dev_name);
+	name_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
 	eir_len = eir_append_data(eir, eir_len, EIR_NAME_COMPLETE,
 				  hdev->dev_name, name_len);
 
-	name_len = strlen(hdev->short_name);
+	name_len = strnlen(hdev->short_name, sizeof(hdev->short_name));
 	eir_len = eir_append_data(eir, eir_len, EIR_NAME_SHORT,
 				  hdev->short_name, name_len);
 
-- 
2.35.1

