Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch [109.224.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6AB36B061
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876993; cv=none; b=n+up3b46lSGyzekn0pl8K1VUH18duV5Aquxq7uYkcK/g8yh+AcTWy9UI1NmbVEDsz2YdOx96RRSNvJgwc7kKmNDYgA0Qp2YV87crkmGwztSozmz2nkbRBLHvm8Viv89xCOCUO/7o9qC0d1Tt1+mKSOrC4HLxMht6vBJmlalFZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876993; c=relaxed/simple;
	bh=ic0buBK4GzRnzE6aeyF6/yYI6YDb1PCWQ3Lfs60yfAE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dlj8V2dg9fnWaQu4aI349CGa6yH9bf8m3wIZd167yuVuh6N2i4X/+F0WsXbWUbKnCqpU8Mj3iHpaVm1YBmhZ0gcOjWLLkjeO/N+Iv9v5W4SazDpbkxPj3j8tdeA0wk2UrfeWM6+ZKnA4NIVBNfHnxZ4O8615OIzXSE3kBIrBCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=a0ux4AcL; arc=none smtp.client-ip=109.224.244.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="a0ux4AcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1762876658; x=1763135858;
	bh=IV/CgGDu9OzCAZJkFRD5Yh0fT1Fb19PCHVA+Uap1TUY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=a0ux4AcLmt9xSRDtn0QT9H7UYVYpv6OuIB6OHDpZ88ocn5VTPf53VifkS40lKJRuJ
	 d3fWHDV+AFRFN1TDeKUCcxwX0q9Kj6M9p8d+c+8LfmX3LnJZjUG2b0JOHrwQH/r55h
	 2G6+0beJgLRA/3ZwCVMVFvQuYSSUcryyIIA4dO6Fy15xERCWU5qIasU6XOjnlqVLcZ
	 eIPEThyatmEt2QqZmQhIwPpfIqmnK2x7BNgN+ppgfwGvJYtuqhdqAq4ZS9HjJ2V2TO
	 oYLGnNilheIwDfkEgHYk3dqGnphzU7r46GawhVma3E0Y3eWxj74WDXEqFAqsfX9yD+
	 JlvxzTdqJdWBw==
Date: Tue, 11 Nov 2025 15:57:32 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
From: Alfred Wingate <parona@protonmail.com>
Cc: Alfred Wingate <parona@protonmail.com>
Subject: [PATCH v2 BlueZ 0/3] build: Fix distcheck while installing org.bluez.obex.service with --disable-system
Message-ID: <20251111155644.11675-1-parona@protonmail.com>
Feedback-ID: 25092314:user:proton
X-Pm-Message-ID: 4ccd84683f7d4824b046a4d56c338738f00ef6fc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Alfred Wingate <parona@protonmail.com>

Pkg-config variables give absolute paths with system prefixes, causing prob=
lems
for distcheck which wants to install everything in its own prefix. To cope =
with
this lets give distcheck its own configure arguments with its own prefix va=
riable
already included.

https://www.gnu.org/software/automake/manual/html_node/DISTCHECK_005fCONFIG=
URE_005fFLAGS.html

This allows reverting the previous workaround that stopped installing the o=
bex
dbus service on non systemd targets.

https://github.com/bluez/bluez/issues/806

---
Changed in v2:
- Use AM_DISTCHECK_CONFIGURE_FLAGS as instructed in automake documentation.
- Simplify fix to only set dbus variables and explicitly disable cups as
  well.
---

Alfred Wingate (3):
  build: use AM_DISTCHECK_CONFIGURE_FLAGS
  build: Fix distcheck by hardcoding non absolute paths
  build: obexd: Revert "Fix make distcheck"

 Makefile.am    | 11 +++++++++--
 Makefile.obexd |  7 ++++---
 2 files changed, 13 insertions(+), 5 deletions(-)


base-commit: 5e41d1e1d361e7288964e4c2c5ed90736025662f
--=20
2.51.2


