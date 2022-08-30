Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C380C0502C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 02:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiH3C6g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 22:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiH3C6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 22:58:34 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6924A00DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 19:58:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h12-20020a170902f54c00b0016f8858ce9bso7180528plf.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 19:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=mXODdFJOi47qFxuaBDFzWIBYSAQ55JCqgGs7Fum9gUw=;
        b=oXx1RFmFoaFpGoHeVLvUsAH/QO5H28u8zUgFjw5oflI5sieX1P5U3/Z7TXqAFe86GO
         clzJ4uCylokNoe46G/ldRWnVm5FQWxyZAb6g3Drk6G2HncBy0aq/ZiYBPw3tXZCcgNJy
         OLsVTH+rbA095vRPvrDH0IPRUnFUShEeEknHPwFBPCXSp01miFtUtxHrRRs1hPLWd2sV
         EfgpBLla/mP4qdmFmB+yFLWJzbc6I2c8oom4mv0o60Qu3PFpKkuWGH9htbfs9lYlxFwy
         Hp1CoE26ziYkh7cGeYjp8Fl31BKFNJNqMJYCtEGzZ1EEvEANHlEzDwPj7Av71FetwD7W
         RObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=mXODdFJOi47qFxuaBDFzWIBYSAQ55JCqgGs7Fum9gUw=;
        b=G7d/1YagaI8bJTL8f9+dFhPgy5VpjqAsEnx5uamTm14j4HyJq9mRqrwG0IlXj0KxRP
         YkLWjZQcE6Lwbxc/Iu1wEkZE/pPByaNJ5I3d+rEkqBbUoRT67e+k6KNBl0re0fUSryUa
         HSwX/48BaPJmcM9T4dyX4ZywmFFd69UbygCMqSVai2fV5mlG6n7gXO1FzJNvx9oWvpSQ
         kjTNEvrR+aKQe3e/MWmuzeXa6VeSv6aiRdN+jyyOApo4tJoZ6zA2GbXnc38VeVpLNTnO
         7e4CmErUb2K8n9l4/FWnpg3iAY1WdUFc8nKqHROfGqK3oFp2scPdUXuUVz6dqAq+b/K7
         Nl0A==
X-Gm-Message-State: ACgBeo2mE4T7U32V87TUS2ZP/+NdTEhVlZEQWTp7JxgnURc+h0dxztGo
        7bf1X+ABv/heieu+vh4mUsXIFxrNAHYkNBXt4Vxe9fTwYhzrnGigbBu2p58L+06y+yfS0rMyn/r
        0LvqVZiDjkCtTjfEelD9Y8vE04Jl4eZfogSVoPIaivp95BHNAQ33UQtOJWjEd7Hyao4hcPMIAtG
        JJ4aimkCp7Hmen5KTsH4w=
X-Google-Smtp-Source: AA6agR6NZUm4QwSTu5Mo0zFw2JMhgTEkHooh30Xuym1xPQd7iaesgJ1yJQcjk+QRHUx17Y2Fbclio8SH5AxJYBUx/Yd7bQ==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:a63:145:0:b0:42c:1f56:2799 with
 SMTP id 66-20020a630145000000b0042c1f562799mr6647738pgb.154.1661828312961;
 Mon, 29 Aug 2022 19:58:32 -0700 (PDT)
Date:   Mon, 29 Aug 2022 19:58:26 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829195805.1.Ic8eabc8ed89a07c3d52726dd017539069faac6c4@changeid>
Subject: [PATCH] Bluetooth: Call shutdown for HCI_USER_CHANNEL
From:   Abhishek Pandit-Subedi <abhishekpandit@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Some drivers depend on shutdown being called for proper operation.
There's no reason to restrict this from being called when using
HCI_USER_CHANNEL.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
This is easy to reproduce on QCA6174-A, which uses the hci_qca driver.
Simply open the socket, bind as userchannel and close again. It will
succeed the first time and fail the second time (because shutdown wasn't
called). A similar bug also occurs with btmtksdio (using MT7921).

Question for maintainers: What is a driver supposed to be doing during
shutdown? We should add some documentation to `struct hci_dev` to
clarify.


 net/bluetooth/hci_sync.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e08c0503027d..be78fd708f16 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4680,7 +4680,6 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	}
 
 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
-	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    test_bit(HCI_UP, &hdev->flags)) {
 		/* Execute vendor specific shutdown routine */
 		if (hdev->shutdown)
-- 
2.37.2.672.g94769d06f0-goog

