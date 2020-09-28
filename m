Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68294C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1B12071E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 19:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucsb.edu header.i=@cs.ucsb.edu header.b="SRr/lnFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgI1TUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1TUY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 15:20:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835EEC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 12:20:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so1703671pgm.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.ucsb.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ir+w7eay7v1aPDzbNMpbiaPstOeOucFen6zw0sKacko=;
        b=SRr/lnFrU/eMLv2iNrAN3rX4R9gJRfiI0VI/Gc8A8tSlwtF98tgwIRGYbpJmp5/vvV
         eFvmUefcAMt2/9ppeY8Jf/4CiBOiSw9/1tTqz+1MmCBi6exYDVkZIaI3/4T4oS5f4QYL
         FGrtju6qUnzKA0nRLzlOF5W57ILNndVYVbfZpshwXDYa2QTZKUHNuZJV6h3Pt8V55xuf
         /2U/3CqFr3ZL0toUG5jH48CO+AOQ3XQYvmqH8D45qPuzPhzujd4yRTDKRnB73QkmxszM
         8CkrUDTbR4vzqbmDmhzA7LwnDRnHi1zdgSqrmb3HuiNUplP8F6hCtWh4u4cvMrlk5kJK
         agTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ir+w7eay7v1aPDzbNMpbiaPstOeOucFen6zw0sKacko=;
        b=H/iBEIGj8IMmmsVMHiWtGv4tp6GKrRt29rxgbqtRiLxflV99gPCdlpYi7ikhqdGbS9
         aQfjW2orMOPWR47sjkFuddws2dbPWOuX+xa7iPfEjB6rpq2PvjRQNuXmEUnPAXznfr9h
         d9jCQsnmbSjzvm8+Le1pwR7DXyvkguWUEvn66T0Vi47GUDNHG86Skfr6jHSqRwW5eFDh
         iYIL+HRT9VJn4K1zZB/qlZvP4BV7l02X7J3PkN0IidEhD7JBqn6nNDmVR+B1BkJ/G0KT
         4sX59JBXtomyN24OO8TB2PzI5EgVKYO308bRScZlPbuLmwGas1mzRNlsLh6jJC5hTwfj
         hKKQ==
X-Gm-Message-State: AOAM532KatlWiRtlYji9rR0fNqht9g8IeMykY/M/pm1/XAmYVeS/HtEN
        9hiLYAAQCxAieU06lN33l9IV3RmnJ3nTmCFVCZmmMkQkBLPhjUBN+6xSlSkaINYxv3iqF62XQ5g
        ftlEifzrSXy4QwbxG+k1T73hLNW+GZ7LOXnwgaqJ0gI0sJJ+WPz8+B327rOkpJrlk8GSp1rMiGC
        ah0UpfMg==
X-Google-Smtp-Source: ABdhPJymmbZwvJGUT/j96vkpYOyqvr8nxeK334RWVn3lEDdct5fFSSco+Bz101fQGrJ0nG2UmEertA==
X-Received: by 2002:a62:1e81:0:b029:142:2dad:a68 with SMTP id e123-20020a621e810000b02901422dad0a68mr742195pfe.5.1601320821631;
        Mon, 28 Sep 2020 12:20:21 -0700 (PDT)
Received: from localhost.localdomain (ip72-194-13-5.sb.sd.cox.net. [72.194.13.5])
        by smtp.gmail.com with ESMTPSA id q5sm2437258pfn.109.2020.09.28.12.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:20:20 -0700 (PDT)
From:   Aravind Machiry <machiry@cs.ucsb.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     mhnaik@seas.upenn.edu, liby99@seas.upenn.edu,
        Aravind Machiry <machiry@cs.ucsb.edu>
