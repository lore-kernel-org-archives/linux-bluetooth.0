Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939940;
	b=41bXgxfA38KBk8m+d+bSRqk+jaxJvcnORb/NuAJER30UBi5mGhCFDrOdFLRAmBnrasGk
	 p/vpJ8USyQolBS1zI2j+pI5nDwO/ZO3R1iBVyu4+QgIE1X41xDSCUAPrjbknpN63W0tg6
	 /lWBb7St3ErAys+7LvD4qPmt/WmVhuR4ScladoAcF6fqjXOLtLJIC4iUQMmriqu5IjQW1
	 ieXXJEeqvGr4lMmkGBaOwWoslU6psrEe/qugEY2tvMD3VtZpzd1Wmtgs6ICpDLxw8lw0o
	 u/flDkfF/n20jSc3Fv3BEvOz70auBGbTnzvHTBCxijj/HT7puOvPJY87DQfGaUrz4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939940;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=eY1+MRv5xwnoSYIarSFltFsh7hcdbhjVBAtc9lCQkhk=;
	b=JvFMFbP6FCG3qBNDRB6YU/Z5ufFRCf8PYkLOKKazcUGkjNv+t076RcMuv/hrlS5RPyQv
	 epOoHoJfQCgVkdvi46v8E1zvcRuMXvSiSmHN5d50NhdtPYJ/tl+Jgfka9/tTjZfkLtlJ8
	 xvmQm+yyaOZjSL8jQr8fZxG0j27qc2kXgnBU1h/TQM7M10flP9nOicpUd0UN3k+Lx72Y7
	 ZZE4w0ssk27gkqSdIjmbRxyjPpNkBM6yziu7mcibtiRBI4CTl0WrJZIcV3/HibAr2AyZl
	 YxOYvv5QjjH527Uz16wTgjjAZM1WFAKI0aZWK762tsnJhJecwohho7cjLfOsXjhBqBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=n4bus6m4r5ce5bmeq5bvu5kwqe.protonmail2 header.b=mHzZSQn6;
	arc=none smtp.remote-ip=185.70.43.102
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF5606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 04:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CAF5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=n4bus6m4r5ce5bmeq5bvu5kwqe.protonmail2 header.b=mHzZSQn6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=n4bus6m4r5ce5bmeq5bvu5kwqe.protonmail2; t=1793939936;
	x=1794199136; bh=eY1+MRv5xwnoSYIarSFltFsh7hcdbhjVBAtc9lCQkhk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mHzZSQn6CAlsjraSR3gpMzrZwJNhAh+qSynGX42nt2BgnAtXm28TUj9siUcsQ12pY
	 X9qSjTkUJHHlim4N2FCVK07/sZ4ti/LaTHmOTVz6VfG0oICfginUpysUZalWW85bQh
	 rcIhPD0NKK6NNRVrvuWe2N/YiGt8KOMYHOmPKyqt18paC9Jnc3OHZGahhjC3yNakLz
	 P/At366XuHMrEfSkCj4/QAvneIZMZbYvgXXaGdSIQQqrFw2RHI8EXByv122aGbA7Bq
	 dl8nnv7xXvbXiVkBRnn7JNQuOByvNCgu7Rl0V9ZW1RUPYffIOGPqDZrWXb+NpFyzMz
	 oQWgytzSVAZbA==
Date: Fri, 06 Nov 2026 04:38:52 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v3] asha: allow LE 2M PHY on the audio channel
Message-ID: <7VbZMuterf0n1CnSFuGMS17crZ2uDN_EhX3wejjJeb_RAW9bJairJbq_H3cyIhl0NsN433shqWztJrekrkoEhn96QfsUEGzlrGaprSCo7AM=@proton.me>
In-Reply-To: <20261029030037.1300725-1-cochcoder@proton.me>
References: <20261029030037.1300725-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 05494e126ce64ba2f50f31ba679c9a1169f42337
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Following up on this patch, is there anything else needed to move it forwar=
d?

Thanks,
Kyle



On Wednesday, October 28th, 2026 at 11:00 PM, Kyle Pepper <cochcoder@proton=
.me> wrote:

> Allow LE 2M alongside LE 1M on the connected audio socket before starting
> ASHA. Keep streaming if the kernel cannot set the PHY preference.
>=20
> Assisted-by: OpenCode:gpt-6.1-sol
> Assisted-by: Codex:GPT-6
> ---
> Changes since v2:
> - Drop the standalone PHY unit test and its build/ignore entries.
> - Reuse the existing test/simple-asha playback script.
>=20
> Validation: builds without warnings, 35/35 native unit binaries,
> and checkpatch pass.
>=20
>  profiles/audio/asha.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> index 8e625fd..d862247 100644
> --- a/profiles/audio/asha.c
> +++ b/profiles/audio/asha.c
> @@ -88,6 +88,8 @@ static void connect_cb(GIOChannel *io, GError *err, gpo=
inter user_data)
>  =09struct connect_data *conn_data =3D user_data;
>  =09struct bt_asha_device *asha_dev =3D conn_data->asha_dev;
>  =09GError *gerr =3D NULL;
> +=09uint32_t phys;
> +=09int fd;
> =20
>  =09if (err) {
>  =09=09error("%s", err->message);
> @@ -105,6 +107,15 @@ static void connect_cb(GIOChannel *io, GError *err, =
gpointer user_data)
>  =09=09g_error_free(gerr);
>  =09}
> =20
> +=09/*
> +=09 * Allow LE 2M with LE 1M fallback. Older kernels may lack BT_PHY.
> +=09 */
> +=09phys =3D BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
> +=09=09=09BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX;
> +=09fd =3D g_io_channel_unix_get_fd(io);
> +=09if (setsockopt(fd, SOL_BLUETOOTH, BT_PHY, &phys, sizeof(phys)) < 0)
> +=09=09DBG("Could not set LE 2M PHY preference: %s", strerror(errno));
> +
>  =09asha_dev->io =3D io;
> =20
>  =09bt_asha_start(asha_dev->asha, conn_data->cb,
>=20
> base-commit: 82667d713949447d7c94725432c61b33689ae68a
> --=20
> 2.56.0
>=20
> 
