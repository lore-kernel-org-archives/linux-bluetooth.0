Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A5653
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545634; cv=none; b=UNaMOtzhK8nBsWed+/syIYDEBiSHYiiRx8uOY9ZU+HB55GG/fFFGWuk4iM/oOqxSmfH3fuquqMHVHRZku4+/KPIw0rF+hbtiw/5dgMv5UQdj5r9SD9MgFgk96fSK1kUFTFJNF85pDzMN9vcCKOhnjVlT3YUal/O/G8Cu3jo71RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545634; c=relaxed/simple;
	bh=WNpimCh9XJPzy6P5oh0eZOzYHFfBq6uYcUFoz2VfavU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EMQqGxuFPJ/gu3InyaeVWMRTFi49Pu0j0fhKCuvaHXjPWmRci55DqmgyoLblanlpxqu8jaYuSHmZh4ukOYIKGaAEJLWEB/nKnbsDrQIpyt6wICf12706b/GOXBowtojYGQ+UMN8SeKeS9Sav5/adqwxMkI5ICSDhTQuqmpf4ZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36B3CC0005
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:33:45 +0000 (UTC)
Message-ID: <2fa19c107c457eb60867c2c08948895694fe1489.camel@hadess.net>
Subject: Re: [PATCH v2 0/2] device: Better "Connect" debug
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Jan 2025 12:33:41 +0100
In-Reply-To: <20250122113103.1106793-1-hadess@hadess.net>
References: <20250122113103.1106793-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

Forgot "BlueZ" in the prefix, please ignore.

On Wed, 2025-01-22 at 12:30 +0100, Bastien Nocera wrote:
> Changes since v1:
> - Add client-side error decoding
>=20
> Bastien Nocera (2):
> =C2=A0 client: Add client-side error decoding
> =C2=A0 device: Better "Connect" debug
>=20
> =C2=A0Makefile.tools |=C2=A0 2 ++
> =C2=A0client/error.c | 37 +++++++++++++++++++++++++++++++++++++
> =C2=A0client/error.h | 11 +++++++++++
> =C2=A0client/main.c=C2=A0 |=C2=A0 5 +++--
> =C2=A0src/device.c=C2=A0=C2=A0 | 36 +++++++++++++++++++++++++++++-------
> =C2=A05 files changed, 82 insertions(+), 9 deletions(-)
> =C2=A0create mode 100644 client/error.c
> =C2=A0create mode 100644 client/error.h
>=20

