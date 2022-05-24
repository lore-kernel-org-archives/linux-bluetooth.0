Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3FCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 20:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiEXU0g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbiEXU0f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 16:26:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E43A70E
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 13:26:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b5so9763758plx.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7670BzM1lZFWkcIEKUthoaKaWjKyu9miEYfM3UOiXq4=;
        b=i1HRUnBQDhvCNmQzZY2pYbko/Sm8Esn2jNG1RxvNFK4orfYvJJbeA88aMMyzsiipOC
         sR3ntiHmxI9ayyPv+SgyVCL40Yoppw2sq0gxxxb5afjH33ufJRb8zvscf2gqb5Oxi+ND
         OfE+rjJVF3q6aMH8BamUk/cluHoNn70ZaT7URh/uo9kHqsPQY6COpQHIUbYd5u+M8JfC
         95H7D1ww1g+vmP8n0iDri/ZSXjf0ViKJ766gODTJ+zuJmiWyNW4e9aZrbQWMGJlgGa3t
         nIzjTCRlPuqF2XWrjLyFm7f8Q4jlh5vRET347wUtni+5PKIX++YQCPz2VDeZ3RnprTnb
         ssoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7670BzM1lZFWkcIEKUthoaKaWjKyu9miEYfM3UOiXq4=;
        b=5A8ncuOkOG3hS9oJfj8uhhZlrvbCLPLYFyhguyqULZGKtpNIvDUxqiUDFbBVCOJ56H
         uKDHkSopItgeJJTFCPotcOJ1t773v5+QoYOKi6iQtPxb81pfiEAVQr9vX59LACSwQSik
         dXJ8fXx2GlpvQvyJPQxEHVDRxvxDa68n6Br6ok3Gfjbul1WdckBME6hcNPFt1+oGYZE3
         +bl681uMbVg4c04bluf/C8wAsXhXhxDRcVcV0cLwocY98669tuACTkipUZrsGHKPxsOA
         j+3q1605QT9aXT0Cw6QbpontohCM7nbjeddc9i+6OLyFQ44UlaHLDG4Bxzxy62yP1UC9
         hl3Q==
X-Gm-Message-State: AOAM533rX2QVy+aOvY3NE7b+2qh9X8CKii/c7eLynVBTWL5jyAF8iALm
        lN5wqYbMRvDVzBoNZb8w3L6cpqkhs0w=
X-Google-Smtp-Source: ABdhPJzoTNZon/N9Hl7dlnrNug5YBUpoEFresBu5Lv2v+BrexhjrBowraVmpQ7AqjllIW6XB9xQVOw==
X-Received: by 2002:a17:90b:946:b0:1df:4b91:9924 with SMTP id dw6-20020a17090b094600b001df4b919924mr6325601pjb.180.1653423992322;
        Tue, 24 May 2022 13:26:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b0015f2b3bc97asm7886322ple.13.2022.05.24.13.26.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 13:26:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH-stable] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
Date:   Tue, 24 May 2022 13:26:30 -0700
Message-Id: <20220524202630.3569412-1-luiz.dentz@gmail.com>
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

