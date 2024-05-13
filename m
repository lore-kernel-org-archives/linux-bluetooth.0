Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2EE7E575
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632657; cv=none; b=G43x02KG6e8wHJOGVWaV/GTQuURF6LUKS1S3SbDXcwDK5Q6KOE1TbBBgrUfV2ZjqUCn8J9/RyDqqe9pwu51A3YMbZHDsU4k05zKftd0HVoBBdEOidzX+Sa3hxNkRiyviuJs5VPJGoyMbBt5arVMmrXUbLQU1sogWgE84vyTesoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632657; c=relaxed/simple;
	bh=A3CFibtjVNWTQYvrYpCCB3+zMdXR019nykrO8emUWXI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=swf/6aXnBJAIK0p3GJ1X3FbSc7mc2LvOhisaPoSHH0d9cK0vi3ZuvjJlYDZiTUi8GMuzTv15BVQYYsx9WaUS1OI4FQDaNY+fnacIUXLfGS+MBeQjJ/njDlxDTc26pI+TLPU5xqlkIUwDkcrq9jJJAjqtn+/oWqf8OKFsYF+flyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX3/U4LK; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX3/U4LK"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7f3317ff3c2so1452606241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715632654; x=1716237454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aoxfvs4cTaou5ZH3no+t+VhedOUexElN8NnhKcWZ7zU=;
        b=AX3/U4LKc/4MYcnpHQaCdsibDxMPDMnN9pquHchIAUvpVyqbm+FQeF2hXBany6aw2p
         tH+Mm5zOInppssBDRqzg5SuHEXQ+LskAx4PlZqdc9KhfyYMHOjR12dJoP4JPS6DKTOCV
         iT8Rzh3545MOFuJV0iJ3DpDmL6Zgkp7NUIDpPY5WvMU41jynnMLjZxyMGGXwDUn2+nZ9
         Cu/vma57UD2Rt8ShxberZJ6NaZfwXjEIZHOwVheC5xNOBQUph0WUI4yb82T9nBVbVFYV
         a3Qm/ZmM7IW7KyNWVrZ4hBm1zjLZ0znbfpdiL6Zqvm+l7VIdSsorJQxjonNfiSP3M6L9
         yIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715632654; x=1716237454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoxfvs4cTaou5ZH3no+t+VhedOUexElN8NnhKcWZ7zU=;
        b=flV9p10NFM7akn3PODpPr14O9QJk/JIuu55tmZIcgZ0/hmpE+9+VRy+5no8kkKLf3h
         MvYDuTwSatxyXMvlTLJHGr1B1+rw4t/A/AHyfdx2ewuKscdEeOrME+9fy5Fi2EmHPYWz
         6aEhdzAzz8mOCaIusWhMzAJ5d/qi9y+Jjxl3ktKx0BvGzHffKWZKZj/LwbxyDKare6nL
         zg9d/3sYNhzVa72ICWlUtDkSzCcb8R1+CwZljt/iRk5MKD5cSrdpqWvw48yuOs2ik13L
         sqqn9wpEFjY1O9y5JIEoqBobMU+liUDjAT7guvIHL8Pov6x3MaY02k6rBvciF+Mc6Do5
         QL+A==
X-Gm-Message-State: AOJu0YwJRJHG3w6ctY6o7C/Mhra5YQBBJ1xU+ycDsNNE9X5LUzT1y/f4
	0SXS8uSB2tO4Pnvw0Q+L8OXbzzO/M6GOHd5jI4PyrvA7UG1BeYsou96/Rw==
X-Google-Smtp-Source: AGHT+IFB0ngqCfaUFD6KlUMvCbAck44puvgrNsiiWUzpRuWMDoAuNMsyZCztROCOaLQ4gphLcxyJeQ==
X-Received: by 2002:a05:6102:c90:b0:47c:1251:cf25 with SMTP id ada2fe7eead31-48077de62e8mr10294356137.12.1715632654386;
        Mon, 13 May 2024 13:37:34 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-7f9000e35fbsm1318421241.35.2024.05.13.13.37.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:37:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] mesh: Fix not setting rpl_dir as static
Date: Mon, 13 May 2024 16:37:32 -0400
Message-ID: <20240513203732.435344-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

rpl_dir shall be made static to be properly scoped.
---
 mesh/rpl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/rpl.c b/mesh/rpl.c
index 1213ee66e745..fb225dddd62b 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -31,7 +31,7 @@
 #include "mesh/util.h"
 #include "mesh/rpl.h"
 
-const char *rpl_dir = "/rpl";
+static const char *rpl_dir = "/rpl";
 
 bool rpl_put_entry(struct mesh_node *node, uint16_t src, uint32_t iv_index,
 								uint32_t seq)
-- 
2.45.0

