Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C1345CCD
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470683; cv=none; b=dAD/ppjMkrjpQ4vOKjAnFXzPct4t3sSdhqKyZTXLrhdwKQXCefLjGTXZYaJsA/mvS74dLz827pZMZ3YDsgUV8U41kshfUjSK6rg4tZr7ildna+4uklFzrEDsNIqDitXwkvfnvPsCj8xTZL7iLpjJYLLnOFsDvvztJYTKVadbEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470683; c=relaxed/simple;
	bh=QoUIyUpECYdrRIRdbFzVFzDumAmHkiYJshybEuKYSiE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1qxtNZv49Y9NlyNzhRvZXiggqDAAtvjDpKcZcVy+w7hHs2nCVgoPSsYJSfmf7uwT2fR8DbUD5MWCFETjNcCBF1hqp3xsbwiRlPvVLA7OliKEdZRntD5FWzRYG1mZPXa4HRm9FTGNxEwB3HF7RAFwkD8kAq8bl8Fe9ZrAL4rG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9EE23E97D;
	Thu,  3 Sep 2026 21:24:38 +0000 (UTC)
Message-ID: <361381856ecdf141a801762ed7d4f3a2d7520494.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] btattach: Update for glibc 2.42 compatability
From: Bastien Nocera <hadess@hadess.net>
To: Aaron Brice <aaron@embeddedts.com>, linux-bluetooth@vger.kernel.org
Date: Thu, 03 Sep 2026 23:24:38 +0200
In-Reply-To: <20260903182709.473976-2-aaron@embeddedts.com>
References: <20260903182709.473976-1-aaron@embeddedts.com>
	 <20260903182709.473976-2-aaron@embeddedts.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTEMWv8f+Fr93SvE8+OuYChviTJHVz/izN00ogoV6HQ8zu3NAHCzdPaWpH1GOtGlBd2kHffDLaMD6V7E/zk/wjwWWOhjCfnG8nqHTdlGZVVwuzqQrFDsC90jilgFTIF1XREYnUuP0LK+ENrHgMv/44rWIEw1y8gp9GumRB7D8mjEd7EpU2Eaoqcj8zs4d22pLeM1h2VO4bSuTHAAF6YblwOw4UxrPuhEyVbCTIHhBedAzUAlJozR+cFTlonUcb/QNJ7asTiMvsRbEOrLONe+A1Axqg6R8gGPa7zJtNnuaeBBChzWXycLS3WQ6BV++Ar0fZ09kryGpJJxFJe8EB3gpRrpQHsCzwptgPmTUgQwrz0tGeBH3hUH054Nki2QdN5GpmeiNckg083bfH7QKDmwcvtn+eQUOofK6n5/bdTdRGL4Nxmnmybt/MCO4tzRIPSnzxhnF3QaRMQbFpaKyXAfO0mj/LBYr6heD4Qlr/zOp6ZfpXSfRp1LikKjSZ9coOPsDtjyjr0MBWJJdY0ihzv+D1pIiwqY3EtgVFvPcqA5WeV6TW0/NXPPrOLOLTxlDfUE1IeJitrSOMl0aW0wrxrqpu34pD9VDIxTDwRgd2xngBsaIw6F7Iry0Cz7tFdw/wmVWh7CHjkCVRXvlJYmJQgBIECfVIdX/50bV8f3kvFcEkMYbw
X-GND-State: clean

On Thu, 2026-09-03 at 11:27 -0700, Aaron Brice wrote:
> glibc 2.42 baud rate constants changed, use cfsetspeed to be
> compatible
> with newer glibc.

The explanation in your cover letter, which will not be committed,
should be in your patch's commit message, which will be committed.

Cheers

> ---
> =C2=A0tools/btattach.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/btattach.c b/tools/btattach.c
> index 5f7d19093..cdd7b125b 100644
> --- a/tools/btattach.c
> +++ b/tools/btattach.c
> @@ -64,7 +64,12 @@ static int open_serial(const char *path, unsigned
> int speed, bool flowctl)
> =C2=A0	memset(&ti, 0, sizeof(ti));
> =C2=A0	cfmakeraw(&ti);
> =C2=A0
> -	ti.c_cflag |=3D (speed | CLOCAL | CREAD);
> +	ti.c_cflag |=3D (CLOCAL | CREAD);
> +	if (cfsetspeed(&ti, speed) < 0) {
> +		perror("Failed to set serial port speed");
> +		close(fd);
> +		return -1;
> +	}
> =C2=A0
> =C2=A0	if (flowctl) {
> =C2=A0		/* Set flow control */
