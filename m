Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F24F647A
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554881; cv=none; b=jxchm7P5jy/XC2u3uTLqgWPBLwWZnrh4c6cm+cEwPpvzL2Z2yVsuVzWF2MO3+JcFgOWmfJJSeznitFDZ+c9PksmjjzP2uTMlZimdQ92HwktamjQFHEtyDX6nyFuctjgE8l6IQ6j2XFyjm/A6gF4GoihWgVI7w22OF5GcBIvmIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554881; c=relaxed/simple;
	bh=sezVlt2hqPgn7x5dNeWxKBV0PHXS3WnhlVSntpgctho=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eknTej3pYNcRUxIX/8a20scm3LgvRC52lq1XVzMe1+bk2sfSDd0ZkVpmp8wNR+n0YYLDvOPpU35wgaAecUm0pFnlKg60tTvkVAkig5KHk1sBCyI6sQ2jzejm87KUnxFVMkVvbDw/AhPlK5uH77yVCG4tvMrthcsg8Hv1Jw3oqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gOeQCXup; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gOeQCXup"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789554859; x=1789814059;
	bh=sezVlt2hqPgn7x5dNeWxKBV0PHXS3WnhlVSntpgctho=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gOeQCXupxI5KN0qDr08WFHijdRsOtRb6EmkIV4eFhj1e5SAOCKpHr6+2imoXtt1lo
	 f1Njr75ygHSTgMnf1OM3DAqN6LvLbGhOcJrYlsjcyvW9t64BeD1vbPRv4pDsgJZai5
	 j8NMpwVkl0H4onKhqwJN7WQyAP6qH3CRmia9bsanVUfeul8UTelKWOIJWeYlD6d92L
	 M3xBXrC3TXMjInsFyjtqSigfMk5SgLAffGUgoRMP5q7j8WRyISDITKCSBBKAvqpv6y
	 d/PkZxPhct1/J4iNNnBn1D7iBL+VYb546hE9183iieBhqCp+9EOQkVDqHVxOJyCknQ
	 HLPrI7xXUwQRg==
Date: Wed, 16 Sep 2026 10:34:14 +0000
To: "pav@iki.fi" <pav@iki.fi>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] Bluetooth: btmtk: don't generate bogus ISO packets from zero padding
Message-ID: <fp1LLpMjte31CZfdRymzNx8DeLqozYHgFf2TAKxtIiHEkPcykA5jgtuDuZYcJTb5vPGpPkgB8GoVoX5_821oWe9NvenZdL4kwrxyCuanlw8=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 3c7e295f24b45de5e806b0314f3684397af67a90
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

Following up on your v2 proposal:
https://www.spinics.net/lists/linux-bluetooth/msg129361.html

Additional evidence for the MT7925 padding issue, from an MT7925 using
LE Audio on kernel 7.2.4-3-cachyos:

Before filtering, a capture contained 206,325 spurious handle-zero ISO
packets. The count matches interpreting the zero remainder of 264-byte
transfers as four-byte headers: 3,633 genuine 60-byte SDUs and 507 empty
SDUs give 3633 * 48 + 507 * 63 =3D 206325. USB URB boundaries were not
captured, so this is byte-accounting evidence for the padding explanation.

A local adaptation of this proposal eliminates the phantom packets in
two subsequent capture summaries, which contain only the real ISO handles
and no short or truncated ISO headers.

The tested variant differs from this v2: it uses the existing dev_id to
restrict filtering to MT7925, leaves btmtk.h unchanged, and omits the
once-per-device warning. It retains the original 264-byte transfer check
and discards an all-zero remainder only after consuming some data and
reaching a new packet boundary. The original v2 itself was not tested.

The complete local setup has also passed reboot, reconnect and duplex
profile-switch testing. Separate PipeWire, WirePlumber and BlueZ fixes
were involved, so the specific result attributable to this filter is the
removal of the bogus padding packets.

As of 2026-09-16, the receive loops in bluetooth-next at 2e63b55654e0
and Linux at 9b87fdc9af2f still lack a trailing-padding check. Would a
refresh of this proposal be useful? Has MediaTek confirmed whether the
fixed-size zero padding is intentional, which would inform retaining or
removing the warning?

