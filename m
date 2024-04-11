Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C614E2F6
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842776; cv=none; b=k7pAttBP+djiJ9X64ivggQI2Ei1IsJg1oaallKhC8CR/0NQU+M5th8lt43dNaOm97Bavu68ddvig6Y+lTNdIw7Q+B2wcoohoF7QlfDWDBmMPW+eDc//i63edHv07azhxUHCfzUCsiwMvs6LOrrrba9aXxTZ8J+7emUk/RuP2S3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842776; c=relaxed/simple;
	bh=2zd2aErHG1lZPkrmYGGNWy8rR9E2GG4suFCJDjI8SaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tMvBp00EhPf8Y9DfeJ3w4NT8aXP+ydrPucjNXlbovhEfyowugHYKpfdZkRWwGGJNWsY49Hb3S5MAyA495xXZAI1oviJnOhCpidkW7aVc2HYl0lt0BJ8b9Bz6iEaVhIG6FI+VRuabOaf2qKqxSyCwJ66N4+7XAecdyWY5qeypEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOsGoCag; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOsGoCag"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479e12bde9fso2391339137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712842773; x=1713447573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hANOqpWi5mccCXObOolBPcIhoSeVd6fCezYfr1BhRY=;
        b=OOsGoCagJHOSzzzakQQDwcESGAmmsZTlk1tBgbN4tDN3Z8tGANaAqX672cJcZXVOTI
         kTd3tMgxWrnYWLmSpO76dBZgUrwdqfMkFr0XSXe7jLGGjrImCAFJ+blcyKPfh+6gKzLA
         B7Xz8wAv0uUW5X9CuB3EuneLURcHytV/E/ZdzKdr3Icczh76sQwgaiBQ1TzecyAlUA+V
         BJu6vkJorRPywrfJdjJVTZ7gPW0C8aD70dbkEIaZ+uR8dKkilSfaay7ju5qQQ5e7j1IG
         qhwM1b8YXptoiRTBnW4az7j0goGaeOlwvto9fZTlMvt0CG9fxaYTURhgrlhGAA7PKd3R
         6lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842773; x=1713447573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hANOqpWi5mccCXObOolBPcIhoSeVd6fCezYfr1BhRY=;
        b=WvF/KdES28KGNzW8JaYurL1mz0r+4EuPYI8fVYXYtbmRlm5w8ZDxjaEoyeqc8FNQxf
         bT63BzieGMczcjTB29i28/f4j2UJArbVR9ilctru2IbywAIu0BxXi1Rc7Y1rltZS8YxY
         P4aZ00au95sLXd0Q2nr1v0h3oD6PGMbfGAwdLzjrVGiZLwZ/elXWloe0CIbeQgZsI3ko
         cNSYLOFeL8tMNmzJNTS65FFtSUCxzq1/TVB5gylD9VIwq26zEcbdgUra/d0UFTcX3PwI
         hFiDw5gZ2Yvm5hWz0jfRrI70VKGxYYzGGySKiyZjIkXOtA3qT8EIfrX7AKsDm492ESGd
         NpqQ==
X-Gm-Message-State: AOJu0YzcEgv55xPuOKxgebbarNiI8AcqjrsvJsbHKCdLqrl4KYM5hm/y
	+Fi6tar03wurdjInbpf22vXIEWI8MOlviDFYWhiSin8zhA3CzTflWZz7+Q==
X-Google-Smtp-Source: AGHT+IFXF98U3VBANGsfssldzFCAW6bzFWojLgXdtfr3erEpJ+IBpw5uBdQQuVl7m6FOY8DXL11PHQ==
X-Received: by 2002:a05:6102:f08:b0:47a:233f:9fce with SMTP id v8-20020a0561020f0800b0047a233f9fcemr5179286vss.19.1712842772830;
        Thu, 11 Apr 2024 06:39:32 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id dd2-20020a056102568200b0046d2de55f2csm217918vsb.15.2024.04.11.06.39.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:39:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/bap: Fix not updating location
Date: Thu, 11 Apr 2024 09:39:29 -0400
Message-ID: <20240411133930.96265-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix not updating map.location when selecting.
---
 src/shared/bap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f553096dfcc6..b452461ac715 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5163,12 +5163,10 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 			/* Check if there are any channels left to select */
 			map.count &= ~(map.count & rc->count);
-			if (!map.count)
-				break;
-
 			/* Check if there are any locations left to select */
 			map.location &= ~(map.location & rc->location);
-			if (!map.location)
+
+			if (!map.count || !map.location)
 				break;
 
 			/* Check if device require AC*(i) settings */
-- 
2.44.0

