Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8755FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 23:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511D5206C3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 23:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591313084;
	bh=0tx9kpBc+f0HEiwsJThcotQHTTp9JdJkreVr9mEpIpQ=;
	h=From:To:Subject:Date:List-ID:From;
	b=CT1LCq7Gh0SdmnYn/6fvxC00Inc3fdYfC9VliFZIkgCWDUOM9BTfAI6wyNakhoRwi
	 1yfvIWeICgKbxzCRfQKTuFW9mJFdOrXY9GM+AHzzHKC+H4CFuxWlGBQWKmAuzd66/L
	 vnUbc7MIPY63czNAx1/y8miOs9JK1+dgkSzMn8jY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgFDXYo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 19:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgFDXYn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 19:24:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5B0206A2;
        Thu,  4 Jun 2020 23:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591313083;
        bh=0tx9kpBc+f0HEiwsJThcotQHTTp9JdJkreVr9mEpIpQ=;
        h=From:To:Subject:Date:From;
        b=VYLa7vCVWYPmgg7o/bcJYDULx16j12CnIRVKZgCP4MgKyMflhG/UE5TnWJzc5YHQk
         8daf+cDrA7FcpDpncNAEwZOQYbzGIYaFkHaZckFNWtmbuC6kXDrAgBVuEuhpmaG1h8
         UplbgvnLdEQCmxJYfo2qb98qDyFcdaFLOKaClpjw=
Received: by pali.im (Postfix)
        id 80E07F88; Fri,  5 Jun 2020 01:24:41 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH] sap: Improve error messages
Date:   Fri,  5 Jun 2020 01:24:33 +0200
Message-Id: <20200604232433.4951-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When bluetoohd daemon is starting, it prints following error messages:

bluetoothd[19117]: profiles/sap/server.c:sap_server_register() Sap driver initialization failed.
bluetoothd[19117]: sap-server: Operation not permitted (1)

Initialization is failing because sap server is enabled only when
bluetoothd daemon is started with --experimental option.

And "Operation not permitted" is result of returning error code -1.

This patch improves error messages. When --experimental option is not used
then bluetoothd prints more explaining error message. And in case function
sap_init() fails then -EOPNOTSUPP "Operation not supported" is returned
instead of -EPERM (-1).
---
 profiles/sap/server.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 5de682a33..99ff80297 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1353,9 +1353,14 @@ int sap_server_register(struct btd_adapter *adapter)
 	GIOChannel *io;
 	struct sap_server *server;
 
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		error("Sap driver is disabled without --experimental option");
+		return -EOPNOTSUPP;
+	}
+
 	if (sap_init() < 0) {
 		error("Sap driver initialization failed.");
-		return -1;
+		return -EOPNOTSUPP;
 	}
 
 	record = create_sap_record(SAP_SERVER_CHANNEL);
-- 
2.20.1

