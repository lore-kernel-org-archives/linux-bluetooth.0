Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E30C28CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 11:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiAZLgz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:36:55 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41603 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiAZLgo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:44 -0500
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id C54A31BF203
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 11:36:39 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] build: Always define confdir and statedir
Date:   Wed, 26 Jan 2022 12:36:35 +0100
Message-Id: <20220126113638.1706785-1-hadess@hadess.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As we will need those paths to lock down on them.
---
 Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e391d7ae8..2ba25e687 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -28,14 +28,14 @@ AM_CFLAGS = $(MISC_CFLAGS) $(WARNING_CFLAGS) $(UDEV_CFLAGS) $(LIBEBOOK_CFLAGS) \
 				$(LIBEDATASERVER_CFLAGS) $(ell_cflags)
 AM_LDFLAGS = $(MISC_LDFLAGS)
 
+confdir = $(sysconfdir)/bluetooth
+statedir = $(localstatedir)/lib/bluetooth
+
 if DATAFILES
 dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
 dbus_DATA = src/bluetooth.conf
 
-confdir = $(sysconfdir)/bluetooth
 conf_DATA =
-
-statedir = $(localstatedir)/lib/bluetooth
 state_DATA =
 endif
 
-- 
2.34.1

