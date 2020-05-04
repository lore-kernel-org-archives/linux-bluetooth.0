Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28628C3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 16:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FEB206D9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 16:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgEDQBw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 May 2020 12:01:52 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgEDQBw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 May 2020 12:01:52 -0400
Received: from Exchange.peiker-holding.de ([82.119.189.130]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MyNoa-1jD79W07Nk-00yfdN; Mon, 04 May 2020 18:01:50 +0200
Received: from Exchange.peiker-holding.de (10.0.1.22) by
 Exchange.peiker-holding.de (10.0.1.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1779.2; Mon, 4 May 2020 18:01:49 +0200
Received: from Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42]) by
 Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42%13]) with mapi id
 15.01.1779.002; Mon, 4 May 2020 18:01:49 +0200
From:   "CEE Forostyan, Konstantin" <Konstantin.Forostyan@peiker-cee.de>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: Fix errors during
 L2CAP_CREDIT_BASED_CONNECTION_REQ (0x17)
Thread-Topic: [PATCH] Bluetooth: L2CAP: Fix errors during
 L2CAP_CREDIT_BASED_CONNECTION_REQ (0x17)
Thread-Index: AQHWIiznNF+Yj3mpc0Ky6ItztISKMg==
Date:   Mon, 4 May 2020 16:01:49 +0000
Message-ID: <5e44176345684a8cb83adacf1a845e86@peiker-cee.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.112.11]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Provags-ID: V03:K1:+vpXtpKclCue17zWjIUWDs3TZiTgkirPYAxduHYo3TyFvy/uUqY
 AO9U/SB5d1RgDc0kkPzdjdbukN7628jb/7D5JPEUzZDbHprxj+MRcMKOCwdy0Ek0ln2GhA9
 riEYxOhNE2LvBBCzD9tjm5rF0Qm7H3V0XZ4TciUziJkjxG6fLlKQmKwX5JJShl9ZIf9kPWg
 cqhuNBP2RDt9hhPo6/peg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XSoc/Uljc84=:tzwBLuncOLQ1nUlyNmbaCh
 cHYwu56LY4TXqLfX+bDLM2jJ9+F6cBhxqSZ7ttyTOtNR80xVWtGzZ53hyVH+7DdiGoHhD43qP
 tMbdcgKSDsogxn21l1Lm7g3vtERa2N31mcG3OTOqwUlWkrhv2buXFjj3l5pNxINe9zPgcc+hk
 IDcvBgsc6Sr0eFMNlr8FHyYhGpCG+yiwH6YaRKUm6QI6V7lSjkZTQ1kZIATa+7oTZxWrpS3Zl
 QkRXK3zBdzN49OaFbRxhn2y/yI2AjYgG0yiMQXgCm9h691VvKNQLe451ZkGC2SeOQaqJlZelw
 YOSvaP6RSrTztNJVj3itz7lkFEDnB98edj8Xf0p3SVfeZyP9HDcmITm5ULUaUoJgNhCwvQY7u
 bQfyZ10QfgBSPHpm6H8L81eqqsoEdPIIeuyEmd1J2YM1bNGc+SjkAH7JJdUzq2+yC6JTjC5U/
 l5AC4sqvh66q5dKaW5B1EN/8orCvL7lfbkhzmZTgS19lyn6fKL9ztPXiOs5iDzsk25wpf85ER
 EuxgzOGCfeTapfQtxMMKVrmvQLQShPhFwzGc3xbwFE4B3r9TGcan89+8zP2ab4MlZLihr5ssS
 6m5CHiHd6AJybxaLEJdroIJmJ5JQCao0YOt8BvlmCLgziJG9xgwI8jz23WlI25F/LNvWG01sq
 q3G6nZ9TAENCdQY15RkIMrIgEvJktOOUEf0MysjF7wUkWb84sBQBGY6Pep8eintT276QOUN56
 iMqvFd5TpsQmC9OWFy+FLwf7vaQpPy2g0DOWK/UWNS46Gv8bLv803ohqskoDzoIqq9/jeWC25
 xGVkBFeFBq+LrJN1zmGtx6LsvrRupKVpOkhE1nc/TVfJo1VhI8iRGdropiHqenB6QxnvEK9ZR
 9H8NnUblMN5ayhShqhfg==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>

Fix 2 typos in L2CAP_CREDIT_BASED_CONNECTION_REQ (0x17) handling function, that
cause BlueZ answer with L2CAP_CR_LE_INVALID_PARAMS or L2CAP_CR_LE_INVALID_SCID
error on a correct ECRED connection request.

Enchanced Credit Based Mode support was recently introduced with the commit
15f02b91056253e8cdc592888f431da0731337b8 ("Bluetooth: L2CAP: Add initial code
for Enhanced Credit Based Mode").

Signed-off-by: Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
---

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fd9d0d08f9c9..fe913a5c754a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5927,7 +5927,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	if (!enable_ecred)
 		return -EINVAL;
 
-	if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
+	if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
 	}
@@ -5964,7 +5964,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	}
 
 	result = L2CAP_CR_LE_SUCCESS;
-	cmd_len -= sizeof(req);
+	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
 	for (i = 0; i < num_scid; i++) {
