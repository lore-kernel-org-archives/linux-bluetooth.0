Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBB32AAAC
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090945; cv=pass; b=XYrHbaEwR2mku8gc3lSbTGQzrvc11GCtQ0YXJBbToX2wKTADEdmqF5aNfDsZSO4ebN4+AzZRNlTwaO2mdUrDzXn+I8bCVK6pP1V9ybkxaxD5cDJ5ZYl4CxTNqDCE+HiztH4D5Jym7sAjOBu3Vs6N5GJtmNxlI5tlXessoc9Khhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090945; c=relaxed/simple;
	bh=0jiBx1m82Zbf3BRCSkITjI60ZLUwRlLzEu52zbbyGkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cixS/oAuzXnlMf9OgVK9JkD/uIhfIqIsLCeKGZ8c8sZZxjTj7sUJ0SQj6MRN6aRcylBUZLV606tP3ohJt/M641HOLpP3zp6ihYdkuziLHI20bSVBPzFQHAm/klX6Xzbt/M8o1N3s01AxlQxZZGDwC6ZomQhpezhP+axEt625E8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dce5ES+/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dce5ES+/"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dG8Tf6nFHzyS9;
	Tue, 25 Nov 2025 19:15:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764090935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WqNRv4kcjNG2VeYjghyOjZ9WjIezFgJEc35dw8rzc4A=;
	b=dce5ES+/K1U3HTG+hY+t/csqMucHuMSSzZrueRkYzbjXQnvpbvnTmZ6TKCmep7D9UBGp8X
	H1AXwO5N3R/Eo0W+Q6V9vsRU8WGvggSV/4m+UB97pFJ0SzKuL7sBSayC57oGjbUIx6CfKR
	hJ/x+8sOFR6f2IusxJ6ZJ5tziEKkl4w=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764090935;
	b=dIig4HyozVf+7+7Mh/dXZIouDx4h9QYqjskxkP0oeVzkCPEI9BSlZBLDsAWdE5a3CZb8WK
	V0wMwITbRjkqxFgLytPWFDUM9bMcTcJmTGT/hsi5MFmTvml5zRSA7D66cMhgB6ZnCr+Wdf
	FxWcrbb5JD50LGKgwl+35vdpl7sBFFw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764090935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WqNRv4kcjNG2VeYjghyOjZ9WjIezFgJEc35dw8rzc4A=;
	b=qLlNuiU6l2F9zoOSGXFDAWGHB6RyQXpzbBoHNcKn3xLtkepqz290ye3ueChZD6mQ7Fzptz
	igr7D/+p68EUSqFqRbdqbiMJT+ude8ntaBWzxVzNU12scxSBUcs+R46YmOvjVccqEvTUrp
	RnqUfcGmeHSJg74VYBHAJOQyVfxHHiw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] transport: fix VCP volume updating and sink volumes
Date: Tue, 25 Nov 2025 19:15:31 +0200
Message-ID: <68b8ba8dd63306081aa7630e3b1f8a186e558b6c.1764090857.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signaling VCP volume value update was broken in
media_transport_update_device_volume() due to inverted strcasecmp(), it
also has to be done for all transports since they show the volume.

VCP output volume was incorrectly shown on input transports.  Don't
expose Volume for BAP input transports, since AICS is only partly
implemented.
---
 profiles/audio/transport.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index fc23cf33d..d466ec9b6 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2308,16 +2308,32 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 static int transport_bap_get_volume(struct media_transport *transport)
 {
 #ifdef HAVE_VCP
-	return bt_audio_vcp_get_volume(transport->device);
-#else
-	return -ENODEV;
+	const char *uuid = media_endpoint_get_uuid(transport->endpoint);
+
+	/* TODO: PAC_SINK_UUID needs AICS */
+	/* TODO: VOCS */
+
+	if (strcasecmp(uuid, PAC_SOURCE_UUID) == 0 ||
+				strcasecmp(uuid, BAA_SERVICE_UUID) == 0)
+		return bt_audio_vcp_get_volume(transport->device);
 #endif /* HAVE_VCP */
+
+	return -ENODEV;
 }
 
 static int transport_bap_set_volume(struct media_transport *transport,
 								int volume)
 {
 #ifdef HAVE_VCP
+	const char *uuid = media_endpoint_get_uuid(transport->endpoint);
+
+	/* TODO: PAC_SINK_UUID needs AICS */
+	/* TODO: VOCS */
+
+	if (strcasecmp(uuid, PAC_SOURCE_UUID) &&
+				strcasecmp(uuid, BAA_SERVICE_UUID))
+		return -ENODEV;
+
 	if (volume < 0 || volume > 255)
 		return -EINVAL;
 
@@ -2802,7 +2818,6 @@ void media_transport_update_device_volume(struct btd_device *dev,
 	if (dev == NULL || volume < 0)
 		return;
 
-#ifdef HAVE_A2DP
 	/* Attempt to locate the transport to set its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
@@ -2811,16 +2826,19 @@ void media_transport_update_device_volume(struct btd_device *dev,
 			continue;
 
 		/* Volume is A2DP and BAP only */
-		if (media_endpoint_get_sep(transport->endpoint) ||
-				strcasecmp(uuid, PAC_SINK_UUID) ||
-				strcasecmp(uuid, PAC_SOURCE_UUID) ||
-				strcasecmp(uuid, BAA_SERVICE_UUID)) {
+#ifdef HAVE_A2DP
+		if (media_endpoint_get_sep(transport->endpoint)) {
 			media_transport_update_volume(transport, volume);
 			break;
 		}
-	}
 #endif
 
+		/* This is sink volume */
+		if (strcasecmp(uuid, PAC_SOURCE_UUID) == 0 ||
+				strcasecmp(uuid, BAA_SERVICE_UUID) == 0)
+			media_transport_update_volume(transport, volume);
+	}
+
 	btd_device_set_volume(dev, volume);
 }
 
-- 
2.51.1

