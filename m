Return-Path: <SRS0=CXZ/=PT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC95C43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 14:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA992177B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 14:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7vRaS4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbfAKOUp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:20:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40584 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732685AbfAKOUX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 09:20:23 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so18947233qtf.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jan 2019 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=z4HBtxuEy69aigD+F4RBcOog5bIz/Kua221ptKckbZI=;
        b=T7vRaS4XHCiXz7xvt1MrxOdDqHMc+dF5Hl9TNq3fn3ZwEjhJDHI7RrpHEHBmk9tg5Z
         6oY7bLpyxZAXcMGOesQ5EocQdws94eGrQ3yJc/o5TXaqRaAttSVOxCeuNbJzluIzLJzr
         0ah8dY6xouKrkr5HgXf4heaaX/gdZzD8nmGiT9vRO03yOKxhm+qIWVbOXK146+HmvaQJ
         wbNsvwwiV6tjHR1JAxotAu8TknrvSki/YZZ5Fkw8mCgUamQhUtIidRJ6IO+u01Gch3mM
         Z6EmVqHih4nFBLYTQJ05XTnDLY9vuei7MjPZs3MdZGQOPtFMpkYNZ/Bd3GWPlHTiruWo
         qUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=z4HBtxuEy69aigD+F4RBcOog5bIz/Kua221ptKckbZI=;
        b=p790EENo4mxmAUyXy/cwPnnmV3kBZbU5bMx63a/CIEwRPy77S8LO1Fa2PqCh4WHIqt
         a/pqk8N61NbcXyyebXZoEHZuLKAgYCS9AxtPXtd65G+Uh5PQcfF+NUGRP4UAbCUHKVTj
         SAm4df1bDisdLOjLzWBr/RuBfqS8AsNZHORLH4TO6ngGBlvcQ2MeXZUARojBiblbFkkg
         Bo8xl/5w2Ct929ZjYRqf4EjjIPMuNCsgCyvjfWVv7cLKFYD+CDjTqu8R5AI9i2kBzueX
         45R7jf9VrzCJbKB4X7edEp1LRGh9ET5L0FOqqLquZSmBg8mZXvmBTa1dHSfiBzSgCDHl
         YECQ==
X-Gm-Message-State: AJcUukeFZV22fn+gzEjAWd2XP1b74QPRzmCq7wxw3YbbHhsSrza1vrot
        Q1eni+uGCINwyzKlUjHoXuFSWTRDofU=
X-Google-Smtp-Source: ALg8bN7fBE8yTLiBkzfs4Afa4W4Rbfwsp6oqI2pmlORpWGQ2vDso52NChmkqJj4Vojs7wHIq87rEbg==
X-Received: by 2002:ad4:5004:: with SMTP id s4mr14057194qvo.109.1547216421296;
        Fri, 11 Jan 2019 06:20:21 -0800 (PST)
Received: from localhost.localdomain ([186.206.5.228])
        by smtp.gmail.com with ESMTPSA id y70sm34673043qka.75.2019.01.11.06.20.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:20:20 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] unit/test-sdp: Avoid extra copies when sending a PDU
Date:   Fri, 11 Jan 2019 11:18:16 -0300
Message-Id: <20190111141817.25077-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make use of writev instead of creating a separate buffer to transmit
the data.
---
 unit/test-sdp.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 5a50cbbf1..66da038cd 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -29,6 +29,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <sys/socket.h>
+#include <sys/uio.h>
 
 #include <glib.h>
 
@@ -191,31 +192,23 @@ static gboolean send_pdu(gpointer user_data)
 {
 	struct context *context = user_data;
 	const struct sdp_pdu *req_pdu;
-	uint16_t pdu_len;
-	unsigned char *buf;
+	struct iovec iov[2];
 	ssize_t len;
 
 	req_pdu = &context->data->pdu_list[context->pdu_offset];
 
-	pdu_len = req_pdu->raw_size + context->cont_size;
+	iov[0].iov_base = (void *) req_pdu->raw_data;
+	iov[0].iov_len = req_pdu->raw_size;
 
-	buf = g_malloc0(pdu_len);
+	iov[1].iov_base = context->cont_data;
+	iov[1].iov_len = context->cont_size;
 
-	memcpy(buf, req_pdu->raw_data, req_pdu->raw_size);
+	if (context->cont_size && context->cont_size != req_pdu->cont_len)
+		put_be16(req_pdu->cont_len, iov[1].iov_base + 4);
 
-	if (context->cont_size > 0) {
-		memcpy(buf + req_pdu->raw_size, context->cont_data,
-						context->cont_size);
-		if (context->cont_size != req_pdu->cont_len)
-			put_be16(req_pdu->cont_len,
-					buf + req_pdu->raw_size + 4);
-	}
-
-	len = write(context->fd, buf, pdu_len);
-
-	g_free(buf);
+	len = writev(context->fd, iov, 2);
 
-	g_assert(len == pdu_len);
+	g_assert(len == (ssize_t) (iov[0].iov_len + iov[1].iov_len));
 
 	return FALSE;
 }
-- 
2.17.2

