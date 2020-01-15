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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861AAC33CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFB22187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX+wcBxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAOGgl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46928 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgAOGgl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so8006613pff.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TDyk5AyJqA9dAh536qpFA01HVC0HaO+c8TkZOF2IjWQ=;
        b=SX+wcBxQZGxK2aCfVvyVTfRRY58XTh7ZIb8WpLXXoAhFS96auUwSDilh7iA/AvuHRU
         hLVTiYw2sy8a2La7x2W2FySpysmpegj0YVT4kpAIm6ipAH0axgGB45s5/gRnqoe0u3yg
         cnpt6y7g0ATK0rpRHc3eCVPMcbNCrRhR+aRpoMnszQKCgX1IGzqLEyeheZbm/XnvqsB0
         vGI0sIvOK6rK8upRW2oHJdAccVXtxM5GCT/Ty9rM3CKNAADmJEiGlqe5B8PC2yfC1OSC
         MoeHjIirc0h6dLLLdaWm5mEFgnNwYfLyeDzlFGpYtNKHwysaZEj3F+Xu7UGacC+VpL2T
         UkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDyk5AyJqA9dAh536qpFA01HVC0HaO+c8TkZOF2IjWQ=;
        b=fjWFLU+L7Rf2R1PQzZeBTXarR+04kZwvFD38FWlEvXnA4BcKdj6AyINF8heQMxSxtm
         m2c1cpBDl7n4zDDC2vX3SZa5peGhNQ56FdzQYEiZfRUZ7ki7r33ywEoTuWcFGHMVIRya
         f975uRwotQX6Sy/FpxsDnE7FeyD7J5lKUS3x7r7GsGIFJJozHMqfIt5JpoMWa2s/wLL8
         SBhyYd0fv9TeJrafKfU7RhesVSRNzyT2dgrV6ZYLV8SyHNz49lVVnyd0Q6KGGXsFWthK
         zoGWdI8LCBC9S6rb6LlCaX/Tuv7BjBTp6qkp/oGU71sO1mqubL0uIbJXuVi3wWxpr8Vz
         URpw==
X-Gm-Message-State: APjAAAX6iwV/BTyirv02amXE5RIClgq6g4eySndcw7t5TzfAfo16z5ks
        vGzkT47B7r39om9oMJfKxN43ZAhaQ+0=
X-Google-Smtp-Source: APXvYqye0/USkRDZDn9vp1UCzPd+xV/OcTYeD6flHmtMGoFwQCWXoHqqTO1g5MGEy4HEQG1LTerdwQ==
X-Received: by 2002:a63:6c09:: with SMTP id h9mr30780902pgc.34.1579070200401;
        Tue, 14 Jan 2020 22:36:40 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id z19sm19725594pfn.49.2020.01.14.22.36.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:36:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 05/11] Bluetooth: L2CAP: Rename FLAG_LE_CONN_REQ_SENT to FLAG_LE_FLOWCTL_CONN_REQ_SENT
Date:   Tue, 14 Jan 2020 22:36:27 -0800
Message-Id: <20200115063633.32441-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063633.32441-1-luiz.dentz@gmail.com>
References: <20200115063633.32441-1-luiz.dentz@gmail.com>
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

