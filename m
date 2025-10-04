Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53322FE18
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759572167; cv=pass; b=uDJ+4Vqowl3GSOig16v/vtbDml33aDybId5omDSTrGsDtHUH3cCTbxwumtYt2+5k0doD1gwZEQQFKu16/g0ZmTbkBrCKv1+T8AsFQD8BuC9zlafH5O+9fc5/gijq8VJo5LYW/1Q5xKUry8+Rw2pMOAG64hGFQ/KuXkp8zRCmW0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759572167; c=relaxed/simple;
	bh=D00F6xiL2YlUhiejygFhIF/JEqaO/RoStkprTZKD2Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hi4tpBAmDj+DKubPsCcW5Pp4CEoTrO7aE28eE6lsHMZ+GK8EuzTu9GTuCRJeNCNCQFqonftJRiKy3Zd7yWGAQREGaLLaAtdwmPN3GHpfqo6HBkl5CBh1MYI81ECigAwcLPw/kiAtjc3EN+Yhvfub0w/BfZ8RB9LkFluB7zaYyTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jJb33/hg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jJb33/hg"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cf1L94sd0zyRl;
	Sat,  4 Oct 2025 13:02:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759572162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jy5J0asb5Qewi6zlX7EOkV7Fuv3XyUH9Uq0ULy23FRY=;
	b=jJb33/hg275DxxU6gIcYfZPwhXzdFwal3EcA15uQLnoO81dOfCkAEbEAng9RJDZZhtT2OJ
	sOhAB3fusCUGKgVC2HYT40KHYu3o557k4379XozNrRXwrpkWKTpV83HvIuFBbzS9qvxNbW
	8o2IQAW6RviK+tQNfOBb3M/6vV4X5o0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759572162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jy5J0asb5Qewi6zlX7EOkV7Fuv3XyUH9Uq0ULy23FRY=;
	b=fqF1Hfc/D6VUCEb3hi91FYZqGUO+Bwy6l6aYw6Vc2jjKrT7bmosTTLWn8x4Ng3mABItSEk
	9VNXTKFYmNqhOVGNiF2bwKDK4Jps8YbqmX+6JtDg6U4DR36WYVOEu2zGynnwhmQjKjHNg6
	/jVp7+ZmpTidrAA+4qEvXkibxHsPwas=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759572162; a=rsa-sha256; cv=none;
	b=AgqKXAgUNVUa0N9OlHkowhwjO5yB+SaMMqp2RkgMQA5wZQ/BMYjf8bR236eLKe5nMPii/l
	McoCI3zlEVzVJlvs/sJIxGazUsj8x14LS1cQlb1oNtSBMFJXRo05cYC56t3jsOc6gDXZfn
	g/sCksjyR+CFrEeyFBtQXVuQC7kIPn0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] transport: always show A2DP Delay property as sink if DelayReporting
Date: Sat,  4 Oct 2025 13:02:38 +0300
Message-ID: <daaa156e4ff99ddd24eb5f14fe4c6940e8fa8527.1759572113.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
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
index bc550b743..8c33d00f0 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1010,8 +1010,13 @@ static gboolean delay_reporting_exists(const GDBusPropertyTable *property,
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
2.51.0