Subject: [PATCH BlueZ] lib: Replace malloc/memset(..0..) with malloc0
Date:   Mon, 28 Sep 2020 12:20:02 -0700
Message-Id: <20200928192002.22733-1-machiry@cs.ucsb.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch replaces various instances of malloc and subsequent
memset(..,0,..) with malloc0 (i.e., calloc) for efficiency.
---
 lib/bluetooth.c |  5 +++++
 lib/bluetooth.h |  3 +++
 lib/sdp.c       | 36 ++++++++++++------------------------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 0aecb50e1..84e40c819 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -173,6 +173,11 @@ void *bt_malloc(size_t size)
 	return malloc(size);
 }
 
+void *bt_malloc0(size_t size)
+{
+	return calloc(size, 1);
+}
+
 void bt_free(void *ptr)
 {
 	free(ptr);
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 1619f5f08..6994c037a 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -149,6 +149,8 @@ enum {
 	BT_CLOSED
 };
 
+#define malloc0(n) (calloc((n), 1))
+
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
@@ -349,6 +351,7 @@ int basprintf(char *str, const char *format, ...);
 int basnprintf(char *str, size_t size, const char *format, ...);
 
 void *bt_malloc(size_t size);
+void *bt_malloc0(size_t size);
 void bt_free(void *ptr);
 
 int bt_error(uint16_t code);
diff --git a/lib/sdp.c b/lib/sdp.c
index a27cd3a7b..98624dcfc 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -345,12 +345,11 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
 							uint32_t length)
 {
 	sdp_data_t *seq;
-	sdp_data_t *d = malloc(sizeof(sdp_data_t));
+	sdp_data_t *d = malloc0(sizeof(sdp_data_t));
 
 	if (!d)
 		return NULL;
 
-	memset(d, 0, sizeof(sdp_data_t));
 	d->dtd = dtd;
 	d->unitSize = sizeof(uint8_t);
 
@@ -906,11 +905,10 @@ int sdp_gen_record_pdu(const sdp_record_t *rec, sdp_buf_t *buf)
 	memset(buf, 0, sizeof(sdp_buf_t));
 	sdp_list_foreach(rec->attrlist, sdp_attr_size, buf);
 
-	buf->data = malloc(buf->buf_size);
+	buf->data = malloc0(buf->buf_size);
 	if (!buf->data)
 		return -ENOMEM;
 	buf->data_size = 0;
-	memset(buf->data, 0, buf->buf_size);
 
 	sdp_list_foreach(rec->attrlist, sdp_attr_pdu, buf);
 
@@ -1030,12 +1028,11 @@ static sdp_data_t *extract_int(const void *p, int bufsize, int *len)
 		return NULL;
 	}
 
-	d = malloc(sizeof(sdp_data_t));
+	d = malloc0(sizeof(sdp_data_t));
 	if (!d)
 		return NULL;
 
 	SDPDBG("Extracting integer");
-	memset(d, 0, sizeof(sdp_data_t));
 	d->dtd = *(uint8_t *) p;
 	p += sizeof(uint8_t);
 	*len += sizeof(uint8_t);
@@ -1105,13 +1102,12 @@ static sdp_data_t *extract_int(const void *p, int bufsize, int *len)
 static sdp_data_t *extract_uuid(const uint8_t *p, int bufsize, int *len,
 							sdp_record_t *rec)
 {
-	sdp_data_t *d = malloc(sizeof(sdp_data_t));
+	sdp_data_t *d = malloc0(sizeof(sdp_data_t));
 
 	if (!d)
 		return NULL;
 
 	SDPDBG("Extracting UUID");
-	memset(d, 0, sizeof(sdp_data_t));
 	if (sdp_uuid_extract(p, bufsize, &d->val.uuid, len) < 0) {
 		free(d);
 		return NULL;
@@ -1136,11 +1132,10 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 		return NULL;
 	}
 
-	d = malloc(sizeof(sdp_data_t));
+	d = malloc0(sizeof(sdp_data_t));
 	if (!d)
 		return NULL;
 
-	memset(d, 0, sizeof(sdp_data_t));
 	d->dtd = *(uint8_t *) p;
 	p += sizeof(uint8_t);
 	*len += sizeof(uint8_t);
@@ -1183,13 +1178,12 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 		return NULL;
 	}
 
