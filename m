Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60B3C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 18:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiGVSpQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 14:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiGVSpG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 14:45:06 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3589D29A
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 11:45:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f128-20020a636a86000000b0041a4b07b039so2665648pgc.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oBaauaBIZjrieTof2FGDg75mtCH/CB1KU2oTgxF56KE=;
        b=n7ZISF7P0c/oRx0sJ9WPdepLb4eJUQgpXQDXjgvo0KJX7kPA2r4EbdOFkQiIB4xYJA
         48/3exbglFlVY+oXYsKQhXAjLm7FBbZ6HGC8+IcyekAk0G4e4zmzxDeEiJy/4ph3o29i
         tDgrMBmYM4RjvOU1sLPzKFktof2eMfBOhLK+dl96gSc03eucM06TF6ZbpQlzHr/9ejAY
         8X24suFfsNBLHWN3bR5wjfKQtTVJMpRY8eS1+b/dV14p+lxfTcpJ5g4chbjao0aioYJB
         BqxUGP5yv8jwWiRFogKKlYEg32BDBVZ9Q9jW6R1No+fbmwZDfRNQdYfLyEOXuoFVvaYx
         dVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oBaauaBIZjrieTof2FGDg75mtCH/CB1KU2oTgxF56KE=;
        b=xVhuBplzRho9pnkR5MLeXrk6lhd97Odc2xgasmKN8//0R+AsJ9paK2aPV4ZV1ClIro
         F4JM5yKY8wGhQTQOncLMo90Lze95L7HAwR452eqeJj0iMITBJnQgAP9A8i3/pmGz32iu
         crmoa5QP31Eq3fXZX8XP6dvo2UhPvF1FLYlfOIkYZW321N8I+h8CYuFlIjEbmyHXpNGc
         2SSVaYb8IV3K5dEZc51RCnYBQeZUZaDPK9yd4/Ez6V1w682oejzDAnlZhBE4NgRlqEh9
         R2O0aSHHvzkZYmXxNAC1OrVnhmtVG2cAj61J8VCXaedwCHW8+hlbs42Lj4KR36YGnAGU
         tKzw==
X-Gm-Message-State: AJIora+akpUJ/RpaiAspxOBTKAnM19ND9+AbjJmVhno/ye6jMxgliITi
        AVVdjjjpHjV8ZHA9OJAsYCkPqhJsZwYPZry1DcpgdgvE73nL5b7OAmsSacY/zGlZk7sK88GOWrd
        ATtgXtHGaYWRucAIS/riGiKTUZlgZmR/Wcc+N0FDTqvfwwaGxNmbaRZMfjZfuZ2EX8pk3oC992d
        +y
X-Google-Smtp-Source: AGRyM1vN3WlCMN72nJ5jc9Ik2xDUl3kgfKgcFdGOzta9WiLWfv31zr1Kj12o0c4KRCLEMjVDMJqdux/+E36a
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:903:230a:b0:16c:58a3:6395 with SMTP id
 d10-20020a170903230a00b0016c58a36395mr1135339plh.20.1658515504364; Fri, 22
 Jul 2022 11:45:04 -0700 (PDT)
Date:   Fri, 22 Jul 2022 11:44:55 -0700
In-Reply-To: <20220722184455.3926696-1-jiangzp@google.com>
Message-Id: <20220722114449.kernel.v1.1.Ifce963ae9c092b69c116736b57e5d3a40b776060@changeid>
Mime-Version: 1.0
References: <20220722184455.3926696-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [kernel PATCH v1 1/1] Bluetooth: Return error if controller not
 support ll privacy
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
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

Return proper error message if the controller does not support ll privacy.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Return proper mgmt error if controller does not support ll privacy

 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ef8371975c4eb..e5eb422d14464 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4143,6 +4143,12 @@ static int set_rpa_resolution_func(struct sock *sk, struct hci_dev *hdev,
 				       MGMT_OP_SET_EXP_FEATURE,
 				       MGMT_STATUS_INVALID_INDEX);
 
+	/* Controller does not support LL privacy */
+	if (!ll_privacy_capable(hdev))
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_EXP_FEATURE,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	/* Changes can only be made when controller is powered down */
 	if (hdev_is_powered(hdev))
 		return mgmt_cmd_status(sk, hdev->id,
-- 
2.37.1.359.gd136c6c3e2-goog

