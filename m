Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE04DC61DA3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 20:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjAZUMv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAZUMu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 15:12:50 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E0EA5E1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso2818596pjp.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mt1++iUS4aFzF9d9LPdS46c9snsj2FOX4BGBYQRWY/s=;
        b=BPkH+cPgWWIQPtPr0dlPH4gCtw7TQrnNyalJadRTxw5BTdEdCV8NcOGBNl07A2f/mu
         T6eTVW7PLb5yiKO/8zBpT4HtO/kjH2IFVx3xNXEVk5Mw3S3TAUMTPNW8CJFz0hvZCGnT
         ytMRZvaHvTwUjfEuWVJAdVYYbWgeSUDjfQJ/B6j5ECrK78hKie7VDETada6HQs0yhs4z
         gcspSUTFMqiwFjxUR4cKMGOkiRBNYmS9tCQiE/0JyBJCn5RvaHgYYBVbRMuX7g7R+1Lo
         TPPPffBDRkBpOeqJhhSxOlMnlWBWyl1qGS3hwobDagr9NluDOzWDjHtbgT8a6zYNX/G2
         SLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mt1++iUS4aFzF9d9LPdS46c9snsj2FOX4BGBYQRWY/s=;
        b=PmNFfbPv0Sn83/nqYPTqhxKfWwM92UgCmNFYQ58Bp0NTH8CDcdZCVXTpw1hVg41Fu+
         v36Znt+XkFSR9yhOq7Ygvo8RpmTIMtXe/VaTTm07uJSZYPNtxYAGmuuYThS4RJlFLw9M
         cdpNXCa6NNeKoT0l+4uYn4ehb3C0CWXgBAXxCJzZkI0bKIc2VDNvqgmO+U9SG+5/Q0bE
         vDkkBQGG1w5apq8jrVU8D1opcJLl/0l/SFPK0I28lzFIMUsfMWeJ/eKgdMu28KZ7HnRu
         G3wOWVKK0NHmLRNn2Lvs4GiohlPC8sMTJnLw5SeNfdBTWCN7+Tas8AvGF6hxVtkdol/l
         e/aQ==
X-Gm-Message-State: AFqh2kr8jHZX6lUC2h19n5FLR0SaZTBZos2Oki9rjb1Lm+JDR0jU2H4F
        Xs7jncWtjB8Jm2FBwwC1dWjxBHTt2SE=
X-Google-Smtp-Source: AMrXdXtG4a6FgwiFpEB/Al9v75peE7i1J7gUpE5SBSFe8z/aVwij3dqDbb4k+YtDVjyyGB2+NZ6GTA==
X-Received: by 2002:a17:902:b18f:b0:193:234:443a with SMTP id s15-20020a170902b18f00b001930234443amr33158015plr.45.1674763967858;
        Thu, 26 Jan 2023 12:12:47 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902c78100b00194955b7898sm1341045pla.237.2023.01.26.12.12.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 12:12:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/5] bap: Fix not checking if request fits when grouping
Date:   Thu, 26 Jan 2023 12:12:41 -0800
Message-Id: <20230126201242.4110305-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230126201242.4110305-1-luiz.dentz@gmail.com>
References: <20230126201242.4110305-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When grouping requests with the same opcode the code was queueing them
without attempt to check that that would fit in the ATT MTU causing the
following trace:

stack-buffer-overflow on address 0x7fffdba951f0 at pc 0x7fc15fc49d21 bp
0x7fffdba95020 sp 0x7fffdba947d0
WRITE of size 9 at 0x7fffdba951f0 thread T0
   #0 0x7fc15fc49d20 in __interceptor_memcpy
(/lib64/libasan.so.8+0x49d20)
   #1 0x71f698 in util_iov_push_mem src/shared/util.c:266
   #2 0x7b9312 in append_group src/shared/bap.c:3424
   #3 0x71ba01 in queue_foreach src/shared/queue.c:207
   #4 0x7b9b66 in bap_send src/shared/bap.c:3459
   #5 0x7ba594 in bap_process_queue src/shared/bap.c:351

Fixes: https://github.com/bluez/bluez/issues/457#issuecomment-1403924708
---
 src/shared/bap.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 4ba65cbaa8f9..22f2e67146fb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3425,20 +3425,34 @@ static void append_group(void *data, void *user_data)
 					req->iov[i].iov_base);
 }
 
+static uint16_t bap_req_len(struct bt_bap_req *req)
+{
+	uint16_t len = 0;
+	size_t i;
+	const struct queue_entry *e;
+
+	for (i = 0; i < req->len; i++)
+		len += req->iov[i].iov_len;
+
+	e = queue_get_entries(req->group);
+	for (; e; e = e->next)
+		len += bap_req_len(e->data);
+
+	return len;
+}
+
 static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
 {
 	struct bt_ascs *ascs = bap_get_ascs(bap);
 	int ret;
 	uint16_t handle;
-	uint8_t buf[64];
 	struct bt_ascs_ase_hdr hdr;
-	struct iovec iov  = {
-		.iov_base = buf,
-		.iov_len = 0,
-	};
+	struct iovec iov;
 	size_t i;
 
-	DBG(bap, "req %p", req);
+	iov.iov_len = sizeof(hdr) + bap_req_len(req);
+
+	DBG(bap, "req %p len %u", req, iov.iov_len);
 
 	if (!gatt_db_attribute_get_char_data(ascs->ase_cp, NULL, &handle,
 						NULL, NULL, NULL)) {
@@ -3446,6 +3460,9 @@ static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
 		return false;
 	}
 
+	iov.iov_base = alloca(iov.iov_len);
+	iov.iov_len = 0;
+
 	hdr.op = req->op;
 	hdr.num = 1 + queue_length(req->group);
 
@@ -3531,9 +3548,19 @@ static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
 {
 	struct bt_bap_req *pend;
 	struct queue *queue;
+	struct bt_att *att = bt_bap_get_att(bap);
+	uint16_t mtu = bt_att_get_mtu(att);
+	uint16_t len = 2 + bap_req_len(req);
+
+	if (len > mtu) {
+		DBG(bap, "Unable to queue request: req len %u > %u mtu", len,
+									mtu);
+		return false;
+	}
 
 	pend = queue_find(bap->reqs, match_req, req);
-	if (pend) {
+	/* Check if req can be grouped together and it fits in the MTU */
+	if (pend && (bap_req_len(pend) + len < mtu)) {
 		if (!pend->group)
 			pend->group = queue_new();
 		/* Group requests with the same opcode */
-- 
2.37.3

