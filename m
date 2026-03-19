Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949B314D08
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929684; cv=none; b=lZhE48SHa67L47Rv+P+cYzRL8sl9EjH3O/4Md8oE5jJMx2zgCj+3NnOMl0bOHzx0cEI/DtGUeriy5OMgwQjxXOsM8yry5zzffz7qR/f1Vvwk6K2nbabbNv0JIVnO1HSozywqYDib+QNG70+V5BjqHh7np3w/L2nJu4pp8oEAknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929684; c=relaxed/simple;
	bh=ICO1SOskBjEwzGSGFsYQRDtZ+CiHYAW4PSpDG10fPb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPg82eyCDF/eFpcE4hWW3dGSAr2sfw9IYoogw5vaOzaAIDbT4pUhJVXnrDoX2SciM8b+E49zQrLsHcbJD344Pdgs1p2TOiQOTf9rOrTy4VwzxFX3aw00c2mI8FSOvLDfVrPIB3KGjHwDgcK7zgMe9AlwN2Tu+sagS/7JweK4Fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl; spf=pass smtp.mailfrom=xesxen.nl; dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b=QDuBUG40; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xesxen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xesxen.nl header.i=@xesxen.nl header.b="QDuBUG40"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-662b5bf4b10so1973240a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xesxen.nl; s=google; t=1773929681; x=1774534481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC5b7YW15OIekHxkfS08fNLBJYqfw6uR2O9jjut/6DM=;
        b=QDuBUG40pAJBHnDZtJ2U8wA0z/QX7Yph1czVtobm1fUKbTawRBIa+DUm5TQRQkwCYb
         6Kset1rqpRoApga0nFmxPW+AJU6VJMT4npvUP93ZJb9BidEU7Mb/IDLrVJbe35w4p4hZ
         CerN4vzFgduMyh/4iPe1kFb4v7DqIjaXl/apo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929681; x=1774534481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sC5b7YW15OIekHxkfS08fNLBJYqfw6uR2O9jjut/6DM=;
        b=gvtzvAMPFN5Fc3SI1fOKh03pKxkuUsYpCMcbhK1QKs/gp5keL0WwJOhtTSvF99Y5wA
         6R5chUSXmv00CeIOWsQciHgYyDnucJaDQy7C2QAk6u3sP/WQwaUN8r9LGJHLmPUU4Q5Y
         Ajh5rzJs4OVG654QhiG00vPVUOJwJsHvTaZcgXfd0ZzL/blTBnBNXSD5vqbochVsvWbi
         Fktg4pRqeN+rK9dH6tW+RVXDMWmqEf5zK7i2p8UDzzvGCcBdq4pABOFJ3Z1J7aUagbRv
         B9OvWPlvJlgKyTs4W9WI3FQXJgwZpcAOEFunnz88iOcVFlofJunONQnspr40qGcPA2Q9
         7hoQ==
X-Gm-Message-State: AOJu0Yxd9LQ0AAVu/BTvlRf/eGvaRk2TddkhOrCpn4hG8a4n6lAk4cUo
	nc0ipzikGM+dHZbAdvvs0RULzDzqyMXIxne/c0xq5H4aYKyDr6u+8R1J+GLAIkMDQps8Hcql15t
	dQLIi08E=
X-Gm-Gg: ATEYQzzyj3WyG9U/G85T61WuVpr+N/ia9gqfpzL35THuZmTp4w7V5y575miuXr0oW3y
	Hqq3W5Cu31/7KOOx8AQIX8bH0J72inxLmNG/2U06b5JlEnuqLKKqWKMCMk0dgS+tPlXfjxoy8pA
	TPF1FnSEyhwyukwhPRRGe41kt8O8sPcXNMOXzvXRPZEY62JEXMd9B+GlIHk35/xmDeOogXOyyJ0
	KB0WqgjbWNENbM4lLalQntLXFNM0chl21Z80LMKZjMyjH1IaQ4rNt92DRZHikmpSbNhoFh4ldGa
	RtFB423c10FA2hKbpzSSUP464xkZg5ReR8kIwJlQvvw7uWGKpF9z62sjGhivTQBi5KhzbJ59E6H
	tftFbQ3IPFO9s/6zjaqurbk3U8X0zmF4Ts5EyKGypf/enC82m41UWkyIiH5WKD9CkQ9lIN+Vz3b
	pZpfcmy332T6kT
X-Received: by 2002:a17:906:209a:b0:b97:cd54:c579 with SMTP id a640c23a62f3a-b97f4b19166mr364401866b.51.1773929680660;
        Thu, 19 Mar 2026 07:14:40 -0700 (PDT)
Received: from tomoyo ([2a10:3781:4903:0:eca5:f23c:3275:af25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3ccsm443100466b.59.2026.03.19.07.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:14:40 -0700 (PDT)
From: Wouter <wouter@xesxen.nl>
To: linux-bluetooth@vger.kernel.org
Cc: Wouter <wouter@xesxen.nl>
Subject: [PATCH BlueZ v2 1/1] shared/shell: Fix SIGSEGV on invalid input
Date: Thu, 19 Mar 2026 15:14:35 +0100
Message-ID: <20260319141435.83060-2-wouter@xesxen.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319141435.83060-1-wouter@xesxen.nl>
References: <20260319141435.83060-1-wouter@xesxen.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a crash when handling "<space><tab>"

==3760495== Invalid read of size 1
==3760495==    at 0x4902187: strcmp (vg_replace_strmem.c:941)
==3760495==    by 0x4067408: menu_completion (shell.c:1126)
==3760495==    by 0x40675DE: shell_completion (shell.c:1177)
==3760495==    by 0x4B267AB: gen_completion_matches (complete.c:1282)
==3760495==    by 0x4B2F8C1: rl_complete_internal (complete.c:2104)
==3760495==    by 0x4B26B52: _rl_dispatch_subseq (readline.c:941)
==3760495==    by 0x4B27B71: readline_internal_char (readline.c:690)
==3760495==    by 0x4B48695: rl_callback_read_char (callback.c:275)
==3760495==    by 0x40655F2: bt_shell_input_line (shell.c:309)
==3760495==    by 0x406577E: input_read (shell.c:343)
==3760495==    by 0x4068CB4: watch_callback (io-glib.c:173)
==3760495==    by 0x49C1F4C: g_main_dispatch (gmain.c:3565)
==3760495==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
---
 src/shared/shell.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index b061f8001..87a8a310d 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1122,6 +1122,9 @@ static char **menu_completion(const struct bt_shell_menu_entry *entry,
 {
 	char **matches = NULL;
 
+	if (argc == 0)
+		return NULL;
+
 	for (; entry->cmd; entry++) {
 		if (strcmp(entry->cmd, input_cmd))
 			continue;
@@ -1147,6 +1150,9 @@ static char **submenu_completion(const char *text, int argc, char *input_cmd)
 	if (data.main != data.menu)
 		return NULL;
 
+	if (!input_cmd)
+		return NULL;
+
 	cmd = strrchr(input_cmd, '.');
 	if (!cmd)
 		return NULL;
-- 
2.53.0

