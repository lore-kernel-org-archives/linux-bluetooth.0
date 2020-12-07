Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF39C4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BE72311B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 10:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLGKJ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 05:09:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58677 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLGKJ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 05:09:28 -0500
Received: from localhost.localdomain (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 83C14CECDE
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 11:16:01 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Bluetooth entries
Date:   Mon,  7 Dec 2020 11:08:42 +0100
Message-Id: <20201207100842.128579-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update the status to Supported to reflect the current state of affairs
and add Luiz as additional maintainer.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0fde12b650..4ca8a3cd0b4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3205,8 +3205,9 @@ F:	drivers/mtd/devices/block2mtd.c
 BLUETOOTH DRIVERS
 M:	Marcel Holtmann <marcel@holtmann.org>
 M:	Johan Hedberg <johan.hedberg@gmail.com>
+M:	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
-S:	Maintained
+S:	Supported
 W:	http://www.bluez.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
@@ -3215,8 +3216,9 @@ F:	drivers/bluetooth/
 BLUETOOTH SUBSYSTEM
 M:	Marcel Holtmann <marcel@holtmann.org>
 M:	Johan Hedberg <johan.hedberg@gmail.com>
+M:	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
 L:	linux-bluetooth@vger.kernel.org
-S:	Maintained
+S:	Supported
 W:	http://www.bluez.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
-- 
2.28.0

