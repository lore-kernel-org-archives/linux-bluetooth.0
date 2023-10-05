Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25946E92FC7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 21:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjJEVXb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVXa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 17:23:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402F695
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 14:23:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c60778a3bfso11814015ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Oct 2023 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696541007; x=1697145807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guEk/PtnU3eOvEo45bHj6P9ZfTmRkhDnclmkZXMQzf4=;
        b=XLIPX47pew1GTp7ciscUCWgalsK7nxVvkZ8COzjhEAX+9ERyTB76s5V/hBj4AcYKBe
         lRh0dVgJxNatU8AeGI99qCoXAAAuH9LvmVtrCFbbzXgNKNoz7DWS5ftcxsIE6XlFlqjv
         htTEwWeBiUXWP+r0uNOrPlhdUhuMLxHSf3vjKGDGw2cQkF15cav4TGH11w7YhQi/uvKT
         GYeCSUDWawJtRJhU+yEQBBlomPBd4coFErzWvIEx50tKFjClGeGlWpd26tKn/6U//dS8
         Cd9BS/gAOI5Cqc/4TZDo3Akb4rLUfep9IZcURBAuQyORZN6ETwuirAZevFsu431w0D6+
         CaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541007; x=1697145807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guEk/PtnU3eOvEo45bHj6P9ZfTmRkhDnclmkZXMQzf4=;
        b=IoMUQDWrY/nFI1JvmyITOuDbxhrDkLihYXIE0I9T3WAd6xkTFV19Zm5bFuCjKAeb26
         mlHinQF0IfQtyVgo8gEEjfAJiyOHxy+Sx0hDf/SbbYFGjqNkajZJ5N7NwzNsNXGRNeA2
         4JZ43H2AUNQUFblxkm2EjsbOF6n2tyauqW6iBKfPU7o5lN2Tiy/PIrzAEUVh3QTLBDrd
         wZMwqWi5VlBSGPUqF0vBF9VWK9z2EmFrcX2OMhbOtkgtMqRztpVCDW6r0IA8zYhXj7qr
         WfMTV4eDnYwP161VlpWtB6QJ3tFFB+cDng5cgVdevjtMEnd8lcO/hCGTwbdUnGNQQWwc
         t6yQ==
X-Gm-Message-State: AOJu0YyOK3jw+mWiY81i2oHpNhp+e6ttM911h+bWAI38I49g4dHAbUcH
        0K4X7nE/nkKzPYlXZIo6EAF1afh4RIOcf2rt
X-Google-Smtp-Source: AGHT+IEU5o/NZhJr/Yx+G2sdTErSi10Pjls1EXTHlHddy3u+ib8vV5VV0j/G7LCLu/c1bMWa9eEQ7g==
X-Received: by 2002:a17:902:b909:b0:1c7:2f33:7ccd with SMTP id bf9-20020a170902b90900b001c72f337ccdmr5904129plb.33.1696541007034;
        Thu, 05 Oct 2023 14:23:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001c60a2b5c61sm2208410plr.134.2023.10.05.14.23.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 14:23:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_event: Fix coding style
Date:   Thu,  5 Oct 2023 14:23:22 -0700
Message-ID: <20231005212322.3886919-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005212322.3886919-1-luiz.dentz@gmail.com>
References: <20231005212322.3886919-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following code style problem:

ERROR: that open brace { should be on the previous line
+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))
+	{

Fixes: d70e44fef862 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d9c1bfb3082f..6f4409b4c364 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3273,8 +3273,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	/* Reject incoming connection from device with same BD ADDR against
 	 * CVE-2020-26555
 	 */
-	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))
-	{
+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
 		bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
 			   &ev->bdaddr);
 		hci_reject_conn(hdev, &ev->bdaddr);
-- 
2.41.0

