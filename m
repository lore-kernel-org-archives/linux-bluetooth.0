Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F2DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 02:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiBOCCu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 21:02:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiBOCCm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 21:02:42 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1865914892F
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 17:59:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g1so12532102pfv.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 17:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bHPjfYHptf9otUjWtSYm2RENZWE1lh6de+mqIGnHXU=;
        b=BoTr8Irz0R/7fGrTY/FuXoS2f2N3D9ecntIvc9C0fAA7H4Ppvl/dAw2vW0fUWJqByM
         Z+9PHipNVpw7cNHQ48GPmE8Lqie95FgGunfRbgVNAYp2/oZ5Lhhlgmm4LYdHy0Ew2ZbC
         POAc2P2w+Yr0kjwF5upDsPXNBPyrrpN3css6zTTpTGl9dj8oG/GdDFctIsDbFi3gv+vZ
         ybUtlVK+iA286bODQMVHTOm8HipGmfJ6yV4oNxMeLCTf+PhEeU9LXajvEuPUP6e01tek
         yxwJL8htXanxYjaWHPQRkrD/KfJHQKH/pW8JUadjWI5qBFk0M94EdxNoUqvrKQoKTfCn
         X1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bHPjfYHptf9otUjWtSYm2RENZWE1lh6de+mqIGnHXU=;
        b=GKqCfuYMrX9HTK74Gr4Ltb9hT5OGw8ktGjfm2M+mHrwA5novKa8dk+55tmAYknSvvQ
         DgabQ6gr8pjXpOY6ef7DKYbyYtx6vLNOiF3jUmG56zttu7k6yBfhTWoB3AByG5XMeHXp
         DAHm9/UYPKGYRGroNhg6AEyYBDTkvbVnWSIiBPnxbNX1i92MfJ5XFGvWWl4hGx150jNc
         4r56rcX8VNUuxAOX0DaXCGlmqG0UTKgVsSFygk1dABtyDCd11kOcnYbeyqjFbT4o5egn
         mY/LMie3K+0G5f9EgJ80pchtl3LtoZFim2HKlYurb28vtSt8XmKeQR/2oDWs7+KGSnqM
         sk7w==
X-Gm-Message-State: AOAM5303CVhwZWxbP/k4YSHmVSSzq7/iLsx8EfZr4uNq0K9kFBElZRCM
        /2TIlt7KsaxNGlHBeo8aXGehoo88x8MsNQ==
X-Google-Smtp-Source: ABdhPJxJUoPJtxUrpTxd78jP9tHX0DhPCge9PSLNguvpH50XsrUwRdoaAOOJpJX4j5Wt7THdLjUIhA==
X-Received: by 2002:a05:6a00:16d3:: with SMTP id l19mr2000550pfc.7.1644890379357;
        Mon, 14 Feb 2022 17:59:39 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h16sm8740528pfh.40.2022.02.14.17.59.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 17:59:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix bt_skb_sendmmsg not allocating partial chunks
Date:   Mon, 14 Feb 2022 17:59:38 -0800
Message-Id: <20220215015938.1950978-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since bt_skb_sendmmsg can be used with the likes of SOCK_STREAM it
shall return the partial chunks it could allocate instead of freeing
everything as otherwise it can cause problems like bellow.

Link: https://lore.kernel.org/linux-bluetooth/aa3ee7ac-6c52-3861-1798-3cc1a37f6ebf@molgen.mpg.de/T/#m1f9673e4ab0d55a7dccf87905337ab2e67d689f1
Fixes: 81be03e026dc ("Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 4b3d0b16c185..a647e5fabdbd 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -506,8 +506,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 
 		tmp = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
 		if (IS_ERR(tmp)) {
-			kfree_skb(skb);
-			return tmp;
+			return skb;
 		}
 
 		len -= tmp->len;
-- 
2.34.1

