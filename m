Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCE39DBF2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333886; cv=none; b=rRUpLrflSnVYm59/eg8lvD6xOYisDYfrGMHzN0Qd/BTQPde0wNlL7X+ioC5RIdF+pxGjUMXW7ANl1SBxmUKBsgVSXXXRsRGdKmN2LVbzc1WIOfqnD4+MMQ8RjAe3nK/PPv0v5CslHA5D52vQL21G15xPKpsIZufI09hnM+mK1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333886; c=relaxed/simple;
	bh=Fg8HWTLy5dcLcL8qhMSZksYtyL5MVvyeIOP5HhwFdCM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8fUIHya6z8/MWrEu8ZZLhUuLB9hLgAzPlAGlAHKupgFEsjd3gizs+e42P6lcn0Yu4Z+Yor3qBLp61F3XW6mRRsm6hID2hFNrWEGuc6mbfvs7a2S5R7z38BUFHg/ZFGYs0rkoyoPZQ7raFXVx8I2ZGOBCPcS1Q/YkWzoR+hY7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 482F9581572
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 09:57:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A0CA3EC02;
	Thu, 16 Apr 2026 09:57:26 +0000 (UTC)
Message-ID: <59197f235800db69549ec163391ac1ac1f1ffe65.camel@hadess.net>
Subject: Re: [PATCH BlueZ] sixaxis: DS4: use 0x12 cmd to get device bdaddr
From: Bastien Nocera <hadess@hadess.net>
To: Marek Czerski <ma.czerski@gmail.com>, linux-bluetooth@vger.kernel.org
Date: Thu, 16 Apr 2026 11:57:25 +0200
In-Reply-To: <20260404123042.3049158-1-ma.czerski@gmail.com>
References: <20260404123042.3049158-1-ma.czerski@gmail.com>
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
X-GND-Cause: dmFkZTEcIEluE6ogQIUxAxtxovZBGf5RmU0tGjhswUkM9MRvMoKu+xgCINs9d7R49O1uOJzh54hDtsTPnaCR3UTEff90aKR+a2Owb8mBIzCpZmTPxIPfL6ZGGJiOlLUTeDW0glYNYvwOOOknWa+e/uWg5smqZdiTQc5IqpWCOLeM/FR2nqt7gFraAAgCGRGIlsStNhyXrhM/q8OSBWj6KQdmNqHmDExlD714UWutqBIbaWgb5uzAWWcrIdbL+92+2u8s78OY0fbnGHGMKQxSf9vrWg3VuyIcHyCof53bP9TrcP3yRg+FesRnVNdi1klWiA56ejAah0p+C6uPnFr2tn0hKjDeqs7t0+AXQFGFNEPSNUZDBhPa1MB+3iEVIPn/cSBYuCFuOjzlRWc0Zwt6OUi2nvlnUtcK5vj5yvWowRuD3fff/ZgPjp2DMJaMfno65EqdeslB1n9uL2zrpHaRFYI1GQjQDzveBaUFAEADW2LBTPgdmiwjs7VUHqo5x3TVhcxbSTGdJDrlIul/Ogr9l6BtS66P4TluAeABS5uUb5vgLDv29NG2ZxaJs6l29orKKrwR0hnwi+KCalcViza/0U8wFvXrKbpXr6921yAjalb+bhnUOXS7RlytsLzrL3AOl6FHgrpby0b3z10bs0C1d/yMOLq1oSPocgN/ZlLlFyk0ktaWIw
X-GND-State: clean
X-GND-Score: -100

Hello Marek,

Some comments below.

On Sat, 2026-04-04 at 14:30 +0200, Marek Czerski wrote:
> This change is required for Esperanza EGG109k ps controller clone.

This should be what's mentioned in the commit subject:
sixaxis: Fix pairing Esperanza EGG109k controller

> EGG109k looks like PS3 controller but presents itself to the system
> as PS4 controller. It does not respond to 0x81 command.
> Command 0x12 contains both the device mac address as well as
> configured host mac address, so it can be used to query
> both. Kernel driver also uses 0x12 command for that.

You should name the kernel driver (it's "hid-playstation").

Note that despite what the hid-sony driver says, it's not a "Bluetooth
MAC address" or mac address, but a "Bluetooth address".

I would also include a link to an online store or product page for the
device, so folks know what it looks like.

> ---
> =C2=A0plugins/sixaxis.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 27bc09815..8e212ee71 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -111,12 +111,12 @@ static int sixaxis_get_device_bdaddr(int fd,
> bdaddr_t *bdaddr)
> =C2=A0
> =C2=A0static int ds4_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
> =C2=A0{
> -	uint8_t buf[7];
> +	uint8_t buf[16];

This is a good opportunity to copy the constants from hid-playstation:
#define DS4_FEATURE_REPORT_PAIRING_INFO         0x12
#define DS4_FEATURE_REPORT_PAIRING_INFO_SIZE    16
and use those.

> =C2=A0	int ret;
> =C2=A0
> =C2=A0	memset(buf, 0, sizeof(buf));
> =C2=A0
> -	buf[0] =3D 0x81;
> +	buf[0] =3D 0x12;
> =C2=A0
> =C2=A0	ret =3D ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
> =C2=A0	if (ret < 0) {
