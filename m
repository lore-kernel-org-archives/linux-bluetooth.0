Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1450C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 22:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjCOWQs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 18:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjCOWQs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 18:16:48 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A877166FF
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 15:16:42 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 2AFD724064F
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 23:16:41 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PcPr858qlz6tp6;
        Wed, 15 Mar 2023 23:16:40 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] doc: describe new ISO Transport properties
Date:   Wed, 15 Mar 2023 22:16:39 +0000
Message-Id: <6a9a8ad4f432b2c5e1d9e290e8eba6ebfd7985f4.1678918574.git.pav@iki.fi>
In-Reply-To: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678918574.git.pav@iki.fi>
References: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678918574.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Document the currently undocumented transport QoS properties.
---

Notes:
    v2: Fix errors in v1. Don't update Delay, implementation may change.

 doc/media-api.txt | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 281f72c1e..3746ccd55 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -804,3 +804,43 @@ Properties	object Device [readonly]
 
 			Linked transport objects which the transport is
 			associated with.
+
+		byte CIG [ISO only, optional, experimental]
+
+			Indicates configured QoS CIG.
+			Only present when QoS is configured.
+
+		byte CIS [ISO only, optional, experimental]
+
+			Indicates configured QoS CIS.
+			Only present when QoS is configured.
+
+		uint32 Interval [ISO only, optional, experimental]
+
+			Indicates configured QoS interval.
+			Only present when QoS is configured.
+
+		boolean Framing [ISO only, optional, experimental]
+
+			Indicates configured QoS framing.
+			Only present when QoS is configured.
+
+		byte PHY [ISO only, optional, experimental]
+
+			Indicates configured QoS PHY.
+			Only present when QoS is configured.
+
+		uint16 SDU [ISO only, optional, experimental]
+
+			Indicates configured QoS SDU.
+			Only present when QoS is configured.
+
+		byte Retransmissions [ISO only, optional, experimental]
+
+			Indicates configured QoS retransmissions.
+			Only present when QoS is configured.
+
+		uint16 Latency [ISO only, optional, experimental]
+
+			Indicates configured QoS latency.
+			Only present when QoS is configured.
-- 
2.39.2

