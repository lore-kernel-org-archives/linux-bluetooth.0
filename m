Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D2FC18E5C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 10:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F21222D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 10:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQbeqMhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCJKJC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:09:02 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41474 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJKJC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 06:09:02 -0400
Received: by mail-pg1-f202.google.com with SMTP id t3so8314593pgo.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qgIz8ZXqxR+qL3nvVcdKU+rwgX72c7Lhu1jYDVFQ+gU=;
        b=QQbeqMhejQGLjzt6M3ysCxg/Kr0sB595VzRhzxXl1Qyg5zKnJoZVhIlwh37+vavyil
         83/8JvZT0fqzcjkaWOByFkuvWlIzxNDAUYUwvmlbNKoYUmavJoJJNvyyZjFscJ5KXAjo
         75irtwgv8v8foPo0mFf0/EjXqruZYB/MJFvg6aFl1s6bqF615/TI7e8njU1uYqrdfZ99
         ZMJGSgtji0wRcNyeB4kj7VHuDvUPYY6MkYZWsjPZ2rgYYmjMG5uocsW+go0mZ6asoKAC
         AjFfFRvJjIf2cKvyFzM4M2p8QS04LdABCKklWIWhC+WgsXJUxyyM0x+v2kG0Pkq9imDz
         qUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qgIz8ZXqxR+qL3nvVcdKU+rwgX72c7Lhu1jYDVFQ+gU=;
        b=hMaWGyy/98yCh+0gfToD8vof6xhukafEUyhflPbzBYhcHAzAuuV+IPU3bUte30ndC3
         ylicymXtmCCYSuWSQHwZlUgq/HR1sjG+UF+1J7y9FgbTNNobE/ng3Z6JyDE5aoLmba4r
         ZSFSHxVKN/wc6ElNH83KM7as1JxRt5ljv/sNAricD02KVDtO0xeJLlsg4Ht6wHE8KlNh
         jDwslO7cJfRTAx0Q6Om/nwiiltGSSEl2ahIJUFOtVwjU6ePx8mGMhIZWdAkS4DtBi8Cv
         XVJdz3DYsEebsKW2nNOGiWQ3EmMXMIt+gTC73hkaPe/2r7252+KZjWdcIcpWUfcXTNGh
         GNLg==
X-Gm-Message-State: ANhLgQ10Xey8uKXEnZAKXTb3yQbE2bz25W6LzM87Mp7emKLaBxQZcX03
        fvxKm7yNf/hSm+/kn/xXXu2xHgCY4pSpCWzEf9FDCu6VvzKjhdx3I7egYOSDTR+wwosnq76BPdI
        DrF7HdgsGZlxMvDlWmxwUAR7ejZTnGCrNYEAcgPIVlmIz1yHGVag1m4pVWe6cAQ2/m8WKt9ljQW
        D7k1CIHLIonM0=
X-Google-Smtp-Source: ADFU+vuz3HaWYBXcTimqnRcUDBF9dxFd4pjU5MyI1k3cXJJvIdcUkEfxqolA1dijJ5VKuTOLdcG8w5W6+bmEbeBoEg==
X-Received: by 2002:a17:90a:9908:: with SMTP id b8mr912701pjp.93.1583834941368;
 Tue, 10 Mar 2020 03:09:01 -0700 (PDT)
Date:   Tue, 10 Mar 2020 18:08:52 +0800
Message-Id: <20200310180642.Bluez.v1.1.I50b301a0464eb68e3d62721bf59e11ed2617c415@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [Bluez PATCH v1] Bluetooth: L2CAP: handle l2cap config request during
 open state
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to Core Spec Version 5.2 | Vol 3, Part A 6.1.5,
the incoming L2CAP_ConfigReq should be handled during
OPEN state.

Signed-off-by: Howard Chung <howardchung@google.com>

---

 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 697c0f7f2c1a..5e6e35ab44dd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4300,7 +4300,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
-	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
+	    chan->state != BT_CONNECTED) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
 				       chan->dcid);
 		goto unlock;
-- 
2.25.1.481.gfbce0eb801-goog

