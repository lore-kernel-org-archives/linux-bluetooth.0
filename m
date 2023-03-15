Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91783C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 17:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjCORyH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjCORyC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 13:54:02 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930A23678
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 10:53:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 89A9524003C
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:53:55 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PcJ0z0Bnpz6tql;
        Wed, 15 Mar 2023 18:53:54 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] doc: update ISO Transport properties to match implementation
Date:   Wed, 15 Mar 2023 17:53:52 +0000
Message-Id: <d33ba431a0b89d8dc80b0da984316d9936be54f4.1678902782.git.pav@iki.fi>
In-Reply-To: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678902782.git.pav@iki.fi>
References: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678902782.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Document the transport QoS properties. Fix documentation of Delay, it's
microseconds for ISO.
---
 doc/media-api.txt | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 281f72c1e..eac7f081c 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -773,12 +773,17 @@ Properties	object Device [readonly]
 				"pending": streaming but not acquired
 				"active": streaming and acquired
 
-		uint16 Delay [readwrite]
+		uint16 Delay [A2DP only, readwrite, optional]
 
-			Optional. Transport delay in 1/10 of millisecond, this
+			For A2DP: transport delay in 1/10 of millisecond. This
 			property is only writeable when the transport was
 			acquired by the sender.
 
+		uint32 Delay [ISO only, optional]
+
+			For ISO, presentation delay in microseconds.
+			Note the value type is different for ISO and A2DP.
+
 		uint16 Volume [readwrite]
 
 			Optional. Indicates volume level of the transport,
@@ -804,3 +809,38 @@ Properties	object Device [readonly]
 
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
+		byte Interval [ISO only, optional, experimental]
+
+			Indicates configured QoS interval.
+			Only present when QoS is configured.
+
+		byte Framing [ISO only, optional, experimental]
+
+			Indicates configured QoS framing.
+			Only present when QoS is configured.
+
+		byte PHY [ISO only, optional, experimental]
+
+			Indicates configured QoS PHY.
+			Only present when QoS is configured.
+
+		uint32 Retransmissions [ISO only, optional, experimental]
+
+			Indicates configured QoS retransmissions.
+			Only present when QoS is configured.
+
+		uint32 Latency [ISO only, optional, experimental]
+
+			Indicates configured QoS latency.
+			Only present when QoS is configured.
-- 
2.39.2

