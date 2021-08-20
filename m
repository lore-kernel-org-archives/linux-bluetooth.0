Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2874C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 23:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AE061184
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 23:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhHTXlU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 19:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhHTXlT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 19:41:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B3C061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Aug 2021 16:40:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so3086224pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Aug 2021 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+ZkKcq8rQRo3ajx4rX93vlz/dXLPknKQg3FHrKdCxw=;
        b=S/Fq5gdAaWgBR5KAQmyJfSeOHB66N2Fk7YLGHNvreDJOL7nqdgM8dJpS5Ur+UP6UsK
         K1/CfwpLAlKJZC2l6kWG/tSH/sIEyIPc+xEKgOaGEKQYVAPdHope7MdDrZeti2ReASx9
         gycJTDjBLVPkG1ykLqcF/8gprdUcpld54vDa/+8RlA3VgNGnRWUzhnqN8zg0CeT2/X1f
         f094+U1uErwG7oZbvnxYWzD6Ffd41VNtUECnDo5LIcZbhEevTCqJOFdquv6UcPQNuD1Y
         upVEgXbSC+hw/0nYueBsclSnuaKc0SCCS4zGL/vLPSQNvXjoeF+A4B5JyhZk6nMom/ED
         UA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+ZkKcq8rQRo3ajx4rX93vlz/dXLPknKQg3FHrKdCxw=;
        b=cr+CunbtIQVnyUZa1OJ6OPhxgxZqxCkOCuD1YJiLnzn7yjTsWDLQqTddIz+ehqVg/3
         /cyVhjtunx5pJPrF1TYCSV+hATnRKdBm/UZvcjpYfVb4n30m4iGZcwj+1TVzq4MOjol5
         sbN35gB5Hm7j56kjMLKMOAQ3IxXVSjrL7rS9qk1Bc13Xi33pKSv3+nI8KiKXGOSzBNeh
         JdNpxWOfS8HH7aB5Ab6iG0bH43WranrTzWWGgYh5WYb1DHiCYotoVt/8l84b2i6foPp+
         xIsKjrvhxxC5jNGn36g7aXUUUDWbNegCMV/fkJBI81k/4/65PUzRACqQqfyfviQW5g//
         yZ8w==
X-Gm-Message-State: AOAM533q8n0VSgcRjg9zIVecr4fKdVjvrneUktaES931T+agSkkSdeXV
        dh0Qj/uHekZuhsn5toeSJIZoTHtte3A=
X-Google-Smtp-Source: ABdhPJyVYg6jlyMDjwi/T/7JO1IxKlvaubW+traDKhgjgjwXpqtexxPd213bCYBxW4is6VUWUMkJmA==
X-Received: by 2002:a17:902:a604:b029:12c:dda2:30c4 with SMTP id u4-20020a170902a604b029012cdda230c4mr17995752plq.73.1629502840351;
        Fri, 20 Aug 2021 16:40:40 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i20sm8336824pfq.35.2021.08.20.16.40.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 16:40:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix enabling advertising for central role
Date:   Fri, 20 Aug 2021 16:40:38 -0700
Message-Id: <20210820234038.586979-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When disconnecting the advertising shall be re-enabled only when the
connection role is slave/peripheral as the central role use advertising
to connect it could end up enabling the instance 0x00 if there are other
advertising instances.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0bca035bf2dc..293d4c9c4b09 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2351,7 +2351,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, status);
 
-		if (conn->type == LE_LINK) {
+		if (conn->type == LE_LINK && conn->role == HCI_ROLE_SLAVE) {
 			hdev->cur_adv_instance = conn->adv_instance;
 			hci_req_reenable_advertising(hdev);
 		}
@@ -2961,7 +2961,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * or until a connection is created or until the Advertising
 	 * is timed out due to Directed Advertising."
 	 */
-	if (conn->type == LE_LINK) {
+	if (conn->type == LE_LINK && conn->role == HCI_ROLE_SLAVE) {
 		hdev->cur_adv_instance = conn->adv_instance;
 		hci_req_reenable_advertising(hdev);
 	}
-- 
2.31.1

