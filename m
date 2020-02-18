Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B121BC34036
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A67B24649
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 11:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6TrpqGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRLFU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:05:20 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47066 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgBRLFU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 06:05:20 -0500
Received: by mail-pg1-f201.google.com with SMTP id f5so13728909pgn.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CAoGK0unI+k/xLNKWQdh/lAz4VEEtKso1RLerS+jz98=;
        b=o6TrpqGwRyQGGsIaFlxwYKueoWgUAF4oLyN9Z3JTTL7WDa7Y45dVKy3jvooyfmhZal
         c88Ik7pzARj6rngW3H4f35VaNEbgNOHMBModA1la5bjN7qgpfUN4aYp/5fiY++J8uTX5
         7NzMK7/5IFSWXrCT2gUamB6pnGF0OVVh997QnEhkaXjCL7th7EHVPp2mhIVZg8rvBFIp
         cmm8ei+0ULdDQRGUrxXgd158260yWzyXBxa1HHyYWWYh+WOCMsiBseJkaF5qDjVEKTCj
         7kNb8u00EIQTLAMtbIBMnhnzVvuZ3hT13+X2WYS+FUTAWhj/moREt93bkbfABL/TVgl2
         XpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CAoGK0unI+k/xLNKWQdh/lAz4VEEtKso1RLerS+jz98=;
        b=qYkcpmYuNb91p3b5HvhKFhOZ7fumEU83GI5ISx3f2mTv27nxl20IS7l2SQOZo4A7qh
         BqZuLH+og1EeLLEB6Hap99APj47+vSPgmRVcWtUuPHEIXV2WMTicJ75uJpixQs8ht6mh
         TPzoAAoRiSCdmnq8qryD7iSsyaKwzOf67k5szh/bTiyrI0go2jNlui8YWZk6/0dnAyco
         R1q/06hf4MiGq1hHp7d0zozoYI8YIVSkETxOjiCDLq56H0pPPHCOku3Wo/Vr1Bk8RXNK
         EWuHblFVdKWOp99PEcq+nc72NveSYxIWbYvFQPUAZXlEX8hPHQu5HSgRzJG3QXR5z7/a
         fxUA==
X-Gm-Message-State: APjAAAWGfWSSTBmWdCrmtbk36jV1B/I3FCY3595o2e/36w4IwUWALhVw
        63+LtF4SdY2F5M4T4rNux+0ZnziUxUSAxW6ac6cTLvVlr9VR3JTLzuXtggl4W4bEUZEjFDwPYE1
        scNOGYEGcMG8MzHF6EqDxXwQUSo+Uvit1QZU7rgNuaG7vKcJt7AOUmP9hshqR/idGlsm0LgR7Hd
        6AuptSc9Az138=
X-Google-Smtp-Source: APXvYqy8QXu88UfVxv1mCeKTOtVGqBAda09uLXAcnx1IfRX/aGLHvD+3P7BIZvf5E9bFI9KyVQXAtyUv9pxhStFRHg==
X-Received: by 2002:a63:6383:: with SMTP id x125mr19783198pgb.409.1582023919543;
 Tue, 18 Feb 2020 03:05:19 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:05:13 +0800
Message-Id: <20200218190509.Bluez.v1.1.I04681c6e295c27088c0b4ed7bb9b187d1bb4ed19@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [Bluez PATCH v1] bluetooth: fix passkey uninitialized when used
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        "howardchung@google.com" <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "howardchung@google.com" <howardchung@google.com>

This issue cause a warning here
https://groups.google.com/forum/#!topic/clang-built-linux/kyRKCjRsGoU

Signed-off-by: Howard Chung <howardchung@google.com>
---

 net/bluetooth/smp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 50e0ac692ec4..fa40de69e487 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2179,10 +2179,12 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		 */
 		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
 				 hcon->role)) {
+			/* Set passkey to 0. The value can be any number since
+			 * it'll be ignored anyway.
+			 */
 			err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
 							hcon->type,
-							hcon->dst_type,
-							passkey, 1);
+							hcon->dst_type, 0, 1);
 			if (err)
 				return SMP_UNSPECIFIED;
 			set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
-- 
2.25.0.265.gbab2e86ba0-goog

