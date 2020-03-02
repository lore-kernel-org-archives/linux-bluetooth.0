Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E314BC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 21:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A72214DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 21:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHY0hnln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgCBVco (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:32:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39568 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCBVco (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 16:32:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so316031plp.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 13:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iiBww5T0liLTQo9idkZdPdBXUSr8GhdCY90/l+BLa+Q=;
        b=kHY0hnlnB9hvsgsiQbMoC9IxhvXEHruv1ZLgzFCtBtAYum1XEEo3xwjmE6GwzwCYHV
         hrxSeBuOI7jplANKQfsP/C+/KLUsWQQmi9j5HXnibVzV6BT94ym0oyhid37XcaVLwzxl
         6mX3Yt83LcC1JHGAtdG0d/yTV6V9H+2KM4zrzLrPtoIzMci/qbhe6HkPZ4fYtPPe24oD
         hraly7794AJgYu7DjwE0Tc+KgV0UxUlt6lATWpZi9DLBkuUUhe80//s7v19KyKeHruGK
         HIG1Lbo2k3r6Q7e5DeWSGRIsoiA7M0AfTULFXk+EwUbHsKH1vGfr9cDPcXXCo/cBuW05
         yqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iiBww5T0liLTQo9idkZdPdBXUSr8GhdCY90/l+BLa+Q=;
        b=lDVKQrqp3hvU8rAVBq77VlwWfrS5mmPmnhwHP1VcoB33lDqhU+sG6JgqD7XQ6UKCpc
         zoWQW7uk4VOK0x7OfxYxPf56iq3wvqwHBc79xnhPZzLpaZKRGHYY0DdzcQl51/nI0ETU
         fz8wTg3G5H04xPMjUMV3dtvGkxOMJFZEHk+GLSdTQh14lHlbxv/kWDppwhWdizEqarXu
         2//T0prh3ydnnf4DDP2aBnun8TuVRf0OtmfQRNDIAMG2e4zQCdpsuFLnmhBUIEKkdfAP
         rDDfv5whlfEPjfODaTDqd+e1TpUudb2Fu5M3TeOXXay+CE5O6IWX1BYP7Isi29+DrYoh
         G+Rg==
X-Gm-Message-State: ANhLgQ177avmrrnssG16cZrld8Q+PVhfdJ/B7xNXGey5veC8hxsQaad+
        YQaQDqHTCISoOSQBkwqvrbRZSH94E44=
X-Google-Smtp-Source: ADFU+vs5Lj5nbz/4j3/oliajS5Ov32GvEeIRV+ohKL0d3mmH0sEKnFRUFyUD0YZeuuZag4sXDqaGuA==
X-Received: by 2002:a17:90b:3612:: with SMTP id ml18mr488215pjb.148.1583184762451;
        Mon, 02 Mar 2020 13:32:42 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i22sm22183749pgi.69.2020.03.02.13.32.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:32:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] Bluetooth: L2CAP: Add module option to enable ECRED mode
Date:   Mon,  2 Mar 2020 13:32:36 -0800
Message-Id: <20200302213237.19540-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200302213237.19540-1-luiz.dentz@gmail.com>
References: <20200302213237.19540-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This should make it safe to have the code upstream without affecting
stable systems since there are a few details not sort out with ECRED
mode e.g: how to initiate multiple connections at once.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 15 +++++++++++++++
 net/bluetooth/l2cap_sock.c    | 10 ++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index dbe68b06d4bb..1644c9651a35 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -958,6 +958,7 @@ static inline long l2cap_chan_no_get_sndtimeo(struct l2cap_chan *chan)
 }
 
 extern bool disable_ertm;
+extern bool enable_ecred;
 
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5c03baffc82c..badfbbcc0de4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -45,6 +45,7 @@
 #define LE_FLOWCTL_MAX_CREDITS 65535
 
 bool disable_ertm;
+bool enable_ecred;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
 
@@ -5849,6 +5850,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	int i, num_scid;
 	bool defer = false;
 
+	if (!enable_ecred)
+		return -EINVAL;
+
 	if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
@@ -6092,6 +6096,9 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 	struct l2cap_chan *chan;
 	int i, num_scid;
 
+	if (!enable_ecred)
+		return -EINVAL;
+
 	if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto respond;
@@ -7726,7 +7733,12 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	case L2CAP_MODE_BASIC:
 		break;
 	case L2CAP_MODE_LE_FLOWCTL:
+		break;
 	case L2CAP_MODE_EXT_FLOWCTL:
+		if (!enable_ecred) {
+			err = -EOPNOTSUPP;
+			goto done;
+		}
 		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
@@ -8304,3 +8316,6 @@ void l2cap_exit(void)
 
 module_param(disable_ertm, bool, 0644);
 MODULE_PARM_DESC(disable_ertm, "Disable enhanced retransmission mode");
+
+module_param(enable_ecred, bool, 0644);
+MODULE_PARM_DESC(enable_ecred, "Enable enhanced credit flow control mode");
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 19123c268ce3..2a9fa588e554 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -273,7 +273,12 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 	case L2CAP_MODE_LE_FLOWCTL:
+		break;
 	case L2CAP_MODE_EXT_FLOWCTL:
+		if (!enable_ecred) {
+			err = -EOPNOTSUPP;
+			goto done;
+		}
 		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
@@ -985,6 +990,11 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_MODE:
+		if (!enable_ecred) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			err = -EINVAL;
 			break;
-- 
2.21.1

