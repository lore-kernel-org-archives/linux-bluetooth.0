Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C781A9B3B
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089969; cv=none; b=VnxbUCvXGfI7OFzLXleg89xjyNOKIbq3q7mUuJ637W7zEk3JJ6Ri/p32Kmru/b3LJ7Uk5e4jdIdf1wUau4Vjg2bN/iDx3378m2j8Acs3d5+EIjw+iN+eTZ3D8KKGxWNaPGTvKQ4a6fd0qN5yoX+Vt36TgJQqY8h9kJcbk5fjv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089969; c=relaxed/simple;
	bh=JzuclmkWe9wk9psqNH5fYTTNkFtT77ALu4e0+QIuI1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hb6kce8rXzIgB32wrJPRBrm5QEVbk2X7n9H5sXrFus2uMM9JgB55jK/d08fiueZrOmrm6vqMbgPmqnDq7wYAZXfU0fTkWjEN+SG9lOMDYDT8NfC7QiFu5s9zpW+cwFP5FR5/KaOBPkcRDv9skUuFhrLxSOlOWl+VFuIUBfBY7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLwd3Keo; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLwd3Keo"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84ff43e87cbso959921241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Nov 2024 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731089966; x=1731694766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=udUdvw/6JgUj5yflZJ9ZzTgI8yVpFcskf08iuARsBnk=;
        b=QLwd3KeoFo7pgfx6nX5HuyxGfin+Sjb3rY7UZjy4zNB+uCDN++p+KGY8SWdp3nG/XV
         wdOcm44ug8zA4juwpYtRR5xvrzCBiw/FgPfcltWn0N0P4kAn1dLwFup5xJBeuXt0Xh+h
         sCBwB3M3lo8OrIzyUMTwDZR+g5w8EniuwQgsiP+Vapdkanpho7RO84hJ0ymlAcAh5BIa
         i0SK7rwACvuU3rKqYuGn4WcC36gPnmwUSfRkm+C8MaMIDpZ/DdUDK9OIMgTukAeMkEbL
         FvoEOVRsAq2S8rZlW/gZXuHtkH/kLilBR4/Hj7H2Ox3S6fs3aKAStFGBQNkRgl4Uw95e
         YB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731089966; x=1731694766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udUdvw/6JgUj5yflZJ9ZzTgI8yVpFcskf08iuARsBnk=;
        b=bZcLXFhdcQ90UCp/XXK9Kb8W3YhDLBJDFOMiPweBqa0CmAtuEg/lagM4FfY6S+w7aF
         mhTHL+1D2wzgm1ungkCnWBhHG0MibZqKNPp4BEbb501YgF7r6JRh8oJP0itZTVfk7BL0
         9SIbCTKYFcesyqke+2a/ofxFGYPX8XVNIaK9j5SJ+3VWDf9rb82DpQeAH7Eaq7T6XI7B
         VpnIfoxX1mEJzaoqqc/SCp73eMFTdOsGlaIsfMZZRbKECh4qjN5wVFFu0qgz1uf9p73i
         rgrWS5BRpezv8KEMmHWNTbvFsRZoF58vFRiUN+xk6fXLuwLF7XZY0glwo7l9deVSADpI
         CqxA==
X-Gm-Message-State: AOJu0YxIkDLSLc4mUPVJLEs/WhcGBqDHgDBp9fqgzn6jJZJoNdmkTl0+
	qYn3uzhcAwdiSR1jftg/ZgXL7uLGdLy8SV14O+YX0gsFq/3xRlAib4S13Q==
X-Google-Smtp-Source: AGHT+IGcDAV7xbrGx3SIVx8ipakSlaSuJ7mliVl9c9ea1tpRh3kvIAwlX4AhzEegUy0Pp3ykjoPtjw==
X-Received: by 2002:a05:6122:32c9:b0:50c:4707:df0 with SMTP id 71dfb90a1353d-51401bc7fe1mr4003742e0c.5.1731089964770;
        Fri, 08 Nov 2024 10:19:24 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-513f315fd9csm825315e0c.8.2024.11.08.10.19.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 10:19:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] avrcp: Fix not marking AVRCP_EVENT_VOLUME_CHANGED as supported
Date: Fri,  8 Nov 2024 13:19:21 -0500
Message-ID: <20241108181921.309039-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If avrcp_volume_supported return true then AVRCP_EVENT_VOLUME_CHANGED
shall be marked as supported.

Fixes: https://github.com/bluez/bluez/issues/1007
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b5e6548e6600..9fe8f55e5dbf 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4268,7 +4268,7 @@ static void target_init(struct avrcp *session)
 	if (target->version < 0x0104)
 		return;
 
-	if (!avrcp_volume_supported(target))
+	if (avrcp_volume_supported(target))
 		session->supported_events |=
 				(1 << AVRCP_EVENT_VOLUME_CHANGED);
 
-- 
2.47.0

