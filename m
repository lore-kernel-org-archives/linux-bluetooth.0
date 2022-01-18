Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA46DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jan 2022 08:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbiARIE0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jan 2022 03:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbiARIEW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jan 2022 03:04:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6843EC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jan 2022 00:04:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m4so75728043edb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jan 2022 00:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=iqqdhh1gYn9Fxt/E/d+XprT1SgaF3NS0ZB1U+banoZE=;
        b=U59WiC4rEDCwvb09jikJ8zEA+ae6mAIf6UcCS6DcQv/KPqbep1OjF+8nkAxTETualj
         wYOZtPmsb0mDZkOIiRp2wyNlAE/sah28nxBP/DDZvw7ofJfpglTZGLB0QXFQFj/RRDvs
         P9dFbSqNMrN7QQvA+NFFwd90K7JPIfLzmaY9TkHiDJDYTTthDW0XYO5/+l+LUzcY3XeL
         uBHg6W/2h7+/i4MnPlWLXiXgtY7OvsoIUGykBX+zzbLw/FvAT9zQG/bU+9Z80g7AKJPo
         606I2ogNCOBCqO3i8aYhEgQVRyl37JFo51UKf7TREiWy5nFyp5pPesgyJ/pKanFPZa9D
         nE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=iqqdhh1gYn9Fxt/E/d+XprT1SgaF3NS0ZB1U+banoZE=;
        b=Nu1QJho5YdE/pDeFCmH8r1S0wmCjI7puzugZlumlRYIjDU63nrj+7L8MVZtMZIpeOS
         XQ6vVRQYVq7r7m5de7WyoJ6twf2KZPI9Y00+0NzAqhix3uIrNrZrsIa9sOEQJNI2CbKw
         s3Pw4DBAoL3Tak6GTJAFTGF8TD7CR7A/P6xbBsKyFbtQWJhYcU3RgukjRn1jOPB3FoQa
         sVNl4V9nRoPlbNS6yzhcZNudTQJq3IycltAsomIfDWLvGKFPLVnr64P9BI8wz6YvtoFA
         ZG4Hk93/1+TTttkFrq7HO5ZvMGSHNpvsRQ3/GLkb8VD8VD6ttUl07UXNOpQjCWPjiF8s
         +7fg==
X-Gm-Message-State: AOAM530gPq12Rurad01yWzA+kSgYcSli71iebThbqJVMXx8SzQ+pRDD7
        RDb9L5BKM0riY1P2kvudOAY=
X-Google-Smtp-Source: ABdhPJwdUx/FCppy9w8asQB1opGFys5+A/kOy3IIk8tU3CTGolF0KBfHY4iEWruEXa9V2t3r55XxKw==
X-Received: by 2002:a17:906:5d12:: with SMTP id g18mr19612804ejt.524.1642493061044;
        Tue, 18 Jan 2022 00:04:21 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id t8sm6744603edr.90.2022.01.18.00.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 00:04:20 -0800 (PST)
Message-ID: <80bf8cf6-eacc-4d1f-d004-9574d02a9d21@gmail.com>
Date:   Tue, 18 Jan 2022 09:04:19 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Whitespace fixes for btusb_setup_csr()
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>, swyterzone@gmail.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Properly align the list items of the quirk for readability.
No functional changes intended. Trivial stuff.

Fixes: 0671c0662383e ("Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers")

Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
---

Split off from the HCI_FLT_CLEAR_ALL patch, as requested by Marcel.

 drivers/bluetooth/btusb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 75c83768c..b494b81f8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1948,10 +1948,10 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		 * These controllers are really messed-up.
 		 *
 		 * 1. Their bulk RX endpoint will never report any data unless
-		 * the device was suspended at least once (yes, really).
+		 *    the device was suspended at least once (yes, really).
 		 * 2. They will not wakeup when autosuspended and receiving data
-		 * on their bulk RX endpoint from e.g. a keyboard or mouse
-		 * (IOW remote-wakeup support is broken for the bulk endpoint).
+		 *    on their bulk RX endpoint from e.g. a keyboard or mouse
+		 *    (IOW remote-wakeup support is broken for the bulk endpoint).
 		 *
 		 * To fix 1. enable runtime-suspend, force-suspend the
 		 * HCI and then wake-it up by disabling runtime-suspend.
-- 
2.34.1

