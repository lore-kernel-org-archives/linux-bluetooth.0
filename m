Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649233;
	b=tcXdkURoCJBEnPERUGw7o7BCIzlsT3wv481RhkEerKe1bAitEt1QvSgxomjdDJasRXoV
	 eYcBW6wdTYrbP18zwfF3UdgblAM5CtjuRpRlLMC2Ao2bRtxw9pJVgON7srUFVBytbp89o
	 e+XME/kT3jcV2oKRjtT7tO/heoTihV/dHMOtz1Sxw7dz5u33zudFmNQ7nHb6KLxLZzbRO
	 cTLT8FPy5PDEzcJ/Sm2uVYJiCk+0xL0CznSsG07zoUcd/BoUFi44Cv8tHQMgA2x26HkLs
	 95kl+xcTif5bPxA2lMv8D+W6nf8IaedshNA0twEgqVyneqSLHU3D0l81Rxfwk1PsiJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649233;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=NN8DsjBKwRB9M6lwaGPNUfJArNyOYsIOcgj4kKVVKV8=;
	b=wmNz4RbqD+uKsOhDcwWAq2YK+78gxdMxp40plxtzw7uFfeT+CspVZ6/y2hv8jtiyReIz
	 iOQZyh6LjmROFsCjXVhZEVvY4RFx4rbS9y2SMKatmTUKRYGk15azi54cchiq/b42nOrDA
	 pTH1kIpPk1sztNTYzGMDLFNim8AK/RNT6+7IKc3/IqnlD54jinCMeKHqHtH2L68naBpl6
	 VxMrqP1MMxwJj/DJmtNL6ZS7056toS59NO89NvkoaUK/R+5xeGvZr5NNvomC9sLwz5o9p
	 F9+/atxRFemXwG3UZmSTKnxqxUxyZO6P5UrvDf4nEZ/fheIdtv9pEQabl1z/dFJ2iKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=wbMelQbA;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300E606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4300E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=wbMelQbA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795649230; x=1795908430;
	bh=NN8DsjBKwRB9M6lwaGPNUfJArNyOYsIOcgj4kKVVKV8=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=wbMelQbAuUhYsEqEd281Kbbf59LTpHU3m1/75wLo64H4B7I8yn68wDyOv0NRi/JUE
	 rfPrQPRI+Sgvt/L612Qv5+KQpPPBrRDFY6zwdaQetSGX/Rx3zxA7Mcr/aDfoUMvPy+
	 UCPuRWWhUO49nAyZVDsjfhqZaTsh37WoevJ5qfIruC3XfxpySTVOSJAsVhUWcW+rJS
	 PPGo6GpHU/HgHVBXrCHV6WPeObiHX8gjXVxR4a8BaW049IUrZ7dtx5+5HqU1yxZPGx
	 pvHIopsmCz2SMc+2wxDipvZMOLU/CFFb32MzHvcPM/Gag5KH8DteTeBxJ6RU3siRYC
	 v28YA/Z6iNqfQ==
Date: Wed, 25 Nov 2026 23:27:05 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v6 0/4] asha: Notify connection interval changes
Message-ID: <cover.1795648818.git.cochcoder@proton.me>
In-Reply-To: <cover.1795535897.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me> <cover.1795535897.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 5fc2c02b519b852551b482e46ca3e8fc4980c75d
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Report observed connection intervals to attached hearing aids.

Apply patches 1-4 in order: set lifetime fix, shared STATUS helper,
profile observer, then tests. No out-of-tree dependency is required.

Changes since v5, addressing Copilot's review highlighted by Luiz:
- Recreate the set queue when an attached aid completes START after the
  only registered aid resets or is freed. Fold the fix into patch 1.
- Define _GNU_SOURCE before system headers in the observer test so older
  glibc headers declare asprintf. Fold the fix into patch 4.
- Cover successful START after reset/free of the only registered peer,
  in both directions, followed by reattachment and peer-state checks.
- Rebase onto BlueZ 79162c1089110c896cb48118c3f7eb0db1fa0f2b.

The set bug affects START's other-connected state. Interval STATUS uses
the separate attached-aid queue. The header failure is reproducible with
glibc 2.35's stdio.h; the unchanged test builds on this host's glibc 2.44.

The v5 bot run passed all 12 jobs, including TestFunctional. No v6 remote
CI, native functional VM or hearing-aid validation is claimed.

The observer still reports only its last successful observation. Lost or
preexisting events remain unknown until a supported event arrives; LE
Enhanced Connection Complete v2 is not registered. Controller power-cycle
cache behavior and the profile ownership of the raw observer remain open.

Previous v5 cover (this series replies to it):
https://lore.kernel.org/linux-bluetooth/cover.1795535897.git.cochcoder@prot=
on.me/
Review and CI:
https://github.com/bluez/bluez/pull/2911#pullrequestreview-6046633570

AI assistance: prior OpenCode work is retained; Codex prepared and tested
the v6 fixes, regression cases and revision. Copilot identified both bugs.

Kyle Pepper (4):
  shared/asha: Unregister set members by object
  asha: Add connection interval STATUS helper
  asha: Notify observed connection intervals
  unit: Test ASHA connection interval notifications

 .gitignore                |   2 +
 Makefile.am               |  17 ++
 profiles/audio/asha.c     | 231 +++++++++++++++
 src/shared/asha.c         | 101 ++++++-
 src/shared/asha.h         |   1 +
 unit/test-asha-conn.c     | 579 ++++++++++++++++++++++++++++++++++++++
 unit/test-asha-conn.h     |  11 +
 unit/test-asha-interval.c | 417 +++++++++++++++++++++++++++
 8 files changed, 1354 insertions(+), 5 deletions(-)
 create mode 100644 unit/test-asha-conn.c
 create mode 100644 unit/test-asha-conn.h
 create mode 100644 unit/test-asha-interval.c


base-commit: 79162c1089110c896cb48118c3f7eb0db1fa0f2b
--=20
2.56.1


