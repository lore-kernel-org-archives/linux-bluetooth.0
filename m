Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE613C63684
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 11:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiAZLg4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:36:56 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52351 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbiAZLgo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:44 -0500
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id DCE591BF206
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 11:36:40 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] systemd: Add more filesystem lockdown
Date:   Wed, 26 Jan 2022 12:36:37 +0100
Message-Id: <20220126113638.1706785-3-hadess@hadess.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126113638.1706785-1-hadess@hadess.net>
References: <20220126113638.1706785-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We can only access the configuration file as read-only and read-write
to the Bluetooth cache directory and sub-directories.
---
 Makefile.am              | 3 +++
 src/bluetooth.service.in | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 2ba25e687..82125c482 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -622,6 +622,9 @@ MAINTAINERCLEANFILES = Makefile.in \
 
 SED_PROCESS = $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
 		$(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
+		       -e 's,@libexecdir\@,$(libexecdir),g' \
+		       -e 's,@statedir\@,$(statedir),g' \
+		       -e 's,@confdir\@,$(confdir),g' \
 		< $< > $@
 
 if RUN_RST2MAN
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 7c2f60bb4..4daedef2a 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -17,6 +17,10 @@ LimitNPROC=1
 ProtectHome=true
 ProtectSystem=full
 PrivateTmp=true
+ProtectKernelTunables=true
+ProtectControlGroups=true
+ReadWritePaths=@statedir@
+ReadOnlyPaths=@confdir@
 
 # Privilege escalation
 NoNewPrivileges=true
-- 
2.34.1

