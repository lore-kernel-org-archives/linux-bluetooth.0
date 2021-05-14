Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D5FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CA6613E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhENN7v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 09:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231616AbhENN7v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 09:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621000719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aDxAkQryP5/7V4zYsaUEtaJazesB3yw/zMMfovHV9Tk=;
        b=eChlAAs2krL0xV1Z5PaqxRcpwFE/7wOgIjxiq0a3LrQUCU2HDaiITNnx7j3zCJTyArgmlt
        W/2PTayuwvAy8309if3UPlQBjkzoSIuBTZsWV7UsfaA2AI0hBl51X9K0T1S5i8b4H+PV4E
        py7IhmLkXRPlDemrY05LA+TXIRvMu1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-zEw5bFBdNyq8hV7Z9u9jSg-1; Fri, 14 May 2021 09:58:38 -0400
X-MC-Unique: zEw5bFBdNyq8hV7Z9u9jSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4599F801AF7
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:58:37 +0000 (UTC)
Received: from ivy-bridge (ovpn-117-226.rdu2.redhat.com [10.10.117.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F18D91007610
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:58:36 +0000 (UTC)
Date:   Fri, 14 May 2021 09:59:05 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 2/6 v2] Fix leaks in obex
Message-ID: <20210514095905.59358796@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


In filesystem, g_file_get_contents allocates fresh memory to buf.
It needs to be freed after conversion to a GString object.

Destination was missed on an error path as is mld.

---
 obexd/plugins/filesystem.c     | 2 +-
 obexd/plugins/ftp.c            | 8 ++++++--
 obexd/plugins/messages-dummy.c | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
index 09bff8ad0..44e3cf3d2 100644
--- a/obexd/plugins/filesystem.c
+++ b/obexd/plugins/filesystem.c@@ -416,6 +416,7 @@ static void *capability_open(const char *name, int oflag, mode_t mode,
 		}
 
 		object->buffer = g_string_new(buf);
+		g_free(buf);
 
 		if (size)
 			*size = object->buffer->len;
diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index 259bfcae2..4b04bab06 100644
--- a/obexd/plugins/ftp.c
+++ b/obexd/plugins/ftp.c
@@ -386,8 +386,10 @@ static int ftp_copy(struct ftp_session *ftp, const char *name,
 	ret = verify_path(destdir);
 	g_free(destdir);
 
-	if (ret < 0)
+	if (ret < 0) {
+		g_free(destination);
 		return ret;
+	}
 
 	source = g_build_filename(ftp->folder, name, NULL);
 
@@ -424,8 +426,10 @@ static int ftp_move(struct ftp_session *ftp, const char *name,
 	ret = verify_path(destdir);
 	g_free(destdir);
 
-	if (ret < 0)
+	if (ret < 0) {
+		g_free(destination);
 		return ret;
+	}
 
 	source = g_build_filename(ftp->folder, name, NULL);
 
diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index 34199fa05..e37b52df6 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -488,6 +488,7 @@ int messages_get_messages_listing(void *session, const char *name,
 			int err = -errno;
 			DBG("fopen(): %d, %s", -err, strerror(-err));
 			g_free(path);
+			g_free(mld);
 			return -EBADR;
 		}
 	}
-- 
2.31.1

