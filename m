Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1C25B2F4
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929843; cv=none; b=YAozgZins0pd4zYMtWtJeJET8hSk7oFjsSxMYPigkM/slmz0F7MtF2eHh/DjTRly/ea7r0ZLUItA760TZ8EVsOWrSg0+b8/guiAbc5Kma0pipPzXAd+xOHJYNb65AarhbbT3O8RtU20MCVt569uRa8BL9mpZEh1FBDJcSG9+mRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929843; c=relaxed/simple;
	bh=gv58V8QVV9Et41DGa1KpAhhmPb2I/lGqN8a+HCXlvxE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D98YVVLzsV6JoULXl4xqguBn3izoKvYra1e0mbQbWWLZ2sabBQ6frYELXoHONwG/F0Krmh2x1bJcVRpAwCh5cEGcOCH0r+aoq3z+7GgzHphcKS2YTgJ0jNn3Hf2S6JPPeSfqTjiB1Cban8L2W4B6uDMB1pGk7pSUMT+tVHDO1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TosYx/eF; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TosYx/eF"
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5fd05e8d317so249761137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770929841; x=1771534641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdAzEgxa8QjaH5yjC1sDo1+MK3Zrmic41z9YwF2rN9o=;
        b=TosYx/eFqHzo3c81d/d1Ig6DRSaAkx3nodDibKgcESefEre0M6BGu5u9LhDtiNfJ4y
         Ro1OpQDuCVgom9CcccaEITlXYPW6gKlyRIGyoZoOP3U9mGSwEmLPiNjyweCcTcJK7yUG
         RHLY9//omLiVTFvosFDBaFoSqn/ZvoJ2ut3BLOhNtadVGqUk8LHYUoN689YEoK0JR/LW
         x+OKsLWa8UXU8jUcDM5v8SOKg/RIKIWKBZCOhjClas6ZfMLbpHF6RUGBttRaNP1UpZrn
         BddCMutWZ28vF7iTkzei9QRp6pLp+ysi3RqgoqfhM+R8AS/7JWXsOjc0JXkTdzVyG4Ji
         1B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770929841; x=1771534641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdAzEgxa8QjaH5yjC1sDo1+MK3Zrmic41z9YwF2rN9o=;
        b=adtVUmCJQytC+HEwsrqDAhWsNaUbZC21fm27KoUwx665VKWc6iXzNP13d4tRBVLjfk
         XEL2B2wi1F91TkTH7EmDeXnk82iUW9ToE6K7k5eCkKAd5dd5akRGUQLQ6J2cqGoigvK8
         OwsVmmnlxkgQn3EWEJlEimGoIALUHA2hl1RGQUGNUTGvgOrqQK9Spa4UHVjHEipfu84n
         k5dGsUl2EEWuTb3dXRJfgXbrmmcGnQUWfd89bi8xgEPF3efA+sxog9kXYx7KR85IbPmj
         5V+aawvTf4AcRNL/JsR1MsUiGELmuqGnaxbkCNFOGqJnIu9nd5zpag7rLndP3PyS74vk
         P6pw==
X-Gm-Message-State: AOJu0YxQ9z7q/xZd3O0FFG9GX7LNfWZHX8tBZLsBEyYN47SBCOfkEtEg
	VvQj4YRSQ2oZyQ6rvPK1rMMp1+7TXHauxhIG5ye0+XubicyO8W1hWTzQypDeEJa/
X-Gm-Gg: AZuq6aJrOA6GfwAatuQxKLLv7K4huAVD6aikFQLpytJeuvBT3iaqOquzxCRtP0vDWcr
	y2rAnACBAN5oalJpYhKUQEK85gjO462bBAdYO6ExepK95k7CCdBPdARiJiX7HCHliaOvxb6BDBC
	qx3oYRWJFw5Py6/r+OLdgATu9VCA0+8L8ALdA6saGNU04pZtnF7vYhrRqwDSgw0ZTbLPrlKWiJR
	liGeTDrKZvVkE+AeICyVmEngYYVdaMd+Ic2fidFTQQ+hn+kcUU2k0LS3Kv+UMMRvkHio9Kq2fWH
	DQtG4Ei9zF6SuNmWfuC2nqdr8TktterefgXK5wsPlPBN9mcmB8eHBGyCjSHxUxdpNXnwrGUhKS8
	P1BRfWij1L3IB0ujcJBR4qDYxaeIJzRveuKPuGEQ9EY1yEg0iB7LcZ6kPtfXFatPI8baZZY9hwK
	v06uXyaSa9owGczKQS9hszLdEzGgI4XPFTmHIr2XmmZybE4St/Q+e5ky36SflO862QLvsj15T27
	m3+lboh8RS/PMEedA==
X-Received: by 2002:a05:6102:c8e:b0:5ef:b4c5:d8e2 with SMTP id ada2fe7eead31-5fe16e063e6mr70333137.7.1770929840664;
        Thu, 12 Feb 2026 12:57:20 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd1ab72bsm2301261241.5.2026.02.12.12.57.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:57:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bass: Fix crash if setup is freed before bass_bcode_req response
Date: Thu, 12 Feb 2026 15:57:10 -0500
Message-ID: <20260212205710.1690782-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a the stream is set to idle (e.g. because the endpoint is
unregistered) the bass_bcode_req would be left with a dangling
pointer possibly leading to a crash if the remote peer respond or
the request times out.
---
 profiles/audio/bass.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 031f527be9f5..9c8046dad99b 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -385,6 +385,41 @@ static void delegator_disconnect(struct bass_delegator *dg)
 	}
 }
 
+static bool match_bcode_setup(const void *data, const void *user_data)
+{
+	const struct bass_bcode_req *req = data;
+	const struct bass_setup *setup = user_data;
+
+	return req->setup == setup;
+}
+
+static void setup_clear(struct bass_setup *setup, int bis)
+{
+	struct bass_delegator *dg = setup->dg;
+	struct bass_bcode_req *req;
+
+	DBG("%p", setup);
+
+	bt_bass_clear_bis_sync(dg->src, bis);
+	setup->stream = NULL;
+	queue_remove(setup->dg->setups, setup);
+
+	/* Remove any pending bcode request associated with setup */
+	req = queue_remove_if(dg->bcode_reqs, match_bcode_setup, setup);
+	if (req) {
+		free(req);
+		if (dg->timeout) {
+			g_source_remove(dg->timeout);
+			dg->timeout = 0;
+		}
+	}
+
+	setup_free(setup);
+
+	if (queue_isempty(dg->setups))
+		delegator_disconnect(dg);
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -474,12 +509,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bt_bass_clear_bis_sync(dg->src, bis);
 		break;
 	case BT_BAP_STREAM_STATE_IDLE:
-		bt_bass_clear_bis_sync(dg->src, bis);
-		setup->stream = NULL;
-		queue_remove(setup->dg->setups, setup);
-		setup_free(setup);
-		if (queue_isempty(dg->setups))
-			delegator_disconnect(dg);
+		setup_clear(setup, bis);
 		break;
 	}
 }
-- 
2.52.0

