Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2926F28A
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647290; cv=pass; b=cjF7n0i77feAjHXwLtidZCRkyOmc4NXO2qCPcJgBuVa0sx2pxZnTC0yIpGssGVZoFTq6qpppza3Wy8uedmYlUM+VlrlPsjqpnH/Hfvc5Va+Fb3MgtxwGyCcKMfr7d/TMqHA44fs4XjWqqfdmP7vtVVpwCTmbAfN0aEM43O+OXEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647290; c=relaxed/simple;
	bh=SEGJn8sriHUOV9Y0Q9UXyZ6+N9DMrP1VBxt66TbWB/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9o7VRCvWePD35Hohm6PllrAw3W6ROi2KgFz0HZQMQJ2pZkNTDiQm69tCx+VPSWt+hC5fbaFPz+lPUxagGCx67qtuM0kNi4Z0lSmMciXDWZtzOQHsRkxUcPxspxhSVwoXLVlC9awfINLO6/DOebAZTOEemXNCSVxMU0r6zD8+8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=R6X2v8aC; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="R6X2v8aC"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dlRhw275TzyZR;
	Mon, 05 Jan 2026 23:08:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1767647280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWbNOqduNHc4idyD/2VZACG8SmpxzTJCIMwejMvtgBE=;
	b=R6X2v8aCi15M/YCbtwvzIB9KWEio8pxifCEWtZcJPlg1PpgW1qYq18KYU/nIcutGMyR4hs
	WuVZVDkbHsvuc5yPJDcS/hBQdaGBLUEJtEgmuGpi/0qesms17DciOs2Rd+Ir6fVR5/m0dm
	+/Fs0d07Q/r21ZEGdbtVpE86Q7uEK+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1767647280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWbNOqduNHc4idyD/2VZACG8SmpxzTJCIMwejMvtgBE=;
	b=Ya9RuXdf46xgE9iOna5t1/ejqBXCu8po5OV3v8eKwM4Vo3qmw86ixTUmw0C8lIks5FHifV
	rTcWkrQ0VM+Fjpf5Qsv4RFodKswvYTbI1cH3az07E4ClyZ4XLvNZ2E9PnzEjns5+gCPwEJ
	RZ620PZA01ah7wvlIEU/Zh1DOqqLZH0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1767647280;
	b=MlHEp9qVeffifMapRXaYFZKJCxIt3GRB7C3V1SoxbaRhKC8Rr0F5OEOyk43Fml9imDIXQZ
	wi2Hi2COrkrUvYpWMUk8jjDTYs1qRSUlcao+qJUYcTl9NYsDAPt6biuTx891p+Xn8m0IkO
	Fs6n8Ktwcsr/gNTCUxM0c2prQx3e6A8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] transport: distinguish BAP mic and playback volumes
Date: Mon,  5 Jan 2026 23:07:55 +0200
Message-ID: <05ae1cdefcc83df5d534c029bddf2f4d746e94e7.1767647222.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767647222.git.pav@iki.fi>
References: <cover.1767647222.git.pav@iki.fi>
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
 profiles/audio/transport.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 7fc8d8525..e03f57d4e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2311,9 +2311,21 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	bap_update_links(transport);
 }
 
+static bool transport_bap_is_playback(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	uint8_t dir = bt_bap_stream_get_dir(bap->stream);
+
+	/* Unicast to local/remote Server Sink, or Broadcast */
+	return dir & (BT_BAP_SINK | BT_BAP_BCAST_SINK | BT_BAP_BCAST_SOURCE);
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
@@ -2322,7 +2334,10 @@ static int transport_bap_set_volume(struct media_transport *transport,
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

