Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2183C6377B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 02:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F0460E0C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 02:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhGVBjm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jul 2021 21:39:42 -0400
Received: from smtpbg516.qq.com ([203.205.250.54]:37759 "EHLO smtpbg516.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhGVBjm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jul 2021 21:39:42 -0400
X-Greylist: delayed 4479 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jul 2021 21:39:41 EDT
X-QQ-mid: bizesmtp38t1626920411tkheapbr
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 22 Jul 2021 10:19:54 +0800 (CST)
X-QQ-SSF: 00400000008000103000000A0000000
X-QQ-FEAT: JDPx/clhWMhLg7x9yjpKcQoUAvwDB2TZe1iLntwG3H1OxmM8q9NY72b9s7nZw
        /nRWFFj1hOmgQoCEc/gQ/BCBuw+XhaqmWjW3GSvpk4YdJf3dAXe0PN2a9q9SLbXUeiZOCAk
        I8P5NIfXhPdvX7ElKyJoYH2wmCqipY4HVOqA8cNJwnkz7UFITXdd5AwbEAVUYQZyZUVoedB
        oqxenVqpMMEP5s3rc4BHxjagNRLdaIGcxJqZQ9h5bAUpg5QVreaIWqxor2HbalRYN9CNw99
        0sBkUW8ayJUF1DKbPeXSIF6Xjkq00cVbcGVmmmFRDyM/K4HnpOn9fp+BBxSg/WwFORAvDGC
        rZPTuZMAZh7k/5xtJk=
X-QQ-GoodBg: 2
From:   wangyouwan <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     wangyouwan <wangyouwan@uniontech.com>
Subject: [PATCH] =?UTF-8?q?=20=20=20=20bluez:fix=20btmon=20tools=20?= =?UTF-8?q?=E2=80=9CAllow=20slave=E2=80=9D=20to=20"Master=20Or=20Slave"=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20?= =?UTF-8?q?=20=20=20=20=20=20=20=20=20=20=20=20=20#431=20[hci0]=2099.92292?= =?UTF-8?q?7?=
Date:   Thu, 22 Jul 2021 10:19:52 +0800
Message-Id: <20210722021952.18260-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

    I want to explain it as　“Master Or Slave”, because this is explained in the Core_v5.2

    8.6.5 Role switch
    There are several occasions when a role switch is used:
    • A role switch is necessary in order to make a paging device a slave when
    joining an existing piconet, since by definition the paging device is initially
    master of a piconet involving the pager (master) and the paged (slave)
    device.
    • A role switch is necessary in order for a slave in an existing piconet to set up
    a new piconet with itself as master and the original piconet master as slave.
    If the original piconet had more than one slave, then this implies a double
    role for the original piconet master; it becomes a slave

Signed-off-by: wangyouwan <wangyouwan@uniontech.com>
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 52d22ab21..b73615509 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4143,7 +4143,7 @@ static void create_conn_cmd(const void *data, uint8_t size)
 		str = "Stay master";
 		break;
 	case 0x01:
-		str = "Allow slave";
+		str = "Master Or Slave";
 		break;
 	default:
 		str = "Reserved";
-- 
2.20.1



