Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C30202C43
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515482; cv=none; b=FaGW5Z+0lUziD2g9lATr3Xa57ITLvsoZGkiHqJDlB0xRE4QCzBDclZqizUl/qYrakImys/6OOFHIDIR0i0ErQ9RGwIDpJT0MeuD2HFgyaQZU2WsMM4UiLU834wjf+vMa62kixeNZ6/2z8mXAqtSxBIieM8BvrxrIu7gs3K5m8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515482; c=relaxed/simple;
	bh=WjSmimTbGYuIJk0WSAOeQokMX7T27kgUItTxy/aOjAc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mcq30SVxbGKqj/uDn2O8f7MfO+LjDit3wx7lXtC78KPq1aglP+4l9Yx50rA+PY/0+tZYXq5SmicdFQeVpPDH86dTTpcPI0KhiTU7hsZ5lNYMKpb7zTLnNqq1z3BYghBRVB8I+3oqCq2bTj1y3UvzEK8RmhV0Hu632CcnnnSJ78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxQxclAy; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxQxclAy"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523edc385caso2488800e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743515478; x=1744120278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XInpZyA1rsrFp/T9Saxzj4ila7mQcEUyyaeGdLn6juw=;
        b=CxQxclAy+kLGdI8YGzeY8xIpdVK64IMuctFwhkXav7Yh/dL6cTWn+I80YVBORulL5K
         ocXVTos5PdyvkEwDvS6QKInycp0TsW8Uu2GUIbbhGRXNzIzOkvonbOIz4D+cL44jbwjp
         RM1x25rqTH29fnRHzItcWcN9lygEBn7OYhrSqHx66tF+7EDPYW2U+TBTjLnwClq31Lko
         K2Xu6Lg4XUQZ4yVaP4WIoVo9ukzgE5MyLlEPGW6wajRiVPjq0kA0xp3gmDGeFk6Aqv7r
         ZTnWuwX+dG1XuzEnKUKEJvNdEFJWFK0O/fyTBOA2sqpk5CZxavwtlONctbT/APz3texL
         DTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515478; x=1744120278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XInpZyA1rsrFp/T9Saxzj4ila7mQcEUyyaeGdLn6juw=;
        b=oxt0U6ksBwt7L11cgRHRr6tUhw8sUtwfSsOwH8fSvqH3BseSGePLZAoG3sgl8z8w2G
         QTtUfqDGCHJf+UDxGHRIhgaXZMFc3mx8aYNglT6Q2S9KATRb63uBZTki6rHr/KbY+4nG
         DzNW59gXAWUT2UY6zZV2zdy/LHKNCXe30Cr/3f28FXoaXhzJmuPpgxRn89EWCggXh4kl
         k79NqPcYxOLMZawYq+wj1Ser3g4zwYOBrvrKl94R1QAHteYi6HNXpIwkZ27HtHMG0v1G
         1gT0QXXVlPmfUzIrtxE75RWip0Ob4gGHK7tKpk6RnEM2snHUxo/N4kGMboJO4ZbLAlV2
         Vw/w==
X-Gm-Message-State: AOJu0Yzp+5loz6MC3YGZ8TxhPpVgmBiCreQwHu6OQ8rAU+W4Q4ry3yfN
	MUpiTJOIzo5J1DPEJO86EsQ6lHbotZh8Laa1y6a/KzJe6WP87TWrh7J5VXfS
X-Gm-Gg: ASbGnct0Yi9+dnJJE5dL4HV0ylgeu+YZAY6p1WRv5P9DD51CJM3cWRW/xC3QCzplnkA
	1LU7orzVMcCW0SjYGqQv9W7Us7E8fa8wLNulgW4b7cx9U27lInHWjSVvMPF9B6JIK8AK0UdMebN
	K5BdS0ZQ75zwjTKgwFuP7AnNfD53rXzD2QYcMTN0K52F4SNTF7bXuOJxx0XOEKrcAanVCYLeq1s
	6Te2cxeZAuG2pARslZdbAhWvdmS4NuPxgb2I2XMPbKpwh6bAV2FIKZZbkxcAK6oV4tovu0eAXXY
	J+gKdzBe+ZayXib595poCMNOJe7+l5RAtIyDpWfXlbLFUnmIwssWlP0JxI6Fy5/aGsDu1XTaYCU
	izZPYaX0BGQ02LQ==
