Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12293C5DF62
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 11:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbiAZLg4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:36:56 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33919 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbiAZLgo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:44 -0500
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 1E6AF1BF207;
        Wed, 26 Jan 2022 11:36:39 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Craig Andrews <candrews@integralblue.com>
Subject: [PATCH 2/4] systemd: Add PrivateTmp and NoNewPrivileges options
Date:   Wed, 26 Jan 2022 12:36:36 +0100
Message-Id: <20220126113638.1706785-2-hadess@hadess.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126113638.1706785-1-hadess@hadess.net>
References: <20220126113638.1706785-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Craig Andrews <candrews@integralblue.com>

PrivateTmp makes bluetoothd's /tmp and /var/tmp be inside a different
namespace. This is useful to secure access to temporary files of the
process.

NoNewPrivileges ensures that service process and all its children
can never gain new privileges through execve(), lowering the risk of
possible privilege escalations.
---
 src/bluetooth.service.in | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index f9faaa452..7c2f60bb4 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -12,8 +12,14 @@ NotifyAccess=main
 #Restart=on-failure
 CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
 LimitNPROC=1
+
+# Filesystem lockdown
 ProtectHome=true
 ProtectSystem=full
+PrivateTmp=true
+
+# Privilege escalation
+NoNewPrivileges=true
 
 [Install]
 WantedBy=bluetooth.target
-- 
2.34.1

