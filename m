Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2679DE92701
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 14:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjJEOQu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjJEOOq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 10:14:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67024869
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 04:19:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405497850dbso7616585e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Oct 2023 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696504768; x=1697109568; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LKCiGSV/cuMXEYdiJil1myXSOfx9MNViFnO/h9nEBA=;
        b=rsKd1eCDCzM3GTQdScgk/dEX4rrYOiT0DrzGPGxytPiv01oDu8dmJxCnE9PrP/WIkI
         7IwRMo6regjvT8hhcuBpNzbzL3yuFM8ONqqGstKcYk49MvD/3lR8Yv/NDGwph5Zydu7a
         puRnPZYG06yle4Q37/qv10vPZIoHjo35B7c89vpFyPeCwbs8RbeEIv3MRGf76ixyFqcd
         y3hTZMIMl62kImLmt3VpvBVkGfqAX9fN0GGRwQUnEv08bjSVx+0df83X8mjvVQD1TI6l
         9kji+YqqOtWYW0BOj0eUHWxkQ1GB7mGLOoPkD1p0FnEammnndDS9zx+zWZ1k74ksaXa6
         x6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696504768; x=1697109568;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LKCiGSV/cuMXEYdiJil1myXSOfx9MNViFnO/h9nEBA=;
        b=O+GevHCS4AnuogWQTrAlRg+xc1Fva/sbHuW9umNl969QOVtxUO/jAtknCRhWbXE69D
         1DlL7FU4PEcJKPSk3sqnTqcvqR0OsmYKnJTZHcGUndebpoXD6xWTuewZHk267b1QJJNL
         lgIyvOvTlEI1ZjugFfxyI2mwzYFEZPA+AfbIDhMMvigh4vX9chwgQlKvEpuq8yXtvWlt
         xJgl6MUNLx0FkkSHESfVTbCgyeHIHaatJrBLC2Os6XEfyKWu1144BccmhIehI6bgiLsD
         XnSCb8YRxjUd8j/WSfkkuj/uZLkaoZYmKUOlRuTRcoQKRtyQTpuaQ6ogPaM2RjIsi50D
         +Muw==
X-Gm-Message-State: AOJu0YzzRM6hvCx7az5/dDJYm0ZWVDRj4J5kvnD4PVcbp9d/BSS5PXMY
        y4OOn7/D9QlCtnWOIihBp2wxIg==
X-Google-Smtp-Source: AGHT+IHXJRakpDXJ4VUBMMYIV9wfPKW43f+yaIrWAqlTvo3Y/zdHtgPKm4FKUQCuKZK3LdgpybK9dQ==
X-Received: by 2002:a05:600c:2197:b0:405:514d:eb0e with SMTP id e23-20020a05600c219700b00405514deb0emr4954223wme.19.1696504768002;
        Thu, 05 Oct 2023 04:19:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c044a00b004063c9f68f2sm1282084wmb.26.2023.10.05.04.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 04:19:27 -0700 (PDT)
Date:   Thu, 5 Oct 2023 14:19:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: msft: __hci_cmd_sync() doesn't return NULL
Message-ID: <5fffad33-4d19-4645-a21f-57321d1c82a6@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The __hci_cmd_sync() function doesn't return NULL.  Checking for NULL
doesn't make the code safer, it just confuses people.

When a function returns both error pointers and NULL then generally the
NULL is a kind of success case.  For example, maybe we look up an item
then errors mean we ran out of memory but NULL means the item is not
found.  Or if we request a feature, then error pointers mean that there
was an error but NULL means that the feature has been deliberately
turned off.

In this code it's different.  The NULL is handled as if there is a bug
in __hci_cmd_sync() where it accidentally returns NULL instead of a
proper error code.  This was done consistently until commit 9e14606d8f38
("Bluetooth: msft: Extended monitor tracking by address filter") which
deleted the work around for the potential future bug and treated NULL as
success.

Predicting potential future bugs is complicated, but we should just fix
them instead of working around them.  Instead of debating whether NULL
is failure or success, let's just say it's currently impossible and
delete the dead code.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/bluetooth/msft.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index abbafa6194ca..630e3023273b 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -150,10 +150,7 @@ static bool read_supported_features(struct hci_dev *hdev,
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR_OR_NULL(skb)) {
-		if (!skb)
-			skb = ERR_PTR(-EIO);
-
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to read MSFT supported features (%ld)",
 			   PTR_ERR(skb));
 		return false;
@@ -353,7 +350,7 @@ static void msft_remove_addr_filters_sync(struct hci_dev *hdev, u8 handle)
 
 		skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 				     HCI_CMD_TIMEOUT);
-		if (IS_ERR_OR_NULL(skb)) {
+		if (IS_ERR(skb)) {
 			kfree(address_filter);
 			continue;
 		}
@@ -442,11 +439,8 @@ static int msft_remove_monitor_sync(struct hci_dev *hdev,
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR_OR_NULL(skb)) {
-		if (!skb)
-			return -EIO;
+	if (IS_ERR(skb))
 		return PTR_ERR(skb);
-	}
 
 	return msft_le_cancel_monitor_advertisement_cb(hdev, hdev->msft_opcode,
 						       monitor, skb);
@@ -559,7 +553,7 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, total_size, cp,
 			     HCI_CMD_TIMEOUT);
 
-	if (IS_ERR_OR_NULL(skb)) {
+	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		goto out_free;
 	}
@@ -740,10 +734,10 @@ static int msft_cancel_address_filter_sync(struct hci_dev *hdev, void *data)
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR_OR_NULL(skb)) {
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "MSFT: Failed to cancel address (%pMR) filter",
 			   &address_filter->bdaddr);
-		err = -EIO;
+		err = PTR_ERR(skb);
 		goto done;
 	}
 	kfree_skb(skb);
@@ -893,7 +887,7 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, size, cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR_OR_NULL(skb)) {
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to enable address %pMR filter",
 			   &address_filter->bdaddr);
 		skb = NULL;
-- 
2.39.2

