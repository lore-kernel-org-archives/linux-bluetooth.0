Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24917204F8A
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819479; cv=none; b=qmjCwwgZj1ziwb7wVA3w1KeLmnrHSUGFaBNyv/SxIZ9RYmg92RmW5/RwvaviZPijqEVNsVj+U3tRGZqn2e4/2rRrIdcvk+MkMT+0OcVqi3WkG+p/miHUYiY6WhD11KnD8jdugOpcMEZyLdYelK7/PupAcanpPNGw6PM9B2L27eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819479; c=relaxed/simple;
	bh=r32oAtmJV4GUBVTcyRweY8W3ZwcYF9lzM96+0PEcaBo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dTzedM3Dj0GFLlO+JwJHG2V4iIeQ4K/gJIg9+48IPxzQ9lzw6802zOGrv+1D72BMU8eiLjx2TfjuuuGUABbTrzwFJkeG4IpJeP3EA8Ymq0mJHMa0Dkny+uJ+cAd4dO/DJyN5rrc2gx8psF07cBAm6w0P1MHIQgYyMX/gi37AFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyD2pVI6; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyD2pVI6"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72ecb4d9a10so124538a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744819476; x=1745424276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aO8ssM0dfDJUhN473dOwaJoGRWoeMmAGYDR1boXBPUI=;
        b=DyD2pVI6eqDrC97fgNCjdaPbDeqyhEOUY7Wg50khWhcsJBwjdcMo0IzwOW67Nr6y+c
         0+JBJ7OCH/Z25yTIr+M06myraYEBJaDeLOvYwg7Rdfuo06+w1gbSgeySQLgUqyKNCB7N
         ckguXfcggic4v12jMOALWg8sCqEzZ0usjOtYORS8mmVpy0h7A6qemcUYVwmkeohCO2w8
         vdS6NqDMc6hEp/ck1t1u79ncJIVeG8VjpPj8+kiQ6z1IxlQbQ7th5BHkPS8MjGiHl3wm
         eHk7V2qbZ7qXfxzC1KgMwKFK/6ZuvZrBv8kvNCt3xRLHHXRiBMFcEB7lvhbzpubXYrmM
         vBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819476; x=1745424276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aO8ssM0dfDJUhN473dOwaJoGRWoeMmAGYDR1boXBPUI=;
        b=kp+IeOsunhLtFMYF/lUVCNmXUZnTz2jdA66iJ4RvUQ50j09QrsofsrtHpsZCBrgomr
         GdwrV0WUrlrF7ZhQKeUqlwXASRsEoTk9kz3itjZTW3nx7QpInSadasOFsytHjy7SVHCj
         PYHow3MJ1JMWPxJg3poUmeRp2Q9JwJWTmZ7NBQsZG4FiEKTf5kQYhhlZtqVXGlZfJWDp
         54JBs7FtznOOYhw5B7xUqc0GlFMFurvioUNHBfBC088dZ8UbTTw2F7RrRy4riIRcdgMy
         aFHFOFaAZKUOtXMFIE6cBwiYf34KTRxBitnur36P25OBKjTD5Wqi2Oh4AZBW2sYN2+Me
         QMdg==
X-Gm-Message-State: AOJu0YxlukUQ2IcyOdOvgOeShQeyBMwj31V1OBvFEevZ14LbU4Az+fJu
	6Mi0i+qmdMch66ru+t20V0rEhiLzWAaEvlUl+teN0oJfTmHianphCA28FOI5
X-Gm-Gg: ASbGncsUIUa3IwdjqlnOjrF/TkvmlGq7b0gEWD5tao12OGAYTbGVFEAia0g8qmQQ048
	OeOxyPPCeK9ETR4yeCLYlfFidpINBXWeWKjurOCFw78oD1KqsWIiYpHTgrvqZqSFkW8+xPVXClz
	5xD6xDbjzwkcPXl3trQDT7FkCik5y6tSK/xR3yjYbZBk8+FcY6gmQfMn3hBWUW1vulc9r+BnLzz
	/W7ZYK5mo2I0zoUT/yna3FOv78DOFOe2wN1c064pTGL2RsTRH1QwpdOuZJyDCYi06Ft10q0KbGo
	dXDZgW/tldC+WoQhmjO/SnXe49WTg+fokRvalDW5AGeStMpwO4dJw/RQ0xhZqSNbdbCIzamoCop
	7+HyhQNIAMQ==
X-Google-Smtp-Source: AGHT+IF8U5ZYKhkFSkpYiKWxsc31+YvpwJxNxmjUzfjSTaYaIPcDgzE0Qe7H5HbAcnM7WK8uF0uZtA==
X-Received: by 2002:a05:6830:6f85:b0:727:33e9:322a with SMTP id 46e09a7af769-72ec6c36a4amr1531691a34.16.1744819475845;
        Wed, 16 Apr 2025 09:04:35 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98afd43sm3094029137.20.2025.04.16.09.04.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:04:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/7] bap: Fix not setting SID for broadcast receiver
Date: Wed, 16 Apr 2025 12:04:27 -0400
Message-ID: <20250416160433.1822263-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SID most be set otherwise 0x00 is assume which may not be what the
broadcast source is using over the air. but since we don't have access
to the SID of the advertisement in userspace mark de SID as invalid
(0xff) so the kernel fill it up while scanning when creating the PA
sync.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index fd9b751cc1bf..24763666ce96 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2813,6 +2813,7 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 static int pa_sync(struct bap_data *data)
 {
 	GError *err = NULL;
+	uint8_t sid = 0xff;
 
 	if (data->listen_io) {
 		DBG("Already probed");
@@ -2833,6 +2834,7 @@ static int pa_sync(struct bap_data *data)
 		btd_device_get_bdaddr_type(data->device),
 		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 		BT_IO_OPT_QOS, &bap_sink_pa_qos,
+		BT_IO_OPT_ISO_BC_SID, sid,
 		BT_IO_OPT_INVALID);
 	if (!data->listen_io) {
 		error("%s", err->message);
-- 
2.49.0

