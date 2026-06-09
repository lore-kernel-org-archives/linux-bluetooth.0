Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B4B4B8DF8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031209; cv=none; b=ZWCksI00KM8XZhOo0F/sP7PCRb+0ChIDvitEkfoZCRhwTizve0t20DNb9Jzc/s2DFcLbYOa0fZCZi72OyuY4d7ecelOUZGf4iOksbptmzTkG2ePohzCGF+Ce46aueymzFbIie/sNazYXpZbAYvuRxtRuSahj99I6L20ewCCi4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031209; c=relaxed/simple;
	bh=sfLnOs8V37Uk2wChj/DEWmYkhRuvMJlqphzY1XibJdo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiYjK5SVrd1wtFnp0p3CDefhNOLkzYbQ6AG9/3rRzJJiFkqNfIV1PEHPszNcZ4ujz9NqCNWeGd782OY5bIcTncPDMODdLnEYxOg+tgH9dY6nCz0M4mex3O2LVxcC1tSZMSduARtmIN2Obc5p0ZEMezuMXzsij/f9mrfqffyBuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7HxGV9y; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7HxGV9y"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59c1bacf871so2197775e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781031207; x=1781636007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bk5qnVzRe20GH6FFxoWbySocwuHhZa61NmDX/6aFY3I=;
        b=U7HxGV9yUxO8ZU1av4OoUDzCq3bzRS67MW/AkXYqCe8aQsjbAFV6tnV9/yfE1TZTaf
         teUbORa9dCzypIAWBjnnrVshw4MV+KdTgfiBlOt3j78ddHY1EUtO3/1ulWnE9OngmSf/
         JuFt40KA0G7ooafcvcqh4RUm1war5LuVkXIFmB98GjD1yTwS+jcNoac/0BpgnuXsbnyL
         Ls14xjBKA0KX8KkM4/IDJMCb/25hW0lUxvFXwxHBO6lFBIlwTA1LyIsmG3eZk2kCHv33
         23+F+3oZQ6jnnAHInudTXUKyrySX6F4aU7i29yNivdYf6zCx0SPnO5nViqS85wJsjtkb
         f6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031207; x=1781636007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bk5qnVzRe20GH6FFxoWbySocwuHhZa61NmDX/6aFY3I=;
        b=JfvXODAHXqh6hYn9ixVheNStrfYd3uJuTF4sBzOIdIiuOhMcGNUbIdB8jcdj0xYhc9
         ovQerFMINBAyJBmg6gAO9EHQIy+nC04XPJDjSA78ObkMwKVrXOmjljOOZ6Um/8SYFkS9
         dxdFQ5eDF8c9M7CWzhLRCajZL5M15Qe/t9YKaZOD0ctQPX/zvcLDVcEhpRxj8mdQvJzH
         IGyIk6MzO5JL8KDnEtv3tyvLjRAeByeu3GtF/yL1FrcAs5gmCEPROEDht6bBZLjzhRIq
         JS4AkSB+Mn1A0TSCjn2uYaJhInVXkImKQ6kLp4k7hC/LpIrrDKvzJYXK+OlHFSkjALwc
         sCgA==
X-Gm-Message-State: AOJu0YwVPbGo9ptVrwjsaISJeYSl2cBlheDLJh9vTNIBNYu4i8ZiAMlu
	QFVrZ3RwveQ8TpHey4g5AyP1mmXs8jzSMIJ82EOnVRkFHaGc+fN9ah2LO2kL7Q==
X-Gm-Gg: Acq92OFh6ZHVfHUaM5S/BxRCEsaS20br1M9N9mDAhakVCh0SxjjmlZQ9qMVjDA/r10B
	mjybvTzlTgu2Ps2pASrSqG98+ePJYnL4n/EKK2rVizNZ0xw3uxF027v+FK2op1Vxk4hMrJxxuJS
	53EYlTv7+xGywPvv86ieaKPJZd84xq7InwMY5GFCpi43XxKiidFYheht6iwGkmSQ04E1iXha+9b
	NQ5BfznehvHM2vZERzIzwOyt1dFGer/Wb3mF/RclVwiZP+ImjI1HD+Xi/zVmbqggVzVrmb9fQSB
	p0RZu0N28McCz18j4wp8U7JK/f8fT6jhJE5QkmyPC+6a2AiVrqd4bFBKwQ5piv6K9Rfw0Zhs45X
	sZEimH7z/vw14qzw5YSoNBUCw9CVvdAJFts9BhA1Qe1LGPQFexMmijg1lIo/CZA2fxU9Ai/RcZA
	u8d3Lsyoo6+dONcKFJVaORZSd7WDPtT7w+/RWquHXySiafq3v8dv85dOl1zSYWGpMi9Ta5cMQF1
	g/wx2k5cbndB9RJlFvjFzlH6/ItNVBXz4M1DaU=
X-Received: by 2002:a05:6122:4784:b0:5a2:5c65:850f with SMTP id 71dfb90a1353d-5ac5291a593mr10347038e0c.10.1781031207092;
        Tue, 09 Jun 2026 11:53:27 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d06a491esm17772795e0c.0.2026.06.09.11.53.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:53:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] bearer: Check btd_opts.mode on btd_bearer_new
Date: Tue,  9 Jun 2026 14:53:13 -0400
Message-ID: <20260609185313.155105-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609185313.155105-1-luiz.dentz@gmail.com>
References: <20260609185313.155105-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Only create the bearer interface if the corresponding transport is
enabled. Return NULL if BREDR bearer is requested in LE-only mode or
LE bearer in BREDR-only mode, so the D-Bus interface is never
registered for unsupported bearers.
---
 src/bearer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/bearer.c b/src/bearer.c
index 02267c711431..ac3a22030770 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -34,6 +34,7 @@
 
 #include "log.h"
 #include "error.h"
+#include "btd.h"
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
@@ -278,6 +279,19 @@ struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
 {
 	struct btd_bearer *bearer;
 
+	switch (btd_opts.mode) {
+	case BT_MODE_LE:
+		if (type == BDADDR_BREDR)
+			return NULL;
+		break;
+	case BT_MODE_BREDR:
+		if (type != BDADDR_BREDR)
+			return NULL;
+		break;
+	case BT_MODE_DUAL:
+		break;
+	}
+
 	bearer = new0(struct btd_bearer, 1);
 	bearer->device = device;
 	bearer->type = type;
-- 
2.54.0

