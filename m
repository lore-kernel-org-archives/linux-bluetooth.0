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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D537C33CB3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FF22467C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0FYqiYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAOGfc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:35:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39153 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgAOGfc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:35:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so8024179pfs.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TDyk5AyJqA9dAh536qpFA01HVC0HaO+c8TkZOF2IjWQ=;
        b=c0FYqiYSIIcoDAXsCBSL5Qiti63MS1UOvDsJQkByLOUdu+mvcd47Tx4BCtjCnhil9V
         IqwNaE0+xOctKLYt7bn8HRP1gwMNWsBPEA2wIE36YkzrcI5w6g4ZiC3CkIYqtZrky6qB
         eL10KMau8WClVQNTIuimlhuixLWSNn/0T/MyXsprE07eUmFZ2d5zFYMo++okeZ+VO6fU
         DDAbRunAZqiXWgrthoDwqB71n/QvnHIgMr6dRhtoB3eXwWvTiZ0o2jXDk16XOzLOPdFL
         SZHXvLHiVtPXS3JHEzhNPIXg3W7Bn/Ky3Xc98mR5JLK6P/fHUTgeIMkVYFTbLG5qErz6
         4Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDyk5AyJqA9dAh536qpFA01HVC0HaO+c8TkZOF2IjWQ=;
        b=pI59offCOjT5DTnWrWsNUFEEZQnU+/ZtOEYJnF4SQUFblT6TDE7uxWhgzWP8feazGg
         IcJV8dP/4OQSI2q9pP5RSPZ0QyLDSXx+NlOvWxy2Jndj9RX8P/7+63pBFbofNR7L7sR9
         9B9MQsQ7S0D0lwiAICDAmVr3Z3/HimRWSLF9UCIdIOmo1V0ZGX5ZfIn5cQ7O/kmYl1uA
         CDWca7Me70L+/TzLVm/LeHlzwMfKItq5tanWxb2stfNuX5UZH2CGwseywdrgJUCBOwvD
         25O8bla92GGXnuHd7VZ4nD/FRgxXbm7CDGdOZK7si7gDOVzHw9DWQRvAC0zGkNsdjq4Q
         LVUg==
X-Gm-Message-State: APjAAAW0pVopzaHAbDidwbZ7ChHF9dt8a3JKRlqlvl5UVzzbzliBPRBE
        P+mFyMy7EnuYFOQp+7vVjf+Gve/no1Y=
X-Google-Smtp-Source: APXvYqxgdbqinTjsteWKWM6gJWXBXNvvR0/B8gOqVtFkjV3X/pLkhsuuLXCst9yWtVczX1Mtm9uqYg==
X-Received: by 2002:a62:8782:: with SMTP id i124mr29239037pfe.22.1579070131276;
        Tue, 14 Jan 2020 22:35:31 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q21sm19637469pff.105.2020.01.14.22.35.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:35:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 05/11] Bluetooth: L2CAP: Rename FLAG_LE_CONN_REQ_SENT to FLAG_LE_FLOWCTL_CONN_REQ_SENT
Date:   Tue, 14 Jan 2020 22:35:14 -0800
Message-Id: <20200115063523.32127-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063523.32127-1-luiz.dentz@gmail.com>
References: <20200115063523.32127-1-luiz.dentz@gmail.com>
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

