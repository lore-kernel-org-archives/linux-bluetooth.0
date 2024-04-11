Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F443C478
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853046; cv=none; b=SgMOdc/vFvXJqsz9RBoCGraWt5i/WliT6fyJ+HSMCQS/hpIW1PnL+egJM9qKpZH8EHj0VONtnvkpqgXgG75Mw6NbOBAJiqGVOEMrRvXiV8peV4mlKWMXcUbsXYFgbM4X2OYDb0+MOypiTVvmgvjbVPHNzDxzlKzQ7avOwPkcMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853046; c=relaxed/simple;
	bh=2zd2aErHG1lZPkrmYGGNWy8rR9E2GG4suFCJDjI8SaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r9gO6BJjFHpH1qZJbIQSiBN/rR6BXhj3MAxSNBnARqkdVk5Zgee2kRB9QAX+cvB3Ava07khPQP3k3NER39n7AfG82RN5spqlesvZ79icpEpE6BWXH39LO08Ls43Lk6mccAjDktetuQmYpZl5y86ifPsg3BCACnZISQIk5MMsEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOzTlkNL; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOzTlkNL"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479d6c6f2c0so598071137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712853044; x=1713457844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hANOqpWi5mccCXObOolBPcIhoSeVd6fCezYfr1BhRY=;
        b=dOzTlkNLhTYYrtp3cm0C/h/fj1LyvTzRM3MgBQR+y2atHWrUllqZ59QViLRI9ti4aE
         SyDQHLnWtsSZzbicRTnfW0iAW9nWy8HBH6S5CXJ0eiMpt0426NO1du1YtrLQcp2E5Ujm
         gOZiOdEwYMSHe4pO7CBrLb1ILnSpQw/USLZJa/TwPgvzQXvZvbg+eDLBQaKoRPwPF2r3
         zWGxOxKsobrR4eWlkN2fgyRB9X+a7Q7y0oVsABO4lq1vblDurI3IG8TKt+i1nJPG64Dp
         wvAhIvFzYJuBXNr2Ck+OW7UwRJ9oRKxJJOW8Udkrg2a9nQE2UJS8UOohweblqw6Pg9ZX
         fRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853044; x=1713457844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hANOqpWi5mccCXObOolBPcIhoSeVd6fCezYfr1BhRY=;
        b=TKbKUjPWdtRYHDAobutgwecgiTgOkfCCb4GeBTLJ/a1A7f+C+7xsVUj3wWUDDnow5G
         Bx3oNz95K2D7WHuvFzglfI0VVaKYbVNZGW/1BzECX5p6Yvxv86mLcNVXmUQ5eBUEyMtB
         VeKnQA+1XK9M5LSLVIUzVttPYn3bDH+o0rndThuZy0a/vFkkQGD+dO5HL1zPrgQBZbDl
         rWl51MWRdSe+7KwrpI/6GnL18Z6deBhlgeEtZStQnI0V3z01e7BXp0Lu3KT3LVl6uKrL
         EN7IjUopDOTT5CeZk1jcj+a4MPiK9CvoDvIVgqcoTKPa3i5NRaQIdtVPGJUcUNlXBNJp
         tyoQ==
X-Gm-Message-State: AOJu0YyI0NyxHiDwKx/+yf9+3fa8cocHFYKTHCVOcBGeSvNUHjbMd1K6
	bq2zB7sd/XdKvKYdwxRax5R/+QF4y8Lc1bbRvMMph8AZVi45pHM4Heqn7A==
X-Google-Smtp-Source: AGHT+IH3KvX9HJnxhj7RTzTJCz6stNKzHJ3WZdxHzC6dyta8mMy4qBqftxg4NIeVE3cT+6ZfrCk15g==
X-Received: by 2002:a67:e285:0:b0:47a:35a6:cf90 with SMTP id g5-20020a67e285000000b0047a35a6cf90mr1572603vsf.14.1712853043681;
        Thu, 11 Apr 2024 09:30:43 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ih12-20020a0561022d0c00b0047a1d8d2230sm294159vsb.2.2024.04.11.09.30.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:30:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] shared/bap: Fix not updating location
Date: Thu, 11 Apr 2024 12:30:40 -0400
Message-ID: <20240411163041.130214-1-luiz.dentz@gmail.com>
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

