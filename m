Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06735C19B
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711492; cv=none; b=MDgZ3gOnTzF6ygfVGna03sNnitTdetJ4JWFLGQZ6V0kzvwYsXKSosJ7oqG+3cpzvMDEzsvJ2UXFG/OQPCORJ/auA04yqRsLFtp+RnKQq80v305Ngzra1JyWoWiMGpJENSnVZ2dj/8f2PCoWzpo99ARIyeqr9qMz7vJ773v0Aj5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711492; c=relaxed/simple;
	bh=Q2yYIMU35xn8OwWnjV+Ua6CHPf2c/Y1oTAzN3Xwew6I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSggDO30N0ObUlZSkG9M5VaQXxjW1dtw3pAg/YW7SDOw4uQhEmNXe2GCcTubVWmd8f6BFkkj7bBzzPTmmEkeFKHk5TlFpT5WqxIRGsasQbQbPgCN8FxMtAkjrZmWPp3b31mzTk7KKHhndQXyPpBeZqfku6SLjkhPBxDJE+yvpp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=nQ7qdOLg; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="nQ7qdOLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790711485; x=1790970685;
	bh=Q2yYIMU35xn8OwWnjV+Ua6CHPf2c/Y1oTAzN3Xwew6I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nQ7qdOLgq8tRXQcVQZzQStVXtf64SZijunyWodrMOQ4eByOBfozEvVe87SAczQXEL
	 hQRyo3OuKl3/1IHCdImFj7Vh701o06wv7DlSSdkwj4KITvgjnWT+Yy8EB3C8AwGgB2
	 aQ066j3NkOVufLY607Q8qSikQUCWpz5Yi7LzySfGxsNym8a6bT+cHA3Nv5YCAPY0Mh
	 QGSzCBTId97+G4tnLixeSRBsfpAMy6jwv6yqNx3sbY45EZhTyb2F62UJm+tzCbyLnP
	 vLEU2DsSXTUIExcVGAvZdI1agr0pmoSfMF7kfZgzMy6lHowyNurWSQbTDvaAeVdtI8
	 UjVm8ulaTxDPw==
Date: Tue, 29 Sep 2026 19:51:22 +0000
To: linux-bluetooth@vger.kernel.org, Kiran K <kiran.k@intel.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Ravindra <ravindra@intel.com>
Subject: Re: btintel_pcie: a gp1 mailbox interrupt during firmware download left the controller dead on 7.0; gone on bluetooth-next
Message-ID: <20260929195114.21972-1-lsa.uz@pm.me>
In-Reply-To: <20260911210634.87502-1-lsa.uz@pm.me>
References: <20260911210634.87502-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 7e8c73502fc0b3cfb254dcaf459b0e61c8c759ee
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A follow-up so that nobody looks for a fix upstream: there is none to
find.

Built with Ubuntu's own 7.0.0-34 config, mainline v7.0 went 0 of 41 warm
reboots and bluetooth-next 0 of 41, against 9 of 28 on Ubuntu's 7.0.0-34.
So the race comes from Ubuntu's kernel, not from btintel_pcie upstream.
Another machine with the same signature is in Ubuntu's tracker, and I have
added these numbers there:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2161900

Sergey

