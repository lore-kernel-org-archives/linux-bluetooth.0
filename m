Return-Path: <SRS0=OtJ6=EM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2847C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 22:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120AE20882
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 22:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="TNUW3qbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgKFWtS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:49:18 -0500
Received: from hoster906.com ([192.252.156.27]:37536 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgKFWtS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Nov 2020 17:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=from:to
        :cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=dkim; bh=L7QXUo90D/In1WQ6QhkeRV1p5
        RphLbtmekUbbrTBuPs=; b=TNUW3qbB8RnSJstJ8+tGtl3Uhh3ottKPAuV3scoUP
        EPmpzsE+r4kylQL1iOmd8hHKSIvzGVBidqPbngJEmxPOU71w7CHnbiLIJaJBJ2MO
        dj679dCLdUFi77Zzqc6wvmvMLpMTyWrn2CBtKl5EbRQDTMOJPvwVYNVPV7NHhfqg
        Wk=
Received: (qmail 35434 invoked by uid 503); 6 Nov 2020 22:49:17 -0000
Received: from unknown (HELO knuckle.Home) (mike@mnmoran.org@40.134.89.129)
  by hoster906.com with ESMTPA; 6 Nov 2020 22:49:17 -0000
From:   "Michael N. Moran" <mike@mnmoran.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        "Michael N. Moran" <mike@mnmoran.org>
Subject: [PATCH BlueZ] mesh: Only deregister io for the last network detached
Date:   Fri,  6 Nov 2020 17:48:11 -0500
Message-Id: <20201106224811.1987610-1-mike@mnmoran.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When multiple mesh networks are active and one is detached
using Leave(), the I/O to all networks is halted.

This patch prevents that by only deregistering the I/O
if all networks have been detached.

---
 mesh/net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 01a475d74..9e0ea860f 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2899,8 +2899,12 @@ struct mesh_io *mesh_net_detach(struct mesh_net *net)
 	io = net->io;
 
 	mesh_io_send_cancel(net->io, &type, 1);
-	mesh_io_deregister_recv_cb(io, snb, sizeof(snb));
-	mesh_io_deregister_recv_cb(io, pkt, sizeof(pkt));
+
+	/* Only deregister io if this is the last network detached.*/
+	if (l_queue_length(nets) < 2) {
+		mesh_io_deregister_recv_cb(io, snb, sizeof(snb));
+		mesh_io_deregister_recv_cb(io, pkt, sizeof(pkt));
+	}
 
 	net->io = NULL;
 	l_queue_remove(nets, net);
-- 
2.26.2

