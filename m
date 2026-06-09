Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A8496915
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023871; cv=none; b=NxGR0/ZqalvvFxDTd5VEI6A/ylyDs1B3IlroYI7xzXveLn3PuDBeCn6Lqh7bobqRJBaQb3dkRYkxCNez/u6pnwW5eLHMj8lu8nxyB2eVN+MlFJ9dytYhxOX3WOjwNupa2eTSvFgNIN6d21ozQv6qEN+C3eIudyutpIkHH8TpRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023871; c=relaxed/simple;
	bh=zDNClOASNcYniJRmPl3i64qEzGh0uLp9mpRAM/C3uuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSYXdqqkr28iCYVmXJ6xXXqhYeXcqigWracsqfD2nrxeJBrwBdwENH92yJBRfcexHwzPknfLBvnnzxFwbHGupUgOhJmrLaG2dE7TaaafYvquIDPGAGZXx2ZlyVQAgeMdsI4snRRr1WE7dqvxXJDAV+EXF27xm1t9m/TkMAgfd0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1x6HDn8; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1x6HDn8"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59ebb89109aso3926777e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023869; x=1781628669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1YpSS752ZXtpy56r2dFOQvS3CN3AjBp1p6aG780Agk=;
        b=a1x6HDn8wQuxjMS2ftSxiY4ZccQgfS/xG7t1OtXqRstpVPTRHU+/yl4f6gJXtNJ5aB
         8DUES66ktxcrYC1F1ULQN1qh/CFLjyuw5OqW28Tvxusp7tqGYQW7wPxYppmszY+Cwlgz
         3sdIveBCyB+XfcVux4yt99/bOFK2H9eoUmVHf//r60j56QMJsZyTAe6HhvuKKGcyBirZ
         9pWXpj6LGZn5E1KdAxedURlyeAbTZeIeUqy72dJCQ+l+ENO/uSpbEfkAtD49MSdOjq45
         AvaCGNMuUoLVPf6ao8FG2SmOWSuVY758R5DZvMKg8vsWrEShXYUkG7R5U3lMsBg+nfUh
         zxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023869; x=1781628669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1YpSS752ZXtpy56r2dFOQvS3CN3AjBp1p6aG780Agk=;
        b=cEy1ky2ZC89wXAdNJNh10dO9mj0k191/72s0iExszYu2tABbd0hOGs135u/yuLUXVF
         wGGd9WKFmfWEkAasveC8RWDH+UA3keZAewftiA7ci5ZGq5RGaC2O1qEWC5flO+alsWSc
         DJIKdmSL5Q4fgszRJHOxttNOBeoZf7ffAeS9tDZ3sB+/mqe9mIzgPjnzQQ6r2ZCpw/XY
         GixL51xoHez0+vS7k/6qGb2iZ5jeyypxbT0i6DrCMBlbG6O7TYT5Fig7IoiXWlmnXmf8
         kG7SOJ+14QC7O/mLg5qCee8t4QcZzypdChShU7i+rLGzTdImOM9NpKzavb/KbC+Uts5h
         7Wmw==
X-Gm-Message-State: AOJu0YxbOYpASWXSGrD2QxohvvUyiBK/A/BxcrqrRdFcLt+gSvnmu8KA
	6W/fWhBiga3AL1LabUvFlW3A1m7rDiTEROi4KWFGWn1alufBiK1+zlKXHe+pIQ==
X-Gm-Gg: Acq92OH3FBTaVcOOLEOZw32qcpl49BbADMs4A8Oq7UQK7fo95udOWlExoTqgmS+T5/V
	YLYswtWMG4C18A4HCzjjMK+Q4PQlfzvnqs5UBRlR/rl0iPzdgmO9a9k2TYurfOhXrVK6fTy4OO6
	8hkSpXJk78kUVNUvAcF2mB8J5bDL+EB+THz/p+hm8EpUSkJTcEr9tn8n6AqI0X5A2VR2fmS6qZI
	/CHsPtz4CkEvG4I9QMtUdfc7uKALtASlo/JoLQfod0KmsoQGo+QYnHnRmQwVDeMTMAGbOjSgGXL
	WgrQStmrxfQR/ZlvZ4lVw8UrR6yPLfr4Vqt8QZLRoPntfFX+F3KjsSEl5HinOYAJI1UQ8BMdzbN
	b+0wTaTVje9dq/UzRFxFjH4Za5wlFgK1QiPhZLGrKCG7Elnky9/WODnvGCiSMnee6YLZqXnxQTv
	vl/Uu86oOOombwxtpT87OZxg1YuXdIJ7mPWR6JdN4hGVb1fb8BfLMPaX1pcvd/I7PolehR0/ZSL
	LoezelSCsJFx2iP/PDF1OZZ26Bj
X-Received: by 2002:a05:6122:1796:b0:56b:579c:82e with SMTP id 71dfb90a1353d-5ac4e3c9db7mr11659270e0c.5.1781023869213;
        Tue, 09 Jun 2026 09:51:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm18333721e0c.5.2026.06.09.09.51.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:51:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] profile: Check if bearer is enabled on registration
Date: Tue,  9 Jun 2026 12:50:55 -0400
Message-ID: <20260609165057.90837-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609165057.90837-1-luiz.dentz@gmail.com>
References: <20260609165057.90837-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_profile_register now verifies that the profile's bearer type is
compatible with btd_opts.mode before registering. If the required bearer
is not enabled (e.g. LE-only profile when mode is BR/EDR, or BR/EDR-only
profile when mode is LE), registration is rejected with -ENOTSUP.
---
 src/profile.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 65df0f7a0969..97fffe9b4d5c 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -36,6 +36,7 @@
 #include "dbus-common.h"
 #include "sdp-client.h"
 #include "sdp-xml.h"
+#include "btd.h"
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
@@ -802,6 +803,14 @@ struct btd_profile *btd_profile_find_remote_uuid(const char *uuid)
 
 int btd_profile_register(struct btd_profile *profile)
 {
+	if ((profile->bearer == BTD_PROFILE_BEARER_LE &&
+				btd_opts.mode == BT_MODE_BREDR) ||
+			(profile->bearer == BTD_PROFILE_BEARER_BREDR &&
+				btd_opts.mode == BT_MODE_LE)) {
+		DBG("Bearer not enabled");
+		return -ENOTSUP;
+	}
+
 	if (profile->experimental && !(g_dbus_get_flags() &
 					G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
 		DBG("D-Bus experimental not enabled");
-- 
2.54.0

