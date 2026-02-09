Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993426ED48
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770673068; cv=none; b=uEKB4LNWuAcm4YYky0GbYYMFnTWDF2McXjysA+BcMYsfuhkujttjfguvVqWyRP/MxWXxpTGQDLX8DC2AtTLhVseTYLdOP/c64C2IzVcK9fQ8loEZYfJ1kvUyd9hJW2oFy7khbyZeNxSGx3A/JHXL2Vja+dZRoBrEJWTY3YJXiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770673068; c=relaxed/simple;
	bh=4u4OOSkdRkmTDkt7iUi9Yp3ijCvx3bpj5IvAAlczQTs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvupBWr0jbstlzs/n430WtLuu8WoErN3kSNIx326/9i1BAPIgEPmBRpC++PzIgBmSA/eYv2lJ03I3Pae3Gl6Mat078SmsfWdjVPPhyf7xAseE6puwQ19TuqVhJ0gIy02Zr0c8G+whu6/QyfnpXmm6ViwZj/Og9yDjU0Zhi3lRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=fail smtp.mailfrom=iki.fi; arc=none smtp.client-ip=185.67.36.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iki.fi
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D007E240103
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 22:36:35 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4f8ygl016Yz6tvx;
	Mon,  9 Feb 2026 22:36:34 +0100 (CET)
Message-ID: <8e576f35b6279255c1eed099c1142625c53a6be5.camel@iki.fi>
Subject: Re: [PATCH BlueZ 2/2] emulator: Fix compilation on big endian
 systems
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Date: Mon, 09 Feb 2026 21:36:35 +0000
In-Reply-To: <20260209203316.3050687-2-hadess@hadess.net>
References: <20260209203316.3050687-1-hadess@hadess.net>
	 <20260209203316.3050687-2-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-02-09 kello 21:33 +0100, Bastien Nocera kirjoitti:
> Use new helper macros for byteswapping constants.
>=20
> This fixes the build on big endian systems like s390x:
>=20
> emulator/bthost.c: In function =E2=80=98bthost_setup_sco=E2=80=99:
> ./src/shared/util.h:43:26: error: initializer element is not constant
> =C2=A0=C2=A0 43 | #define cpu_to_le32(val) bswap_32(val)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~
> etc.
>=20
> Fixes: 85888a8357ea ("bthost: add bthost_setup_sco() and accept
> incoming eSCO")
> ---
> =C2=A0emulator/bthost.c | 16 ++++++++--------
> =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/emulator/bthost.c b/emulator/bthost.c
> index d09ad1e76c50..37865f61bc52 100644
> --- a/emulator/bthost.c
> +++ b/emulator/bthost.c
> @@ -3562,18 +3562,18 @@ int bthost_setup_sco(struct bthost *bthost,
> uint16_t acl_handle,
> =C2=A0{
> =C2=A0	static const struct bt_hci_cmd_setup_sync_conn settings[] =3D
> {

Removing the "static" here would be another way to fix it, as it
doesn't really need to be static here.

> =C2=A0		{
> -			.tx_bandwidth =3D cpu_to_le32(0x00001f40),
> -			.rx_bandwidth =3D cpu_to_le32(0x00001f40),
> -			.max_latency =3D cpu_to_le16(0x000a),
> +			.tx_bandwidth =3D
> cpu_constant_to_le32(0x00001f40),
> +			.rx_bandwidth =3D
> cpu_constant_to_le32(0x00001f40),
> +			.max_latency =3D cpu_constant_to_le16(0x000a),
> =C2=A0			.retrans_effort =3D 0x01,
> -			.voice_setting =3D
> cpu_to_le16(BT_VOICE_CVSD_16BIT),
> +			.voice_setting =3D
> cpu_constant_to_le16(BT_VOICE_CVSD_16BIT),
> =C2=A0		},
> =C2=A0		{
> -			.tx_bandwidth =3D cpu_to_le32(0x00001f40),
> -			.rx_bandwidth =3D cpu_to_le32(0x00001f40),
> -			.max_latency =3D cpu_to_le16(0x000d),
> +			.tx_bandwidth =3D
> cpu_constant_to_le32(0x00001f40),
> +			.rx_bandwidth =3D
> cpu_constant_to_le32(0x00001f40),
> +			.max_latency =3D cpu_constant_to_le16(0x000d),
> =C2=A0			.retrans_effort =3D 0x02,
> -			.voice_setting =3D
> cpu_to_le16(BT_VOICE_TRANSPARENT),
> +			.voice_setting =3D
> cpu_constant_to_le16(BT_VOICE_TRANSPARENT),
> =C2=A0		}
> =C2=A0	};
> =C2=A0	struct bt_hci_cmd_setup_sync_conn cmd;

--=20
Pauli Virtanen

