Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6C15E81
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479600; cv=none; b=W4Onrs4u2GIcL/8DpZwL05d8sOCo89Y1zzkLGN6dlYlRoUiUL54YlKmfmr7X7EoW1LegGlNA4InWEh4X8Seeavsey57StRJID51IOlYGuA/iYQ1U2tzbizR9Be5nI/x1wczNuSphMZG8Zac1chP+F62JObxrCDCx199NWGQAPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479600; c=relaxed/simple;
	bh=rT6OLdnBR/mk8EeKmF/bsQGed82UsuRd0DbD7NjpT9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sm1E6g4g7LSW0107UGlExwI80m5/a/FDuGEz1u/oJ1vq59pBFm+nHpqWeLfkTxssKxVH0SynMmgPR9NDj0m122MDF/cOOv1G55tyHISWPt5glclhNvEmgPQ7NUkuRp9L8y+oLUx7+c+GXAPYdbODcYsld7e2pq2zhBM4tPab16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=vQWvWr/1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="vQWvWr/1"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51fdc9af005so11847887e87.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716479596; x=1717084396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ1MCXegTloF+LteSI5RonTSHmIiXIbRQRSEkRpzFZw=;
        b=vQWvWr/18OFIqurRi4cPAEyTzz8AMVakF+u+5XrUXMr0L4UE4bCtdUNPlXdRvqB387
         R3X2FOJP1YWaw3DbYtmGc+R/zE9TqXzQhVQqPTcS/kwi3W6twOkdWZ2A/PTF9f0zJCkY
         rT6PnANe6N0Jr14/lQcGvIOGOFVGayze/LMvx31j/BAhGdMnLvglXLFSxugQQG/Tspzq
         mRw30hqKpotmA6/ufMj7hKh+M+GIVGFIOiQ1syER0XWxU21TXBMwS1MCtoUGUQ2Ygjui
         LK0PTMuakaQbG3b7sQtSzas/bgEaUOWLCq1xLOepQ00YLifVcqbyC0WQxQU6C6IdJrpW
         SEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479596; x=1717084396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ1MCXegTloF+LteSI5RonTSHmIiXIbRQRSEkRpzFZw=;
        b=jexMYEbOKODiZbWU/qx0diIgA4JTEwh9UwL0xH0W0QT7H6l3X3jJnqr6Boz/lz82UZ
         BaR1pHf62HmoO7eOPDseYevX6V6R/WQpOmOHbyIGJBK5EFr+ZTnaALT7AQbq1S7koWJS
         kZTqotbEXydPoXLaQ66l7K59HgEOlTPEDSvs1T8x3AGIta9GCk6H6iKKrx8+inL/7VDJ
         xCoqOcsi+VZfbytVoIeWZKn/hSucoUkzi65dI4X5JVsgbUDX8VTzarDTtgJHOMb8UlNv
         Pwc3IVrH1EIrW0o7T55yncp2v2g7eyOIoxQJgzC8OrPh/Z3F5D2xPkCuqvfOq39NX+i8
         aDVA==
X-Gm-Message-State: AOJu0YyIkceqPqiKCk4dCzCYj6FKx2Lb/FdXG2rN+vz6tSqBe38Bs4pu
	CQ5YiyMBI2yuMJ25rEODYJxr9WkNH3+MhH6SY/EcCECKM8sDf6Kxx0HxwZn4sj6MeQEO7EBg2i0
	S
X-Google-Smtp-Source: AGHT+IFB+8uLu+smAqvJSjnRzbrW1ZDu2cnm30pbex5wkDLwCVtH7lXE8vgbzKGq4Ukw07TCoMmdSg==
X-Received: by 2002:ac2:4433:0:b0:51d:9aa7:23e with SMTP id 2adb3069b0e04-526c1214499mr4047949e87.65.1716479596457;
        Thu, 23 May 2024 08:53:16 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c686sm1947600566b.47.2024.05.23.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:53:16 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v8 5/5] gitignore: Add __pycache__
Date: Thu, 23 May 2024 11:53:01 -0400
Message-ID: <20240523155301.140522-6-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523155301.140522-1-arun@asymptotic.io>
References: <20240523155301.140522-1-arun@asymptotic.io>
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

