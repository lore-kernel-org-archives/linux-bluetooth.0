Return-Path: <SRS0=tYwc=UC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649B2C28CC6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jun 2019 10:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDBA280BC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jun 2019 10:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EctMQ4ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfFCKst (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:48:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36507 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfFCKst (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jun 2019 06:48:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so26292063edx.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2019 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=55qif/+sqWE4Xb0B5Cxr17PZ9yp4wdN9b2ryTniK8Ns=;
        b=EctMQ4okKDCSGw+Fn/+vr+fngPWuTZELGo1rnm34gMUbLSSwWVI5y6yAhwlsLg18N7
         NOyBiewEoCfCbdlV9K1JegJ+YBbJ5UFhQdTST7ErBFli39+PH9nFGVn7mdEEjDlngMEU
         s5dkbD75Ssy19y8ZYdSzu6GTgQi+WMr5mqrAkQokkRdaF3dVIotug+c527oQf766Y9K4
         pLhMg0CoqWV+ucfYsK9qFDY4hxO4qzZGJIbiO24usjIT05IPohHlMVH6pG+qLgNf3mf/
         AmBW54QTMBuyXTVer3Cs5LQNJKO9OZ3gnyuuGffwXxZnhiIemsKFeXFMegHJgFNKHahF
         SuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55qif/+sqWE4Xb0B5Cxr17PZ9yp4wdN9b2ryTniK8Ns=;
        b=fKWFiLNzUTDmy0L7oB5Aqfg0ZII37MS54u2rINl9dp56YKBPZWFDlXaeTNq6LiYUNN
         EHhcYk6NieBrcqBFmnmfGU8NjQiwrUJmazz+JoEHRUAA2iin2VVVo0PPWvE6t2qizyUl
         WPZM0dQaFDgDO4i1KDTKoS21A9ckhV/qhzNKHdrJ/I8/vDYfJS04nfcnq3OqGDqKx1HF
         LlwX/ZP2eIS0mxIkr4RLfXjJ+yU/d2P8IkwKRp7j4KVqMyNa9nZWSxt+bjQrXjahMebh
         3qIiKZU2Ysb3a3cnn73mMo2R6yZLVOO+Ly8zhWgYWd+b0PVHhDXAF1jXyhbaObZiEXoe
         glGg==
X-Gm-Message-State: APjAAAWGunxpDspRSngWxwxnFIZ2vrLSh8cH3taj4BN7RJ2MjDFA9Qgn
        APlwSM9A6Gxqhbuu/cffFSfOrwEz2os=
X-Google-Smtp-Source: APXvYqxNvLdT810YTxkgrKimz5jpZfkTc4lP8zVu7ijBS67WmsM0YqwYcYXC7XRCi2+oKjn6p2KMFw==
X-Received: by 2002:a17:906:3594:: with SMTP id o20mr16534985ejb.73.1559558927511;
        Mon, 03 Jun 2019 03:48:47 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id d90sm3926207edd.96.2019.06.03.03.48.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 03:48:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] Bluetooth: L2CAP: Check bearer type on __l2cap_global_chan_by_addr
Date:   Mon,  3 Jun 2019 13:48:43 +0300
Message-Id: <20190603104843.26848-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603104843.26848-1-luiz.dentz@gmail.com>
References: <20190603104843.26848-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The spec defines PSM and LE_PSM as different domains so a listen on the
same PSM is valid if the address type points to a different bearer.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b53acd6c9a3d..8da73ca8c111 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -168,11 +168,18 @@ static struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 	return c;
 }
 
-static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src)
+static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src,
+						      u8 src_type)
 {
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &chan_list, global_l) {
+		if (src_type == BDADDR_BREDR && c->src_type != BDADDR_BREDR)
+			continue;
+
+		if (src_type != BDADDR_BREDR && c->src_type == BDADDR_BREDR)
+			continue;
+
 		if (c->sport == psm && !bacmp(&c->src, src))
 			return c;
 	}
@@ -185,7 +192,7 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
 
 	write_lock(&chan_list_lock);
 
-	if (psm && __l2cap_global_chan_by_addr(psm, src)) {
+	if (psm && __l2cap_global_chan_by_addr(psm, src, chan->src_type)) {
 		err = -EADDRINUSE;
 		goto done;
 	}
@@ -209,7 +216,8 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
 
 		err = -EINVAL;
 		for (p = start; p <= end; p += incr)
-			if (!__l2cap_global_chan_by_addr(cpu_to_le16(p), src)) {
+			if (!__l2cap_global_chan_by_addr(cpu_to_le16(p), src,
+							 chan->src_type)) {
 				chan->psm   = cpu_to_le16(p);
 				chan->sport = cpu_to_le16(p);
 				err = 0;
-- 
2.21.0

