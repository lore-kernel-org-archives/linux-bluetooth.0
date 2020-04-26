Return-Path: <SRS0=2aAe=6K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10503C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBA22075B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 21:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587934935;
	bh=TjO0H2HDzlHnC88Oif0p9ELRNOWtjJmgg35GDPNQP88=;
	h=From:To:Subject:Date:List-ID:From;
	b=UlJOhBiFvaL4gi/c+KLGcBjaepP8r6qdI5750a84Ar9PyIvgyuWmg4dwCGC6BWV2k
	 sR0mhfB9jerP0+EOuumHErJZ6hzmBCRAYiEdzJrlCv4oXO+09GItyDvcv8FDDiy24e
	 f+BLTm+AjU5mdwqbN5+dJ+aR2XHZ4N+LcnVGiBrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgDZVCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgDZVCP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Apr 2020 17:02:15 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F178320700
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Apr 2020 21:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587934935;
        bh=TjO0H2HDzlHnC88Oif0p9ELRNOWtjJmgg35GDPNQP88=;
        h=From:To:Subject:Date:From;
        b=picvcPUrb5MNSLoW3wOchmS3SxBMDD9BRHfnUt33kXmLE5WAN7Cgpme+Obim+hotU
         jc22rxqNVJz96rtqwoIaLbxcKRipFt0T3faMHeKPi6M+hqkPB7x9cWDNgvWLX32s9R
         Q9zz0CXnvtel+yJaq9iNTqTpMSTCBNpeUkAc+v48=
Received: by pali.im (Postfix)
        id BD8F2B71; Sun, 26 Apr 2020 23:02:12 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] device: Fix calling DisconnectProfile DBus call with disconnected profile UUID
Date:   Sun, 26 Apr 2020 23:02:02 +0200
Message-Id: <20200426210202.700-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When DisconnectProfile is called with disconnected UUID, bluetooth daemon
often returned error "Operation already in progress". This change fixed it
and no error message is returned for this case.
---
 src/device.c  | 5 +++++
 src/service.c | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 149c45160..229579378 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2054,6 +2054,9 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	if (dev->disconnect)
 		return btd_error_in_progress(msg);
 
+	if (btd_service_get_state(service) == BTD_SERVICE_STATE_DISCONNECTED)
+		return dbus_message_new_method_return(msg);
+
 	dev->disconnect = dbus_message_ref(msg);
 
 	err = btd_service_disconnect(service);
@@ -2065,6 +2068,8 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 
 	if (err == -ENOTSUP)
 		return btd_error_not_supported(msg);
+	else if (err == -EALREADY)
+		return dbus_message_new_method_return(msg);
 
 	return btd_error_failed(msg, strerror(-err));
 }
diff --git a/src/service.c b/src/service.c
index c14ee0aca..e4d747a6e 100644
--- a/src/service.c
+++ b/src/service.c
@@ -281,8 +281,9 @@ int btd_service_disconnect(struct btd_service *service)
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 		return -EINVAL;
 	case BTD_SERVICE_STATE_DISCONNECTED:
-	case BTD_SERVICE_STATE_DISCONNECTING:
 		return -EALREADY;
+	case BTD_SERVICE_STATE_DISCONNECTING:
+		return 0;
 	case BTD_SERVICE_STATE_CONNECTING:
 	case BTD_SERVICE_STATE_CONNECTED:
 		break;
-- 
2.20.1

