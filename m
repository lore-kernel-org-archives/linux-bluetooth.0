Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8479C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jan 2022 07:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiARHYF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jan 2022 02:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiARHYE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jan 2022 02:24:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB28C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jan 2022 23:24:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso3626642wmj.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jan 2022 23:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:content-transfer-encoding;
        bh=iqqdhh1gYn9Fxt/E/d+XprT1SgaF3NS0ZB1U+banoZE=;
        b=Xcw/2l6JpMs/6dsAEtt9OaK8ZDJ/t2IaSV/xTMUJNHg6A4q+cNDjBym6K/6mka+FUm
         293xdYreBpVNNkH0r2D2NrCGcKPe7m7KHvj1vaL25ZYWdP2yj0cR9Tf2029woCRacBOO
         COUqxI1XzM02SWNb9WpyMEQT7ZhHGsrbr3qL1t6GCzEorkLH5zC3TvQTaSDvROzWst/G
         +f5lyr6fu6skhipD+L3l8ae/7dD0CxqsDI8Jhr5ulcKQMPOF7FNmOScZ7fXZasdi2MWA
         cJ5qOmoqbMu2IHKAhIdx21niNpk3ScPHNWo0IVN3/PoMAd+PRKgb1DXq+u+R4dBJBwhx
         qvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:content-transfer-encoding;
        bh=iqqdhh1gYn9Fxt/E/d+XprT1SgaF3NS0ZB1U+banoZE=;
        b=pXM6Ww0TAAxA0Jab5kkdJUOKNxh7s1Hn5gnxiVZDdxQXCN5TGQ1JqDMIs/i77OOIbh
         FtpgFeqHx7FIOSGHlMBsbhZsAlniOgtzJ6HFKMo8NwRp8qWA/zMwQ45lqAX+NzLFN+i+
         eVgJKwO3hNdP393npxrrRPkk0KQV2uynsdqSgtQEF9KClRNxhy1SRAcKWwNfjkdLlG43
         4hNOyoldHs6tpxOi28aGMeN1/0jFT1ycEGkG0iF4Qcf0VgmCe+K2SM7Rv3uO6Cpeo5BY
         jSVdCs0zAVWF6C2X0HEyMok++BBtqninyw/Ru28tL4f91crcA+zH7lxkdq6/tM8I3Jqp
         g+6g==
X-Gm-Message-State: AOAM532YQE0cfzwb+y0DHBw3zyn1iMPBQCfDomf7TCr9/kP5Ciw/cVZZ
        42QZGDI5Ak5Gws+0V1dAKwcCCS8jVNoKpKtx
X-Google-Smtp-Source: ABdhPJxD+sO8RYcNcAPsvEhYfD0GR88LlPpz33suw44p5cD851QPHuvqPsILt7Z0v0YoeOEgej/JIA==
X-Received: by 2002:a5d:6dc9:: with SMTP id d9mr23364419wrz.42.1642490643127;
        Mon, 17 Jan 2022 23:24:03 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id c8sm8456544wri.69.2022.01.17.23.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 23:24:02 -0800 (PST)
Message-ID: <e0f93f54-b466-53ec-20ba-2840ad125b73@gmail.com>
Date:   Tue, 18 Jan 2022 08:24:01 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
From:   Swyter <swyterzone@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Whitespace fixes for btusb_setup_csr()
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>, swyterzone@gmail.com
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

