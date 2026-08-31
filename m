Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB73CBE6D
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170376; cv=none; b=JRJOg5NtYCjltHgzghrjw8gyw/XNlPHq4+2qljPOo8u5POEp741b6fOgFQxu/lqI0Hp3vQ7RdCAv/AHQXM41hihGlH7qvEPQ+gU8nvVzVb/3rLZyMnEpjEPGbwODJHi9xyAiLaznnH5/6Ay/oDU735JFkLg5gB+Yc7H252IbQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170376; c=relaxed/simple;
	bh=nzoFSX+R+AcRpDe3HpmAbT3nJT9qlA+q77afnM09pII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSQ/88DAYZuuQ/Z1B8TwIVUGk0l5fu45O9l66g6LV9pEl53757oqk70g8LTJzmiEBm4zWKb6hR0eVuE5uGhjnfbFpEnAJXf0XzNj2Ew+/6jbfMXLe8XvL8me/nyj8zl9mwoS5e9IeXS/eou49ycF9Tmvk1LntCzDWiIMj6l6qdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlApJuX2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlApJuX2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d942c7cc2fso3182595ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788170374; x=1788775174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0B+PFs1Atg+wJEzTsWLUnHe9K7w0nLXn2hcclRFcU2Q=;
        b=HlApJuX2y/ZBz9tdpZWplwrvXGvLLkNDGEvnNLUz+yHQ8J8FvEC8LBfHcH9HRC8dY9
         yJnsxrRgiOS4Wn3GtJwN0MHYL/hBcz5j75A6CBselbbU5u9mDETh2hqs3SDauvWLYYlp
         l9dvLrEFx9oqdee/dvKHorj2AGgoJ22Ncy3rFFhoCxOwY1Jr7p1s2CXbdpVkwSx6g8Gf
         LIH/lRPCYkMcL9wf/g17KPqIMPeSpa+VzBqTizxbmFVrOH7p4wZVY2yo+S7gnpIR/IEx
         IcDrd2h5fmK5PVBivBxpOo1ytM34QnYz2+thsFiM1RtgGLhs9nFG1xAqxknSK5nA1OQJ
         Bh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170374; x=1788775174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0B+PFs1Atg+wJEzTsWLUnHe9K7w0nLXn2hcclRFcU2Q=;
        b=phZBgczQhnZjJDPUgO3FwUFtAr8b4uIdplTnsI091BYndT1hXKFr+zzWaSK/I0fl+h
         ooZB0vSeWw6VSNeYaGs3yEUD3Aq6JvG9DspjMM+fLZD7Uf2cGwPV7i6HEqbdkh91HTlL
         LLewVjiIOdQ4m62z7uCQBCoR7q449zAQFYGR6gXuMC27ULGkfAKGJ5fB4tpv6a3ix1o/
         FXSOFn3ZZ0RF2qQTwkudFf05RKdN8PUfxW++6G7dLg5nCf6YzTj4OA4AgXl/6j4Fnwie
         VwKIK94J+VVSz+HKVsCP2tuBA/4qLC1GuavNfADLCa4sEj4I0JZW+DIkUMmptcr3EfJw
         1zoA==
X-Gm-Message-State: AFuF++nHeO4iKFH5pw4WO8FDby8ztCUjD03sWXbwlmoEUl4ACnIjqMIw
	Z7b84EJL2oBgRv+EYK+pIi8PMF9P4OHdaPC+rDd5asvtIgWvZYdxi9FSgqehm2FhQmg=
X-Gm-Gg: AYBFou2+sp2q2nG8pawZQTI4GupK5eh/YirR7aytoOuY4M2/cGS1404wSjfFXKALleE
	vuH95ZiujY3WFDlwMVqrjLdBhwGrE2JtvU8ETadAfG19jA0YGYX54j2aKYC9A9xGn+Yh1q5ZiM8
	qwuBgysOge+MEmofzqDXGvu+cEXfU6mM/ip2eF+lmdPkBjaJdINPhpUPMqLlFOJbWyFCWiI+VBx
	sPhUONoBTrbiiqVs7lgerubFXGN948JgOTdgABBPTzhEFqeKvPHN1/vV+JBPaTe8Q31DA6R2Mqf
	/WE5HaEFTo+7WJKeuYPggoc0r1LR56WRltxUGANRzrmJxnvlVZRDA+mP57oCcuaB8brcUCWynz+
	5UVUjRkjpnyT3aKtvHjLQ/gtrjaQx0ETIiDE+M8PlbsnWggta7dF31Pj364ILKSyxXP9n+ehdlS
	E6OPMZMzyH8lqpsGEMp+zs3/LFufy8RMXM561j2Aaoo5td0Y4KrRsWrxcvmfipLK/3FuSw0QHCf
	l0ib1ymZsEkyi77vp+gMlplrQUdt/OF06zro5X6JkgInOaRZUyH3TDLBVLX6WaOujuWhz8NqKqw
	cDMFMI3utthesj+enL6HIw74ZRELXB3v6Ps3fJR8EU4OZRKnULauVlWsVFLtgaEvqk27TD379RV
	jne3Kvc1uRg+2jE23pflfXA8WJvJwMaPZQQlTXougKDqDgdE=
X-Received: by 2002:a17:903:3d07:b0:2d9:3be4:7e31 with SMTP id d9443c01a7336-2d93be47e51mr37298095ad.5.1788170374046;
        Mon, 31 Aug 2026 02:59:34 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759640becsm32270775ad.36.2026.08.31.02.59.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 02:59:33 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	ali@iusegentoo.com,
	kiraank@gmail.com,
	kiran.k@intel.com,
	ravishankar.srivatsa@intel.com,
	amit.k.bag@intel.com,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Subject: [PATCH v3 0/3] Bluetooth: btintel: harden version TLV parsing
Date: Mon, 31 Aug 2026 15:44:20 +0545
Message-ID: <20260831095923.18830-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malformed Intel version TLVs can make btintel_parse_version_tlv() read
beyond the received response. Validate the minimum value length for each
known fixed-size TLV and bound the firmware ID conversion by the TLV's
advertised length. Propagate parser failures to the setup path in a
separate patch.

The two bounds fixes are kept separate because they were introduced by
different commits and apply to different stable trees. The parser error
propagation is also separate because it changes setup behavior.

Changes in v3:
- remove non-standard Assisted-by trailers rejected by checkpatch
- add Ali's Reviewed-by tag to patch 3/3
- no code changes

Changes in v2:
- split the minimum-length validation and firmware ID bounds fix
- use the appropriate Fixes tag for each bounds fix
- keep parser error propagation as a separate behavioral change
- add Ali's Reviewed-by tag to the two bounds fixes

Laxman Acharya Padhya (3):
  Bluetooth: btintel: validate version TLV value lengths
  Bluetooth: btintel: bound firmware ID by TLV length
  Bluetooth: btintel: propagate version TLV parsing errors

 drivers/bluetooth/btintel.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)


base-commit: bcb621272aa04a116a74ab5fcc9324231ffa3acb
-- 
2.51.2
