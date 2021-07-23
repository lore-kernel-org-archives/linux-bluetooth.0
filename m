Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBC9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 02:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2036C60E99
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 02:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhGWBXY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 21:23:24 -0400
Received: from smtpbg506.qq.com ([203.205.250.33]:38722 "EHLO smtpbg506.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhGWBXX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 21:23:23 -0400
X-QQ-mid: bizesmtp44t1627005833tpovzsyv
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 23 Jul 2021 10:03:42 +0800 (CST)
X-QQ-SSF: 00400000002000204000000A0000000
X-QQ-FEAT: MF7pU6I/MELY4jjeBjBaDx9rHz6roxkB46qUBVmZ+8nAWX7T7/IU9JcQ6K/I/
        xNqF9H86K6n48/gAaOaLRR2AbghRC+oq8L7Uq5ZCZRhj/en3xY8gGvsk8SMCRHqwzKvHZSe
        QlMYAT3X4QDTVvdEBJGx7cpQrZMQzwLzCtUGtc2f1SoqDUs0ki/FYpOJ+DY/Y3P+I/VjDrh
        RyhYxI0WV+aC/79ubGq7NEiUQ0NBDnhLIiGEJPLiq5n3xj7+SeQ5L3ZVkCGaJZhrLGRrbTa
        MC6enloRXc9clOLJ0/jlfIiwxRXZ1mf+5ox6qg2q0vpV6WgBIABoAUo7GALGYg0sk6/6+FO
        WRCEVyUCzvWhqqEm5A=
X-QQ-GoodBg: 2
From:   wangyouwan <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     wangyouwan <wangyouwan@uniontech.com>
Subject: [PATCH] =?UTF-8?q?bluez:fix=20btmon=20tools=20=E2=80=9CAllow=20sl?= =?UTF-8?q?ave=E2=80=9D=20to=20"Central=20Or=20Peripheral"=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20#431=20[hci0]=2099.922927?=
Date:   Fri, 23 Jul 2021 10:03:37 +0800
Message-Id: <20210723020337.31128-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

spec in v5.3
8.6.5 Role switch
There are several occasions when a role switch is used:
• A role switch is necessary in order to make a paging device a Peripheral
when joining an existing piconet, since by definition the paging device is
initially Central of a piconet involving the pager (Central) and the paged
(Peripheral) device.
• A role switch is necessary in order for a Peripheral in an existing piconet to
set up a new piconet with itself as Central and the original piconet Central as
Peripheral. If the original piconet had more than one Peripheral, then this
implies a double role for the original piconet Central; it becomes a Peripheral
in the new piconet while still maintaining the original piconet as Central.

Signed-off-by: wangyouwan <wangyouwan@uniontech.com>
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 52d22ab21..f5d90f204 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4143,7 +4143,7 @@ static void create_conn_cmd(const void *data, uint8_t size)
 		str = "Stay master";
 		break;
 	case 0x01:
-		str = "Allow slave";
+		str = "Central Or Peripheral";
 		break;
 	default:
 		str = "Reserved";
-- 
2.20.1



