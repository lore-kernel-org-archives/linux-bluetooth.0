Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5175C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 20:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbiEXUZv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 16:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbiEXUZu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 16:25:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6575D653
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 13:25:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p13-20020a17090a284d00b001e0817e77f6so2188363pjf.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7670BzM1lZFWkcIEKUthoaKaWjKyu9miEYfM3UOiXq4=;
        b=XIbebF35N1/3WkdC2LC0rzIAR5I5KfYRska6SVB2/rdYgKHm5t6EgAnjghozBpbgO6
         FZxXC3gp17NPYmiL2pGgxLJ4hF8Lp14C+rdwNlMlfFL9V1SGAgal4CGNLt8yAh6Wzht/
         ZR9eKdafh7FBnkJMIbKNXbW6HQhrAX37CiWGIAtqPAmNL9smKmoNAtV1L1wIeF3NPZhv
         a4iubU3rb6vPnYpvPmiKs2DrlQ5knZfUzOhZ1gmiIaHfGPs3Qgoj3yX2YEN1h7q+I1qE
         id8TrrmPPnq0cEbcfTOV7a+qNbw1yqlLtpMjiH7nZtw/6bFzz3923F76BtWsYGjinSCE
         98yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7670BzM1lZFWkcIEKUthoaKaWjKyu9miEYfM3UOiXq4=;
        b=AmnYITjcevycnrr8C5AG8KhjoGIvwjdzPG7f0MAizMucMrU+HfnSlSbmBQfNmqqU2x
         Nz1WD+eL9PzVNAE9aHJFSjWvQrMHYDLhF9eeUgGysUb2dF49ZJb4ooZDGANwdEAr8VDs
         QmgNnEka0GhkqIwkqI41gznr04N8tNHVk+9v/v+bXdFrR+nwOU47sNQM2sCAODaFdrAa
         v9OyQ1CbJSaLsi83Iq/QlfF9ur1Hsq+V0mhsml6IfUDApyKJ3384dWdQrPuDeVwaEFb1
         5Q3OluN8dnSUTVEwL+Doko/YuLZFevOCF936UOiBejUqF2QTiCUbYV7DeX05OuMG1UHs
         Q7gQ==
X-Gm-Message-State: AOAM531aoJ/TyZrOCXpv6QvbmPObF6/HdmZbd1ayluNcGe0LQM3oOPDS
        p+QPagiuPxu8QZARYzUrl0uVODjgyyo=
X-Google-Smtp-Source: ABdhPJzXz5+RqVE+pt7nmRull8SIsKOiVwtBCiq90ByIpSlJQsjzEp0eTfLVbnfJoAaXgTRcZ7OoGA==
X-Received: by 2002:a17:903:110c:b0:15f:f15:30ec with SMTP id n12-20020a170903110c00b0015f0f1530ecmr29341282plh.162.1653423949203;
        Tue, 24 May 2022 13:25:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b0016196bcf743sm7562487pls.275.2022.05.24.13.25.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 13:25:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
Date:   Tue, 24 May 2022 13:25:48 -0700
Message-Id: <20220524202548.3569218-1-luiz.dentz@gmail.com>
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
 net/bluetooth/eir.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 7e930f77ecab..4171edee88e4 100644
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
@@ -168,7 +179,7 @@ void eir_create(struct hci_dev *hdev, u8 *data)
 	u8 *ptr = data;
 	size_t name_len;
 
-	name_len = strlen(hdev->dev_name);
+	name_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
 
 	if (name_len > 0) {
 		/* EIR Data type */
-- 
2.35.1