-	s = malloc(n + 1);
+	s = malloc0(n + 1);
 	if (!s) {
 		SDPERR("Not enough memory for incoming string");
 		free(d);
 		return NULL;
 	}
-	memset(s, 0, n + 1);
 	memcpy(s, p, n);
 
 	*len += n;
@@ -1260,13 +1254,12 @@ static sdp_data_t *extract_seq(const void *p, int bufsize, int *len,
 {
 	int seqlen, n = 0;
 	sdp_data_t *curr, *prev;
-	sdp_data_t *d = malloc(sizeof(sdp_data_t));
+	sdp_data_t *d = malloc0(sizeof(sdp_data_t));
 
 	if (!d)
 		return NULL;
 
 	SDPDBG("Extracting SEQ");
-	memset(d, 0, sizeof(sdp_data_t));
 	*len = sdp_extract_seqtype(p, bufsize, &d->dtd, &seqlen);
 	SDPDBG("Sequence Type : 0x%x length : 0x%x", d->dtd, seqlen);
 
@@ -2740,12 +2733,11 @@ void sdp_uuid32_to_uuid128(uuid_t *uuid128, const uuid_t *uuid32)
 
 uuid_t *sdp_uuid_to_uuid128(const uuid_t *uuid)
 {
-	uuid_t *uuid128 = bt_malloc(sizeof(uuid_t));
+	uuid_t *uuid128 = bt_malloc0(sizeof(uuid_t));
 
 	if (!uuid128)
 		return NULL;
 
-	memset(uuid128, 0, sizeof(uuid_t));
 	switch (uuid->type) {
 	case SDP_UUID128:
 		*uuid128 = *uuid;
@@ -3191,12 +3183,11 @@ int sdp_record_update(sdp_session_t *session, const sdp_record_t *rec)
 
 sdp_record_t *sdp_record_alloc(void)
 {
-	sdp_record_t *rec = malloc(sizeof(sdp_record_t));
+	sdp_record_t *rec = malloc0(sizeof(sdp_record_t));
 
 	if (!rec)
 		return NULL;
 
-	memset(rec, 0, sizeof(sdp_record_t));
 	rec->handle = 0xffffffff;
 	return rec;
 }
@@ -3731,23 +3722,21 @@ sdp_session_t *sdp_create(int sk, uint32_t flags)
 	sdp_session_t *session;
 	struct sdp_transaction *t;
 
-	session = malloc(sizeof(sdp_session_t));
+	session = malloc0(sizeof(sdp_session_t));
 	if (!session) {
 		errno = ENOMEM;
 		return NULL;
 	}
-	memset(session, 0, sizeof(*session));
 
 	session->flags = flags;
 	session->sock = sk;
 
-	t = malloc(sizeof(struct sdp_transaction));
+	t = malloc0(sizeof(struct sdp_transaction));
 	if (!t) {
 		errno = ENOMEM;
 		free(session);
 		return NULL;
 	}
-	memset(t, 0, sizeof(*t));
 
 	session->priv = t;
 
@@ -4173,13 +4162,12 @@ int sdp_process(sdp_session_t *session)
 		return -1;
 	}
 
-	rspbuf = malloc(SDP_RSP_BUFFER_SIZE);
+	rspbuf = malloc0(SDP_RSP_BUFFER_SIZE);
 	if (!rspbuf) {
 		SDPERR("Response buffer alloc failure:%m (%d)", errno);
 		return -1;
 	}
 
-	memset(rspbuf, 0, SDP_RSP_BUFFER_SIZE);
 
 	t = session->priv;
 	reqhdr = (sdp_pdu_hdr_t *)t->reqbuf;
-- 
2.25.1

