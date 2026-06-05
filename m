Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519E3B71AD
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652368; cv=none; b=LOE5FJW4ICgHU72P0RMS7CBBssi4FlOPzMDLeAxxcUQbDTc1THKLN4dqwQWBft2uqDMtglaFhvVTCkE9p4sH8bvqrUsPJfwTMDLw53tfQDMRPp2efA5JE8vvg5S+K/PFD6gyK+KjbsmfcDFQG5EzOnoKuFVXfRZGZxvrXfLBLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652368; c=relaxed/simple;
	bh=S2uQjdEIJ6ihJf3FMB4ymJIGWk4+3ZDuuo6EwmKtin0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKeosuVrrrtW42qDaEoPPfRXLmomxVef21Cjxu2AQlN3T7MvbGjZdnOqR59qUNOLDeK5j/SG+4bdrPA9TJy++pwMnWsbzS3QJaH8oYAi5cssN5y6qTmUlFCzVXaJAVqGpYIAQPfdC84zdh41jJXy9YplOTdE11TazDPDS7nfW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 786B43EBFC;
	Fri,  5 Jun 2026 09:39:19 +0000 (UTC)
Message-ID: <72fce9d0891c39adfac228ebe213af6a62f50c65.camel@hadess.net>
Subject: Re: [PATCH v1] obexd: fix PBAP PullPhoneBook failure with ebook
 backend
From: Bastien Nocera <hadess@hadess.net>
To: Zhiyuan Sheng <zhiyuan.sheng@oss.qualcomm.com>, 
	linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com
Date: Fri, 05 Jun 2026 11:39:19 +0200
In-Reply-To: <20260522060312.1503481-1-zhiyuan.sheng@oss.qualcomm.com>
References: <20260522060312.1503481-1-zhiyuan.sheng@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTGP4ISE8PPGQgql9X0dd0GYAwyH4t0gouoz7go+aEjJbVkGvryTSU+dKTVRh6ErS+Zc0swsZnnicD2RN8i+t6Jc4jwEn1ECn0gFUJ8mcHji1ylpuDvyf7mRy+DQQrfQqqlW3VB36rMSF9fkKLzsmUU0CeXnau60SFa3pHhJAFrdghlCahnkMH4/oGHVhMK6c7WbuCgXAMnbfsvzJ0n+jZSNQsqnVb8K4cihQOIlT47u9pld4LxJ+PQQ0ks5NXiIJRq6wGliDLqHRPlcW8pqaYCzd42BoMnBtKDdQTmpRW0isV/yFyWXt70f6u9AeErj/Kz4Vace24sWR8bf6Nn/rZVgjY+5fnWQh3x4YXeq3AK5sFBSfGysDtXYNeIrS7BZClNGpO/sMR3nxEP882Gr4mqB8hPRCWZ/jtH3DaaTrgYlUCUN81VefjgpfAhoUDsw34HrA/rpkhqOVW/3bs/tU8xLQXjdErKe0x7l4Sjz8i7OiKZuh7UGjWlnoMw8HHWyP6te2tw9pTEpkiN2/yVtL44/Zx4Z2Rr9fKP1aoJwXpZvPuxWBmpGe1RnfX9cp9nb8SwNov3EPXUrrBr5NSHbAU+GWDgV9xqHkbh7C5N2XKWXZ6IwrPOUw+9aAAejIdzsFhPeVkzg1QlMDWtKoYetdIelYBU7tXVvQTTOWWPmRpW4vw
X-GND-State: clean
X-GND-Score: -100

On Fri, 2026-05-22 at 14:03 +0800, Zhiyuan Sheng wrote:
> phonebook_pull() in phonebook-ebook.c does not set *err =3D 0 on the
> success path, unlike phonebook-tracker.c and phonebook-dummy.c. The
> caller vobject_pull_open() in pbap.c declares 'ret' without
> initialization and passes &ret to phonebook_pull(), so 'ret' retains
> an indeterminate stack value when the ebook backend is in use. The
> subsequent 'if (ret < 0)' check then incorrectly triggers and rejects
> the request with Internal Server Error.
>=20
> Fix this by setting *err =3D 0 on success in phonebook-ebook.c, and
> initialize 'ret' to 0 in vobject_pull_open() as a defensive measure
> to guard against any backend that omits this assignment.
>=20
> Signed-off-by: Zhiyuan Sheng <zhiyuan.sheng@oss.qualcomm.com>

Looks good to me
