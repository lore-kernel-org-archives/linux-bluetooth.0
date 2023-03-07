Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E1C678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 21:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCGVSF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjCGVSD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 16:18:03 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226911EAC
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 13:17:59 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i5so15581445pla.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 13:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678223878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1oHoBbUXMh9VB2Gmy8ASP8TkSycxsMplJXCauV3mzqg=;
        b=DMGRoGEI00VwFMAV3pN9KmQ1GlMVHkRXVHsHRMJqEGYdLMKwginBtvRC7rKWS9zlkN
         T9u98GodYW1PmmKAr4xWdl5dcLSslG46oHQYLO+36+c8CbuL0y9e85yT9/0MkksZnZRK
         hVmUxQVL2N44r+hp4zmfftOWlYKbXvt8FFBFl4hYi/7kUMHCn7/ZP7n8eRbVWGwEYQGH
         uVv9Urle+KmHPLNutSagTtpw0C5tB3vdbXmSIe8NyvgCGtuLeyNsa606fAk4tLYyAgm1
         f/e7cKsP9AgrdB8jyRUAJVfH+PpYuRl8wtCvQsX48JaDgUsp6G3dHVTl9RP3qCeLd+mI
         Xy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678223878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oHoBbUXMh9VB2Gmy8ASP8TkSycxsMplJXCauV3mzqg=;
        b=IJD2PuIOEv9FvE/oRahMQw8zp8RXHsPkXdQgaw01S4z6kveGLzbwRArq4EMGaNWbs6
         +lwTqcZ3lVuVpyj70KcTZn3q3antVPw1d4/qiOGYVZs2hsJ63J3Qm6A/vQvDQ8xxxL/E
         X27JGRMTMrSKymjE0gA7EmbcSjwl7o+dAk+02LoBlijJYUWon70PW7o+ZkBu/3CvBcTv
         bs/hw8rQw0ATvczDF3htjeT5DySJRHnXcaUUMNmeLQRap4gjl7eH7Gcq9UnckTLc8+yf
         Ut698c2gJriH8aj4qmBY/5tQR2jLA5Ps5sO24ZRQpg8qap6m1yKJwBWxQ9XlbjF9nbGB
         vbaQ==
X-Gm-Message-State: AO0yUKVM/tPWhTKUDdLCXoTHB/b4Av/40yZC5tsyY+T4iuH0n5dxcIwn
        Vc/xZJV1/Iis71XAqDI66u+YINAQTJs=
X-Google-Smtp-Source: AK7set/jutlgqYqKoCMsvWwGSw9ufSOdCVwTba6Zc6sY9Wcg1Fm7t9pg04Ve1Luqv5p77iZU9CT2lg==
X-Received: by 2002:a17:90a:30d:b0:22c:afd6:e597 with SMTP id 13-20020a17090a030d00b0022cafd6e597mr17289351pje.17.1678223878139;
        Tue, 07 Mar 2023 13:17:58 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id hx20-20020a17090b441400b002371e290565sm7871030pjb.12.2023.03.07.13.17.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:17:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/att: Always queue BT_ATT_OP_MTU_REQ on the fixed channel
Date:   Tue,  7 Mar 2023 13:17:56 -0800
Message-Id: <20230307211756.2581274-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_ATT_OP_MTU_REQ shall only be sent on the so called fixed channel
since EATT channels shall use L2CAP procedure to update its MTU.
---
 src/shared/att.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index b90af93ccbf8..85feead77d0f 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1588,6 +1588,14 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 
 	op->id = att->next_send_id++;
 
+	/* Always use fixed channel for BT_ATT_OP_MTU_REQ */
+	if (opcode == BT_ATT_OP_MTU_REQ) {
+		struct bt_att_chan *chan = queue_peek_tail(att->chans);
+
+		result = queue_push_tail(chan->queue, op);
+		goto done;
+	}
+
 	/* Add the op to the correct queue based on its type */
 	switch (op->type) {
 	case ATT_OP_TYPE_REQ:
@@ -1606,6 +1614,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 		break;
 	}
 
+done:
 	if (!result) {
 		free(op->pdu);
 		free(op);
-- 
2.39.2

