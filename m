Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4D3C3BFA
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311507; cv=none; b=ZaS3icdW/90EAIC90sU7H05dFYnlOjoyZMgIyshe5sgWMbuloew35aDY4SnHazrb1bh/yymvQjOymbUbl8GfBMmIehKCnRU5aqog7G9Ev5OGcQ1PA4ewwUyE7QHHlSL99oJC/YXSGeB/aRbpr3LkrvTIKpjHaTI+CS0rgvJygU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311507; c=relaxed/simple;
	bh=ig9oLUxmRnO+70c8qEM2wcAAJt7WVLIifjRLCEV4kjw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AtyNa4Ace7TMhhi0zWlHbMJy4vMjw6K+GZkUNTQzl8MBOESqpmPiW44E+Y0nGv3XWM68iLMOhwxoDELP2DK5ILP/y1vManw1BUIEnOS7hMg7l3f6J5HOpM79URbZ/pqihzkR6hw+5KKs1h63OMZGuyAjgG7F5sw8x80NmA6qC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E68CD3EDE2;
	Wed, 29 Jul 2026 07:51:37 +0000 (UTC)
Message-ID: <7e887551e24d1e16c9ad8bbd2305ff1318fd7db4.camel@hadess.net>
Subject: Re: [PATCH BlueZ bluez] bap: fixed the return value of GIOFunc
From: Bastien Nocera <hadess@hadess.net>
To: yang.li@amlogic.com, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 29 Jul 2026 09:51:37 +0200
In-Reply-To: <20260729-fix_iofunc-v1-1-653c8e9ac29a@amlogic.com>
References: <20260729-fix_iofunc-v1-1-653c8e9ac29a@amlogic.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEFly99vOX8lSMTAZj4ORJAOinL89WWVr2ojVhQ9F8aQ0ZNtEUwN5V5eM2wPfNw6Ev+wIYpBrDPdFnXqx8D4RuAlgqT2zcsJj2a7iaffzg4D1hgXQLAwfZomX7uGJeUhSdk8hD5l1naw/M9/kF7/FJQFf5NXG39jAeV15h4u0V8zjct2NR1ZbBcrG1ffdOFleMpD7Q6fWIaAEDPVwbxx72tcSXBEWjAO0DtU21QRZjJ4AAmDq0bC1ZeVAJAfGTfHMhOq5UYN4HzpCqh2c/NpelrA8Q7HVI7XYIL/ZZaGkE4ZF9AyUx0sZRKjP8lMCuy4vDFoAKcNI0OI2sjEjoJzyXit1XGRJDwhHD7fIQ/OFXZFoLm59do2SVioa+smfyy9AhuGqdB67NuyHKj9WZVbNUHIxoFYuA+PYi4Oikawrd3Rox4iNkxslSDWhUq2cUpt03SX7K5K5iwUwwZDdmpMNDNwnW4/De7zxCeGJL12P+23Q4AkQirWQRcJDCAvqUYFzMTCXgtkFuxI7F5IQHDCupzpPWnZEUxfQmQIlxirX6z6coG8B1bXUg3wbfRl9Bh3Q922GhHsYUP7ogL6DZjg4smkPENPMJoy2XDSVwRrQHA/9pogBN9Qg+3XwuMPoFSRe0wokmnr2F3OZo/QBi0JEMaHTOpmYVnv/mJvET0QnZPQg

On Wed, 2026-07-29 at 09:47 +0800, Yang Li via B4 Relay wrote:
> From: Yang Li <yang.li@amlogic.com>
>=20
> The GIOFunc should return FALSE if the event source should be
> removed.
>=20
> Fixes: 322c39a64 (bap: Start BIG sync after receiving BIGInfo)
>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>

Looks good, thanks.

Although I would have still preferred G_SOURCE_REMOVE which makes it
clearer what it does.

> ---
> =C2=A0profiles/audio/bap.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 473e4cfc2..ff8f58a12 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -3683,7 +3683,6 @@ static gboolean iso_do_big_sync(GIOChannel *io,
> GIOCondition cond,
> =C2=A0			BT_IO_OPT_INVALID)) {
> =C2=A0		error("bt_io_set: %s", err->message);
> =C2=A0		g_error_free(err);
> -		return FALSE;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!bt_io_bcast_accept(io,
> @@ -3694,10 +3693,9 @@ static gboolean iso_do_big_sync(GIOChannel
> *io, GIOCondition cond,
> =C2=A0			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
> =C2=A0		error("bt_io_bcast_accept: %s", err->message);
> =C2=A0		g_error_free(err);
> -		return FALSE;
> =C2=A0	}
> =C2=A0
> -	return TRUE;
> +	return FALSE;
> =C2=A0}
> =C2=A0
> =C2=A0static void long_pa_sync_confirm_cb(GIOChannel *io, void *user_data=
)
>=20
> ---
> base-commit: 729f96089cf66831d911385623ca932e0c245913
> change-id: 20260729-fix_iofunc-e62cecc52b8e
>=20
> Best regards,
