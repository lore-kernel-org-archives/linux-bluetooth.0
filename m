Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F44AE11E
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655440; cv=none; b=D3qWzbiMma83KtTJLmGBzn/6qQSmROAePju0M2pESnE6YwwUS3yd6/H8wclePLNmFNoa/VsDuFCpfBQd+07H/IZ3Umq+gpVI/GAdup/3ZE4E4mF9C/LA3JJmiYoJmKG6zsd1ZYf4oa20IZWn7HoVYwSo30Bdxjt4lk7MYoKeT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655440; c=relaxed/simple;
	bh=0A5pVANVs2H+9Hg4Fbm0Q5ZuUpgZ7lTiuPXga4d1Dwk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja5Bp0o8o5s6CFAfWkISi//Olrlb2na+Cs6oZ1Q6tvBi6DIYFYtxcCBl8bfZUxHeC7VCEBo7tvxrPsb63vVnpvZ7a5y6sdJq0i0UXq0riFUEDHBGenLFsbVS26Vqki8tX20cU+JP5Fs4WPOCQEcbCjdR57JHyOE+S4t33nTzB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EV0d9hZa; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EV0d9hZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789655425; x=1789914625;
	bh=0A5pVANVs2H+9Hg4Fbm0Q5ZuUpgZ7lTiuPXga4d1Dwk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EV0d9hZaIcfY8ouG6edwFwwIQznQBK5nh0puqRAoSDefy2aTEWbkyt17jLxINRxYe
	 i4BOqoqQioPKa0W3BLuhf3/ESIYXjeOi5Dw+s1U+bgVlG2zVPYov5y6E0OqmAClkXD
	 tXSEqfPd+Bd+WE6UMKBRyG1QE4l3a5gCgLqm1O8HPFjTJ3tUQWLB4I76XaLRPn9KBg
	 05LDnI3O9ZeZiW9asQpVvDtHeJLs6z1ee/2hxMX0G/JrKWpUXNm3wCGjnb8xo0wsEv
	 zdRC8KLklMgOO/pP/YCoCd789q0uMx8QH4h+Xr0bpEbxhFinrUvPe9ZP9dzcBRxtZs
	 cWo6CU0buIXqg==
Date: Thu, 17 Sep 2026 14:30:20 +0000
To: Pauli Virtanen <pav@iki.fi>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] Bluetooth: btmtk: don't generate bogus ISO packets from zero padding
Message-ID: <YIDlCNZQwBhqkY9WfsaV0eA2620ZhUMPvlLJnmq919znENWqW0zIOHy4r5sxp8YY5VO0O_nxU80SfxhAgs0ibGL9V72vdLRCVfR-uzyF-vQ=@proton.me>
In-Reply-To: <e4b4da9d018ab26c5376fef47476b8852222eb07.camel@iki.fi>
References: <fp1LLpMjte31CZfdRymzNx8DeLqozYHgFf2TAKxtIiHEkPcykA5jgtuDuZYcJTb5vPGpPkgB8GoVoX5_821oWe9NvenZdL4kwrxyCuanlw8=@proton.me> <e4b4da9d018ab26c5376fef47476b8852222eb07.camel@iki.fi>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: b78e3d7ee951c238b3dafa7d73d712f8b75baa6a
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Did you test the latest 20260813113236 firmware version too?

Yes. The kernel logs confirm build 20260813113236 for the reported tests. T=
he phantom ISO packets occurred with that firmware, and the local padding-f=
ilter adaptation removed them. The exact upstream v2 patch has not been tes=
ted here.

