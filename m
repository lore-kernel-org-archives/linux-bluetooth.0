Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766313D53F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460187; cv=none; b=QrOw6eWP2PU+RGmr4u7mDpizzW1nvB7ZwLS1Yqhd3It26jZlepuI19EPjgd0TrfRoPFYINX0x1joCwUCfEbca0bAoAYKz3xtYW+uMHbkpwm7uS5M5v8ofgVcCHRoUKtmwTJXdX683RzKExIRDtpC/TAL0peJYrTLyEL+dA2shH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460187; c=relaxed/simple;
	bh=rT6OLdnBR/mk8EeKmF/bsQGed82UsuRd0DbD7NjpT9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fraKCY9BhnAutJ25D0Xr4/J4RSabsrguIkAKqOnRflQzrD6TYuCqwif0ilxuA1e76YcNKTZsRcP6Pv13I/VDg30S5wSnkn6w8C8FeLjl/W2Xvw085pDpcf21PMzAj58zs3edzj9TcsiINo3yPwUpceg5C3mKouUzSKtKp0WQ6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=PwgSm4Tn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="PwgSm4Tn"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a599a298990so1164781366b.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 03:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716460183; x=1717064983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ1MCXegTloF+LteSI5RonTSHmIiXIbRQRSEkRpzFZw=;
        b=PwgSm4TnCPJ7CTPnaj01inhKWlhWBqm/hK2JeBovIZlU9w0y+muFiJJeEJIKPsvR/b
         QScrzr9Fz0gFPqS2eHG+88sTXLu/3B6i5axBGJZMhRN9pI/XPDfPyhsq39pQdtoFsLcu
         mCed2W1bs+fwRltZIKgT75g0MUhs3qgcRN765CN3luDsyRY65UTW3I68lodhyFNvMVji
         /qWVzgvGxWS7M9AIsQp5gBAkIBgzzpF56ePgF1XFp8Z4ZaCX3a0xHjBziJ/K6rcSKAZ/
         L++kD4OvjPWXd7aXm+Oq9OHyUHHY6aoGCn0RdKawWhKDKKzMKRrjUgUmLbMgYsIzj17r
         /qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460183; x=1717064983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ1MCXegTloF+LteSI5RonTSHmIiXIbRQRSEkRpzFZw=;
        b=KcaQ/Fh+PHeRAhc8epMUCdC3Ye7pL0K3/iKyuHNJrBBDPirYk53KuwoGe+eUPs5Inh
         YCnqfnYbQB6TtNAiMw8WjI+ZNcwyPij+mUDSwn4kcD9zGX/XN6FzAFjKKB1exslvrpFk
         w/KNyokKynFF+hkp2JCj+NR2SCf1uphZygVo1YhNuJVcDymanehS2N3IBE8Utanv2jne
         7RdKX1+5hM94BVLTfhCQFRCYFdPWDYL2Em+gwEKWquKINXYofZ9nFClziNpZBNg9F3Pk
         SH1L1Y3i/UFWZGKWkqDaPcUD9QP/yVwG6+1aawUmnAYDOFz/n9tF6fOMNqwXyYTndCg2
         plRg==
X-Gm-Message-State: AOJu0YwcvFQmeU+HD7qTEjg63u2zoEMIxucA/lohpNsbDG9CCl00ft5j
	Sfyy0G9BEBeLl/01YmSN70b2NzuWcw4Q/hk4uI7ZuMpSafKq8gZPKhJ2SSSdqg+yb3CEDPVPttd
	i
X-Google-Smtp-Source: AGHT+IEjfO958DC0wfGZpFOiFXLouvPHw+Oh7UYisKR7PVQcoOEmQ1qGM8X6cKn4sfdfLnfbV0DIqA==
X-Received: by 2002:a17:906:3e48:b0:a59:a221:e2d4 with SMTP id a640c23a62f3a-a622806b976mr284821266b.8.1716460183012;
        Thu, 23 May 2024 03:29:43 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a50365669sm1673515666b.193.2024.05.23.03.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:29:42 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v7 5/6] gitignore: Add __pycache__
Date: Thu, 23 May 2024 06:29:28 -0400
Message-ID: <20240523102929.37761-6-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523102929.37761-1-arun@asymptotic.io>
References: <20240523102929.37761-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These directories are created when running scripts in test/ in-tree, and
can safely be ignored.
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 6a6422379..041a707af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -187,3 +187,5 @@ compile_commands.json
 cscope.in.out
 cscope.out
 cscope.po.out
+
+**/__pycache__
-- 
2.45.1

