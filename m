Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C42C2BA17
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D19D2064A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NAUJPupj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgDFSEv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:04:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38058 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFSEu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 14:04:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id m17so347766pgj.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 11:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qWvReOTUfVQj/eWaEQUQpECI5Xx6jBeqXDjtEeOsERE=;
        b=NAUJPupjZj963s1Cr8fKU0Jy1k+DMM7aGyuj9Yd8vmUWe8ajf83rUMp+kyZVW3QJWZ
         nPn9BcchTp29ahM1MvN9OGajb8hGE6VJJ1ITy7lKCUQYPWVeLVL/ZgR4ONBzs/YUjwZS
         L0ji7zUT3oVrpPlYXOMqA/UXmgjD09RkfeD+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qWvReOTUfVQj/eWaEQUQpECI5Xx6jBeqXDjtEeOsERE=;
        b=eznR+oV/GgTlJxiR0XNOTwH+TIulRcrP9w4e01bSwveH2/PJ3Er4rGEvJbVVQEhIqk
         LUAtp00gsMUDukrr2SYx65XRH9K4iDVbcc08ub83Ekbz8gr01+A9omIyquU+c3mkjMBf
         jaynR1GpN7aGzJbuol+Mi5hJldz36yat57+NKITkdrv7PTP5R3950uhGfzDPwtEVNAGh
         rEw2yGVWOXnFs5dgPA8enb7ZwAhN0TTSZqBVXRf0WBj5wEHFUorKBuBYLlhutqWrVION
         Gt4OuLvYAnuiv6AFdQ6cxTtSvrfPrZwOSrfpx5jO+mk+8HZRhaYGWcigZCGbV7GZ2w+f
         IeHA==
X-Gm-Message-State: AGi0PubAdm85RsfSzO+OfJd66bywoAkHeapq2aTKe5sfkNxMNonSa5oY
        LDuTLd5vTe03YLlqZ2PH5Rv4Z+EGMf8=
X-Google-Smtp-Source: APiQypKHFbVNzztcDb6XJ0pLeQWlyYRgW9b0APDNJhMQ9JfTFbcjXj1Q69o+gdhko1CpEmTS0p2BPQ==
X-Received: by 2002:a62:5187:: with SMTP id f129mr708538pfb.144.1586196289866;
        Mon, 06 Apr 2020 11:04:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id l59sm909604pjb.2.2020.04.06.11.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:04:49 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH v2] Bluetooth: Always request for user confirmation for Just Works (LE SC)
Date:   Mon,  6 Apr 2020 11:04:02 -0700
Message-Id: <20200406180402.7782-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <DB9E4FAE-C54D-4158-ACE3-45B62C85E2CB@holtmann.org>
References: <DB9E4FAE-C54D-4158-ACE3-45B62C85E2CB@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To improve security, always give the user-space daemon a chance to
accept or reject a Just Works pairing (LE). The daemon may decide to
auto-accept based on the user's intent.

This patch is similar to the previous patch but applies for LE Secure
Connections (SC).

Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
---
 net/bluetooth/smp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d0b695ee49f6..2f48518d120b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2202,7 +2202,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (err)
 		return SMP_UNSPECIFIED;
 
-	if (smp->method == JUST_WORKS || smp->method == REQ_OOB) {
+	if (smp->method == REQ_OOB) {
 		if (hcon->out) {
 			sc_dhkey_check(smp);
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
@@ -2217,6 +2217,9 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	confirm_hint = 0;
 
 confirm:
+	if (smp->method == JUST_WORKS)
+		confirm_hint = 1;
+
 	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
 					hcon->dst_type, passkey, confirm_hint);
 	if (err)
-- 
2.17.1

