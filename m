Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65B40DFA1
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844883; cv=none; b=EtmNsdh76MYgxDaPZFjc55ndxu/tyilF+2bC7aY3fKPri8MPIGWxofs7LlwWqrb05FE3teVR9NsPaGaA852VlPFtjtZVA8TUurpoUwA2At7lqitWP8PLPZM+Nhqh75PmWadqbJ5SToUy+OMTBPnMdHQaAPq5WzRQPPpf4VxvnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844883; c=relaxed/simple;
	bh=9M/g6QZdgJpqlqr0lp7IEXJTwEwGTRpPrFZ6LOPZW0A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TZJShf+YHFQUjQRapPRt5ZBRZiE3rvo9+TtJ9nob1fUVXS3zcFDYJS7G58iIhpaEIouWxofTt8EKFJhLfGCJCj+CTdoUGE3vHGmC5GEnOnZT83J+/LhMLjJ9r9HBZNDhDSy3J2Q8k9m4zxRyTDI1GxaWL5vhwAL9MK3h4y8hABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4CCA3ECA3;
	Wed, 22 Apr 2026 08:01:13 +0000 (UTC)
Message-ID: <93591251ab13408ba014fff8b9bcfc171893e232.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1] input: Fix checking LE bonding on HIDP
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 22 Apr 2026 10:01:13 +0200
In-Reply-To: <20260421202253.1957689-1-luiz.dentz@gmail.com>
References: <20260421202253.1957689-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFdorJH9N1TuHcLpSFwAcDVjPrUw/BRaToody3tsQaU5UK3XZlOPuGtrfTh4y7xG1/L48/KzRKbxY7Q3Oxf3JUGwG/amlYa8biAHOU7YWL0o36dy/rg9HjPo13OZtiEqIK493NfWomOmUxUM8Akhumqft3nmYUEJERoDPwEw8JXK7OuAD+Lg3t1ILZSeVjp11HfvX6+/yVxjdRB48ECpiK6NTXTbY0gSj0sNo41gYQM6Sj72V9XpneGyPfpExyOpwca9v0VY8m5wQYGDtYUmbfUNL5GaH2/EKXwdkWI8mqfrL08R10BefmSbXx/4yktqm9mUIaAB8rcHDkbwmlJm+PGGtph6GpGTRrn37oaEjlRHP5/XZ6GrFzBNPTHL0dAcite6+//DENcb5nd+ERhygVLCJ4giwXrhnEu5AmA5g1lZGfn4INEX+qnilWer88D6Dw7liKLLlwXlVdG91m2b0BX86c7NYf9FGOuzWAwckbUUbj6jiGCF+RG/isBvV+Pr9N2IYOMLmOdHq7ivkcxBVc4I4Adp6hxJo4/XVwWweIIshwFG/qstycqx5u/CAj/jnDF9IlkUbuayW+Va2nEDQbta2tm6uerv8gFw9Gx2f5brSjExtLLi7WPNASoKIUJqCnNwkPYY/v+ZPK6N3WdIDFiAm+ry5j/bqVaLuoII0/18Q

On Tue, 2026-04-21 at 16:22 -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> HIDP is classic only, LE uses HOG, so there is no point in checking
> the
> bonding with the address type which in case the device supports
> dual-mode will map to LE random/public address.
>=20
> Fixes: https://github.com/bluez/bluez/issues/2034
> ---
> =C2=A0profiles/input/device.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 6bdc5ee3aaf3..0ee6988c4e90 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -127,8 +127,7 @@ static int connection_disconnect(struct
> input_device *idev, uint32_t flags);
> =C2=A0
> =C2=A0static bool input_device_bonded(struct input_device *idev)
> =C2=A0{
> -	return device_is_bonded(idev->device,
> -				btd_device_get_bdaddr_type(idev-
> >device));
> +	return device_is_bonded(idev->device, BDADDR_BREDR);

Do we want to do the same in virtual_cable_unplug() in that same file?

Do we also want to apply this to hog_accept() with BDADDR_LE in
profiles/input/hog.c ?

> =C2=A0}
> =C2=A0
> =C2=A0static void input_device_free(struct input_device *idev)
