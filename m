Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9399DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Aug 2021 14:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AF460F11
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Aug 2021 14:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhHHOf5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Aug 2021 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHOf4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Aug 2021 10:35:56 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D17C061760
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 Aug 2021 07:35:37 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6960B3E7F8;
        Sun,  8 Aug 2021 16:35:34 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH BlueZ] audio/avrcp: Use host/network order as appropriate for pdu->params_len
Date:   Sun,  8 Aug 2021 16:35:26 +0200
Message-Id: <20210808143526.99726-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When comparing against or writing to pdu->params_len to enforce matching
length with total packet length, take into account that pdu->params_len
is in network order (big endian) while packet size (operand_count) is in
host order (usually little endian).

This silently breaks a number of AVRCP commands that perform a quick
length check based on params_len and bail if it doesn't match exactly.

Fixes: e2b0f0d8d ("avrcp: Fix not checking if params_len match number of received bytes")
---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index aee2b85a2..710ab3cdd 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1928,9 +1928,9 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 	operands += sizeof(*pdu);
 	operand_count -= sizeof(*pdu);
 
-	if (pdu->params_len != operand_count) {
+	if (ntohs(pdu->params_len) != operand_count) {
 		DBG("AVRCP PDU parameters length don't match");
-		pdu->params_len = operand_count;
+		pdu->params_len = htons(operand_count);
 	}
 
 	for (handler = session->control_handlers; handler->pdu_id; handler++) {
-- 
2.32.0

