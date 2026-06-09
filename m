Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A43A4C042E
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031207; cv=none; b=aJMGyUsaokOVD18PjJw2OtEkt7ryU929FFsMBWFdrtXCwRjj67cwX3dq4TS8aYA9xC8qqN9Zn4PCCUVUtXJqW5lMlI+yBDwA+vGdsFwLhZQP6yCweIKHM7R03N2u2+OpsQP2TLaGw7ti9jXp976QMfOSnl1KFrH4agq+puIkMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031207; c=relaxed/simple;
	bh=zDNClOASNcYniJRmPl3i64qEzGh0uLp9mpRAM/C3uuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5JB8swvB9RV/2WwZtiDvFWk02vFpPyMXBV/uA+xX5gHVOtUCNFJ4Q9+LXVAfhTzDSsMoBUyjeXcdoDgHMYnaBhBwfjw/Cn/Hj5nU+FW9C23m+7Mk6zsU1aMuTmcCBmvEIpOKlfEGFRcvUNZyfFOkr3vv9FlD7pD4FSlGZ6I6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h85pRdt/; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h85pRdt/"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59d541955f8so1954561e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781031205; x=1781636005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1YpSS752ZXtpy56r2dFOQvS3CN3AjBp1p6aG780Agk=;
        b=h85pRdt/D40k7W0uEVS2IPHgLD1EZGK12yju6mAkP2wUHfly45nB6B6DujOM2OBEVn
         xl0IbZzwn1+X8n+iE60LTJG0sFkf5b/UFbV1oslsLGuZWiWYavGAD8NnCUaI9E9my6Iy
         96hqB4SD/WKwJXNpmBjjAUROYvcZKnIG/qINcb8/T7IkPqVIPR+pELfJsWs2bUJnVxzm
         0mhm13vmgQXtQw61NgRkjGBsz1EkrCJ4oHpBXlslWFqHutzo0qkv1eloJHjleX3/rn4x
         5eM1t2wrmm43KYXjjWfWElvx2VgcqPXJc0iYfDIG2PcHcvkETPhEMBRfHKztv10ng8W4
         9fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031205; x=1781636005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1YpSS752ZXtpy56r2dFOQvS3CN3AjBp1p6aG780Agk=;
        b=EyiKGjyh1tUE+ZJ38MtfkRlv5lO8+8rVsb41ND+tgAHFWfG7v0x6KBj6dTarKuhvYj
         DDyVR9cIagaVGTqYGhjVSFRcEfLzDtRJY6QS0Q4nya5pws1E6bB9A5PmcHzVguiFgub6
         ei5ILPAyxvBtPuQHCSn5OFVnYlEJAPvUUSvogN42Otc2n47U0LTMnhyP0BK6zvhQG0T2
         Ru+qB1XpRmEUhAjeSQG11u5Dfbw6TnqVcMBgniFxkXp6lAFZdHVLM9z3oF0Vd2eroM/1
         pVgqlVcaSziDAWB44EnRsbNjanF6JVK7Hkn5UaBJQLTc3kyfP+0ThWvDGC8/sP8iK2LL
         OwBw==
X-Gm-Message-State: AOJu0YzQicWmbA1U7YEQ9krIK1BlmECto7lbYEGKXYsDbdtJET7A/wHR
	o5/VTHEXYnQbpyhGnFH5WNtt5Bbi5O3YyI+tAObDNlI1PpPS4vTEl9GyyFf0wg==
X-Gm-Gg: Acq92OFWJXVelAYGIcgqhqThIK4w3EDT/14P9rFt1N2MAhK13f0Mq6wVYpfmCTeo47/
	IZ7m9qbml7mlpb8DDL8Syhd5MYNDw8iZBRdbG+6shr6lgn9cYDmxcjB4qTf/ZOqZbmbXpp13pmK
	zBOewfHbxiqWbKJ8J+WuXlYhibYjV4e/AZM5YicIMF1dgUTg7tcRYfiCVzde7LrejFh+3pYiNf/
	qUD8mz5d8n5dCRhxUckEGp17ReFAiftIWqkR6CcMBpf6orNeHcH11QRjynC69Oc0BSJGFgF7d3T
	sDWa67N+KDr2gH2FJ8H1geZeDaDFXBEahik0KFsiajW++K05plEV1ToWErDEpgcMCY5W3g6lIpY
	+RQjYVejITZQyieOPw2ILohE/gk2Utv3ag08F1/L5eTtFetX9gSbCZNNs5ho3//cQyGYuwxOaG1
	WflE5lPhawwNGA1CPn5DZfuZvuiIEjxQStF4w7mZN0jQXrUIvsEiLce4CGqoHlbgVZS4vXJTZLx
	jwa2Y3OFSc6H2u3FwfUcBHOjyW+jzz2U3LVZsk=
X-Received: by 2002:a05:6122:1806:b0:5a5:4166:67e8 with SMTP id 71dfb90a1353d-5b6371ba2bfmr1517281e0c.12.1781031205119;
        Tue, 09 Jun 2026 11:53:25 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d06a491esm17772795e0c.0.2026.06.09.11.53.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:53:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] profile: Check if bearer is enabled on registration
Date: Tue,  9 Jun 2026 14:53:11 -0400
Message-ID: <20260609185313.155105-2-luiz.dentz@gmail.com>
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

