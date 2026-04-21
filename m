Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD233F5BC
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801356; cv=none; b=j2I0+shHq3GSTJ95eg3L2ZYRzgLgaSCZnzG+3QnTsfU17AKCQnNfOPQpkshazqanYBBVHA8E+5VPPPuA6J6OCbfyLtmoBGTxOAXNK2IeHMAOGIpfOu7XJiqyJ/xnLE8dXU2mjdxWLFEXtvIfxgY88LiuWEjOdovEpwMWktmjptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801356; c=relaxed/simple;
	bh=l1URCGmFp928CJXJTW1h4ja9YqpDw/29ohR4yYUzrz0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EYBvYplxiriu9iA3ozji4sx6D6JG1mS33StrX3xECNN7ApzGEiEPZcNPfueR/vmIdweZpLKUvIZu4uOFptgLXN0aNnE/hqbm//46K6QkRZWDWkjxQ1Z1k891ihKwZIj9DTkgC2AZcN1Vo6yyjprtfyNnGmhGIZsr2MLR9LYsXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5CLehk8; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5CLehk8"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56a857578a8so1801402e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776801354; x=1777406154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuNjQMgmCEGuUpz9Hhs45f9RQqURpfIZkIYN4kFwZDc=;
        b=M5CLehk8hmRx/nxoqtVGAOgMvmkhjqu/SlQ84qXlF6Uz1+wSrrK5c9ROrcnsneYNiA
         ibvMOdX6lB5gQAi3HEWUk/YLhMWCBv0CMgV0ZCTXbq+KTIpLgI8NGgI906sP/D6vsM2B
         rqJfBbqILQPrgSXu+JBgO7bZUbn9E69eGGq8lwPfY49om87AQiBAu/V168ee7MC4FDUA
         00lYzusVskdX/kAvCgc/LUDr1pRK7S7l1Dq1MVzcso5ExweyalhxbwGIxlOez5p3hF2R
         LLqNfDIxRUvkSVtCxuD051zW0Yga5SnDLF6FKO1Mv1K0zzCdFW8h7ol6f4myjUB0G4p7
         JdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801354; x=1777406154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuNjQMgmCEGuUpz9Hhs45f9RQqURpfIZkIYN4kFwZDc=;
        b=OFzjCieO0akJmCNRHpBLwTniHQWBbtamGHk3EjKbHCh+LL53JKjj2CsnCv3jOPT0cU
         Cz2Rn0hXsh5XlCiPT7pQ4mliu7Qg9eWyzIxXuXBg9tr3mLlr2SO9iJ8190+CdyRM57YY
         L2nW6rCsONncULgvSq5/3U4Iz2Yern2YCmVAyfJJ9pHVa6oKelYiCsOSfpoNH8wBzj7X
         S1IrJ3UAO/LwTna+pzn5VKRKgHxZ00QabmIo4X+QEHeMxBy534IfnlQyWmxG/9HAsbBo
         UPL7Vo0DtOr+5AyD5+tWzRF9FWOE9nS3fyaFAGOVsJA+gEwltiKqiddR4Fl0OYgfjBD7
         vFRw==
X-Gm-Message-State: AOJu0YxcPJGlA5yAf1LlTyuT9jEOAXQfDGssa4+0m/+Xfmtteo20I2qP
	zjqkOpdia2UD5nU26avhF6sRbhVq2O+5EzxUkkYhGwSRnqG6xcSjkuY3tJgJ6bZvKG4=
X-Gm-Gg: AeBDievX2u1guTdMmTPKim61Pd0a3MJEiX+VuBuXTNRTK5r5psdLz1cbSwa4agGWmk9
	zSfyUqu71X6o6bAKoCYdPn2q+mt9xF48YFWCKVqcGmK1/KiCKvNwgA+VmsQyzE8OoqMkJw0KhOO
	8Qqo/582BzthVdELZQqX2j6xxvUPzn20KeI2/S7mfDHy3HpzDm8GuCAzL7B3OSAs4+haAnfHnBe
	JxZqY3SwDCqs4aPJM53gYVOfN30e9rmpBympS+S1s5JSRm1LsD8MZQqWd/vjPQ7Tg6D9v4okirO
	diWCYHBK3HcqzAbN/QC9YX1z7XCp1baJu8gi3tGB7eV7DkMVAbiv/IUjvXDMISQS88+mIF8m2ud
	MNkMJpmRSSUAU4TyrZs2/Dj6W/HlxeZGWD+mU48jm/zMadHD/8Hlxoh+kA8IuqqG03D0lBGyWNn
	NJnJmJTOCQxfutwe2KLb9zssisOnrJXY0bOSIMGY2EdlDQuVo1R9iDTf36753NGx8dqJBiAtxjS
	LaHrTCU6Q5/rbV7qgAF3+JlDuzf
X-Received: by 2002:a05:6123:14b:b0:56a:f576:cfca with SMTP id 71dfb90a1353d-56fa57d82ccmr9453021e0c.2.1776801354219;
        Tue, 21 Apr 2026 12:55:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91bf120sm8962318e0c.3.2026.04.21.12.55.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:55:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] Add permissions for btsnoop-analyzer workflow
Date: Tue, 21 Apr 2026 15:55:44 -0400
Message-ID: <20260421195544.1950548-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Grant issues:write, contents:read, and models:read so the reusable
workflow can post comments and access the GitHub Models API.
---
 .github/workflows/btsnoop-analyze.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.github/workflows/btsnoop-analyze.yml b/.github/workflows/btsnoop-analyze.yml
index 484288c0d9b6..b910f3c0cb66 100644
--- a/.github/workflows/btsnoop-analyze.yml
+++ b/.github/workflows/btsnoop-analyze.yml
@@ -4,6 +4,11 @@ on:
   issue_comment:
     types: [created]
 
+permissions:
+  issues: write
+  contents: read
+  models: read
+
 jobs:
   analyze:
     if: >-
-- 
2.53.0

