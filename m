Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0502BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jan 2022 10:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352438AbiALKRh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jan 2022 05:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbiALKRh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jan 2022 05:17:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09DC06173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 02:17:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l8so3481187plt.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 02:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegavinli.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6P5X/xnkvM4++eid9TJLUIH5bXFuSLtccoKg9xRS+kg=;
        b=KjDXPJJEV8Cw7bI9QvSQDoFyYOSJneiXIzSF1fL6+tMipXXOJWbScPOTdpm70W9xSN
         c31IysSdeWkNmczV+ClMNDjNXAYPnSijQLP5MGxrcoei64lD9SojyMPzaYs6j+vRpRN3
         86SLnvE1sc/I4Pu1es/1HYyWrsGiuzsUdpwcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6P5X/xnkvM4++eid9TJLUIH5bXFuSLtccoKg9xRS+kg=;
        b=CA5LSHvtJv6tWhex9GHk24pOwt+Ia/2HskfSZOaGtOuq2hGyQs6DXbskJQnwTH9QrO
         xbnvt/CuWIXruqeTxTrmYM9ZMQyrNi8I86efl1+9dQrQbTFm9TlA7adfaQmfMyG+FqKE
         eDEK8zbXIBtyVw+6q4MetUZkp4Eeizpg/cSoUUa1Z5FOahqIrXlzrbpNPEQs92LfOVtR
         B/lIhPhvyNNh4P/qu6LP9F7m+JtvwBk8WoAFjVNKf9qdWzZs3j+KH/fyb9TShHI3h9Bm
         KPhPe/+vK6XtrhEwto7QjtRz3wxv2dRgIZLvx4QCILjDdbvBdgSe4A8CWlJ1H3iu/rMb
         /5QQ==
X-Gm-Message-State: AOAM531JjvRYLmfhnUom/H+te7Ox8/ixe1+PfaTjQH2uyhysEFPqOz73
        n8JQZVimr/MLiR/mSa9+5QcAi85bCrMTFHKN
X-Google-Smtp-Source: ABdhPJyATo0F72bZqjd2v1MDJCGMrbrcl7PmYpqMWDmGLBckc7vcM+BRqCFBYzhR5cbiRU8AsD5Qiw==
X-Received: by 2002:aa7:91c3:0:b0:4b0:eebe:49c0 with SMTP id z3-20020aa791c3000000b004b0eebe49c0mr8771250pfa.6.1641982656459;
        Wed, 12 Jan 2022 02:17:36 -0800 (PST)
Received: from craggy.lan ([2600:1700:42f0:8090::34])
        by smtp.gmail.com with ESMTPSA id l9sm1997421pgc.20.2022.01.12.02.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 02:17:36 -0800 (PST)
From:   gav@thegavinli.com
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Gavin Li <git@thegavinli.com>
Subject: [PATCH] Bluetooth: ensure valid channel mode when creating l2cap conn on LE
Date:   Wed, 12 Jan 2022 02:17:31 -0800
Message-Id: <20220112101731.77010-1-gav@thegavinli.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gavin Li <git@thegavinli.com>

After creating a socket(AF_INET, SOCK_STREAM, BTPROTO_L2CAP) socket and
connect()'ing to a LE device with default settings (no setsockopt), upon
the first sendmsg, the following BUG occurs because chan->mode==L2CAP_MODE_ERTM,
causing l2cap_ertm_send() -> __set_retrans_timer() -> schedule_delayed_work()
on l2cap_chan.retrans_timer, which was never initialized because
l2cap_ertm_init() was never called to initialize it.

  Call Trace:
   queue_delayed_work_on+0x36/0x40
   l2cap_ertm_send.isra.0+0x14d/0x2d0 [bluetooth]
   l2cap_tx+0x361/0x510 [bluetooth]
   l2cap_chan_send+0xb26/0xb50 [bluetooth]
   l2cap_sock_sendmsg+0xc9/0x100 [bluetooth]
   sock_sendmsg+0x5e/0x60
   sock_write_iter+0x97/0x100
   new_sync_write+0x1d3/0x1f0
   vfs_write+0x1b4/0x270
   ksys_write+0xaf/0xe0
   do_syscall_64+0x33/0x40
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

This patch ensures that when connecting to a LE device, chan->mode will
always be corrected to L2CAP_MODE_LE_FLOWCTL if it is invalid for LE.

Signed-off-by: Gavin Li <git@thegavinli.com>
---
 net/bluetooth/l2cap_sock.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 160c016a5dfb9..58c06ef32656c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -78,6 +78,17 @@ static int l2cap_validate_le_psm(u16 psm)
 	return 0;
 }
 
+static bool l2cap_mode_supports_le(u8 mode)
+{
+	switch (mode) {
+		case L2CAP_MODE_LE_FLOWCTL:
+		case L2CAP_MODE_EXT_FLOWCTL:
+			return true;
+		default:
+			return false;
+	}
+}
+
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
 	struct sock *sk = sock->sk;
@@ -161,7 +172,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		break;
 	}
 
-	if (chan->psm && bdaddr_type_is_le(chan->src_type))
+	if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	chan->state = BT_BOUND;
@@ -240,7 +251,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	if (chan->psm && bdaddr_type_is_le(chan->src_type) && !chan->mode)
+	if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
-- 
2.34.1

