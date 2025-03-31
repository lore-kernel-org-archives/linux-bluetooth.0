Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED526AF6
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743441124; cv=none; b=ghomN2tTLUKjjHAce5U1R45ZM6KvNMH0YH4A43RRT3eqHrUZnTLjIH9V5veGEqpvPP0VrOW5DzN48RGQgo++pLL1ob+o92W7jrOHhCAbfr8TuicaqAfaJoLv/2lFHEJ8+jhibbaPDprvFYE96k/aebujMCW+Lep/v2mea8qaA1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743441124; c=relaxed/simple;
	bh=8udGiQU5ZRAiro+3u84xU1691oYYYgMFURpfFG125yU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q/mm5LlUF5c/Ol6RZfG3jBzlPLSri8dLXnsQNUTkACYC6N4T0rJx5iMtUDWXlDHLDSB8VTX5Al9Czcr8R7lg2DVBnUhKV7S60fLpE7bjO1cAshY9Nh/UuGQPMIh1wCEJ02i6VXNRe45DfgjsaDUd/K7AnbaNuufRw+IdHgbLCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9OSfw9P; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9OSfw9P"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso2415727e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743441121; x=1744045921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcuF0+ZKE7JCP7NOtTQzlRSim4RB1PAdxmeupWvyor8=;
        b=O9OSfw9PM+0sDe+M61M0/v3P3SOraaF0Pg1tVnTir39UBtgEnOPuPZNSnlZlZ6SRH1
         zV33qWgwuIXXenr9tmYP5kZRM95dGBXSaSuJnYEOmOWXOxBKSqhiHBMYK2DEFFC1l+kQ
         NAFGBv34QTVhA+Teasgshwcy2n7axjIy4gJQtucCpLAlpRGqxiP5t9lBpLmfRAHXzs85
         50s4WUZ72NCNnb3edtNMY2xcDQ17qmvUpJ/+aG4BUITpSpA6vhuQPV6v5c0/h52KtIfp
         FTavfM3Umu6McFu3v05qrQFcEPnpbpqDNV1QE+j1tQ5Y8K2tlStQeeUD+m6Q3WNMApye
         1kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743441121; x=1744045921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcuF0+ZKE7JCP7NOtTQzlRSim4RB1PAdxmeupWvyor8=;
        b=VW43CG0GElyhceStVouvYI4lECrkDf2ZJkE99wkFWNVo+gscLtGL15W/76Li5DMfz0
         1lbk+N18Gn8Jl3J+y1LXQsgRtYzld+VmeJ6YFjrKdwbZebVk8yfjngUN3BeCyDDXIYhp
         RJwvqEhC+/zSLw2AliN53SMnNgAHXw2BwyMLuaF7/ag35+Im7yObq8PFLwBDrKvFypUK
         hAj2T/lWvpjw8Hz+lqxFKgzT3Xgr21dwm1rCnxSSgCLFuJ4PdcBrNQmDeNBzD7E2Mgzf
         ehKTopBGlLcPw1252Okka02TyzHBw/GgYLTVovz+duLm1qvVyCTc197GUMfY8S0IznQX
         xOCg==
X-Gm-Message-State: AOJu0Yx5nUG09RTfTRacTnQxrfNVKYbf6OsDNwE1pzSm4ap6EeAPw5DZ
	DVuAaRkQEOkj4ilIZzypLqdrSY3ebNI+gTgS9Sp3Z4pUnK5N6Q12r5tdVw==
X-Gm-Gg: ASbGncuNDnCfi0lUsHn0aqCXXQHcWX7IbN2nUPguWGPNGyYte/EByi1zEFsDFfOwB/0
	xqH4NUF0PHvJGsKS2s/6xuRAN0dt9Klx5zPfm7v1ZqhO1OgVdMz1czFp8dHNrcc3Kk52lRUtKTZ
	RIxjzQlmQVtXEA6fhExIWj5DXHqfI0eZ7gNzyOw0G/xHmAfOMNu1KqXRvjz/qFB5jEfpjGn/Xu5
	+utoFeqd6GBR9eLrUAzlcGIpV+xezH/fd5WwEnR/+Z34xGVT1zTLhq0x0XiRBfePeP+Y+/oyWID
	KF2iKVKxmaUafnsxcIm18Mq2EmIS3OSKjOpyWbkjDZn/R8eIByH2gkJSbRLiZMYnc9NIovKlQ2X
	MDhb0W8ov9wz0+g==
X-Google-Smtp-Source: AGHT+IGWt/DMlYXsTOjX5F4/+wul1K/mVWGyIyjofQfN7kJ6lyBE4fGEm5A6TtmxNzfH3phypq39Vg==
X-Received: by 2002:a05:6122:1307:b0:520:5f0a:b5a5 with SMTP id 71dfb90a1353d-5261d47bd0dmr6068226e0c.6.1743441119936;
        Mon, 31 Mar 2025 10:11:59 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5260e6a0f03sm1641471e0c.1.2025.03.31.10.11.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 10:11:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Fix swallowing states transitions
Date: Mon, 31 Mar 2025 13:11:57 -0400
Message-ID: <20250331171157.3608035-1-luiz.dentz@gmail.com>
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
 src/shared/bap.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 5d4d69d2925b..2bab316f3802 100644
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
@@ -1705,19 +1706,11 @@ static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
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
@@ -1735,6 +1728,24 @@ static bool stream_notify_state(void *data)
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
@@ -1760,6 +1771,10 @@ static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		stream->state_id = timeout_add(BAP_PROCESS_TIMEOUT,
 						stream_notify_state,
 						stream, NULL);
+	else /* If a state_id is already pending then queue the old one */
+		queue_push_tail(stream->pending_states,
+				UINT_TO_PTR(ep->old_state));
+
 
 done:
 	bap_stream_state_changed(stream);
@@ -2716,6 +2731,7 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 	stream->cc = util_iov_dup(data, 1);
 	stream->client = client;
 	stream->ops = bap_stream_new_ops(stream);
+	stream->pending_states = queue_new();
 
 	queue_push_tail(bap->streams, stream);
 
-- 
2.48.1

