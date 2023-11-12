Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686214AB8
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="IHiqEp42"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3932D46
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 08:00:15 -0800 (PST)
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SSy256sMSz49Q3F;
	Sun, 12 Nov 2023 18:00:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1699804814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkHnfkzajncCjvIxAFoOmkNYt8GllDeiUV2HGDPsjxc=;
	b=IHiqEp423PSjb4aVnzBTJvtb450NZQE8xfX3C0cB3/1+HstjSDAk+dZOXkG1RDYv9xVCG2
	btESNEZaED37t32lXyIvc3BvhnwkMpwcxxlgnJQS/UmMLosPkwGDNR81uP9Kf/bUJ2IOzK
	pibZ9JMnDT9KI0HFJNbE0vKhbF7VfGUP4HresOtu3s+t3g90x2TeO9JF0bxgpDhD44HMEC
	sidRKTKAo22x6cb3a504ThoOQd6K8roizt4qrkQXqUS60ECkttA8iqFBXAqxQXzHSnUfk4
	v7rmgXGtVOatYG4xZAS8fn8rEzBknA1RF9m+RsDBDyGDN4w84rE4i7oaYL0FNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1699804814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkHnfkzajncCjvIxAFoOmkNYt8GllDeiUV2HGDPsjxc=;
	b=ZV3yoTugsTvE7C5OhvHVbmdaDaImF07ffJFbthLzLa8emiUnfWaOhNI+FWgDC3k//o2lsd
	zR10DV9qTeZOXGLGrL5ECjcPWMceLlNMS9v1qx8tZVfnmUMwmIuEHQuXCSkJ+ZDzQoVFH7
	b3I08bOtsgXoLUiHfWig3c4NepX9ghK80y7MqbdBTlKIBFYQ14nQdyYziWhd3S17DXTt1o
	dsX6evvGdspuy1V6rdizOMsr5GI5ZC2umiXeiu7hELWLJJyaws5BeSfPQsseUCfMF/TgL3
	uW+kCUDitjmDZxsTWXbgwpDRFjlxwCGu3GJTdqsp4d4esF/x3d0eq7qktQZWcQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699804814; a=rsa-sha256;
	cv=none;
	b=SFmjeARQS6I7M3qErmZORql70jmcYec7nLY0mtMCMNUefFipjBoCXMyb7lGQ2guwWrDDOL
	ePxseUuFW1laL1uFBjDFiIEYy1iR/CP1Q8aYPohvscDbO8KCeruEaylqvwpU6/hwSGSIk5
	BisxAD0C/ysDo5SRd+Q/N8djU4+uaW4WT+GDp920KQ+3EWBGtV7bSuzL0GBNKx1JH0hsUP
	Dct2Ixk3xJyHxwqgV4xskpmxT9aYs7Xn5yJPkvRvWCVf59Z5BqvLfazGcQclWERqbyn4s/
	/3Ow20xHrJ53G4YQmvQw3d9Uc9ANaqBhDDZAPpUmNVV47So/i2tlITsH4lYmNQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/4] bap: call explicitly bt_bap_stream_bcast_configured when needed
Date: Sun, 12 Nov 2023 18:00:04 +0200
Message-ID: <e3487e9ed13bbc5d833dad9a6f718f5fb1035007.1699802164.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
References: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finishing bcast configuration is no longer a side effect of
set_user_data.
---
 profiles/audio/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 780dff412..85532b1af 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -854,6 +854,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
+	bt_bap_stream_bcast_configured(ep->stream);
 
 	if (ep->metadata && ep->metadata->iov_len)
 		bt_bap_stream_metadata(ep->stream, ep->metadata, NULL, NULL);
@@ -959,6 +960,7 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	data->listen_io = io;
 
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
+	bt_bap_stream_bcast_configured(ep->stream);
 
 	fd = g_io_channel_unix_get_fd(io);
 
@@ -1200,6 +1202,7 @@ static void bap_config(void *data, void *user_data)
 	}
 
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
+	bt_bap_stream_bcast_configured(ep->stream);
 }
 
 static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
-- 
2.41.0

