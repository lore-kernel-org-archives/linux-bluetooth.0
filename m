Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46BBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 19:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348491AbhLFTad (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348487AbhLFTad (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 14:30:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F1C061746
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Dec 2021 11:27:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso125742pji.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Dec 2021 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k6rWR830L89X/gW4lAqjaoM5Kvk1TlILSVMJh4bBgfg=;
        b=ZkHDtmYLLd1dcnzZNHt1T0xLjsjUXhha7NpONscn8ogF5pLfZKzPZopfEPzCVPPDEr
         UdGa+XiMpO1njGJVOeUsDSxO8ciOBY9dBGE6lvXfeqEbW9l6NuEPyag37oqVVARTpEyD
         czg3Uma7Vpt0JgFFnMaNSOM61Q10swpEORpKFXI0rI/azvPUT1LpsSIWGeVXGoFV8gvK
         5ivEVzv2nyfwOPG3gPlvo5m2rDQOaI3NzVIgF5wsMkitxcLmJvImphhKtVBwUrHhNrue
         a6PsStvFOSzf9xNHNqh4U7wh8hJDKh/ko5FSA/VKRFGS6QdH9/HfoPl/lgfy4TFGmMFH
         ijSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k6rWR830L89X/gW4lAqjaoM5Kvk1TlILSVMJh4bBgfg=;
        b=IiTGpZZfPOMlYBYEg4hpatxcCeGOlBU8eHMzCu1oYBe6JaiIPOpzJqTQfG4FHeExX/
         MXVQFpEwB7IzEyveOQdOWeDQJ7ugLkiq4Lu0MNyla5xoTIAnLLGy+UqfamiRQnXxausK
         Mj52RUIBxh0xX7CJMkblJDvEHBPOD5FLZ0+ZDIfQihNjmuaszlw493rmCYG24MdFjW4F
         W/sdhUVddWgTb/nbEBv40FCj1DXYoV4vq+zrBK1X04c/Sr2Iqo15sqF2T26U0ikm6j/T
         SljTcUTM0D58CeRBSqhMr0VSe2Pb2hRYUBYxvVPIzEl9oqo9WIK12n2+lP22DGsjTo7k
         uvyA==
X-Gm-Message-State: AOAM5330W3reQ6ECe1Ov9PCGyrZdjvv/wooG2u1Jc1rEIjSyi4JeUtXI
        GVDQqVGuCrPVFs3mQla0rR4eEuwEuAk=
X-Google-Smtp-Source: ABdhPJzdW98TcDbK2entkBnWsM8lQamK1h8JsJ/zIrL9rARQ8804CbJwM7XH6U7mJelTY4Zu7OsOjA==
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr656471pjb.62.1638818823361;
        Mon, 06 Dec 2021 11:27:03 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n6sm10662016pgk.43.2021.12.06.11.27.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:27:02 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: msft: Fix compilation when CONFIG_BT_MSFTEXT is not set
Date:   Mon,  6 Dec 2021 11:27:01 -0800
Message-Id: <20211206192701.3146782-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes compilation when CONFIG_BT_MSFTEXT is not set.

Fixes: 6b3d4c8fcf3f2 ("Bluetooth: hci_event: Use of a function table to handle HCI events")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/msft.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index 7fefc0655b6f..afcaf7d3b1cb 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -39,7 +39,8 @@ static inline void msft_register(struct hci_dev *hdev) {}
 static inline void msft_unregister(struct hci_dev *hdev) {}
 static inline void msft_do_open(struct hci_dev *hdev) {}
 static inline void msft_do_close(struct hci_dev *hdev) {}
-static inline void msft_vendor_evt(struct hci_dev *hdev, struct sk_buff *skb) {}
+static inline void msft_vendor_evt(struct hci_dev *hdev, void *data,
+				   struct sk_buff *skb) {}
 static inline __u64 msft_get_features(struct hci_dev *hdev) { return 0; }
 static inline int msft_add_monitor_pattern(struct hci_dev *hdev,
 					   struct adv_monitor *monitor)
-- 
2.33.1

