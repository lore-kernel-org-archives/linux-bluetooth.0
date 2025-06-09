Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD443FF1
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479900; cv=none; b=NbBl6Ao1hk0J427vo95scsbs5/DblpsuSCmqJPGXXLbTQQX46ylOHYHXrl76VJ+nERWGWAxLY59kw13ivVPEYwy8iv9C+lHvXNSkDEcCfUjsLpelexWFqVZd0qVwfuvUK/YgR6+4x1UlCWtfq6SlvyVSPEKj3ULLgOjHEiviKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479900; c=relaxed/simple;
	bh=a1iNGVoEE31jAT7yCH2uLWU5W951WNpJ0Rgf7oOjPok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXvZO37I/erGNrcm7hAXPDMD+c+d58gSxkm5sIAfmVPkEF1UdrZPGdXCOBq2quKMEYgLhv8blNN8BurRbqLdVXHsmh5LuhtIRLCUKT3Ilfa/3DUOhUbmVU3Y7mpXrt4Ow9/RRhFQ4zMbxS00pE9GpH1hy9TtO6fyhItrIow8VpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3WqlbA2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3WqlbA2"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so7144462a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749479897; x=1750084697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a09EzeqPLWZjlEN9/3f0lsAYK7bd8TDMIpaQpzGUXis=;
        b=C3WqlbA2LuWZTOrZ5xUgB2JxQ6mxVnar60sfoB0Ksa41VttF7Q9t1R0vp/8zt/mFMv
         jvHRtavbclXgCfpy/D1XLzasY79mAyTMHuIqIB397BRaZhny1ybNevQ48btcYR2+Div2
         kF1qgY6NYuFmIYxhLhx3PltR7kpKbsULwJr1kdooW5aWRK+rD3n+c1iz24l4fA7EhyG8
         Z5xa8sHK2uHkibseQQKlESzlnqj/bF1GlOwk8mnhdKzKQZQI4IcrUITre6cQIHQgiPXs
         F8vb5zVHPA5oy/L2fRqbO2IgUm9FFNHyZVBRHhYWeR+7oNKTmItjTTk2DMb+7twJGRRN
         +45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479897; x=1750084697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a09EzeqPLWZjlEN9/3f0lsAYK7bd8TDMIpaQpzGUXis=;
        b=vaQlYMONGz2MUGXcRIqHxQN0CxIOYPw0ip7HJH31GPharQUZk6K3ahVn4ODto7bG47
         7mLiEQKUYER9ONp7dXyPXkn9CXeu/RftackXq3xLL5HSYhzlp8w0QAJLGXF26lktzFGf
         LmyAwEVkhqiEXxIItTwWR4VuSNfyZbewssVKKWaP1sK/XjxeQe2EUsxGJihc7KyVFKWb
         6VgxCgZJeiUnK8HCFAJGfVON24TuAgCO/KBmkatifO5dhDwdI/juOKEO054+BwL8Z3PJ
         MwO8/33oZ0sO3GEBHDtKFUvDOAVXXBPU2XEVDzv6S1/GeZgObXYMn4CXHhGzql0kmPix
         mEQQ==
X-Gm-Message-State: AOJu0YwF7zb4g7Uhf39Fe5pvPt38N2ZUOuZZEYnz2MM6L7uu74JpSHDL
	uBFAY5FMjZ/XpnWd8cnmz6PriwZJnx2g5/859PU9HKUXz5XuADnnAQf8YAnRbg==
X-Gm-Gg: ASbGnctzByMRDncXMuLXFVn218oemz9bv8pne7jaJI8Nzfq0OfqePGVih2rUZTVtdzi
	nhnKHSSTV5rYZKCCGPrfCkEssGMqmFZ1wRXvJmpN41SXUYWPwuORAP17VQpqwcikgx7KqsG86Ep
	H/ouiikoNcWJFAWCCKJlmc+nKiADG5L1R/v1hP2KCgkATHYA09BlKLRVXSUqhcFEqPida/SStYY
	Cpbix/jDVFi2XJ/kLZdDV3QTkXI+tc8GEndwBp17wbwMBlWKrBr0SXxsk8qgEnezDVi7mJ8vCZU
	K4aBZh5hV3i0H7Oze1ogqbIBwOZQWtOAnEe7uh2ltxF2/XpeBP/1O8CRoqcQzhPAMFzeiuvCl1h
	OIjNlFNISuphK+XhuIPY/2cbcsXHyBg==
X-Google-Smtp-Source: AGHT+IHkJrEdIYvtAsoh8Fz495hGIgaAUEKtvtx3ZvKgq9yKv1ntuMV50mAl8FbP1TRlKQsDOzdq2w==
X-Received: by 2002:a17:907:7ea2:b0:ade:7513:5471 with SMTP id a640c23a62f3a-ade75135516mr35745266b.39.1749479896521;
        Mon, 09 Jun 2025 07:38:16 -0700 (PDT)
Received: from hyperion.tail59961f.ts.net (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade34ea5adesm452017866b.80.2025.06.09.07.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 07:38:16 -0700 (PDT)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Subject: [PATCH BlueZ 0/4] btvirt improvements for LE Audio
Date: Mon,  9 Jun 2025 16:38:07 +0200
Message-ID: <20250609143811.566331-1-d3dx12.xx@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves some bits around btvirt, its interfaces,
advertising and isochronous channel handling.

These changes enable btvirt to be used for simulation testing of
Zephyr Bluetooth stack implementation of BAP server for LE Audio.

Dmitrii Sharshakov (4):
  btdev: implement extended advertising
  btdev: fix LE Remove ISO Data Path command
  emulator: add option to listen on TCP
  emulator: server: handle ISO, use BR/EDR+LE 5.2 by default

 emulator/btdev.c  | 52 +++++++++++++++++++++++++++++++----------------
 emulator/main.c   | 20 ++++++++++++++++--
 emulator/server.c | 19 +++++++++++------
 emulator/server.h |  2 +-
 lib/hci.h         |  6 ++++++
 5 files changed, 72 insertions(+), 27 deletions(-)

-- 
2.49.0

