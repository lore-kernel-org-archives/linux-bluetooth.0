Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F51C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 23:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C40D2087E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684789;
	bh=MZI3kqXetRqYZNmF/nAtn3E2oorqBiw+Aq+t9Y6NEEA=;
	h=From:To:Subject:Date:List-ID:From;
	b=0FnueBarzn99c666ks6TuiOYVa5Bmjyg9rIjTT0U2b8hrfv059cZDXIii45UW7Ld9
	 U4al/dVk6WJiJQjW0DPPnAwz6+r7DLpe0xz9p+z4+1b576m6+8gAbkcqxQm74mG4Z4
	 EWD8y8Ughx9J9Hqyk8xYCso/3kVGd6KH/2wgdgS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDWXdI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDWXdI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 19:33:08 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F6E20784
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 23:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684788;
        bh=MZI3kqXetRqYZNmF/nAtn3E2oorqBiw+Aq+t9Y6NEEA=;
        h=From:To:Subject:Date:From;
        b=vWr239aIdvbZ+OyFhHB3pgmetnwIRLhjHSEZpg7KTicCZXmSCgH9ljXjFiO1WGHLJ
         1Zr0Pm1ncilplWu/oTYvp83LTc/LWQ2sRGgT5Ng2hHZXbA9jI2mc1yhhhrMoWlZso+
         qIWMvlm2+4A/2BCEajaMwpJHBEmFj0cL3APDm8qA=
Received: by pali.im (Postfix)
        id C29E07E0; Fri, 24 Apr 2020 01:33:05 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] device: Return error when ConnectProfile DBus method fails
Date:   Fri, 24 Apr 2020 01:32:43 +0200
Message-Id: <20200423233243.14937-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Without this patch ConnectProfile DBus method does not return failure if
profile connection failed and some other profile was already connected.
This is not correct behavior as ConnectProfile DBus method should always
return error when specified profile failed to connect. This patch fixes
this it.
---
 src/device.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index a8d95346a..7ab30705f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1584,6 +1584,7 @@ static void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
 	struct btd_service *pending;
+	bool report_error;
 	GSList *l;
 
 	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
@@ -1632,9 +1633,16 @@ done:
 
 	DBG("returning response to %s", dbus_message_get_sender(dev->connect));
 
-	l = find_service_with_state(dev->services, BTD_SERVICE_STATE_CONNECTED);
+	if (err && dbus_message_is_method_call(dev->connect, DEVICE_INTERFACE,
+					"ConnectProfile"))
+		report_error = true;
+	else if (err && !find_service_with_state(dev->services,
+					BTD_SERVICE_STATE_CONNECTED))
+		report_error = true;
+	else
+		report_error = false;
 
-	if (err && l == NULL) {
+	if (report_error) {
 		/* Fallback to LE bearer if supported */
 		if (err == -EHOSTDOWN && dev->le && !dev->le_state.connected) {
 			err = device_connect_le(dev);
-- 
2.20.1

