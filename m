Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8550DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 01:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJHBLi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 21:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHBLg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 21:11:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B069EB48A6
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 18:11:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r18so5970420pgr.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 18:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LouFIjt6eyVIB3skK9CrYX6MidIDEaMX8AY8SOHiN0=;
        b=BYSpjKcMP6d9MzGuur2Jp5wFfSOSVVgIc0gUo9aPvKE714GLvblQFrRYa/WFEwhivK
         Y5luaDydH6zZIx3TFslUKrFcL4eLF0YxQDcU+Bt4CoeXPaVhMU/Tmz/T3433e4s4niGe
         pGaduNv64yW2vZDW9pmuVbIymXcwpgQ6mg2PPXKGjlRLtVUkssWgVdMKgnMi46NisfbN
         /+osWE3d/7hlDevq0EsXfaupDVAFHNzsuY81msp1lDxzzqRsQRPCJlkTjVVpvSu7/uZi
         Doa7LIQ6DjseIqN9reeNDZlK4bIik/7D38RUjdV1TsEddhrXV7R+6c53xCQB4/VwrY+7
         Pz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LouFIjt6eyVIB3skK9CrYX6MidIDEaMX8AY8SOHiN0=;
        b=5g86Xft/SjCsWh5wTjF4Py1vuROZLWNuyDlKSH+yUOMQBrt6aFTeQjDNzps7Deh0Kx
         bQdtjsyXJVRWCtlhGoCT1qixZGpyap7+btzmhgZZqhnRoZZk+2rJ6Rsmtb+Ud3cdfg/s
         XkYyAT+6CC5X1DNtHduOAiQQVphs08EIqjREPaW/DzeHtI1WodR4kcBZCoSGAaOiWWg0
         yx9BjLGm6eyWHjWYPeBnl3WnU32IQvniVDA/3inI8pwXjh6GWdgeDlf9PVeVtJVySWq0
         mo78jtz/0VpmllGyiThadOutqECsg471EmN26pFj040TbO2VHPkfmgALbFfypuyFYQY1
         N65g==
X-Gm-Message-State: ACrzQf1Uh20d5i+2zaCgu1lEXPQEv4LRLd2Jxl3DTNSmd/hYWL6KYDRI
        Nyu3GrDbJX/t1xLORXqUsKXLkThyVCMMGw==
X-Google-Smtp-Source: AMsMyM5y/mPiMHSmvUkU11KuEPLQVJmNalfDnasRSuU8cEjKl0XQm9+vkaDBHr7rx3oe7tGFancb2A==
X-Received: by 2002:a05:6a00:a96:b0:558:8915:2f0e with SMTP id b22-20020a056a000a9600b0055889152f0emr7776414pfl.38.1665191491673;
        Fri, 07 Oct 2022 18:11:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h187-20020a62dec4000000b0056158a41d74sm2234123pfg.58.2022.10.07.18.11.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 18:11:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_sync: Fix not setting static address
Date:   Fri,  7 Oct 2022 18:11:28 -0700
Message-Id: <20221008011129.1906898-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to program the address stored in hdev->static_addr after
the init sequence has been complete:

@ MGMT Command: Set Static A.. (0x002b) plen 6
        Address: C0:55:44:33:22:11 (Static)
@ MGMT Event: Command Complete (0x0001) plen 7
      Set Static Address (0x002b) plen 4
        Status: Success (0x00)
        Current settings: 0x00008200
          Low Energy
          Static Address
@ MGMT Event: New Settings (0x0006) plen 4
        Current settings: 0x00008200
          Low Energy
          Static Address
< HCI Command: LE Set Random.. (0x08|0x0005) plen 6
        Address: C0:55:44:33:22:11 (Static)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 7
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00008201
          Powered
          Low Energy
          Static Address
@ MGMT Event: New Settings (0x0006) plen 4
        Current settings: 0x00008201
          Powered
          Low Energy
          Static Address

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 76c3107c9f91..b53bb0ee9d39 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3054,6 +3054,7 @@ int hci_update_name_sync(struct hci_dev *hdev)
  * Enable Authentication
  * lmp_bredr_capable(Set Fast Connectable -> Set Scan Type -> Set Class ->
  * Set Name -> Set EIR)
+ * HCI_FORCE_STATIC_ADDR | BDADDR_ANY && !HCI_BREDR_ENABLED (Set Static Address)
  */
 int hci_powered_update_sync(struct hci_dev *hdev)
 {
@@ -3093,6 +3094,23 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 		hci_update_eir_sync(hdev);
 	}
 
+	/* If forcing static address is in use or there is no public
+	 * address use the static address as random address (but skip
+	 * the HCI command if the current random address is already the
+	 * static one.
+	 *
+	 * In case BR/EDR has been disabled on a dual-mode controller
+	 * and a static address has been configured, then use that
+	 * address instead of the public BR/EDR address.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
+	    (!bacmp(&hdev->bdaddr, BDADDR_ANY) &&
+	    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))) {
+		if (bacmp(&hdev->static_addr, BDADDR_ANY))
+			return hci_set_random_addr_sync(hdev,
+							&hdev->static_addr);
+	}
+
 	return 0;
 }
 
-- 
2.37.3

