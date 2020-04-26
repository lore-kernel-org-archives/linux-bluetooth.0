Return-Path: <SRS0=2aAe=6K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D959C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 21:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC7E20700
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587934976;
	bh=HkzsmLqrdyflFHF6XhtSGqqsgsp4epRYoJqhQwCYco0=;
	h=From:To:Subject:Date:List-ID:From;
	b=TTk/7s6lsI49noTmMsAj7QvPEfBbDJnLl7KtyqrMzcXZMtxRylr6PN7gpOXoc9wd6
	 6b3kO5SrRKBY2JCxB+OGBUo99lNEIF08CAH5H67yeiBp9VnZfNV/TQXLm/fWopJ+7S
	 wulgMCHDFRFqAs7Juk47TOSUfV/vgByaL1VZbnpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZVC4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Apr 2020 17:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgDZVC4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Apr 2020 17:02:56 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F2A120700
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Apr 2020 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587934976;
        bh=HkzsmLqrdyflFHF6XhtSGqqsgsp4epRYoJqhQwCYco0=;
        h=From:To:Subject:Date:From;
        b=jHNLm8xH7ZC3ruvo9QviLk26x0HI6CgCGT4J8J1LPQNxPVayd+yHqrWHszAaj2fZS
         87nzHT46kKRyPQTu3sx0XkgTmQEG7Yt3pNa6pV+KVGLIISzuF/7AVrEMSVhcA+VXkm
         JFOIAgia2WeYl7BsLI5Kduc7G9IPHSmcvU2XnLFs=
Received: by pali.im (Postfix)
        id 654A3B71; Sun, 26 Apr 2020 23:02:54 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] device: Return error when ConnectProfile DBus method fails (second fix)
Date:   Sun, 26 Apr 2020 23:02:47 +0200
Message-Id: <20200426210247.757-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is fixup of commit 3aa815a31017e8793b030b04ef704ce85455b9aa. There is
another place which needs to distinguish between Connect and ConnectProfile
DBus method.
---
 src/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 229579378..7b0eb256e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1861,7 +1861,9 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 	dev->pending = create_pending_list(dev, uuid);
 	if (!dev->pending) {
 		if (dev->svc_refreshed) {
-			if (find_service_with_state(dev->services,
+			if (dbus_message_is_method_call(msg, DEVICE_INTERFACE,
+							"Connect") &&
+				find_service_with_state(dev->services,
 						BTD_SERVICE_STATE_CONNECTED))
 				return dbus_message_new_method_return(msg);
 			else
-- 
2.20.1

