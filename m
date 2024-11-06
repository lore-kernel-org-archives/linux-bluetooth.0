Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13B205AC9
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908164; cv=none; b=TEwyB1WTqiOroxfAPeLuMWjzrwyrmUhq6WsidzNlb4gc+CcXsSOFMmwAP5Ti5jlMTB6M1B/vKhHQCMEnpNLc9Yam0ELBZaL1qduLBvryumq6W/GRU2Tg61Zp5JolDgUNjLYYBdV+0puoAWDP0sNcqhZdEVxuvAX+uyNGWj3e6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908164; c=relaxed/simple;
	bh=Gc8A3j0lYztHN0hax0qTtiOOAnwfD1eV/15EE3N1fyU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N2Xqm09eHgIgrHI7cpK4WZBvKqp8AVZ1phTOC9zcZvJ3knMr62etkZ2MJ+yTc1qVTDgwHszdnmReNs9xqca3rtz8jF27L+kw9cZSKxy8UE03Q0XWOqa3veX5QcrvFp4/og7txXb15n5u0pFAr6K12z5rGESxknAQIBu3mEqsqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL4JNIjf; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL4JNIjf"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d58e5bfd2so2312957e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2024 07:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730908161; x=1731512961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bGv3cAhcgKfDkavlaMqAQk1K/NFlw5e846Fp0f+62sA=;
        b=nL4JNIjfLzwZEqS1c6zf7vKWZVSW9g7vbh9fisYjntUHVvmotftTtJm5qaoBv6qwgu
         XXAKX9o0j+h9ff2aiPzZzH/v2W61NnkWYiujBTawxSS00Yryv/pX9Ys3on8SUrvF2P+X
         MRx4bulJ2dtxBgDOFoh8/8SvJW9gTzKj2bvssWNQ90KqckM75wloGrOAdYLgR7GcsrCl
         8wxm0ovGtEiLigdI0KgIsgyOM4GvNL2DAI0HT9fKu9J9T8KKszvRYSyEgr8AsGpqVNzb
         WZ8gSQVcGSLqa5aAZNIVz2cIqfuHJ+aMuAlkiuF1Evv6RLNZHA+XZRNtsCmq4Px1thCO
         EdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908161; x=1731512961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGv3cAhcgKfDkavlaMqAQk1K/NFlw5e846Fp0f+62sA=;
        b=q1htMEJcOv+qIVZ/eHX3b43x/AD0GXo66T6/to/4zFu4pUDg1Df9ntSd+JRV7oSPv9
         quPyOj+ePUvmKvN6vIoq96e1TE10tb+uEGZFkZ71E1iF8fOhjgQphlhfwTSYkNsMNsuq
         ae8rU7PRuwnTCBHgzzR1H3lhq1mwOGZ1HGL2I1n96xhrXsJOfyb4TVvbZ07Gn9i9obSv
         J/Gv5Z34pbLev+KTHSuDX33ZA36H4yVfDTu22qTtcglLhoBh6mCKo5ZhEC4Luua+sXrG
         mL8g6d4SVN9t5Dfe7yYqLgn8w8ef1uQCV/VjHkeOw5WFWuhKZNajD9H0PdvQn05zFxm/
         yxSw==
X-Gm-Message-State: AOJu0YwgOi0PE8nE1Agvx3Vk4lEN1qukc8lXaQ4W+k+uFQ3XlJO/MWOd
	atbW/oYrXzlzIljk33aazyl2DtGdbj+GeSVKvoqqwuHFgsnkpkuBkoi/xw==
X-Google-Smtp-Source: AGHT+IHU5z0khoAxH+AxxPm8SU/d5BBQmXYpI5OvoR9OWPm2Q3hqT1/mC7pKQAhBi/4zeWAaierP9A==
X-Received: by 2002:a05:6122:65aa:b0:50d:85d7:d94b with SMTP id 71dfb90a1353d-51015116a1dmr36224216e0c.11.1730908160465;
        Wed, 06 Nov 2024 07:49:20 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5106f2cb368sm2660558e0c.13.2024.11.06.07.49.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:49:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] sink: Fix transitioning to BTD_SERVICE_STATE_DISCONNECTED on idle
Date: Wed,  6 Nov 2024 10:49:15 -0500
Message-ID: <20241106154917.64459-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the stream transition to AVDTP_STATE_IDLE it means the stream has
been disconnected, not the session, therefore
btd_service_disconnecting_complete shall not be called otherwise it may
trigger the policy plugin to disconnect AVRCP in cases like codec
reconfiguration.

Fixes: https://github.com/bluez/bluez/issues/1003
---
 profiles/audio/sink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 77f195436032..7e02bcca1a01 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -110,6 +110,7 @@ static void avdtp_state_callback(struct btd_device *dev,
 	switch (new_state) {
 	case AVDTP_SESSION_STATE_DISCONNECTED:
 		sink_set_state(sink, SINK_STATE_DISCONNECTED);
+		btd_service_disconnecting_complete(sink->service, 0);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTING:
 		sink_set_state(sink, SINK_STATE_CONNECTING);
@@ -135,8 +136,6 @@ static void stream_state_changed(struct avdtp_stream *stream,
 
 	switch (new_state) {
 	case AVDTP_STATE_IDLE:
-		btd_service_disconnecting_complete(sink->service, 0);
-
 		if (sink->connect_id > 0) {
 			a2dp_cancel(sink->connect_id);
 			sink->connect_id = 0;
-- 
2.47.0

