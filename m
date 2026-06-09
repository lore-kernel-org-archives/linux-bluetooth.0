Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6B3DEAFC
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039494; cv=none; b=JA3vnSYogvNz9yhwdCMSV3UW/kBpZibpUy9n6fwzfYMgS71a/ZJ8zYvhPF4+t2A32eDws1DwEjOCGKSN4zgzlTaJJeM++YT+mUEpxPLS5z83//bX7apxxl3eTNFIbbMaf9vQMc5PTY2Vmk4KPCG759nOqEYWcrG0U8mMyEWe6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039494; c=relaxed/simple;
	bh=x9vKfpzQbBeESpz6uCkGln5CtP1hHDPp4aofWd1F9zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXm4XYvCRDu/a1Ce4NGdBZEJdpefW6K5y4u6AFEaEft2xrD7JtYGVdUpecMbN1sp8ddK8XobGeq/XxNSY+ctN+t+DIiZ0OWij4p2FhR0K9jlF/JBuQIGy8gIJswciiHKmDbymFMCh0fZr21PUtNZ2g3AeZMQvTSdmjgBRumOL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=T+E+kof2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="T+E+kof2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so49806785e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 14:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781039491; x=1781644291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAeak349+yUScSoLf0dgVAalzeiHiaCVqrfFt5LGUCI=;
        b=T+E+kof2GyjeD6jODmWVIiw4kAQ61gEiCidsECfGIXuoBtSfMFCMQPlCOdTcaTGhOL
         fbDW/mhashFPLcE0+VRaJSO3BIWmatnv30WhHC2n6/BdSot8JuZ9BnJ0DbO+rPE1xDcI
         RFD15ULRRS/1ZIFvGEdZ0rm4Hhg+l1VJPKEsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781039491; x=1781644291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAeak349+yUScSoLf0dgVAalzeiHiaCVqrfFt5LGUCI=;
        b=q5ULQfyb4XoKQTWxvF4OGPl3hcRRNupTECBJuyafxRgvCs0q9tgpf1dmVv0yP3ELr7
         leLQdbRxXTvtgX03k7hWYZ0pRezbn7nO9EzWvN//S73Sxh3Jsuf1Vj7++9B+SfqQ031I
         ULEKOIVroAEUtGJgZzVxZ/qpp4oYFcDUlpxo1IjY4UTcBFNr0tA9uxNXtwLHWtC+p56g
         YvrMcCmOgNgJebNb6WbUe3fLrkRNKKZOPO+tircTouZ4iPld8FC0sXo5sLOe6OLuraI2
         /HqN1Wm6DAGTvoB8NHT+O3z/mK0+VmP7dFH/60nCaH7wBZ0qySrojP1ARiEy1OYyJDin
         JoBw==
X-Gm-Message-State: AOJu0YxF70Rc9d2eXNkkrZy9hXrKHJYzyXvJnDIPg7hCFFE0uG8WnAmy
	zpE7hZbg7wMalGZg3kV5lATnm1lXKwRsvPpXQhvVvewHVLg7yjwWiI15CHOb4itbZOEu/neFmLL
	NQfMW
X-Gm-Gg: Acq92OEEqe72eKgWJL/nFJQ42DelowzS46Ee1z3V8W0YwkfuYBiSmBnUz8kbhPRBEKK
	fWLI3WWVn91Ym8JHSjNgI26uvG2f/B37lSTWwXhlUltmLp8iKSo5ENHlX6jM5D/SoOlyFR4BwMu
	3K0plcDygB7ocOp0kE1/r3TuKUnZyq92zPfaQAVfEAcKbaALxQstaCb80AThszXju4HAdHD0pCn
	OIxzPVAIaP0ZGh7F/ZibLTWp6aAV1+RAaepcUzWk2D7dd2qbdBz9VQ7VC4yUBWy2amKz/BYeTU4
	gM+qD1ZOGHJsMbnGAU6cAon69gOd16e1mkNjRNBr6tDBzXhpiqTIn5Zve/2flZoFo+WfoSph5sL
	JIMV4NdLoSiFAPM+z73qDk1EOaSRmIKF0YgEZr2b6EkbTrjrX4xzDdfO8JMwDFVr3iWEdUhx4+V
	zUS2OsxFIHgfJ6LHfK3gA4Ne8THWIzVB7zHomVD88a3zdAaVyuNU0CSV8=
