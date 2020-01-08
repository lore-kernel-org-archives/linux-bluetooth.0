Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8881EC33C99
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB6E206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhJhZ6Jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgAHAeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:34:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41322 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHAeD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:34:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so666766pgk.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mdvyyyvPpQFaJbQGLewzvFtpyc9kHqej1Sc18Z5t20Y=;
        b=HhJhZ6JbtVbTc9Z3tWPTrBC7dYlGj5VUuKuN1jDpB31phyLcrf212m6XwP9fs9iy6b
         gRh7cnjqBfx2/3a6fbNgWvj+FN5OEKRgpEgeUO+RkPLTuRc+ptrbuAj3lx3II4RRXhFc
         7e8sUG5e/7wdcfSpHtIH4Ng2PYqbb2/ajPwGQoNBslks8jWBzZdvAjIzy6ipuiQkui62
         THBw3AtTah9vMJm8sHN85L7f3EfKhaFQ9b8iDIeBc3IlxbrGgP3QChXCygKjMowNiviz
         UF/sVFLnR750BXNxIgfbzbDm02RMqb7u1e9Tk5UR4KE3sdmWPENavXKdmCsQZzbY+Tjh
         MW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdvyyyvPpQFaJbQGLewzvFtpyc9kHqej1Sc18Z5t20Y=;
        b=f0hQoawuQUHF3jcKWRQUT5j8XTempco80Nip58pOn12vjROl94dcCXn3Z+FUBV87VG
         3+CbshifVWrm+47wguQ9ihVnD5CNicox9C7R6FiK2H31xZGWhxCOQP5yINyq+8bjr7S3
         YG0PDMw1bFJThImKyJtiolX0GCS0Q7Ayeb6hiOducxDifH9EqkKKXVh8eR8JmCb+YOzx
         MgBBBesvTVozKbAD/dAArw2UtfEmlyqKUmhOPgsGxbuHUTlaBOtGUm4o9DkNaOCkdqii
         84da4OAHarFfnuHRzncZdCp8nITKYQFAOJR8bPOhfLtbXtS39pSVdXvGQIXvcR53dC6+
         fSvg==
X-Gm-Message-State: APjAAAW1uUgqXzYoJplX7HGwJmjKc+Nq48z4oJcWQJPWpi67YsZf6drB
        9c/gy0LwW5dn8LvGdxeFP8MPURB8qno=
X-Google-Smtp-Source: APXvYqwJNi/eVNHx7riRPoOneDcoz6fCxAYsk/vcjVtJ3dB05F54H07u2edvo37QPp1Uomk0NbdsxA==
X-Received: by 2002:a63:b141:: with SMTP id g1mr2543433pgp.168.1578443642630;
        Tue, 07 Jan 2020 16:34:02 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.34.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:34:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 18/22] shared/gatt-client: Add support for Read Multiple Variable Length
Date:   Tue,  7 Jan 2020 16:33:38 -0800
Message-Id: <20200108003342.15458-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The Read Multiple Variable Length Request is used to request that the
server read two or more values of a set of attributes that have a
variable or unknown value length and return their values in a
Read Multiple Variable Length Response.
---
 src/shared/gatt-client.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d4758c2de..aecf0ca5a 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2639,7 +2639,9 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	uint8_t att_ecode;
 	bool success;
 
-	if (opcode != BT_ATT_OP_READ_MULT_RSP || (!pdu && length)) {
+	if ((opcode != BT_ATT_OP_READ_MULT_RSP &&
+			opcode != BT_ATT_OP_READ_MULT_VL_RSP) ||
+			(!pdu && length)) {
 		success = false;
 
 		if (opcode == BT_ATT_OP_ERROR_RSP)
@@ -2654,8 +2656,31 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		att_ecode = 0;
 	}
 
-	if (op->callback)
+	if (!op->callback)
+		return;
+
+	if (opcode == BT_ATT_OP_READ_MULT_RSP) {
 		op->callback(success, att_ecode, pdu, length, op->user_data);
+		return;
+	}
+
+	/* Parse response */
+	while (length >= 2) {
+		uint16_t len;
+
+		len = get_le16(pdu);
+		length -= 2;
+		pdu += 2;
+
+		/* The Length Value Tuple List may be truncated within the
+		 * first two octets of a tuple due to the size limits of the
+		 * current ATT_MTU.
+		 */
+		if (len > length)
+			length = len;
+
+		op->callback(success, att_ecode, pdu, len, op->user_data);
+	}
 }
 
 unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
@@ -2667,6 +2692,7 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 	uint8_t pdu[num_handles * 2];
 	struct request *req;
 	struct read_op *op;
+	uint8_t opcode;
 	int i;
 
 	if (!client)
@@ -2696,8 +2722,11 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 	for (i = 0; i < num_handles; i++)
 		put_le16(handles[i], pdu + (2 * i));
 
-	req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_MULT_REQ,
-							pdu, sizeof(pdu),
+	opcode = bt_gatt_client_get_features(client) &
+		BT_GATT_CHRC_CLI_FEAT_EATT ? BT_ATT_OP_READ_MULT_VL_REQ :
+		BT_GATT_CHRC_CLI_FEAT_EATT;
+
+	req->att_id = bt_att_send(client->att, opcode, pdu, sizeof(pdu),
 							read_multiple_cb, req,
 							request_unref);
 	if (!req->att_id) {
-- 
2.21.0

