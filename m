Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 05:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbiCWFXo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 01:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiCWFXn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 01:23:43 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC3170CD3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 22:22:08 -0700 (PDT)
X-QQ-mid: bizesmtp87t1648012918tdaneddp
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 23 Mar 2022 13:21:51 +0800 (CST)
X-QQ-SSF: 01400000002000C0D000000A0000000
X-QQ-FEAT: 0VgNaGdhy9gR1o7aVolNIq/TTv1x7QJEQOriKZS1Dl7ddUu+5v7eLLjFun6wU
        bQnC3QQgy/ermfdJYqseFr3oNmfUPOIy5IRp6whWmdByH4K642VHT56tSIfm5JeeieA2bB2
        twlXKcILXA/S3cQjMQHKDTTIyvZ2yyqOx8gv5NnlUpZ6Nbqg7hBQo4oxaPIKG4yD+TpNrev
        FsaBlHHYKDm/ZnQz5ZWWiljIAJ1P4m98NNekpzUDDE5hzINSkJEDdHrzqfxZwYAFwSQbfD+
        DYuUxeFXBmVCFKE3KwLQKaYg1gc0YPxBQ8/4DBQbDanNR9WmHBG+wcRtc1SzFbrGMgwSG7Z
        zGqVHmbNlWkMY4Z9fZm7IQvomlH6w==
X-QQ-GoodBg: 1
From:   xinpeng wang <wangxinpeng@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     xinpeng wang <wangxinpeng@uniontech.com>
Subject: [PATCH] obexd: Fix can't receive small files sent by windows
Date:   Wed, 23 Mar 2022 13:21:49 +0800
Message-Id: <20220323052149.28674-1-wangxinpeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Windows devices use streaming mode to send files. If a small file is
sent,the first time processing data will be completed successfully,
and the transfer_complete function will be called before the end to
clear os->path.At this time, the dbus signal is still pending, and
the dbus method call requesting the file path has not been processed;
in this way, the upper-level program will not be able to obtain the
file path, resulting in failure to receive the file.
Therefore, the signal of Filename is generated, and it is forced to
be sent when status=active.

Signed-off-by: xinpeng wang <wangxinpeng@uniontech.com>
---
 obexd/src/manager.c | 6 +++++-
 obexd/src/obex.c    | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 01741fe62..2c180dc44 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -533,8 +533,12 @@ void manager_emit_transfer_property(struct obex_transfer *transfer,
 void manager_emit_transfer_started(struct obex_transfer *transfer)
 {
 	transfer->status = TRANSFER_STATUS_ACTIVE;
+	if (!transfer->path)
+		return;
 
-	manager_emit_transfer_property(transfer, "Status");
+	g_dbus_emit_property_changed_full(connection, transfer->path,
+					TRANSFER_INTERFACE, "Status",
+					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
 }
 
 static void emit_transfer_completed(struct obex_transfer *transfer,
diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 3a68fd66c..c0d9e160a 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -720,6 +720,7 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
 		manager_emit_transfer_property(os->service_data, "Size");
 
 	os->path = g_strdup(filename);
+	manager_emit_transfer_property(os->service_data, "Filename");
 
 	return 0;
 }
-- 
2.20.1



