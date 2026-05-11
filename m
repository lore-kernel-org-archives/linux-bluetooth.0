Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2831E83D
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497150; cv=none; b=BIq1w+osaU07qBnFdMXvzwwqGdXGcYWn5cWhXqeHTyLfUV0mtqrKNr00e+MV2PuIH0X3KMdObZK7NYYX8o0BPIz27UKXpLc3KYGxH351nudSI6g0HT8Yst0kE0TleiaZlR+CujZUqG0MrThd9bWxHAyLTF4Rqj75FYsYUQWxPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497150; c=relaxed/simple;
	bh=oRGI1LUoNwfT8R5NS0vx19kvIu4b7L0Z8MZEeDkjEbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVB7bmvr3oimAz4ZDu8DkyoAxom4f0v6reL8GoUCPvc37h8Mgm2w6jqoOrStiQNs/vvVJ5IpQANKOOOfqWN3q8+GpwcmUKO7QwSk+1THAURY+eSqVnb8raxe/TA8ner+sk/F7G9eFMyryLntTQ5R6INiU4l2+NZLeurEaFtvHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=etAfnn5V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="etAfnn5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778497146;
	bh=oRGI1LUoNwfT8R5NS0vx19kvIu4b7L0Z8MZEeDkjEbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etAfnn5V6MVFvo1wO+tkhqiS1hKTvmdWeOHduoxUQsYrZsHF71EnOcxYK1nBwW8yH
	 duL8ltkgcRJ2WRjdVpEU5Ou460Eed4ZL2APQaUx08rhxZcBfu4kbqe25j0U7s9klqb
	 irCtN7DjUXqDcoUxMx7/UU8sf5XKyheU5P25DrDF9uwWrC8iZDzYmw/1PHjORnIcmB
	 lbIMYqnw7Hgu/c/bwCeO5uC9yV9MOyQ/99xxRjDrHIDAz4WWprFD4Qu3C4Qgu96Zej
	 TecUoYZu1jfXgnNF16QnXIwJEl3MHIFLCFyclCGupKxth6FyDwhmsBn1DaXtK+XCzO
	 IkMCcEWj98KuQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9AEB117E131F;
	Mon, 11 May 2026 12:59:05 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ 1/1] bap: set QOS state when CIS is lost while the state is streaming/enabling
Date: Mon, 11 May 2026 16:28:45 +0530
Message-ID: <20260511105845.8008-2-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511105845.8008-1-raghavendra.rao@collabora.com>
References: <20260511105845.8008-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is used to Pass PTS tests BAP/USR/SCC/BV-167-C abd BV-168-C.
---
 src/shared/bap.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 78ba22259..2edd4b249 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6670,9 +6670,38 @@ bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data)
 	return stream->lpac->type == BT_BAP_BCAST_SINK;
 }
 
+static void stream_io_qos_disconnect(struct bt_bap_stream *stream,
+					struct bt_bap_stream_io *io)
+{
+	uint8_t state;
+
+	if (!stream || !stream->ep || stream->io != io)
+		return;
+
+	state = stream->ep->state;
+
+	DBG(stream->bap, "CIS disconnected for stream %p state %u", stream,
+								state);
+
+	if (state != BT_ASCS_ASE_STATE_ENABLING &&
+			state != BT_ASCS_ASE_STATE_STREAMING)
+		return;
+
+	DBG(stream->bap, "Moving ASE %u to QoS Configured after CIS loss",
+							stream->ep->id);
+
+	stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
+}
+
+static void stream_link_io_qos_disconnect(void *data, void *user_data)
+{
+	stream_io_qos_disconnect(data, user_data);
+}
+
 static bool stream_io_disconnected(struct io *io, void *user_data)
 {
 	struct bt_bap_stream *stream = user_data;
+	struct bt_bap_stream_io *sio;
 
 	DBG(stream->bap, "stream %p io disconnected", stream);
 
@@ -6685,6 +6714,12 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 		return false;
 	}
 
+	sio = stream->io;
+	if (sio) {
+		stream_io_qos_disconnect(stream, sio);
+		queue_foreach(stream->links, stream_link_io_qos_disconnect, sio);
+	}
+
 	if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
 		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
-- 
2.43.0

