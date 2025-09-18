Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47372236E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215989; cv=pass; b=njvY2BD7uYn8ksNM7Vml+mBa7y6O++KOOC83aDb971A2goIGvRYsColdSnLXFXV4LGpFzggq52cBOBfenN8Xf3hCao2wtjxh1Swe3/ulhGwhlqYhSY+s/JoGMK0L0DUzrSmWGInjm6/FaJ/G/rhzAckW9noSmn4PZN96fleRHTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215989; c=relaxed/simple;
	bh=1IqlqM93pSZlAtitQieLIkccTj43yS4yDgI1L9VK+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofUCxASsl5/Pn7jxcmssFTKTzyNSFSlXCps++/8VdP3hxQIybvzxvgM/wYohqkDn+BnPogVayodn9zL+tLNXcTJmaYjOkRl7k18fOgv+coQyC6EoLp4yTb92fXJNTF/P4QAybGfKXuS4/J/tUSzpE8eGj1TDMWqYxwA0MY0sODQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=RDl9FDHJ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="RDl9FDHJ"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cSMnk3zG5zyQK;
	Thu, 18 Sep 2025 20:19:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758215979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aBEoteOuyHqHEz/tYPFqwCxuz0PYVDiQULwH5vYJvz4=;
	b=RDl9FDHJA7mspTn0OV9pK75I/PUpREadh+PKBm7+hm4NjRwqiHZziiNlBnZnYW4X06Xgc0
	zR1b2iB39vfrWj8weUFUv8RYPpI1ysRJYStVLyc8+nX4CdZLE0+6F5cKfXNkmk4Y4whr9F
	vZke10OZ13NwK96geFlbiw4byMvNM3k=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758215979; a=rsa-sha256; cv=none;
	b=ThRcXbGZoYseCS79ME1e/s04lHhCCxUGkVdJaFyEj9kHTL9xxm7W/tHNYvYMRoAW9VO7Kj
	VqwaBqjWj4YK6spk87ni5mb3wDIq1TjR2L2YbzzQa2Gr5k7XKILRxLo3CdEOYdbvQ3TZIc
	+yuvjSodis2QYE02UYCoMEWy6eVhcEs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758215979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aBEoteOuyHqHEz/tYPFqwCxuz0PYVDiQULwH5vYJvz4=;
	b=YPHXP+ARg05rCAsHfwISlT6s6AI0FSFRgyqi0jjo6ym+q4v6GRjuTTqSqDF+SJfQ4wN4/H
	vlD/1YlbaWjiPDNUHkVF62qVIR4cJXkIUQ55LRf9x99IZhko8Tmnr6UhHCHHwYgnHPINTT
	GjYG6l/QDW6SL/SwY3TeH39UvwH4a/8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] media: fix pac_config_cb() error code return
Date: Thu, 18 Sep 2025 20:19:35 +0300
Message-ID: <a9a2cc5fe58b706247b74adeaa5f0b774432f837.1758215957.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: a887b1a1b91f ("audio: Add support for specific error codes for A2DP configuration")
---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 332f643bb..deb321e6c 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1110,7 +1110,7 @@ static void pac_config_cb(struct media_endpoint *endpoint, void *ret, int size,
 	if (!transport)
 		return;
 
-	data->cb(data->stream, error_code == 0 ? 0 : -EINVAL);
+	data->cb(data->stream, (error_code && *error_code == 0) ? 0 : -EINVAL);
 }
 
 static struct media_transport *pac_ucast_config(struct bt_bap_stream *stream,
-- 
2.51.0

