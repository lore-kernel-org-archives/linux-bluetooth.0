Return-Path: <SRS0=jXj2=ZC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C3C43331
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Nov 2019 20:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38DD207FA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 Nov 2019 20:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKJUIv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 Nov 2019 15:08:51 -0500
Received: from hall.aurel32.net ([195.154.113.88]:47194 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfKJUIv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 Nov 2019 15:08:51 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iTtVx-0002e4-B9
        for linux-bluetooth@vger.kernel.org; Sun, 10 Nov 2019 21:08:49 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iTtVw-0002R2-TA
        for linux-bluetooth@vger.kernel.org; Sun, 10 Nov 2019 21:08:48 +0100
Date:   Sun, 10 Nov 2019 21:08:48 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Subject: BlueZ/mesh: RX not working after daemon restart (with workaround)
Message-ID: <20191110200848.GA28864@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

On my system (Raspberry PI 3), the RX path doesn't work anymore
following a restart of the bluetooth-meshd daemon. I have tracked down
that to the fact that the receive callbacks are setup before the HCI is
fully initialized. Said otherwise, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS is
called before BT_HCI_CMD_RESET and the callback calling
BT_HCI_CMD_LE_SET_SCAN_ENABLE is not called. This timing dependent and
probably not reproducible on all hardware.

I have workarounded the issue by adding a small delay between the HCI
initialization and the call to node_attach_io_all():

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 9b2b2073b..1c06060f9 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -167,6 +167,10 @@ bool mesh_init(const char *config_dir, enum mesh_io_type type, void *opts)
 	mesh_io_get_caps(mesh.io, &caps);
 	mesh.max_filters = caps.max_num_filters;
 
+	for (int i = 0 ; i < 100 ; i++) {
+		l_main_iterate(10);
+	}
+
 	node_attach_io_all(mesh.io);
 
 	return true;

I guess there is a better way to do that by waiting for the HCI to be
fully initialized before calling node_attach_io_all() or by using a
callback instead. However I do not know the codebase good enough to fix
that properly.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
