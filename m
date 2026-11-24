Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491527;
	b=E0jFzeoEMAkh8ud88qY9iGvwwtegT3TjEEsH0zea8FJlFwq2pSfXV/YGJi7mYeTeedZR
	 ase5Yw23X53Q22AYY1l8RvWM500ZIUaeR7N6jpDpiWF9evAPHqpHBHR1mqU95l0Y1vBmZ
	 v4GUt09+UrEEj8h6PJ8mEVZ5V2Yd8O783VR7gaX6QsOvbvGdlLHAEeq03nxZKrIPXRtVU
	 DCt+BJDmfjWhuigUra1oorF1EtSed54jRMBVd/sqIzdQPYVpFP1IIkHmB273d2oLS8b+v
	 hW/4KcN8HQV8yI+s3JsP2lMpCgjTmNo+3VjzXFrVgWBf6dfkgfAEjR1C0J4rIxPyPJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491527;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=yU/3vGZHspQCVIV9jOEipKoQTOpGUO4tOCOqa7NQU4k=;
	b=C6EcIjClv8z9Fn1yH5TyL4dnYpAgoQxPEZ0VlfAoCtW/TYxLsf3fCei2C0MqhJlgL0hc
	 Xqx+GXIwhLSzN3RSiP7Jvi1P/EvWZK+vu4h46PsYfharLmBtHDHIQC3JgQNwXzGO1gbma
	 prfYOeEX+fQPEKCT7DA0cOTV5xqwZIVzmBMRLlkxGL8pMf7Tr/gHZxEelNFKWLXTaytQd
	 QkEMBGSJC6+LzCy3AZ9O2hEvcl/tevztIpLrvNJcy35n3dD+L4fY+1cFKy0mfJLeJtYXW
	 0/BZLPcOm7mvSWxQuVHTpik6Vu8HVimnZwgy5uC8Xa+yghnv1qrroEyExogHvaJMImw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Ux0ClI3j;
	arc=none smtp.remote-ip=185.70.43.101
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0F606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC0F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Ux0ClI3j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795491522; x=1795750722;
	bh=yU/3vGZHspQCVIV9jOEipKoQTOpGUO4tOCOqa7NQU4k=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ux0ClI3jjk2awrPeOlDtl2eTl2jvJDem7SuJcRv89rrQmH68/maRHVDjxcIe7vZME
	 1VS18atfDQ6RAkvrehyR0ZbRgzqAcou9SWhjIcoM5aJVw4PU4TjB2BQUvb83OqM6kz
	 8gZSoP/nkX5JxjMV6r2mHIhBxvgHera8K6422lJGjQNHN1oysZX5SNuJsNELj9ivjp
	 YH2uQpqfuq81DUGahkp8LnvBfOiEFjrbvWezrSZgh1M17McbgedPZBxwFYsM/RXrew
	 lI81DFElazJqM26U5pZq1MKqtqugER//4Qu19Q1NEMBs1xVfoyE5YVQ+Sczt1z7MJe
	 rMuzx2uA42V5Q==
Date: Tue, 24 Nov 2026 03:38:39 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v4 0/4] asha: Notify connection interval changes
Message-ID: <cover.1795489294.git.cochcoder@proton.me>
In-Reply-To: <20261106235122.719665-1-cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 03c22a238f7fe931d86a4f2afc3d208eda4ba008
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
Apply patches 1-4 in order: lifetime fix, shared STATUS helper, profile
observer, then tests. No out-of-tree dependency is required.

Changes since v3:
- Unregister ASHA set members by object identity, preserving replacements.
- Split the shared helper, profile observer and tests into separate patches=
.
- Notify attached devices when an initial connection event arrives late.
- Cover reset, free and same-side replacement in the lifetime tests.

The cached interval is the last successful observation. A requested
connection update can still be pending when STATUS precedes START.
Links already connected when the observer starts remain unknown until
their next observed update. Hardware validation and fresh remote CI
remain unverified.

Previous v3 (this cover replies to it):
https://lore.kernel.org/linux-bluetooth/20261106235122.719665-1-cochcoder@p=
roton.me/
Previous PR: https://github.com/bluez/bluez/pull/2773

Kyle Pepper (4):
  shared/asha: Unregister set members by object
  asha: Add connection interval STATUS helper
  asha: Notify observed connection intervals
  unit: Test ASHA connection interval notifications

 .gitignore                |   2 +
 Makefile.am               |  17 ++
 profiles/audio/asha.c     | 231 +++++++++++++++
 src/shared/asha.c         |  63 ++++-
 src/shared/asha.h         |   1 +
 unit/test-asha-conn.c     | 578 ++++++++++++++++++++++++++++++++++++++
 unit/test-asha-conn.h     |  11 +
 unit/test-asha-interval.c | 237 ++++++++++++++++
 8 files changed, 1135 insertions(+), 5 deletions(-)
 create mode 100644 unit/test-asha-conn.c
 create mode 100644 unit/test-asha-conn.h
 create mode 100644 unit/test-asha-interval.c

--=20
2.56.1


