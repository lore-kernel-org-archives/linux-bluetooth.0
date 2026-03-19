Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1390340DAB
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773886638; cv=none; b=S21ZL4KPRUbwBfH8MprEuzdQRKuUXrw6GekBrwllK40ggiKDRGhDibTGaR2LMB/u+B41YGRu9D4ODNmECE3JNdspvfcbVJ1w8TTi+R5fkKEDdbZ2JNkxzuv7K/sYvqRiqIeHQcs0QGduKwWpq5ONvfB7eNgpJmLwnDYaemaKcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773886638; c=relaxed/simple;
	bh=eOrpxQQKTVI+yP3zvr6YinMLHb2rYE8eKh+Bd4zqagE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3kaGR2JmwDtz74gyWy9cvwRgoQ+mUrPtLz4nBt9ZHZHX/F0nxBFXgkktAqKLcAkHn4FcQhpkerRd6v1s50gGIxA9JolMU9d6AZDdG0GJDDob2nLeF7w7r/phq8iQe7BuxYQhwE7e86UQnkDnaKDOkNT7QwsDujiB7s/7a0LFfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl; spf=pass smtp.mailfrom=xesxen.nl; dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b=KB6kq6qd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b="KB6kq6qd"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b97b30fa5e5so69903666b.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xesxen.nl; s=google; t=1773886635; x=1774491435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQWu7WTB99zJxhVtqx+wyk5nKc5ZDc7TVEoaOb4fX9o=;
        b=KB6kq6qdxNcUd0J4zNvZiaULS2GwGLuB86rQkO8DfgSQBm2q5k8QJCseTE41D/BZsm
         J825Y6VKB7qGKKkNg7JtNMVrh89aNznydQb33qEAwtTjCfD05WQvP9APuSFV+NuuQDJ3
         K/Je+ipv1NwIQwbvN7g5nKKoxChC1VQ0qg9/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773886635; x=1774491435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQWu7WTB99zJxhVtqx+wyk5nKc5ZDc7TVEoaOb4fX9o=;
        b=OtwM+1/l5KlEJ/nYnc+LB0BcJyrDkP8a4Z+RNlPVFdwfWFOHIWKWJ1v2PdH9ZfSAgb
         h1CPnRKoyfuvgcUYNv8HQPGbtl/nqcvtJEyb5DwTxA7HNeGQh127CqbaxD76MsxV+Qpr
         ApH1ewBvkEj5v7nLXhbOmUogRCdJAqwALSsf8rcgus9j94K4HodIkKA34RYjADdHNTti
         M8sM8YIYHGDX2P0NzD0xp0csL4Otsjf1yaoitibngYSOynBirZl8kapGYbXR/2gc2a6w
         dkTZ7u/bCtTRWeQoSzZ0x9vsa/fN8lILx+pHG7hA53hMTdTl3VCuXqchnkdGREtgr+mU
         0L3w==
X-Gm-Message-State: AOJu0Yw3K5/syvt8ddNa09lC4soSgy8zAx8XSLl5MZaArqJBwpKGcRgO
	S09R5axQgSCiWZfOlnZoJXmwDeAtAdychXpJHEith06nWmQ+LDqwO1cZo2qgx+VAg50jWOYiFcV
	SRGtGAQY=
X-Gm-Gg: ATEYQzyuxQ/buBHPBF5LfZ+wRw6cXb929mcEMlT0qUZ5unM6OKu1+/+HvTtgPpTdMcC
	kJ8SX1+kQZh1aiWhgPEb48ay1m7csB1RhJ4gu6nCHq3kmg7Sguonekq7oVQBpkcd4QqtwtAhwYL
	3dwm9hnPlRcTDIiZAQFZ0EHOW19hLAxNmOHKwfbS/465xPiSyBeJxaHdDDWmcC9la4lG7g2zFKL
	TGUv0ZYxdMSWJWh9fJSjMH1HwBnVhErzps0WwqSz/Bx0NYDbv280afkCikrdBBXOUJUzFKrPhlo
	1CFxrg5zkXUubxe0h86fFxOS3WcqOCXpARe6OqMn6LsfEdy+m1N9KqYw2OlSJblXg/Tusxe6nKp
	ykk1JQ0OzgOL9R4zb8iP+IHhWJVjPL5AdKzaIUAiDP9bNSDJI1YWoCNIicjLqYIaw7DZ5SckdFB
	AzhOCaeXYDuUGj
X-Received: by 2002:a17:907:a088:b0:b98:13a:c92e with SMTP id a640c23a62f3a-b98013ac996mr296685566b.2.1773886634963;
        Wed, 18 Mar 2026 19:17:14 -0700 (PDT)
Received: from tomoyo ([2a10:3781:4903:0:eca5:f23c:3275:af25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f142b8efsm377083066b.17.2026.03.18.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 19:17:14 -0700 (PDT)
From: Wouter <wouter@xesxen.nl>
To: linux-bluetooth@vger.kernel.org
Cc: Wouter <wouter@xesxen.nl>
Subject: [PATCH BlueZ 1/1] shared/shell: Fix SIGSEGV on invalid input
Date: Thu, 19 Mar 2026 03:16:45 +0100
Message-ID: <20260319021645.2137513-2-wouter@xesxen.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319021645.2137513-1-wouter@xesxen.nl>
References: <20260319021645.2137513-1-wouter@xesxen.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a crash when handling "<space><tab>"
---
 src/shared/shell.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index b061f8001..57bba0977 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1174,15 +1174,17 @@ static char **shell_completion(const char *text, int start, int end)
 		if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
 			return NULL;
 
-		matches = menu_completion(default_menu.entries, text,
-						w.we_wordc, w.we_wordv[0]);
-		if (!matches) {
-			matches = menu_completion(data.menu->entries, text,
-							w.we_wordc,
-							w.we_wordv[0]);
-			if (!matches)
-				matches = submenu_completion(text, w.we_wordc,
+		if (w.we_wordc != 0) {
+			matches = menu_completion(default_menu.entries, text,
+							w.we_wordc, w.we_wordv[0]);
+			if (!matches) {
+				matches = menu_completion(data.menu->entries, text,
+								w.we_wordc,
 								w.we_wordv[0]);
+				if (!matches)
+					matches = submenu_completion(text, w.we_wordc,
+									w.we_wordv[0]);
+			}
 		}
 
 		wordfree(&w);
-- 
2.53.0

