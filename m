Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Feb 2022 21:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiBVVW4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Feb 2022 16:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiBVVWz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Feb 2022 16:22:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FC7C3C18
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 13:22:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so184681pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 13:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0bc0XxrWajH0dWWRkv3mvkpGCcm6Or0SxsPZo2tQ2w=;
        b=QaDRlmw+BQuc07Za5JPcQI7vHbzd5hHYAzmFIiQPwyk4pgxC3ByXocT7fgRJVnLwjV
         rYsnJHvJdrfAOtifUPWm5SeopSP2ACqC1yBn9lY1MwNjkUVAqjEIzWTQZ3Gx3lEuijDR
         fPVYqOoUBo0qpLEetAqbJY70RkWBLJXlrm8CX7meRSjGHdnN32BCf34mXHYULeDGXZVX
         XgeytdSc9iONDgoU7BTLdsaZPl5zdXao7xIJyoe/BeziojTvo6vH4UR5VWHItlxsflcZ
         0UU1M2hIOQc1J3XeHwMK4fHOyNVw4X2212p2I8zfc5H9fXbsB93VoGyH8B8vQ3cMi4Ee
         bXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0bc0XxrWajH0dWWRkv3mvkpGCcm6Or0SxsPZo2tQ2w=;
        b=BWYDCwP+SK/hLFBOKKM0oyVXDIkD9pB+zwGPdnJxJw4pP0LLNhuFp6GM8CpFwUi1eF
         Relmqd8mZlvGRUFGS5SxBqsGBTBO3OhbmoWmazeFyoYTVH5CEm3xAvrirvIcvOBfUvcV
         3+N5ignK55hkcg8uAsC2zYjMCS+9iqvJ9TvrKkzCC/hBW8eirdLdAYlfvjQ9z4QBL6nE
         LN55gu2+dPSKg4bzvbZjGG1ujLn9x+IVkoJSWnTAsWZ1JVBkNK1R0wzJHTIRfmGmtM/F
         rADwOshJyk0Er1p62WuzmE8QYSis/kR9r3wBaq5HXOmzK2xfQ10IFH6ICdEeShTr3JO1
         v/tg==
X-Gm-Message-State: AOAM531o7vniztKdXoP540uExCMuNdMDp6tomUB5vKL1OzsCjcZ/LLjP
        ODQHcKqVfpeu0idTma1ytYoljW3zLf0=
X-Google-Smtp-Source: ABdhPJzRkYd/Fu9G3MuVwfQZnU2bjkDYK/yd2984i3yCvzAGmB9FFfF4ma30vdfEg089RCLiXrpgJw==
X-Received: by 2002:a17:902:d708:b0:14d:cf6a:a9a3 with SMTP id w8-20020a170902d70800b0014dcf6aa9a3mr25236069ply.118.1645564948362;
        Tue, 22 Feb 2022 13:22:28 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090a899400b001bc44cd08fesm493398pjn.20.2022.02.22.13.22.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:22:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: SCO: Fix codec when using HCI_Enhanced_Setup_Synchronous_Connection
Date:   Tue, 22 Feb 2022 13:22:27 -0800
Message-Id: <20220222212227.24515-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure BT_CODEC_MSBC is used by default if socket user attempt
to use BT_VOICE_TRANSPARENT.

Fixes: b2af264ad3af ("Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8eabf41b2993..b35c772efc7e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -879,15 +879,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		sco_pi(sk)->setting = voice.setting;
-		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
-				     BDADDR_BREDR);
-		if (!hdev) {
-			err = -EBADFD;
-			break;
-		}
-		if (enhanced_sco_capable(hdev) &&
-		    voice.setting == BT_VOICE_TRANSPARENT)
-			sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
+		if (voice.setting == BT_VOICE_TRANSPARENT)
+			sco_pi(sk)->codec.id = BT_CODEC_MSBC;
+
 		hci_dev_put(hdev);
 		break;
 
-- 
2.35.1

