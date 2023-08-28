Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2FCC83F15
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 17:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjH1R4V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjH1R4A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 13:56:00 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B25106
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 10:55:57 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34baeb01942so12374725ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693245356; x=1693850156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=73RN/26zgEFPB4xxZp9XOE1Fftz+5ZpcP2BpWv3kE9s=;
        b=byJJcPTcFCRTBRmgXulZ3hc4Dy312obTQWiDU9THWQ3LHY3IZFgsHWjVZCq80JcYgY
         7FGXx0dlpWNtY+zkFPr0B+tKGpKY+SPU1xdjbzzVevCgwmOkhcfP6dDj2/PzXAL0Ojrz
         9eW8Samvi/K6gifrkt4Rj4rYTFvttMyeI2gcpFdRVataeMFRY11wOLOS+Dxu/zEVFEjX
         T02MZBlazYwDgZY+N5sND3VpV+1GDnrPy02HoGHT2R3dHcmshxabiYixg/EkOR/rNbsR
         wsMQtu8i7oJ+bNWMtbBwWOfP7MrcXqEaEraWID8WkoOpaYPjksayDb9Set93jRPgYZ5i
         JNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693245356; x=1693850156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73RN/26zgEFPB4xxZp9XOE1Fftz+5ZpcP2BpWv3kE9s=;
        b=D8/N+BPUJxnZuWF6VLwu+rJh/NT+sMDExckL2N1EeC8bzQvEXrFh4aCWeiIV3M905P
         hCYIvond3AHkQ1yMl4juslP1wEd1gjzKLlGtobRfc6Boc/4gzDGlGQsu7YlEE/tYrivx
         C4IUPUEawd71RqkNJeMLUnESFKKW2HTSjLcSouo9SwCF6HPEMkHS99QQCK7+w8xXoYLe
         XOj1QvrJeg9OlhQ6hNa+OwOVllnqV/Kd1dMq7fytK21h53ZkMDQ8BsJWOVQ6PlC1W0tx
         eB8MIGSeTCYmYSpDBJ6/DOYLwLrBLGx/lEkWHq6eVI5HC3SBSPf3zwTkMBHBcf8WDnH6
         eDIg==
X-Gm-Message-State: AOJu0YzqGHtoqZqp5panR7Pf89T/JHqRJDrnqTWrL5H8AOBh4Hj3Lpv8
        5VQ/pHj9xqn2qkOZZD0UttArTc8u/fM=
X-Google-Smtp-Source: AGHT+IGWy1ShUYAl4ZkD7hzhjPU40T1CsBqH5Bb3CVvb1icqhOOF8A0ssk8cYbw9YciyQcDQpTwntQ==
X-Received: by 2002:a05:6e02:13ea:b0:349:8811:fc48 with SMTP id w10-20020a056e0213ea00b003498811fc48mr16307457ilj.29.1693245356416;
        Mon, 28 Aug 2023 10:55:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id q2-20020a920502000000b0034aa175c9c3sm2550311ile.87.2023.08.28.10.55.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 10:55:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix not sending confirmations
Date:   Mon, 28 Aug 2023 10:55:53 -0700
Message-ID: <20230828175553.518129-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit fde32ff9c9c0 ("shared/gatt-client: Allow registering with NULL
callback") added an early return to the notify_cb function when the
current client's notify_list is empty which prevents sending
confirmations to indications.

Reported-by: Javier de San Pedro <dev.git@javispedro.com>
---
 src/shared/gatt-client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index efc013a20dcf..5de679c9b29c 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2232,11 +2232,11 @@ static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
 	struct bt_gatt_client *client = user_data;
 	struct value_data data;
 
-	if (queue_isempty(client->notify_list))
-		return;
-
 	bt_gatt_client_ref(client);
 
+	if (queue_isempty(client->notify_list))
+		goto done;
+
 	memset(&data, 0, sizeof(data));
 
 	if (opcode == BT_ATT_OP_HANDLE_NFY_MULT) {
@@ -2271,6 +2271,7 @@ static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
 		queue_foreach(client->notify_list, notify_handler, &data);
 	}
 
+done:
 	if (opcode == BT_ATT_OP_HANDLE_IND && !client->parent)
 		bt_att_chan_send(chan, BT_ATT_OP_HANDLE_CONF, NULL, 0,
 							NULL, NULL, NULL);
-- 
2.41.0

