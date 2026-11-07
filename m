Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034932;
	b=PK48btw+u7YnjWiHdLPFSIDEu/S7rNtaNJga5v32clZ+FOrhuvtF3evAWUqYRONPEtQf
	 CX30FogWFVOX+G9KoMJXbxLTLp1/XynV37EYYwcqqUrPSd5/h03ZKyGXKti6GaTv0cq5Q
	 SwoJncYbKG+VqcpwQQy7a7z5IHV8SbLc0W7mK7JFh3hUuMEWc2+rLe6jntB5a1bP3KSQk
	 PPrRw1UocI60IC5hLO9hXzcrMXqxWUE//l3w5soW9k1hdsBn1s/fylQzYvWLlRurFJHc3
	 X9xdGzjmgky4HZlTsThQkRknD/H/uTSvNnixiDcnfpnosUf8dLuNf32LhA0dnPByMKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034932;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=97JaicQ6lr0cY5yzKT/VGZLK9EZH683cGzfC+eQF/z8=;
	b=5I6G3Gnn4mIpLFue9ueIkK9pYdZuggiRUhhIzqsP3P7rhZ833ueA1Rqb4wVvsgTBSCqk
	 H3IrJgrdWjCt8ydltrYDKknBTAk0AsMsam+h7AZouPI5174aifFitwQIOCtzVPv+n4qs5
	 viwbUm8hIofcR9x1c0MXGGBAnBgj8wf9+IkDyhCHLfyhLYlN6k8Logn42M0PBQFP9HspF
	 lrgFvT5vhoJgCZwSLfxdPq/Tj0Lg/pUkY++Z9GHT7e/XZ1HE42S5bN8UXZRmMOM0rYkg0
	 Pj+w/+p7TTKin3hCpezMb+rmAzzVsEcm5AWZFO2MKKIpbRttupnqeRhA2AJ3I3W2dSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=piny3Zmb;
	arc=none smtp.remote-ip=185.70.43.102
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45A606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 07:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A45A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=piny3Zmb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794034929; x=1794294129;
	bh=97JaicQ6lr0cY5yzKT/VGZLK9EZH683cGzfC+eQF/z8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=piny3Zmb46WQVVU+nFoWCpVpQnuqjcM26Nnh7e3ZkR41TYCtMD3pUHkab3l3rIjXf
	 5KfeWGWIA5wZrqSemxt+t1kRGq0KDD1xJMIhk7maedpZyQ3KO5EgoZ6bA/s0ePp0hg
	 Y7t91Azjjd2F/53SYNdgrxScldwB6hyRWoqDUzvi8iIwaEq4gmRv8Xh2lLWIdmK77F
	 80ixsueGH26lWGT0pcwPIPqybPIZtmDdd7CT6SCQteCtxl29NAISly3V0tj3W+MnCQ
	 VoyZMQiXc25ikofJaKU8ZGdC8U6fzYX5aagH09EK0ns2KBQk28D8eHtVBC/4Hm91ux
	 kKHEksupaTz4A==
Date: Sat, 07 Nov 2026 07:02:05 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.von.dentz@gmail.com
Subject: Re: [PATCH v2] shared/asha: prime volume before starting audio
Message-ID: <MkKCLpe-N1FWGp3r556DRShdgNlt6OKJ8xkXs7na31zwB_ugopkuc8eaLwHGeiuBoXuJp7LorbhUaSKv5qbXGYefXv0u8WVhP_C7LLff6_Q=@proton.me>
In-Reply-To: <20261107010019.1162372-1-cochcoder@proton.me>
References: <20261028133131.262033-1-cochcoder@proton.me> <20261107010019.1162372-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 61fc71f311dda948cd9a475fdd3ac50e96519c6a
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

The TestFunctional failure during bearer teardown is a separate GATT discov=
ery
lifetime bug, rather than a failure caused by the volume-prime change. The
coredump shows a heap-use-after-free in discovery_op_free() while unregiste=
ring
the discovery database callback, along this teardown path:

bt_gatt_request_unref() -> cancel_att_send_op() -> bt_att_cancel_all() ->
bt_att_unref() -> attio_cleanup() -> device_free()

I sent a separate fix, =E2=80=9C[PATCH] shared/gatt-client: Cancel discover=
y
read-by-type requests=E2=80=9D:

https://lore.kernel.org/linux-bluetooth/20261107065854.2147141-1-cochcoder@=
proton.me/

Please apply that patch before testing volume v2.

Thanks,
Kyle Pepper


On Friday, November 6th, 2026 at 8:01 PM, Kyle Pepper <cochcoder@proton.me>=
 wrote:

> Prime the Volume characteristic with the cached volume before START so
> both volume inputs are initialized when audio starts. Keep the write
> best effort so a rejected volume write does not prevent START.
>=20
> Assisted-by: OpenCode:gpt-6.1-sol
> Assisted-by: Codex:gpt-6
> ---
> v2: Drop the standalone mock test and redundant failure log.
>=20
> Previous version:
> https://lore.kernel.org/linux-bluetooth/20261028133131.262033-1-cochcoder=
@proton.me/
>=20
> The unchanged local harness rejects baseline and passes this version,
> including ASan/UBSan and LTO checks. Full make check is blocked by an SDP
> debug-symbol linker failure also reproduced on unchanged upstream.
> No volume-only hardware ablation or new remote CI result is claimed.
>=20
>  src/shared/asha.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/shared/asha.c b/src/shared/asha.c
> index 79bb29bf9a..6310a8357d 100644
> --- a/src/shared/asha.c
> +++ b/src/shared/asha.c
> @@ -262,6 +262,9 @@ unsigned int bt_asha_start(struct bt_asha *asha, bt_a=
sha_cb_t cb,
>  =09=09return 0;
>  =09}
> =20
> +=09/* Some renderers require a Volume write before START. */
> +=09bt_asha_set_volume(asha, asha->volume);
> +
>  =09ret =3D asha_send_acp(asha, acp_start_cmd, sizeof(acp_start_cmd), cb,
>  =09=09=09user_data);
>  =09if (ret < 0)
>=20
> base-commit: a8067198717b38391ca183ed7f41a69ec4b81b6e
> --=20
> 2.56.0
>=20
> 
