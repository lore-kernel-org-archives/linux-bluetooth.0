Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B481CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 05:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiC2FaR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 01:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiC2FaQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 01:30:16 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD893FD15
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 22:28:25 -0700 (PDT)
X-QQ-mid: bizesmtp67t1648531697tlw8inkj
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 29 Mar 2022 13:28:10 +0800 (CST)
X-QQ-SSF: 01400000002000D0D000000A0000000
X-QQ-FEAT: dpyQmELDBxHsTX3hz177724oFuYzRqdrgOCmUPl1+7kkt5+NKUukizqP71H3Q
        eXnvzt0Wb1UEltTrTy7MCJx+m6vL/TVFXZZhhVIAm1ey2HXPa0f5mU/9wgGvPwYgmmY8fwJ
        UDoKGNyyS/wtmfRIMjx948qrxw3WZXKXuS0GwKvBB1UjYUfZUQ6QhsGhIJGutwAl+EHyvv+
        +Xv6dUGFwb/MxljuA4sSGqupbRL2W08JkryVgYnc8pB9Ow29iFNyhHZIu4m8SriSaer7HU3
        IlCT4BKdo+Y8JLTU0bT+vI5Eq3+hKTApUaKuy1WhSCkqBkxpkKLbO1RGz86O5C6NuCgGTF6
        nH6HRByHySkXfFcM8ZpQFb6iFR6hw==
X-QQ-GoodBg: 1
From:   xinpeng wang <wangxinpeng@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     xinpeng wang <wangxinpeng@uniontech.com>
Subject: [PATCH v4] obexd: Fix can't receive small files sent by windows
Date:   Tue, 29 Mar 2022 13:28:01 +0800
Message-Id: <20220329052801.28748-1-wangxinpeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When obexd receives a file, it parses the filename and other parameters
when processing the packet for the first time, store filename in
obex_session and emit the dbus signal, The signal will be pending first.
then when this file is received, transfer_complete reset obex_session
is called.

When using a computer with Windows 10 installed to send a file to bluez,
obexd will read the data through read_stream; if it is a small file, the
data processed for the first time is marked as final, and
transfer_complete reset obex_session will be called when the data is
processed for the first time. At this point, the dbus signal is still
pending, and the dbus method that requests the file path has not been
processed. This will cause the upper application to not be able to
transfer files from the cache directory to the directory specified by
the user.

To solve this problem, emit Filename's dbus signal and force it when
status=active.

Ways to reproduce the problem:
1. Use the computer with windows 10 installed to send a small file to
the computer with ubuntu installed;
2. file size < 10k;
3. After sending, in most cases, the file is located in the
~/.cache/obexd/ directory. Normally, the file should be located in the
~/Download directory.

To fix this, after applying this commit, it also needs to be modified by
the upper-level application. Modified to read Filename from dbus signal
if there is Filename in dbus signal. Otherwise, use the dbus method to
request Filename.

---
v4: fix COMMIT_LOG_LONG_LINE error of checkpatch

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



