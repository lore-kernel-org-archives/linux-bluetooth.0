Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228728314D
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216524; cv=none; b=lWoPoFxqOnI4D7MVUqXHis+Nx53TsOvT2mOLqafnUySMDIOMLeN6fHY3O2Zuh8/0v3lnLNez9bmqROllnpiskz5lc7lXOMUx98GFWFgd4vToqi3v5K30EB3zwsvsvi+w8MaLM/qndvAWyw/JCBzvcDh2+518tYa7iq4DGZb/i0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216524; c=relaxed/simple;
	bh=Mxdx5TlL0l47Eg/qMXwOeYdznQky950SYgcqKpAvhFo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmwrAQ6kQw0eigX0OeSoOc3OdS/afqHFyjmTcQWLYkS0k6Yh70ezR9xA4yMTGvzuSnhHxiiXUDajdzwQg5FeXd0EUbAmidI5Yg4B0d8UUoyci4DiGKI+1oYlTm+N2/XgKVzoAqeb8RcnqaRj9+4UDtdl1fOSYR2r3OJ1nx/+2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD8nRPT4; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD8nRPT4"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-87f36c458afso7069798241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753216521; x=1753821321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Kd7PrTEtneUyVf9K8hE8wfY7Y5JfxyS1sEcRhfmT9k=;
        b=KD8nRPT4FlBFXn9RC0DKF3e9Qq6PuA4mdvQQSe9k12+h3a8fue1w49phlEI7t/2lnJ
         /RUR/eao6k/ncmfSVqDmB4FV8gLp7WZoHEcvc2AEv9q9AlTunGm/621IHdUOrRvNDiah
         V4N0/uTKOTw3Ps+gyzMClu2SZ4JmTbdkwmyT1scVKz4h04yEslp/lddxkLpSEvYe/YoL
         ihasicEh9UyEmQVBfj2oGEbSdbZNOkKuwv1paiKEMSjBEWwABD6I9eM725PJBa8BeAvI
         nLGxT3xwiLm1g4O22XtsRuC7iCNmzNwtBZTUtirntJNJgKZsco+wWj/bnKakVw1+elXz
         LQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753216521; x=1753821321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Kd7PrTEtneUyVf9K8hE8wfY7Y5JfxyS1sEcRhfmT9k=;
        b=s53TNDxCDPK5/nAL2HtwnK3/87y70fBWKquAhoNvLRjejShIY89pc86Bf1y9jJE7kR
         WCi6UWV6E3h6+Cj4PCqej+pTmsRvX5NkKPdhXwQk9tdNPd7KdTSAmwOhqCDlo8YZNFs2
         7l+U7jvWfnte2D2uVCPjQCcD1IgdlWQ0Um8NN105YK7idYOEv6z/+BrQOMIxuC8fhpC5
         MKXnr3wYm9PK1UUqiev/DsQTZVuWIRCtyrfo41Oz8hGHXpQR9zmYyKJby3h+2yAsEteD
         lXJ9sAZjxuj/R469YFnQe3FFqZSw9vObLI3Zbx/aiXIIzILNKVbd+J34hoQs6FXwdgoz
         hfqw==
X-Gm-Message-State: AOJu0YzefVhmCGfckdkx93d5LOGmMFV3hTsUAaziV+gr0XBBNuLpjCM0
	5odCfzGhnaU2/EGp8Vdv6oG5U3kYz30izmQc9a/f4BzCDq4DrYFXgPDLme327oy0
X-Gm-Gg: ASbGncurt2eMWIFkyLUI5G58cRmVGN3xSHYiMsjlEtJ/tJGv22qskTt8l29L4c/bPdu
	vABc/p/2f06qDA9Lo0XM/a1K59dmEOp9CyeVe87q4jJN/bUqzrWQA6qiCfKfHgIR+AtCTy4xrkw
	K9SdbzYLyalsb5UPq9rg67CaRXyqMTlLQvbZ3ssXInPSlPyewVMl5z6l6jluRaYol3wuO2PMfrA
	YW1l3lZhZGxyJpIIogJVVWFUeQgUKh6ErZOREMFQduP1ckGwyxV/tILlTNUCGiTKTh26WhII98H
	en0X6HnS6dBeRtOm/YPX1t5419oVbDghFImkzMbN237lXxtE994SXLgQL0f4QB9FSlm/Kivk7oO
	Ld8l1zk4n+Uzc6UNr+f74h7fL9CfDpEAxKGF73saPiu7XTmnHxo90Jra54ckXPvXI
X-Google-Smtp-Source: AGHT+IHz4exmVxxAeao8Mset7tlk4t0SbbuU8SqWqriVURmAxmp92/QLxThCwNGq67+kzKU4mTE8mQ==
X-Received: by 2002:a05:6102:5491:b0:4f9:6a91:cc96 with SMTP id ada2fe7eead31-4fa15217e98mr194856137.26.1753216521258;
        Tue, 22 Jul 2025 13:35:21 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0abfe699sm3444451241.5.2025.07.22.13.35.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:35:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] transport: Fix not updating MediaTransport.Metadata
Date: Tue, 22 Jul 2025 16:35:07 -0400
Message-ID: <20250722203508.1311750-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722203508.1311750-1-luiz.dentz@gmail.com>
References: <20250722203508.1311750-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MediaTransport.Metadata needs to be checked for updates when state
changes to Enabling or Streaming otherwise it remains blank.
---
 profiles/audio/transport.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bf16de958be4..111d4b9b7ed1 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -107,6 +107,7 @@ struct bap_transport {
 	bool			linked;
 	struct bt_bap_qos	qos;
 	guint			resume_id;
+	struct iovec		*meta;
 };
 
 struct media_transport_ops {
@@ -2141,6 +2142,26 @@ static void transport_bap_set_state(struct media_transport *transport,
 							UINT_TO_PTR(state));
 }
 
+static void bap_metadata_changed(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct iovec *meta;
+
+	/* Update metadata if it has changed */
+	meta = bt_bap_stream_get_metadata(bap->stream);
+
+	DBG("stream %p: metadata %p old %p", bap->stream, meta, bap->meta);
+
+	if (util_iov_memcmp(meta, bap->meta)) {
+		util_iov_free(bap->meta, 1);
+		bap->meta = util_iov_dup(meta, 1);
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Metadata");
+	}
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -2179,11 +2200,16 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_ENABLING:
 		if (!bt_bap_stream_get_io(stream))
 			return;
+
+		bap_metadata_changed(transport);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
 		if ((bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE) ||
 			(bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK))
 			bap_update_bcast_qos(transport);
+
+		bap_metadata_changed(transport);
+		transport_update_playing(transport, TRUE);
 		break;
 	case BT_BAP_STREAM_STATE_RELEASING:
 		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
@@ -2253,6 +2279,7 @@ static void transport_bap_destroy(void *data)
 {
 	struct bap_transport *bap = data;
 
+	util_iov_free(bap->meta, 1);
 	bt_bap_state_unregister(bt_bap_stream_get_session(bap->stream),
 							bap->state_id);
 	free(bap);
-- 
2.50.1

