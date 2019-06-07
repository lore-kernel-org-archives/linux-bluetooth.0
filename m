Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF1EC28CC3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 06:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1F7208C3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 06:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfFGGyT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:54:19 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48281 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfFGGyT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 02:54:19 -0400
X-Originating-IP: 83.155.44.161
Received: from localhost.localdomain (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 668B5C0013
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2019 06:54:14 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] sixaxis: Throw an error when cable setup fails
Date:   Fri,  7 Jun 2019 08:54:11 +0200
Message-Id: <20190607065411.28502-2-hadess@hadess.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607065411.28502-1-hadess@hadess.net>
References: <20190607065411.28502-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If btd_request_authorization_cable_configured() fails, throw an error
and free resources.
---
 plugins/sixaxis.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 12638829b..939fed759 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -384,6 +384,12 @@ static bool setup_device(int fd, const char *sysfs_path,
 					adapter_bdaddr, &device_bdaddr,
 					HID_UUID, agent_auth_cb, closure);
 
+	if (closure->auth_id == 0) {
+		error("sixaxis: could not request cable authorization");
+		auth_closure_destroy(closure, true);
+		return false;
+	}
+
 	g_hash_table_insert(pending_auths, closure->sysfs_path, closure);
 
 	return true;
-- 
2.21.0

