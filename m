Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A45CC35DF8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF86424650
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHsXkF8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgBYHek (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:34:40 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38383 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYHek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 02:34:40 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so895938pjz.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 23:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IK76F8Hano/AjV4cpJJAOJ2mTmDW0uldHdnyQdU/cHE=;
        b=eHsXkF8MTtR593zoJQvUTu6ShHXcVqx2kUNAyy7Z8eamUgKHO0Ei38IqTmWrX+WOwn
         lItXUIStJdnAkx3g3i8poiEiP+YnfW0655kw5Vm/6PUMLmh1RDkW2ID6tju60z9LrGGI
         StlrYc4wMB1fIvG97TKcwkVT4X9XU35ieu1pHOrwu0ZDMxXh3iMzWLN39yckAbyMOA01
         WZNxWQ21asgKkq4z410fUgcUxibNq+BRaKNKcS6VB/yk22uZ1j+u5MPUBNYlupXx51tZ
         gAICapFLEtL49EHvYcUL/6qRvJZcAxJCfxSMA9UGjeiOAW0NbeOuzqvef8VrPbm/1RZq
         6T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IK76F8Hano/AjV4cpJJAOJ2mTmDW0uldHdnyQdU/cHE=;
        b=EywIXVKYmNzKdfNmC8652to4r8b7T7D/jvwsNjXWuBXtsLaIUBUnLsQHrojx4UzRg5
         GvqwjURIIp3f8UGds+Tb2AJpC1DNSzj1AkGu21BIyREUVKYmltXhVXrJu5Q42Ewy2+lq
         kObReNvh+/2Z64EGPeay9I574lvVpfz3yCtUA8BYko7NBiz/fS8kYFjTQrNDIGly1jbY
         dQtOtHwbBdtlDKwrw6ykfAuILqFfajr44HEn22Q1VgSoneDQhXUjKwEdzhpuohIGJJn+
         5WtqYWUyYnU3+zN2CopGvCduWTL1vghBRUlk6qKi4OXoHY0dBljkN1t14v7ppgbqdkPA
         TZtQ==
X-Gm-Message-State: APjAAAXKEPXYzMCpwN58TmvkaTpgfEGIiwFZJFKCO9Ow/7Xa9wvtpO8d
        5usQf2K+YpbnGzgkZ5Qe/jhqdTM+lws=
X-Google-Smtp-Source: APXvYqzLSlhL4GhOvl4MxhdxldTzPtSTEdIA0t8ftce4gJtZ91z5AjEphaFVJT2kZGMn6HoYPAOK3g==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr53551718plp.110.1582616078673;
        Mon, 24 Feb 2020 23:34:38 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id j125sm15642787pfg.160.2020.02.24.23.34.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:34:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/5] Bluetooth: Add BT_MODE socket option
Date:   Mon, 24 Feb 2020 23:34:33 -0800
Message-Id: <20200225073437.11212-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_MODE socket option which can be used to set L2CAP modes,
including modes only supported over LE which were not supported using
the L2CAP_OPTIONS.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  2 +
 net/bluetooth/l2cap_sock.c        | 64 ++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1576353a2773..c361ec7b06aa 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -139,6 +139,8 @@ struct bt_voice {
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
 
+#define BT_MODE			15
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 305710446e66..640cb461af9d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -616,6 +616,16 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_MODE:
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(chan->mode, (u8 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -641,6 +651,28 @@ static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
 	return true;
 }
 
+static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
+{
+	switch (chan->mode) {
+	case L2CAP_MODE_LE_FLOWCTL:
+		break;
+	case L2CAP_MODE_BASIC:
+		clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
+		break;
+	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
+		if (!disable_ertm)
+			break;
+		/* fall through */
+	default:
+		return -EINVAL;
+	}
+
+	chan->mode = mode;
+
+	return 0;
+}
+
 static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 				     char __user *optval, unsigned int optlen)
 {
@@ -690,19 +722,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
-		chan->mode = opts.mode;
-		switch (chan->mode) {
-		case L2CAP_MODE_LE_FLOWCTL:
-			break;
-		case L2CAP_MODE_BASIC:
-			clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
-			break;
-		case L2CAP_MODE_ERTM:
-		case L2CAP_MODE_STREAMING:
-			if (!disable_ertm)
-				break;
-			/* fall through */
-		default:
+		if (l2cap_set_mode(chan, opts.mode)) {
 			err = -EINVAL;
 			break;
 		}
@@ -952,6 +972,24 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		chan->imtu = opt;
 		break;
 
+	case BT_MODE:
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (get_user(opt, (u8 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (l2cap_set_mode(chan, opt)) {
+			err = -EINVAL;
+			break;
+		}
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.21.1

