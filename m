Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538394;
	b=Ay6qKWTFyZpPeVE/Z/6IrKn11wmGej7pu4zs1x6KhdhSirlDZPOHNk7pKM+rnHTViZJO
	 rfU/Rdq1trIyeImpUTfsUEonZzNUryqphi6rpciBzNdBLYc7JTVPWTH5S2W0JLvT5FI8O
	 ASWugntQDUhkw7ODqrmfz6ecO6oWrkUgvJJ03PcggdYD6OPa2q0wOULwVPdxPaTRP9O7d
	 wf0yS6U9xyFnsgQZPRfMLkXiVsdd/1No0tbuBB56HXtEYyVGzS3HPywLY0tFJjaXZHP1u
	 yqMapRfM34CqLzK7O8G5xfIbcpi2J9t3pb15Aoy+/ThWowPA9VLYKVvyusaGh0tgV6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538394;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=KFPU9dnIf2JgSLa8lAvrD9SuGYid53InhO7+MS7xDzk=;
	b=Ms+rzcCOxgKK8SU8u5r+xa8bQP0h+pAhIVtbE56mQDF3SlBTr+zPE4WlY9zKhu0IyRRp
	 RxbNJb/E5IOKxzux03f4s4nWjfH5CgQj7SBk48t12sjQCADQrxzX8E6MrBdbkQPoJGcJz
	 aIB4YcyJK8exjBMmUJ3oWCFK813zPPE8/PEnZmKJ/n5lrlmu3Wqh2r4SwTNBTtQj4F+OE
	 VeRWG8XEZ+/LtvhiESgWkvXxTFmWDHVVi2l6wt6AwR1CoVSl4VB3F2C/J3kAOd5iz9872
	 n5ryL5FORR3b4WQD048Lyt7r3GRU4oHYelHWYyULR5irmz2ZJ+Hmrh/F9dK3YjNiZhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=jlldfd27e5dlvguxpdytjrb2vi.protonmail2 header.b=PiVv3F9c;
	arc=none smtp.remote-ip=109.224.244.18
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9E606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 16:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAE9E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=jlldfd27e5dlvguxpdytjrb2vi.protonmail2 header.b=PiVv3F9c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jlldfd27e5dlvguxpdytjrb2vi.protonmail2; t=1795538390;
	x=1795797590; bh=KFPU9dnIf2JgSLa8lAvrD9SuGYid53InhO7+MS7xDzk=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PiVv3F9cpYYIns3cIIRKCv5jOLEkBaw6GhpCLLBHeDnbq+4/ID7iIY9Nd6kuXLldM
	 wjtDy9/jHvA+9Rsx373+AxUaFO82n/19gTlgi4Ok7EqahJPYXUm3BsK8RKr74N7Ox3
	 3XsS17iZsKzNlg4Uik+H/87w2vmYGf86O9RI5nYO5UDF/77BjafJAci0eOBV7L3q0K
	 3ANbK6iC//RO8Yhk2NqW/Zlpex90ScYOJ2aPOGHzKUPL4RQb8GXCBWJdXnsiw57Kr/
	 BPtj/dSD2iI/PyVfpAOh1pS1hKvIXU/gZHdgnkTr44KRhW5lqgY48ioSNjg9gG/8b5
	 tgEvE0HZsu21A==
Date: Tue, 24 Nov 2026 16:39:42 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v5 0/4] asha: Notify connection interval changes
Message-ID: <cover.1795535897.git.cochcoder@proton.me>
In-Reply-To: <cover.1795489294.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 771ce0905a051eea2a4885e7407e1fa0af158e08
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

Changes since v4:
- Track attached aids separately from previously started aids so a peer
  receives STATUS before its first START. Remove attachment on reset/free
  and preserve a replacement when an older object is released.
- Test both directions and ROP/PSM read orders, incomplete discovery and
  same-side replacement before the older object's release. Keep the START
  other-connected bit tied to its existing set.

The v4 functional job failed BASS/PAST broadcast earbud acquisition with
org.bluez.Error.Failed. This revision fixes a separate ASHA notification
gap; it does not claim to resolve that failure. Native functional VM and
hardware validation remain unavailable locally.

The observer still reports only its last successful observation. Lost or
preexisting events remain unknown until a supported event arrives; LE
Enhanced Connection Complete v2 is not registered. Controller power-cycle
cache behavior and the profile ownership of the raw observer remain open.

Previous v4 cover (this series replies to it):
https://lore.kernel.org/linux-bluetooth/cover.1795489294.git.cochcoder@prot=
on.me/
Previous PR and functional failure:
https://github.com/bluez/bluez/pull/2891

Kyle Pepper (4):
  shared/asha: Unregister set members by object
  asha: Add connection interval STATUS helper
  asha: Notify observed connection intervals
  unit: Test ASHA connection interval notifications

 .gitignore                |   2 +
 Makefile.am               |  17 ++
 profiles/audio/asha.c     | 231 +++++++++++++++
 src/shared/asha.c         |  98 ++++++-
 src/shared/asha.h         |   1 +
 unit/test-asha-conn.c     | 578 ++++++++++++++++++++++++++++++++++++++
 unit/test-asha-conn.h     |  11 +
 unit/test-asha-interval.c | 355 +++++++++++++++++++++++
 8 files changed, 1288 insertions(+), 5 deletions(-)
 create mode 100644 unit/test-asha-conn.c
 create mode 100644 unit/test-asha-conn.h
 create mode 100644 unit/test-asha-interval.c

--=20
2.56.1


