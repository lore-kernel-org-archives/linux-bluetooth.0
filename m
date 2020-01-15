Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21840C33CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82B9222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW/J7nuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgAOVCb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:02:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38264 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgAOVCa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:02:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id f20so7341642plj.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 13:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TDyk5AyJqA9dAh536qpFA01HVC0HaO+c8TkZOF2IjWQ=;
        b=CW/J7nuqDvJRM8h989mTeYvvsFEXcNP3++hhXMJmlpCoV1a2OUBBE8l1O+QcUsqp0+
         BD1f/RvKaU4OfxJrkMGOSJbqS66wB8Kwi+n0YEk/kqfUfjfRmaGGYLAbtvPnmKe4z8s+
         ZcqHlWeydt+AMQgcmo6lJyzv2Kpq8x0KWAD16nq3g09yLPHj0nMqK1sHQ5DizlCF5F+q
         Fbsm6ypMO1VoMGJcpkftWmcFxOwSTWBMc9BFzdSui2s4ojE/xFY2Dfq3BfScVPzjNItx
         uEQrdmylRNOrh+XpD+6XasL9DLvfdB0+hXGzlOVRR44dlslHhm0WTD8huKFULym8kDel
         C3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDyk5AyJqA9dAh536qpFA01HVC0HaO+c8TkZOF2IjWQ=;
        b=e5CVtufCUv46zP7sD99RTRg6oVgbR1aWkxejZ0hajTp/S6Nz+OX74YS+pKwC5K5ed7
         fD5m7TQ9nbWtOzUaKBQjs2t2w8lj9I0SbSPCJlDbFoLWFLH+TlSKMGTJneeKlI4xydF+
         i7g+jwNH3KVWylpvICW5SNXRZqDPj4N5lwtaT+EmmZ5DaQoBaM3xuSidtrCO+OacSotp
         pGAm+qPOCdCLXkYUGfOKkv93vfk9l89Xz7DDsGSDMHD23BnBQOuRb3Mq/N6VzHDlqGdh
         YYL4D9lnvoz7TcIEOJL8MH632VkCzeHYH8xpesgP9WseIanrEK5RQnY5HyuqPfibH1a2
         yz4Q==
X-Gm-Message-State: APjAAAUUjnYOzLdioKcQgnw0DW5k3+0GEG2xzRgHViCwoDCiDI74LTR5
        nCcSkloV15HnzUL7nX492SsKDxoARk8=
X-Google-Smtp-Source: APXvYqynSVwsXLiPt5NZ6ScrN9+bgmi1je3PFQw7XLBh9uSvkx9z1spdlUYX53f8V2+soal+S9teXQ==
X-Received: by 2002:a17:902:a701:: with SMTP id w1mr26385558plq.165.1579122148995;
        Wed, 15 Jan 2020 13:02:28 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.41])
        by smtp.gmail.com with ESMTPSA id s24sm23290976pfd.161.2020.01.15.13.02.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:02:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 05/11] Bluetooth: L2CAP: Rename FLAG_LE_CONN_REQ_SENT to FLAG_LE_FLOWCTL_CONN_REQ_SENT
Date:   Wed, 15 Jan 2020 13:02:15 -0800
Message-Id: <20200115210221.13096-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115210221.13096-1-luiz.dentz@gmail.com>
References: <20200115210221.13096-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames FLAG_LE_CONN_REQ_SENT to FLAG_LE_FLOWCTL_CONN_REQ_SENT so
it is consistent with the naming scheme used for enhanced flow control.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 2 +-
 net/bluetooth/l2cap_core.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d81ed537984f..3b323c54dd0c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -765,7 +765,7 @@ enum {
 	FLAG_EXT_CTRL,
 	FLAG_EFS_ENABLE,
 	FLAG_DEFER_SETUP,
-	FLAG_LE_CONN_REQ_SENT,
+	FLAG_LE_FLOWCTL_CONN_REQ_SENT,
 	FLAG_EXT_FLOWCTL_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e6c8b2ed417f..da927fbb92a7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1309,7 +1309,7 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_conn_req req;
 
-	if (test_and_set_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags))
+	if (test_and_set_bit(FLAG_LE_FLOWCTL_CONN_REQ_SENT, &chan->flags))
 		return;
 
 	if (!chan->imtu)
@@ -5534,7 +5534,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 			chan->sec_level = sec_level;
 
 		/* We'll need to send a new Connect Request */
-		clear_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags);
+		clear_bit(FLAG_LE_FLOWCTL_CONN_REQ_SENT, &chan->flags);
 
 		smp_conn_security(hcon, chan->sec_level);
 		break;
-- 
2.21.0

