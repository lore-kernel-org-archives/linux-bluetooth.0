Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7DFC04A68
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jul 2022 22:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiG1WMA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiG1WLz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 18:11:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB731796A6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 15:11:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so3532262pjf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 15:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKRR2VzkpItQ1F1vECQmRdUFE46CzeX82qrAqlrMOvQ=;
        b=Ubm6YL2hUf8SEmp2Snao+tOQs7Ln+b+/1lTFGh+oB1CWgsrmsYinayTDwIx6yEvC/O
         Vq6KoQRoN8jeq2OY/4w8fUIiqljyx7XCnScNg+OeZg3b7Ul6MTnKG/BmkgpYJ60f4PdX
         nAwd0lORpJVTXVTTGkve1+KRDxQpVnbn5FA2j02M95TLaV8wGiPtTaoXZnTkFcz1r5k6
         yy/G6CYN1yEMfeabxgIzm4TAfGHg1pBkqNt8R9QFvlLBRziQvdzctY8UE31qPSFP+cva
         kftahco0BNVL1FUl171ryLsyLdtfWhegDkDJqU810HvZNq0zjlmH8r8LGKjTtIB4lnvF
         ab9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKRR2VzkpItQ1F1vECQmRdUFE46CzeX82qrAqlrMOvQ=;
        b=yfd+NH+qvsd+EIdemgsHZX7kYwBe+zDUjN3VvjQUNZN8IxyifhafsSAoU5PEcMrgMN
         DHSH/RxHnJHKnBArBYdAGVFG/S0x2fVG+NhKOLyteUPKWlZ2vbvdKtk+zs99XxHvqh3Y
         +J3cl9rlDUEO/XKUye001S4yl7ARLzjc2N5Bj2ChGy6dY01/iYlx68TVYW4t6AUhME3/
         eV/JHwVQ51PBA1q2mkNksSM6dJmcl79an1t45U6TVsT2iC9iGZqmR+yj/CSNXPI4MT8u
         oi2pOUpi92yVhlKGaLsUtH19i2MDFSlCYexBWmCpKrkm2VbE215UDP/SaVNsm9zEmZBq
         vKfg==
X-Gm-Message-State: ACgBeo0FhanRO/bGQRZI6j48FiDgr/ABXLe/xTL6hylGahik8yxkf4+T
        knOs1A1djCjSOZGl/NrI2IdQ5ZY2tB2cRA==
X-Google-Smtp-Source: AA6agR4NBywA9v7bx7Xo4nb8G8+ALTszr3tmWIHzKRBovs6ZvWKgN/qe9A7S9XbZaM/KtO6/R8xXKA==
X-Received: by 2002:a17:902:ce83:b0:16c:2e89:d640 with SMTP id f3-20020a170902ce8300b0016c2e89d640mr853244plg.23.1659046306657;
        Thu, 28 Jul 2022 15:11:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b0016a5384071bsm1907104plh.1.2022.07.28.15.11.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 15:11:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Fix info leak in iso_sock_getsockopt()
Date:   Thu, 28 Jul 2022 15:11:45 -0700
Message-Id: <20220728221145.1301230-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The C standard rules for when struct holes are zeroed out are slightly
weird.  The existing assignments might initialize everything, but GCC
is allowed to (and does sometimes) leave the struct holes uninitialized,
so instead of using yet another variable and copy the QoS settings just
use a pointer to the stored QoS settings.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 19d003727b50..dded22cde0d1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1235,7 +1235,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int len, err = 0;
-	struct bt_iso_qos qos;
+	struct bt_iso_qos *qos;
 	u8 base_len;
 	u8 *base;
 
@@ -1261,12 +1261,12 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 
 	case BT_ISO_QOS:
 		if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
-			qos = iso_pi(sk)->conn->hcon->iso_qos;
+			qos = &iso_pi(sk)->conn->hcon->iso_qos;
 		else
-			qos = iso_pi(sk)->qos;
+			qos = &iso_pi(sk)->qos;
 
-		len = min_t(unsigned int, len, sizeof(qos));
-		if (copy_to_user(optval, (char *)&qos, len))
+		len = min_t(unsigned int, len, sizeof(*qos));
+		if (copy_to_user(optval, qos, len))
 			err = -EFAULT;
 
 		break;
-- 
2.37.1