X-Received: by 2002:a05:600c:4708:b0:490:bd66:e522 with SMTP id 5b1f17b1804b1-490c26038d2mr348207815e9.29.1781039490756;
        Tue, 09 Jun 2026 14:11:30 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:e2e3:d5f1:fbcb:c827])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm66218394f8f.2.2026.06.09.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:11:30 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] transport: Complete Acquire for Sink ASE entering Enabling
Date: Tue,  9 Jun 2026 23:11:29 +0200
Message-ID: <20260609211130.3887817-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the QoS to Enabling transition the IO is not yet available because
the CIS is not established, so the handler returns early and a pending
Acquire is left unanswered once the IO later arrives.

Notify the connecting callbacks once the fd is attached so the
transport can re-run the Enabling handling and complete the Acquire.
---
 profiles/audio/transport.c |  7 +++++++
 src/shared/bap.c           | 28 +++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 4b9d26c5e..22a755064 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2397,6 +2397,13 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 		return;
 
 	bap_update_links(transport);
+
+	/* IO connected; re-run Enabling to complete a deferred Acquire. */
+	if (!state && fd >= 0 && bt_bap_stream_get_state(stream) ==
+					BT_BAP_STREAM_STATE_ENABLING)
+		bap_state_changed(stream, BT_BAP_STREAM_STATE_ENABLING,
+					BT_BAP_STREAM_STATE_ENABLING,
+					user_data);
 }
 
 static bool transport_bap_is_playback(struct media_transport *transport)
diff --git a/src/shared/bap.c b/src/shared/bap.c
index deb85b264..09f671a15 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3006,6 +3006,20 @@ static bool bap_stream_io_attach(struct bt_bap_stream *stream, int fd,
 	return true;
 }
 
+static void bap_stream_notify_connecting(struct bt_bap_stream *stream,
+						bool connecting, int fd)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(stream->bap->state_cbs); entry;
+						entry = entry->next) {
+		struct bt_bap_state *state = entry->data;
+
+		if (state->connecting)
+			state->connecting(stream, connecting, fd, state->data);
+	}
+}
+
 static void bap_stream_set_io(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
@@ -3042,6 +3056,10 @@ static void bap_stream_set_io(void *data, void *user_data)
 			bt_bap_stream_stop(stream, NULL, NULL);
 		break;
 	}
+
+	/* Notify IO connected so transports can complete pending requests. */
+	if (fd >= 0)
+		bap_stream_notify_connecting(stream, false, fd);
 }
 
 static void ascs_ase_rsp_add_errno(struct iovec *iov, uint8_t id, int err)
@@ -7028,7 +7046,6 @@ static void bap_stream_io_connecting(void *data, void *user_data)
 {
 	struct bt_bap_stream *stream = data;
 	int fd = PTR_TO_INT(user_data);
-	const struct queue_entry *entry;
 
 	if (!stream)
 		return;
@@ -7038,14 +7055,7 @@ static void bap_stream_io_connecting(void *data, void *user_data)
 	else
 		bap_stream_io_detach(stream);
 
-	for (entry = queue_get_entries(stream->bap->state_cbs); entry;
-							entry = entry->next) {
-		struct bt_bap_state *state = entry->data;
-
-		if (state->connecting)
-			state->connecting(stream, stream->io ? true : false,
-							fd, state->data);
-	}
+	bap_stream_notify_connecting(stream, stream->io ? true : false, fd);
 }
 
 int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd)
-- 
2.43.0

