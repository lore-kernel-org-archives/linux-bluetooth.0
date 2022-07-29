Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524F9C00144
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 18:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiG2SKr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbiG2SKp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 14:10:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493E17AA7
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 11:10:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w7so5263965ply.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g970CJ/QxOtGbj0HnyeklP/mSzB8FTNV36hJH87eGJs=;
        b=TSSx5w20zD14HDbmuC0lD2GJvrYm4ymp9RUqQmt+wAtiRRrl6g+890UL+tP8vQduoR
         ohYsxw5Vu+uilMgyBSJQfGr57XnQ8o2qgDSDq2itEkjzfqLawIzv0Dz2QWEMFoYlOaej
         uP0eHoRRTnP/6ZgrTejeZrvBEaYylM++nw9OzyCN9dKIs3NdtXuh8v1UK/HuVSX7JbiT
         FgJxYRkclL+80TfHGGaPmwKQcrgFsFUJ1T0Mr1GVjM1IFx3/s144kl+8qum4mt78Kjat
         pypwI4cC0FX7eHfpiK9F135LJlfpu2sJm9z03vTibUHdhc3LCDlRZy27ASgQhdzmnMbw
         SJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g970CJ/QxOtGbj0HnyeklP/mSzB8FTNV36hJH87eGJs=;
        b=aFOuib9lfvjPQouPfWp/7xTGawC2eEMJ30vE+Ngsi2QiSNT0TcxZVsqy5/dL+CZ+ky
         3JWKHgw3rXLFCPmtS+ciFeGhi+GTK9S+y6/1eHRFXUEnvh1Y8RqEUaPGci7CjJuV5YEk
         XPagXIxNKpvp0DJC6cD13xqe7flWOAVgfeD5cKWmLPYBiYTc4CIOZDZ1od0+MvdfyzAV
         dURPliRCVMAHXfvr5S49uEw+QLpMxYTlsPfiw1kMc/sziyYyqMzG2QUzcL/gIxfvV7+a
         xDCwZDdxXo/qKvTmwt3dx63PxW9EM5aoSKqioV6LPgCK1cFHP/6BHBwzvlyN4dN8F27f
         azSw==
X-Gm-Message-State: ACgBeo1jdWRCDhhTA0iAbG23P/xRAdKcUa0GMMVtdT3ikcP79irN62V6
        ZMgZtShzUWYnkJ9XC+MzMWpfcXcZHepTKQ==
X-Google-Smtp-Source: AA6agR6ki51u2TzqLas883AyhjlEkccqVZvZ8ZEc9098CUafpJnZCHAGIxuyzhm3x83ttV2JSDx3pw==
X-Received: by 2002:a17:90a:ab8e:b0:1f2:1ffe:51ed with SMTP id n14-20020a17090aab8e00b001f21ffe51edmr5933396pjq.28.1659118243496;
        Fri, 29 Jul 2022 11:10:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mn20-20020a17090b189400b001f001acc0e2sm6285279pjb.41.2022.07.29.11.10.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 11:10:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Fix memory corruption
Date:   Fri, 29 Jul 2022 11:10:41 -0700
Message-Id: <20220729181041.1571220-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following memory corruption can happen since iso_pinfo.base size
did not account for its headers (4 bytes):

net/bluetooth/eir.c
    76          memcpy(&eir[eir_len], data, data_len);
                            ^^^^^^^         ^^^^^^^^
    77          eir_len += data_len;
    78
    79          return eir_len;
    80  }

The "eir" buffer has 252 bytes and data_len is 252 but we do a memcpy()
to &eir[4] so this can corrupt 4 bytes beyond the end of the buffer.

Fixes: f764a6c2c1e4: "Bluetooth: ISO: Add broadcast support"
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/iso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index dded22cde0d1..70c2dd30cb13 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -44,6 +44,9 @@ static void iso_sock_kill(struct sock *sk);
 /* ----- ISO socket info ----- */
 #define iso_pi(sk) ((struct iso_pinfo *)sk)
 
+#define EIR_SERVICE_DATA_LENGTH 4
+#define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+
 struct iso_pinfo {
 	struct bt_sock		bt;
 	bdaddr_t		src;
@@ -57,7 +60,7 @@ struct iso_pinfo {
 	__u32			flags;
 	struct bt_iso_qos	qos;
 	__u8			base_len;
-	__u8			base[HCI_MAX_PER_AD_LENGTH];
+	__u8			base[BASE_MAX_LENGTH];
 	struct iso_conn		*conn;
 };
 
-- 
2.37.1

