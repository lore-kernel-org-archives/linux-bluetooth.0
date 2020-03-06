Return-Path: <SRS0=yWdD=4X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEADC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Mar 2020 22:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF250206D7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Mar 2020 22:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJUoFOE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFWvb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:51:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40899 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFWvb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Mar 2020 17:51:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so1454638plp.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2020 14:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAx5Mh50NmUHRMRjnYfpTTjaxbg1dtH0gM5doNjpHa0=;
        b=iJUoFOE47gIqyrU++HYA5PMK34+0tD4UlfJ0wUa1y2dSGOnDqezk22YXjHSAJARuAw
         mEPClH8gS9/8DJ2qXRXUt1mmCO1bHNDF3msOg1NJn0CdbsdM2/EJSWOSAiXj3yf6lJ1X
         GpZE+Nf/Esr4xmJsuPPiQbd3VHYw7wYNfp4hXU++1UqpgkuR4EOTUWmXZXbp/k7orDvM
         RhYr8tu/NUBZncmQs3VgW3Fq4Ou8GdPSOtQhRb1e/ypJHi4GWF10J1Nv3deI6O+v2JPZ
         0K3/kSTh1IaLQTFrRNITuPt1bZ4Aot0IA9IxxZas18ewVrv1k6GnCje2yIchvNGnJhkK
         0yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAx5Mh50NmUHRMRjnYfpTTjaxbg1dtH0gM5doNjpHa0=;
        b=nQGDSmA7FGFpJXl3mzpjT4qLvLKoX9j5sgvfklSKslQt44fTjk/CBQlj8t3jag2CZI
         Gjr8g3wfhaasmHkrmb+sx2fhBJ7gnq4kjK78xp1kkO11gsjHr6cUUeS8j7aIPrWpTRQv
         tQ2+zL3vhxPQgKV1dXvA4SeqJmE/hWqOi1PweVLPgJBmeo8fLBaeNosVIIsaKVmvtWn3
         NO6Gk4DB7sqbGeRKYtU9rUuxuwyOeEXHEv6CO6onKNja9wrr9q35GUub5gTgE92W8pKv
         QCzyJLytGjZS+lzaRtU7mGvPoYLDXEYUXBDhcqQL1G8tm2zgF5nwi+LtYBeOu2Q+yBXD
         yyYg==
X-Gm-Message-State: ANhLgQ0Q11eyi8nyjtzJeGkUXgFNxvHlLzyxlxzCX9/f311uvxqIoytB
        9AH+WmgRAiQHRIMGG8cWSlwPovwTicE=
X-Google-Smtp-Source: ADFU+vvowdpc7B2AvPPDhBrV6103eb6Hkilo5lZuARCZrwik5/eBXqES8St4S6+kyPvyZsjq92mFRg==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr5150420plq.101.1583535089583;
        Fri, 06 Mar 2020 14:51:29 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e12sm6416577pjw.3.2020.03.06.14.51.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 14:51:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Make use of skb_pull to parse signaling PDUs
Date:   Fri,  6 Mar 2020 14:51:27 -0800
Message-Id: <20200306225127.9824-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull when parsing signalling PDUs so skb->data for
pointing to the current PDU and skb->len as the remaining bytes to be
processed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8eb483948565..d13ed5b7f725 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6379,9 +6379,7 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
 	struct hci_conn *hcon = conn->hcon;
-	u8 *data = skb->data;
-	int len = skb->len;
-	struct l2cap_cmd_hdr cmd;
+	struct l2cap_cmd_hdr *cmd;
 	int err;
 
 	l2cap_raw_recv(conn, skb);
@@ -6389,35 +6387,34 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 	if (hcon->type != ACL_LINK)
 		goto drop;
 
-	while (len >= L2CAP_CMD_HDR_SIZE) {
-		u16 cmd_len;
-		memcpy(&cmd, data, L2CAP_CMD_HDR_SIZE);
-		data += L2CAP_CMD_HDR_SIZE;
-		len  -= L2CAP_CMD_HDR_SIZE;
+	while (skb->len >= L2CAP_CMD_HDR_SIZE) {
+		u16 len;
+
+		cmd = (void *) skb->data;
+		skb_pull(skb, L2CAP_CMD_HDR_SIZE);
 
-		cmd_len = le16_to_cpu(cmd.len);
+		len = le16_to_cpu(cmd->len);
 
-		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, cmd_len,
-		       cmd.ident);
+		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd->code, len,
+		       cmd->ident);
 
-		if (cmd_len > len || !cmd.ident) {
+		if (len > skb->len || !cmd->ident) {
 			BT_DBG("corrupted command");
 			break;
 		}
 
-		err = l2cap_bredr_sig_cmd(conn, &cmd, cmd_len, data);
+		err = l2cap_bredr_sig_cmd(conn, cmd, len, skb->data);
 		if (err) {
 			struct l2cap_cmd_rej_unk rej;
 
 			BT_ERR("Wrong link type (%d)", err);
 
 			rej.reason = cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
-			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ,
+			l2cap_send_cmd(conn, cmd->ident, L2CAP_COMMAND_REJ,
 				       sizeof(rej), &rej);
 		}
 
-		data += cmd_len;
-		len  -= cmd_len;
+		skb_pull(skb, len);
 	}
 
 drop:
-- 
2.21.1

