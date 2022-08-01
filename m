Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB3AC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 04:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbiHAEaD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 00:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiHAE3s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 00:29:48 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A59140AD
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Jul 2022 21:29:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g186-20020a636bc3000000b0041c3d64031cso38728pgc.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Jul 2022 21:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1bQbst9icU8PzrBH3x9FY5YwDFo9gdkmYY4v3XzOPoA=;
        b=nYIVllHuj+lpycvPE1ZOmapJ6S2uOuZKeWAnIWJ6qQAOjzjH9xA8vufIqCpd7WmsYW
         aqr5H5NaGqbORFkq8pjFnX1t/6Lrf61FQWVYB5hC9xmIbTxLGVgPcGrTBVBGM5b4KdV9
         LD4sEp8DHaroGU/12I8AkN2LL/GmRIl+TpZYoTtU5OuloiTMdhJO4qCSfUUrQYsmUbJG
         0Mw+ysIvTcstsH1ObeEVLdT99vp+Gq4JNAzg34iML8fQg0BqRR8DrlCj+ahOwoVXtMnG
         VPmwdWQUBts65He+v+CjFIX9Vy3ted1U5e+gYH9/j2sJ/EPV+UpgFi49XSpCbX6epsSK
         DXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1bQbst9icU8PzrBH3x9FY5YwDFo9gdkmYY4v3XzOPoA=;
        b=vDUNkTt2kLT26M/CffOVvvP/a31UcE91xPDGioFtEYJlq8cT+8Y42efuSgn16Vjea/
         seWg/RygCm4uEebFRORaZrly+r4MFtTgLx4hzI48Ds2tedMpuJWvhKDAGlb98O5M3EC3
         6c7zs6JCaBF6+zCpkF5WuHety4XV3deVMA4YP/l2J5zY2Y/mDFgR70RnPQZeNMgW/lZF
         IhOjbpkF7ha7eMWubkAOFUgIgiu+DPLCLZIXlgLSHcTYNUVamUEch5UD4n91JR5seFId
         M6ltwsqbsbQxwpx+mmE3fEHlM+90uayp5vF58ii4EEsXNEK40h16zPSht0QfoPHCmaAl
         aT1g==
X-Gm-Message-State: ACgBeo2z7I2/J+4HvXatAPDnq2orr7IjJfNRlLUbSxqdUqkmqL8Xh6PJ
        A89/a8JkYTY4X6Qne04AMOvCmypGkOga
X-Google-Smtp-Source: AA6agR6/PQNxetyTw87QGRgI8/orhOO6IHB2AfZi0+8Sb9nacfASDTQusW/A7OtYG6QbLMmlsxbIIZ5mnXRY
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a17:90a:df03:b0:1f3:396c:dd94 with SMTP id
 gp3-20020a17090adf0300b001f3396cdd94mr626688pjb.1.1659328164765; Sun, 31 Jul
 2022 21:29:24 -0700 (PDT)
Date:   Mon,  1 Aug 2022 09:59:18 +0530
Message-Id: <20220801042918.292541-1-shraash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH] Bluetooth: Replace IS_ERR_OR_NULL with IS_ERR
From:   Aashish Sharma <shraash@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, groeck@chromium.org,
        mfaltesek@google.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aashish Sharma <shraash@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since bt_skb_sendmsg never returns NULL, replace IS_ERR_OR_NULL
with IS_ERR.

Signed-off-by: Aashish Sharma <shraash@google.com>
---
 include/net/bluetooth/bluetooth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 6b48d9e2aab9..a8b52175af05 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -494,7 +494,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 	struct sk_buff *skb, **frag;
 
 	skb = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
-	if (IS_ERR_OR_NULL(skb))
+	if (IS_ERR(skb))
 		return skb;
 
 	len -= skb->len;
-- 
2.37.1.455.g008518b4e5-goog

