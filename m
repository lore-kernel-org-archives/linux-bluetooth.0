Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF93EDABD
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948243; cv=none; b=Kw6nodCH9ymdNpnwJavM/KUQzFgXFrqJEHKTkKuE4+LLavHrY6o3g5preqzGaM517a+YTSaundzJsbD70Jkmovq/ETViwpOz6aJk/CG0eG6xV486aTOkAzuOjVLrA6gQAuyY7BUhs7zcRmG/hHHi2v+O4yYC7NOwYulja7+z1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948243; c=relaxed/simple;
	bh=XqGgeNzDxICnbRDt18oYxRxDtvwVzjay+VfqgULbtoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvlLaXravwWPzFDHxiKM+9jTl2hpAU0iU3OaK6GIT3LwMn/u4mtDtPEYmRZ+AqF4RNZAYX1y3xyjpAtwzTas3Wgy04PULZErbaiQXEPZ+TiPAUPaMPWEO4YL0pFOAv0Lffv8M3JZr5B1i4UFmMlCi6AqdHkXrajIl4GOAS69T+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59FFF3EC19;
	Thu, 23 Apr 2026 12:43:54 +0000 (UTC)
Message-ID: <9fe0ba616226321d27564aec3a0d872d569781c8.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2] sixaxis: Fix pairing Esperanza EGG109k
 controller
From: Bastien Nocera <hadess@hadess.net>
To: Marek Czerski <ma.czerski@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 23 Apr 2026 14:43:53 +0200
In-Reply-To: <20260422212045.1325603-1-ma.czerski@gmail.com>
References: <59197f235800db69549ec163391ac1ac1f1ffe65.camel@hadess.net>
	 <20260422212045.1325603-1-ma.czerski@gmail.com>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTENnhb9C+KfsNhiicZZbQ+WGBFMDqxgJEVbRWvODCmAuxZnZC1MYenkzf3ONMj+MBFlueEx7M2AbpZ9AWlLMsYqho4oqqEh4Qbh3dFldMiB6uBHOHeW4H0VY9hR+BUv5UstVuaLUZmGQFmVN3srhCsR8NI6eaDdPKfQqHGsaeexcGgYtqkMwmActQIzFHyaNCar/e/swgpf/Pb7i7bf2De0AGsRLWENUDeP8SEBqgrO6VkBsG5WnyzOaoHMVi18/knClMqHt9pMiI+WEqDEbIx2PsWL6xVjO+mpCyR58IU5Y+H1yFkRJriiZqnwKaTTC53Q7unMKDkq5QGsxZtDTCWqo5EaRGbmnrLGePTx/UFE+VT4zNknFKuZ4G0QIy5yd3UP6p1FOONNmJZ+CeQrMFSJKFvHhDBGrYjl13iCtyp9hWG4zWoomBie/Shb41Ww8W3on71maXSarR5mmF0Itv8jVZ1N8mbSFRH5waireAphvg8JADaXRDuYrEMAt1VSP9b8YFjV0njnhxrdmdscNEBxnWb/Y1mpZeqNfhX3vkwSkded/rszJlApa3V8tBr5NVzF887pebe2ZBtOHvp6M8W2p5p4BdtW84k2zw8EHuH8HtNZnfVkG8MO3dva5zNTjKbGVG2v8kxK9LTfmuPv3eYzCPZABYNpmbjoGXjijq8Oig
X-GND-State: clean

Looks good to me

On Wed, 2026-04-22 at 23:20 +0200, Marek Czerski wrote:
> This change is required for Esperanza EGG109k ps controller clone.
> EGG109k looks like PS3 controller but presents itself to the system
> as PS4 controller. It does not respond to 0x81 command.
> Command 0x12 contains both the device bluetooth address as well as
> configured host bluetooth address, so it can be used to query
> both. Kernel driver hid-playstation also uses 0x12 command for that.
>=20
> Manufacturer link:
> https://esperanza.pl/esperanza-gamepad-bezprzewodowy-ps3-marine-czarny,17=
6,1701.html
> ---
> =C2=A0plugins/sixaxis.c | 11 +++++++----
> =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 27bc09815..a04a76d39 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -39,6 +39,9 @@
> =C2=A0#include "profiles/input/server.h"
> =C2=A0#include "profiles/input/sixaxis.h"
> =C2=A0
> +#define DS4_FEATURE_REPORT_PAIRING_INFO		0x12
> +#define DS4_FEATURE_REPORT_PAIRING_INFO_SIZE	16
> +
> =C2=A0struct authentication_closure {
> =C2=A0	guint auth_id;
> =C2=A0	char *sysfs_path;
> @@ -111,12 +114,12 @@ static int sixaxis_get_device_bdaddr(int fd,
> bdaddr_t *bdaddr)
> =C2=A0
> =C2=A0static int ds4_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
> =C2=A0{
> -	uint8_t buf[7];
> +	uint8_t buf[DS4_FEATURE_REPORT_PAIRING_INFO_SIZE];
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	memset(buf, 0, sizeof(buf));
> =C2=A0
> -	buf[0] =3D 0x81;
> +	buf[0] =3D DS4_FEATURE_REPORT_PAIRING_INFO;
> =C2=A0
> =C2=A0	ret =3D ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> =C2=A0	if (ret < 0) {
> @@ -163,12 +166,12 @@ static int sixaxis_get_central_bdaddr(int fd,
> bdaddr_t *bdaddr)
> =C2=A0
> =C2=A0static int ds4_get_central_bdaddr(int fd, bdaddr_t *bdaddr)
> =C2=A0{
> -	uint8_t buf[16];
> +	uint8_t buf[DS4_FEATURE_REPORT_PAIRING_INFO_SIZE];
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	memset(buf, 0, sizeof(buf));
> =C2=A0
> -	buf[0] =3D 0x12;
> +	buf[0] =3D DS4_FEATURE_REPORT_PAIRING_INFO;
> =C2=A0
> =C2=A0	ret =3D ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> =C2=A0	if (ret < 0) {
