Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1886270575
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367228; cv=pass; b=XAwk9NqK3+lJ5D7dtPuZDda1LoZ6/S65cwSV/8jr1CDxa44KeAr7ec6xECs4zV/JUjgSIrnH1X+ceEztxMv9uGAcaqrmdRLT+Sl5PLTEe+kLE/0d/3a026iTMNYlWb73efdRflImSYLqQ/yfh+I6eNNgIhOHk7imoWf7xhwv4Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367228; c=relaxed/simple;
	bh=mKKL59jB3llqMfFdtJbSDFpKLu1M4zhIX/xcS4Edo98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBlQPxtK8RFhG83gCZ76ehrwFGC31ArtsIFz7E3REYggl1itDjuklaJUF0To4VIFK0aZyI8p4wgTvIzxQ4hD0X8T/WbL9b/k9df3RriQ89jLf/0kLX8rxeANS/J3TZHhovLjaTmNdC6Iqeye8ChrqEzeSDuQrhXILStT30Gwibc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vJBxDMHG; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vJBxDMHG"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d1v1L5Z9PzyV3;
	Wed,  5 Nov 2025 20:27:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762367222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uzoj0VGzOonrK7f44EtYXePsfqKQ0hTYqmtQZUCdDW8=;
	b=vJBxDMHGGr7njiTFKkGo1g8qWSGzprTWbD6aqe78Be15Wg423sgmArTmkT0ZWK4mwt7mU1
	ycz1vxpKM8JfpZBdIftIxUnrryZJSU5uK9sgM6xrCya7Ni8B9/hKsvABNjczHjUTBzT7Ce
	cvfzZExMyTd9Uzf6427E3Qtox497CBw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762367222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uzoj0VGzOonrK7f44EtYXePsfqKQ0hTYqmtQZUCdDW8=;
	b=Jli3HYJggR3Oq39J45aU/tZEYtMITi1GjwoerwXwd+c9WvzJlloh1WGWbTnPYSquF7pSLV
	H/oaLzxO0+na0GS5Zxrb2kivtvXx/E7YDz1REu4DNRXdlGs8MMczFe0tIwI9TTnmxr64XN
	kuJ0YVUFgn5J1sjqyuRV5geaAi+x3zQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762367222; a=rsa-sha256; cv=none;
	b=YGxJXh9L+ZORTzzpE5eMUnSld2/2lGw1PN2EiEj8dLZhxNbgJ+EdH5MKAcr/l7B6/TxMSi
	ZLD4auYMLBWhccw7UIxtLSDSpWZXOvEQ05dQt2nmb4LlIC5NRzSdQIXPXi0MmFmKXxA18z
	fGO2X6+fb4/1Gw7yPQILQxRGufWmEiI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RESEND PATCH] transport: always show A2DP Delay property as sink if DelayReporting
Date: Wed,  5 Nov 2025 20:26:52 +0200
Message-ID: <9c8c3680e82cbc31b8f9cc3a64997c3668220ddb.1762367086.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Delay property is currently not shown to sound server unless remote
side has acked delay reporting.  However, when we are A2DP Sink, we
reply to delay report requests with the current value, so the value
logically exists and is active.  This behavior was apparently changed in
commits 05f8bd489fd1 and 5d4efe960fd.

Show Delay value for local A2DP Sink endpoint if it has DelayReporting.

Fixes: https://github.com/bluez/bluez/issues/1541
---
 profiles/audio/media.c     | 5 +++++
 profiles/audio/media.h     | 1 +
 profiles/audio/transport.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index deb321e6c..a7a8575f9 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -3488,6 +3488,11 @@ const char *media_endpoint_get_uuid(struct media_endpoint *endpoint)
 	return endpoint->uuid;
 }
 
+bool media_endpoint_get_delay_reporting(struct media_endpoint *endpoint)
+{
+	return endpoint->delay_reporting;
+}
+
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint)
 {
 	return endpoint->codec;
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index d3954abd6..380951f28 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -19,6 +19,7 @@ void media_unregister(struct btd_adapter *btd_adapter);
 
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
+bool media_endpoint_get_delay_reporting(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
 struct btd_adapter *media_endpoint_get_btd_adapter(
 					struct media_endpoint *endpoint);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 08ed699b2..08ca360f4 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1011,8 +1011,13 @@ static gboolean delay_reporting_exists(const GDBusPropertyTable *property,
 							void *data)
 {
 	struct media_transport *transport = data;
+	struct media_endpoint *endpoint = transport->endpoint;
 	struct avdtp_stream *stream;
 
+	/* Local A2DP sink decides itself if it has delay reporting */
+	if (!strcmp(media_endpoint_get_uuid(endpoint), A2DP_SINK_UUID))
+		return media_endpoint_get_delay_reporting(endpoint);
+
 	stream = media_transport_get_stream(transport);
 	if (stream == NULL)
 		return FALSE;
-- 
2.51.1

