Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C98C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 03:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiCWDiF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiCWDh7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 23:37:59 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB570CD1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 20:36:25 -0700 (PDT)
X-QQ-mid: bizesmtp63t1648006579tb7ls3za
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 23 Mar 2022 11:36:14 +0800 (CST)
X-QQ-SSF: 01400000000000C0D000B00A0000000
X-QQ-FEAT: jfdGVjI73+QTWEhMp8TSi/75ht75hgsMCPpObJyTMLuOSwgd3u1PfXpJ+1bDA
        D87S92Qvh8aW1gQYy4dYfn8UlFGES5s87i+zEtjxdN8Wk4/+YE5HGrQWp0eiH/b6rQdfbjm
        FZ3rgJ1wKUtEoOh6SM7z1n8W8NxnIlrFVqNrAywSxJzzuOby+lwX2gLEsQ968aO2UAY/ljJ
        qmJEoLeFQ6KwuGb3JciD1Gahft56v9OES34+EvZO6Lmhu7RVHrQqvk3dUtuxeQhNr9FzQGO
        oxRDO6JjNeevp8yGCNbf9FTn7BrPSbdvfHOSRNCDg56a6YBkRq3ItTjygA/JlQHEdSQHt/e
        8i40WMeunr8w7/kOEQ=
X-QQ-GoodBg: 2
From:   xinpeng wang <wangxinpeng@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     xinpeng wang <wangxinpeng@uniontech.com>
Subject: [PATCH] obexd: Fix cann't receive small files sent by windows
Date:   Wed, 23 Mar 2022 11:36:12 +0800
Message-Id: <20220323033612.12132-1-wangxinpeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
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
 obexd/src/manager.c | 5 ++++-
 obexd/src/obex.c    | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 01741fe62..ba9ad43e6 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -533,8 +533,11 @@ void manager_emit_transfer_property(struct obex_transfer *transfer,
 void manager_emit_transfer_started(struct obex_transfer *transfer)
 {
 	transfer->status = TRANSFER_STATUS_ACTIVE;
+	if (!transfer->path)
+		return;
 
-	manager_emit_transfer_property(transfer, "Status");
+	g_dbus_emit_property_changed_full(connection, transfer->path,
+					TRANSFER_INTERFACE, "Status",G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
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



