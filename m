Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EF202F70
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195930; cv=none; b=M/eVYEgqAMLeuD4uLMimo9fRf5xVjyOUPgmHxgEOYqAg16dnissi0GsgvORSizUdwy4MLTROtPirIsWiZKwPk+9zAU7q/a10cLq7qZ1qtPya7J2+bMPK2qL6/xTT54rhJA7BL2QNecW6EUSCLNTnwo1OS2VgVIepWC7lHxPATN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195930; c=relaxed/simple;
	bh=hAo0iHw45O7UtRC10odmwQhq9JPn9RVi9AONDUulPxE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=LAyCS3XlBdv72cVLOx8Rv7NMo4PSFbTYA4BZzDKPJ3IDcrsS+aNZIktuff5bh1w7HcSPSUef4T8AkfuGD9H/joKSPQLQxOLbsaXN22nBW9NAftXP7GgnZpEYKqRbdjOoZ/PvFUY44X6Lj8wlHVFTQbZRRj9mvntGi6SlJ2MwM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Z/sFsRH1; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Z/sFsRH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1761195914; x=1761455114;
	bh=D6+Qhbb549u+bFqyWaPtL2a8OSVFq0ttIbF1i0KEtNM=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Z/sFsRH1kI8a4qwI03eixQxsqBfkyND9BrI1DobQfi5y5eut6EOGT0QTVPUzfT2J3
	 icfzStDj8taxcLRfQnjTA6geIxTidIFcV6LUtVM5wWOmgJ9BwoZnu6ip2pqxELf76X
	 9gfuxsTZQlwEzFhMSLGSq+t+U2wTy+eGNvsC3pnW896Z/zdOAsFLxauGJEnH35eQyA
	 +84SdNZQs3vSQ7g51lj1tHopsfnAAoYvKIc77oHUdMl2i3OEX/S3+4s3oZt+kAr5RK
	 cZuuM9O16+Rdt8SXaXPgcB0HLlBLUWoaQJfrha2WjaBWULZK0ZIwLltF+exLqi4Cu/
	 ZCuS0OIi6h0Og==
Date: Thu, 23 Oct 2025 05:05:09 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Alfred Wingate <parona@protonmail.com>
Subject: [PATCH BlueZ 0/3] build: Fix distcheck while installing org.bluez.obex.service with --disable-systemd
Message-ID: <-w4Tz-HGOFe81IvBNIZkrOtGaZ6VR30rkdG0gO1KgjhxcPPSli_0wT7tBXmJ1aUbSXQrBj7g0sEEfolp4FhC5d2WJwwICWVE0oNlVa1sp_w=@protonmail.com>
Feedback-ID: 25092314:user:proton
X-Pm-Message-ID: 7845e47daccd663c6eb7d0984fc315d9dcfd1dd2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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

Alfred Wingate (3):
  build: Support setting the cups_serverbin directory
  build: Fix distcheck by hardcoding non absolute paths
  build: obexd: Revert "Fix make distcheck"

 Makefile.am    | 8 ++++++++
 Makefile.obexd | 7 ++++---
 configure.ac   | 4 +++-
 3 files changed, 15 insertions(+), 4 deletions(-)


base-commit: 9faf1244a93217775e31ed5ef3b656d4430b63e1
--=20
2.51.1

