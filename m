Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38D1E98E3;
	Sun,  2 Nov 2025 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110645; cv=pass; b=RaEgZbki8mar6uZtUa11DRciMrfyGq3dXdvCaA1ghEzXsnChpcxj3qtt4iiDAJpO8OLn4zpnku6XwkzavSu8un1OKE7529ZPiHIqCgGQDi2VDy22WelWcXlmUsfiLhHNqjCkw/G85LG1HpBRn4G8fTqKqCWwOkxjR6GUxq+qUYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110645; c=relaxed/simple;
	bh=85YAsu0JXmPoJve1uWT8OdsdgthE9YF5aeTRmOu1n84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKw/Jk3GP81rWm1bJ1md59LNxxmm0OhVQaNKA0shWe+Isgx+C9MSNr46qi50t8S2xVosd01gOApQGVrU8p7nor3dfoxWEpFcJwIO3BaSePX3pGrq4q29KfWRFHRWpdLkYEKL8YM69hOjVXsf7hw/nX4CZEojhdWnCl/S2xKwEJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GOJ4qg5B; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GOJ4qg5B"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d04735mh8zyTf;
	Sun,  2 Nov 2025 21:10:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762110640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TyDz8UTU1XS+dg3StBHEDETctWzgVmHJp0QgzB1R4XU=;
	b=GOJ4qg5BPXFl9NvfONQWRPdfYq9NPlVya0MXnyd60bqgLmzzm/WRS++9zp0onYtmdR7nXl
	wkdHp3djBLysesrvof7NfOSW3rCn6rOUjIVWszfgFMReWxmL7+V+2z3G5LWyXAx0nRYbzg
	V7mZ3kvlsjRPgI/FV/dzYpB9yEa3TpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762110640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TyDz8UTU1XS+dg3StBHEDETctWzgVmHJp0QgzB1R4XU=;
	b=mfgsIAjb8Y713rwLtDERPSQG7MjSC5bSS6D/henf9LT2xvTrqSnJnToA0xoyMpLdavOUfC
	f/xYNi2YlzCkRY4Zbuqyn2UEZbHYJSYiOWhTVs8ot+eFAe60USJMhfBfO988dFE0jH+lsb
	TMwPiTXNqJRX/Nu7LPnHfphJdXBFrpc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762110640; a=rsa-sha256; cv=none;
	b=U6PXPD9ly/NC3XaXhOxIr+BO5yQAKEJImjaKaQ+rEyvZ22s9nnbIdhJyK/DaqP8eTOKnt9
	gHtcd1wsuPo88ff/K+sJt3eyf7YRExwMJk+oNnnO5Qd6cc8gH6acmVPO/78726b6xwXs+g
	fnh8lFlBOs5yh78uXhZt4i4TSiMH1y0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: add min_mute quirk for SteelSeries Arctis
Date: Sun,  2 Nov 2025 21:10:15 +0200
Message-ID: <a83f2694b1f8c37e4667a3cf057ffdc408b0f70d.1762108507.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ID 1038:1294 SteelSeries ApS Arctis Pro Wireless
is reported to have muted min playback volume. Apply quirk for that.

Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4229#note_3174448
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 71638e6dfb20..e5b857129caf 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2267,6 +2267,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1038, 0x1294, /* SteelSeries Arctis Pro Wireless */
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x12d1, 0x3a07, /* Huawei Technologies Co., Ltd. */
-- 
2.51.1

