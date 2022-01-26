Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BFCC2BA4C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 11:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiAZLgz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:36:55 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49043 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240852AbiAZLgo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:44 -0500
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 33F411BF20B
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 11:36:41 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] systemd: More lockdown
Date:   Wed, 26 Jan 2022 12:36:38 +0100
Message-Id: <20220126113638.1706785-4-hadess@hadess.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126113638.1706785-1-hadess@hadess.net>
References: <20220126113638.1706785-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bluetoothd does not need to execute mapped memory, or real-time
access, so block those.
---
 src/bluetooth.service.in | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 4daedef2a..f18801866 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -22,9 +22,15 @@ ProtectControlGroups=true
 ReadWritePaths=@statedir@
 ReadOnlyPaths=@confdir@
 
+# Execute Mappings
+MemoryDenyWriteExecute=true
+
 # Privilege escalation
 NoNewPrivileges=true
 
+# Real-time
+RestrictRealtime=true
+
 [Install]
 WantedBy=bluetooth.target
 Alias=dbus-org.bluez.service
-- 
2.34.1

