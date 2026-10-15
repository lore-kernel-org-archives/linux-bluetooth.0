Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB2389455
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030163; cv=none; b=dOABThsGgd7nqQvHo7Ha/NYSB6CXQWK9/CPApEsWAcTT9SvxOkp2PbsGV8gA3Ahzn+BFZ7aqXxc0Z1CPC55u6Kns8QJ+8PuIIbvKpjd5C4zbRP8h/GtkQ0ETuoIYAHjFJXgU7y73Qe4eziAHZgwIE60jQTcWzI2xSPWVYQFKkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030163; c=relaxed/simple;
	bh=H7osc969JUWG05A7nLZ3bxXyPCU2p/+wGT+fLzoynqQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhfJzmIlSzwoXAWUbGW4qtk8EuRO+USegK6Om2HdJdHj+WPWE75LVR/PGhg0eMj6MLD4v06l/qFCDj6465Bxm/RmVmlQC07EiWec48Vah8LrCQTZV978S9bbxol3XsUCHwuBKey8IKLJlDXVNXZofgGxQhw1qK6y5PGESzTOERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lLmyAwii; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lLmyAwii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vfay463jnfgrflj2ev32476xam.protonmail2; t=1792030155;
	x=1792289355; bh=DjQHbEnxIKHSj3itqAaOQQwbzMHyr80N8XVROLA4Pyc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lLmyAwiiLZjZ4NoT35EfbO7xzqzfP4wFwd+qMwEf0asiUrbHRCzW1L7T1b/sJglhb
	 zC8TdRk5bx4Na2iasylqQXLnnUwl0nqF7wc2p9aPC8Mim6GR9SNDNHl97aAmxMpzvj
	 fvH8dzbxsX8kW6S8vDd1/jb6+oBtB3ec78ZXBsrOKcIdA0UvH/D57kGeBOUnzhGyBq
	 ab9gKpH4HuAMrcDwxaFXXmKdD7Igom0gyXA8hOt+CysihZOnsPI57eMzxRiTFds3RZ
	 09o7W7qrHWXKttzCDgoiRj5LG6Qz7IYSWxKqrlhaZMGWfz97I9bA6VVTrMiSmkYl3n
	 ACjgPue43INiQ==
Date: Thu, 15 Oct 2026 02:09:11 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [RFC PATCH] asha: use robust streaming connection parameters
Message-ID: <piGlAxO80fGQRZLeNSgnYAuRVOIeoah6uOuK7BF4UyAhod5CP4zCYeUb_bMc8h26E0hvBsoCFJb5h6MIZF6jjRD_GZ3uey56ZK0I0tCnQXc=@proton.me>
In-Reply-To: <20261013035111.522738-1-cochcoder@proton.me>
References: <20261013035111.522738-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: fe685d350d9966aa352a7c665442d369b8392b2a
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Could the failed TestFunctional CI check for this patch be reran? The match=
ing checks pass locally.

CI: https://github.com/bluez/bluez/pull/2667



On Monday, October 12th, 2026 at 11:51 PM, Kyle Pepper <cochcoder@proton.me=
> wrote:

> The tested renderer requests a six-second supervision timeout and
> latency of five events. Use these values instead of the one-second
> timeout and ten-event latency that accompanied link failures.
>=20
> Assisted-by: OpenCode:gpt-6.1-sol
> ---
> Submission review notes (not part of the commit message):
> Local validation is for base 7428ca2df9356363079db0f48412c20cbdb9471f.
> Compatibility with newer upstream tips has not been verified locally.
> October 9 N8/UB500 trials independently restore timeout 1 s and latency
> 10. Completed HCI values change as intended; the variants have five and
> four supervision timeouts respectively. Restoring latency 5 / timeout 6 s
> restores short streaming. These are device-tested values, not universally
> optimal ASHA defaults. STATUS and the other downstream fixes stayed on.
>=20
>  profiles/audio/asha.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> index 8e625fdca3..409b4f20b5 100644
> --- a/profiles/audio/asha.c
> +++ b/profiles/audio/asha.c
> @@ -50,6 +50,9 @@
>  #define ASHA_MIN_MTU 163
>  /* The default of 672 does not work */
>  #define ASHA_CONNECTION_MTU 512
> +#define ASHA_CONN_INTERVAL 0x0010 /* 20 ms in 1.25 ms units */
> +#define ASHA_CONN_LATENCY 0x0005
> +#define ASHA_SUPERVISION_TIMEOUT 0x0258 /* 6 s in 10 ms units */
> =20
>  struct bt_asha_device {
>  =09struct bt_asha *asha;
> @@ -162,10 +165,8 @@ unsigned int bt_asha_device_start(struct bt_asha_dev=
ice *asha_dev,
>  =09int ret;
> =20
>  =09btd_device_set_conn_param(asha_dev->device,
> -=09=09=090x0010 /* min interval =3D 1.25ms intervals =3D> 20ms */,
> -=09=09=090x0010 /* max interval =3D 1.25ms intervals =3D> 20ms */,
> -=09=09=090x000A /* 10 events' latency */,
> -=09=09=090x0064 /* 1s timeout */);
> +=09=09=09ASHA_CONN_INTERVAL, ASHA_CONN_INTERVAL,
> +=09=09=09ASHA_CONN_LATENCY, ASHA_SUPERVISION_TIMEOUT);
> =20
>  =09ret =3D asha_connect_socket(asha_dev, cb, user_data);
> =20
>=20
> base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f
> 