X-Google-Smtp-Source: AGHT+IFUkEqqDHn94RnAjJa0D54cEMuIsvtLnP9tywnU7YmJSBwswTN4Cq9b5LV4TXyWrnIuc14q0Q==
X-Received: by 2002:a05:6122:130a:b0:526:483:95fd with SMTP id 71dfb90a1353d-5261d4ce0d1mr6793219e0c.10.1743515478444;
        Tue, 01 Apr 2025 06:51:18 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-871a33d2270sm1895066241.34.2025.04.01.06.51.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:51:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] shared/bap: Fix swallowing states transitions
Date: Tue,  1 Apr 2025 09:51:15 -0400
Message-ID: <20250401135115.3735533-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In certain cases (e.g ASCS_Enable) a Control Point operation may change
states multiple times causing states not to be notified.

To fix this attempts to queue states if timeout is pending (state_id)
and then proceed to notify them ahead of the last state set in the ASE
so the remote side is informed of all the state transitions.
---
 src/shared/bap.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 5d4d69d2925b..650bea2f4e8d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -293,6 +293,7 @@ struct bt_bap_stream {
 	uint8_t old_state;
 	uint8_t state;
 	unsigned int state_id;
+	struct queue *pending_states;
 	bool client;
 	void *user_data;
 };
@@ -1205,6 +1206,7 @@ static void bap_stream_free(void *data)
 	struct bt_bap_stream *stream = data;
 
 	timeout_remove(stream->state_id);
+	queue_destroy(stream->pending_states, NULL);
 
 	if (stream->ep)
 		stream->ep->stream = NULL;
@@ -1705,19 +1707,11 @@ static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
 	return true;
 }
 
-static bool stream_notify_state(void *data)
+static void stream_notify(struct bt_bap_stream *stream, uint8_t state)
 {
-	struct bt_bap_stream *stream = data;
-	struct bt_bap_endpoint *ep = stream->ep;
+	DBG(stream->bap, "stream %p state %d", stream, state);
 
-	DBG(stream->bap, "stream %p status %d", stream, ep->state);
-
-	if (stream->state_id) {
-		timeout_remove(stream->state_id);
-		stream->state_id = 0;
-	}
-
-	switch (ep->state) {
+	switch (state) {
 	case BT_ASCS_ASE_STATE_IDLE:
 		break;
 	case BT_ASCS_ASE_STATE_CONFIG:
@@ -1735,6 +1729,24 @@ static bool stream_notify_state(void *data)
 		stream_notify_release(stream);
 		break;
 	}
+}
+
+static bool stream_notify_state(void *data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_endpoint *ep = stream->ep;
+	uint8_t state;
+
+	if (stream->state_id) {
+		timeout_remove(stream->state_id);
+		stream->state_id = 0;
+	}
+
+	/* Notify any pending states before notifying ep->state */
+	while ((state = PTR_TO_UINT(queue_pop_head(stream->pending_states))))
+		stream_notify(stream, state);
+
+	stream_notify(stream, ep->state);
 
 	return false;
 }
@@ -1760,6 +1772,10 @@ static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		stream->state_id = timeout_add(BAP_PROCESS_TIMEOUT,
 						stream_notify_state,
 						stream, NULL);
+	else /* If a state_id is already pending then queue the old one */
+		queue_push_tail(stream->pending_states,
+				UINT_TO_PTR(ep->old_state));
+
 
 done:
 	bap_stream_state_changed(stream);
@@ -2716,6 +2732,7 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 	stream->cc = util_iov_dup(data, 1);
 	stream->client = client;
 	stream->ops = bap_stream_new_ops(stream);
+	stream->pending_states = queue_new();
 
 	queue_push_tail(bap->streams, stream);
 
-- 
2.48.1

