Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8016C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 23:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7777C206C3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591312560;
	bh=5HAgBo3brAxccrTjx8FfyeZLISQRcVfU897pmQEopkM=;
	h=From:To:Subject:Date:List-ID:From;
	b=RC/RiijGJvkvo7rBuAo4P/BTFas6pXoucUd+7O+FfCotFWBvI0XQuH1SgS9LEwf9t
	 TevnxwUGF+F69IluvzTDDeb+TC56Vh7b4Tj7fWXUy9gwIENVnpx84tjbDBEZfpN4d6
	 prK0OdafaFPlS35cuojCidVOCAZevZCnhKm68KXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgFDXQA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 19:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgFDXQA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 19:16:00 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC78206C3;
        Thu,  4 Jun 2020 23:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591312559;
        bh=5HAgBo3brAxccrTjx8FfyeZLISQRcVfU897pmQEopkM=;
        h=From:To:Subject:Date:From;
        b=u9SbIW4JbOrZMKo482VqEI/wVxVoCk5b7Y2DyRGw2BlaCjt6uRJRhI7hmZqwD6j2I
         kQWZvNSINOomcSAIbLBK4uwc38qUoA5IKYa93FQpd+qI8c3ImlK0W7sQvvHGvHNu4S
         OwZVvmZrAP04KPcCZEz1PGivX4IGfT1aKdS+FReo=
Received: by pali.im (Postfix)
        id D8995F88; Fri,  5 Jun 2020 01:15:56 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH] btio: Fix registering Object Push, File Transfer and other L2CAP profiles
Date:   Fri,  5 Jun 2020 01:15:41 +0200
Message-Id: <20200604231541.4170-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When bluetoothd daemon is starting, it prints following error messages:

bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Message Notification: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Message Access: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Phone Book Access: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for File Transfer: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Object Push: setsockopt(L2CAP_OPTIONS): Invalid argument (22)

Result is that Object Push and File Transfer profiles do not work at all.

Debugging set_l2opts() function showed me that src/profile.c calls it with
L2CAP mode 0x01 (L2CAP_MODE_RETRANS). But kernel bluetooth code in function
l2cap_sock_setsockopt_old() for L2CAP_OPTIONS option disallows to set L2CAP
method to 0x01 (L2CAP_MODE_RETRANS) and just returns -EINVAL (22).

These bluetooth profiles have in src/profile.c file defined L2CAP mode to
BT_IO_MODE_ERTM and not to RETRANS. So it means that BT_IO_MODE_ERTM value
defined in 'enum BtIOMode' must be incorrect.

Digging into git history, it appears that 'enum BtIOMode' was broken in
commit f2418bf97d ("btio: Add mode to for Enhanced Credit Mode") which
basically broke all those Object Push, File Transfer, Phone Book Access,
Message Access and Message Notification L2CAP profiles. That commit removed
some values from 'enum BtIOMode' and therefore broke all bluetooth code
which uses 'enum BtIOMode' for communication with kernel.

This patch fixes 'enum BtIOMode' by reverting back BT_IO_MODE_RETRANS and
BT_IO_MODE_FLOWCTL modes, so BT_IO_MODE_ERTM has again correct value 0x03.

After applying this patch, Object Push and File Transfer profiles work
again.

Fixes: f2418bf97d ("btio: Add mode to for Enhanced Credit Mode")
---

Hello Luiz, could you please review this patch? As that problematic commit
f2418bf97d was introduced by you.

I'm curious why nobody else reported this issue about broken Object Push
and File Transfer profile as it should print those error messages... Or
maybe error message is visible only in debug build and nobody is using
Bluetooth File Transfer anymore?

---
 btio/btio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/btio/btio.h b/btio/btio.h
index 23e0ef72b..0d183e3ce 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -68,6 +68,8 @@ typedef enum {
 
 typedef enum {
 	BT_IO_MODE_BASIC = 0,
+	BT_IO_MODE_RETRANS,
+	BT_IO_MODE_FLOWCTL,
 	BT_IO_MODE_ERTM,
 	BT_IO_MODE_STREAMING,
 	BT_IO_MODE_LE_FLOWCTL,
-- 
2.20.1

