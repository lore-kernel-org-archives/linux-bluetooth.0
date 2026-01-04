Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080B2EC08C
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Jan 2026 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767559881; cv=pass; b=EPBKWFpH3G5bWMieCvwwJssEMjQnzWrvqGEdNQKfC22jkx7CkGaWMmnCOKxa0TtSg6sUEEjir9q5r8cjsnFHscWVr5uXe1tYCSE/f8SNRZcE4Sqn3sM1b2VqHJ4dh9Qh7iKg62S+39KnrOf+7VXFHzjPQIh7NSkWjJs1TR8oYGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767559881; c=relaxed/simple;
	bh=4HWskd+obzSHWSZX6poodEkwfvhNMkI+A+22UoLLuaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQbySvBEyHup4Iub6hVEKfFHSDZ8m1gkhnbBXJxTB1MfZpWBwUbzZC/+PrRCPhd0a/sxYbntIBYFKBMTygA6ETPjyuUhOdOn9BZgd+SdgWtgZlkrSGwQUEA4PQbg8iDKiLysZts+gHmco13OYs3AU2ZCICbl5n/uLvWIoKnQTZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=raScwVoe; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="raScwVoe"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dkqN520KJzyw5;
	Sun, 04 Jan 2026 22:51:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1767559877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObFT/EWhIpiwphTtta9vZsPcA22P+j2y1RBsiQT1aAs=;
	b=raScwVoeGkFaf5aJCLK8VDWYyO5VflsBn/EP+d/7f+uqD1L4zWAHvl72GQDalK5EfG7LRq
	MPAAiIF6UeZPY/QunMUo7bGV4MjXj4Bjq75sStbwGm1Oky1uJN8OVoqtLP70ix82cuR/p+
	hv8CUWq+8ziWM6SpM24s/dIRQPQEuyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1767559877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObFT/EWhIpiwphTtta9vZsPcA22P+j2y1RBsiQT1aAs=;
	b=hRDlznT9JP5yaTXHSUnIBNOSsAqUom0lEovz1BZigMe2FNeg8mXYW2U8ZQB7ZhJ43TeOUF
	RLeXpmzANvVEyFofp+Tmiag1OPxbP4L7/+pGWJff1vae5EZfthpUG9mGf87IH2SO2HO8ek
	1FpQ8wovt3tJfuMqW9y8DCfDXKbKJ/g=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1767559877;
	b=wi89EH51NrgU2BDxzLRvQjOY4RBEIaNYR/8T3zblIS92d8PKIPvs+LCGZtgqJKhdE/QuRW
	gjMYhnMuZVOO3srZsUe1zSt4tvj/uWFzUEQsrzERk0b8oKp/Odo4NMBPg8YM8NjnaoivzV
	i1yyZRQhfMg9yVAnwF8YC/qfnTDkQaA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] transport: distinguish BAP mic and playback volumes
Date: Sun,  4 Jan 2026 22:51:12 +0200
Message-ID: <ad296fec68cb7597c1be7a2adec8d563da2639d6.1767559459.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767559459.git.pav@iki.fi>
References: <cover.1767559459.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BAP Unicast has two kinds of relevant volumes: playback and microphone.
Client Sink and Server Source generally correspond to microphone volume.
Broadcast Source and Sink do not have microphone volume.  Microphone
volumes shall use MICP, not VCP, but currently we confuse them.

Fix by distinguishing the VCP / MICP cases. The shared/micp
implementation is incomplete, so leave those volumes unimplemented also
in transport.

This fixes setting volume on microphone transport changing the playback
volume.
---
 profiles/audio/transport.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 7fc8d8525..d9f884710 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2311,9 +2311,25 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	bap_update_links(transport);
 }
 
+static bool transport_bap_is_playback(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	const char *uuid = media_endpoint_get_uuid(transport->endpoint);
+
+	/* BAP Server: local ucast source = "mic" */
+	if (bt_bap_stream_is_server(bap->stream))
+		return strcasecmp(uuid, PAC_SOURCE_UUID) != 0;
+
+	/* BAP Client / Broadcast: local ucast sink = "mic" */
+	return strcasecmp(uuid, PAC_SINK_UUID) != 0;
+}
+
 static int transport_bap_get_volume(struct media_transport *transport)
 {
-	return bt_audio_vcp_get_volume(transport->device);
+	if (transport_bap_is_playback(transport))
+		return bt_audio_vcp_get_volume(transport->device);
+	else
+		return -ENOTSUP; /* TODO: MICP */
 }
 
 static int transport_bap_set_volume(struct media_transport *transport,
@@ -2322,7 +2338,10 @@ static int transport_bap_set_volume(struct media_transport *transport,
 	if (volume < 0 || volume > 255)
 		return -EINVAL;
 
-	return bt_audio_vcp_set_volume(transport->device, volume);
+	if (transport_bap_is_playback(transport))
+		return bt_audio_vcp_set_volume(transport->device, volume);
+	else
+		return -ENOTSUP; /* TODO: MICP */
 }
 
 static void transport_bap_destroy(void *data)
-- 
2.52.0

