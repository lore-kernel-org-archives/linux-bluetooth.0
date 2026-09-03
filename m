Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427847ECF2
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430295; cv=none; b=h7QScyUMcilkdHQphiBfocz5RZ7laj2ODi9pyHdV60/XdWQKq+q7P5t/6NIc1pP0FnIJmDuXg5NNgAnR7MG3XON9CGs4GwxlFVBogPM5BV8GhnCJ1CkM2oKu4yAyF4BTKdEC81t/iKxKTBVciHujQjs6crSUasBIvOkBNEqVLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430295; c=relaxed/simple;
	bh=FvmQy9KSy2GluuKl4XUUhlm8UUNEcViyAac4ZTew5lE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AITpFPssMsX/w0WEOPvWDgXriUje+KtXvFD0KoOJC+Sy4KiBKa2hTd5iPLqFUYqhNjzBBRdMYMCNhJyIk4AsUXFUGoIzOPGiaTisznPXzwMT7urRKKk1eNsk6RnlcUXiaT3hnlTVwff3kb8UA5quW46/WLO8GAXdzUMLe3Tl9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8363F3EC68;
	Thu,  3 Sep 2026 10:11:24 +0000 (UTC)
Message-ID: <65a5c682b7432dc14e4bf1555392e1c7e1f01ffb.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2] adapter/advertising: fix mgmt endian bug
From: Bastien Nocera <hadess@hadess.net>
To: Nicolas Thibert <nithibert@gmail.com>, linux-bluetooth@vger.kernel.org
Date: Thu, 03 Sep 2026 12:11:24 +0200
In-Reply-To: <20260903091059.161705-1-nithibert@gmail.com>
References: <20260903091059.161705-1-nithibert@gmail.com>
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
X-GND-Cause: dmFkZTED+CJ/lpoY/VEBxledsAq1+tnaZx3PTwyRpE4/0tQoip69m38Gys17LkJ0o0u5PdzhPl58djrvBRtgO0Pxk0Emdxa406ri/MyN/o0TwrrkFa3wi1mi3Z2Hcd2hFzrlYTKq+ihRI5qRGd3nvBwdoHYgdbEBlGlZ3z7+gAeH1kRTTA117IgOYDKiMOnDPkeIj9Nib12g7TWzdCC5Kub7ANgMxBpUZrFWtSaEODgUn1+4UjrCWuTzDlvk50IRbP6cmbjekC1sS01lAqF2p5CG09U4KNbgkY//4AbWwICAtILzEYmen96BlYUTUZ9vGh/uklBFB1747bCFTZaNtzH7x1I/nezE6gvVYGzVwMraUDoozLGvyBOq5qYpd6CBFf6zvZARlj/MyjoRe9D7kbbDFc86lWyA+yP2X4tOa8S6SHxrah+ua+Gvd2/qhJGuY1cbonpSx3t6W03vJrWtZPcPl8Wi8TKO2yD1hXPqLZOr0VoeSfF6NxI8lyT6XCfcCsRE1gKG86HsGCNd2yo7Dp/YL0OVMOxHyrKCSqUQQGoYfoP6o9ZT2UeVgIyDRaU6M5KhzF1Ac0hXc2BROIcs2DerfwY2Kupvl/fXTjbkjy/W7rxkgYFdt0hi78+LIofD6KJPBxx4q85LjFISgcxaaMAAAcwjA5ZA+NRTNFL1m3q53/1sKw
X-GND-State: clean
X-GND-Score: -100

On Thu, 2026-09-03 at 11:10 +0200, Nicolas Thibert wrote:
> Several places in adapter.c and advertising.c write a native-endian
> value directly into a __le16/__le32 field of an mgmt command struct,
> skipping the cpu_to_le16()/cpu_to_le32() conversion used everywhere
> else in this codebase for the same purpose. This is a no-op on
> little-endian hosts (where cpu_to_le16()/cpu_to_le32() are themselves
> no-ops), which is why it has gone unnoticed, but corrupts the value
> on
> big-endian hosts.
>=20
> Confirmed live on MIPS big-endian (OpenWrt/ath79): set_blocked_keys()
> sends key_count=3D2 (2 blocked keys), which the kernel's
> __le16_to_cpu() correctly interprets as 512 (0x0002 byte-swapped is
> 0x0200) since the wire bytes were never actually swapped to little-
> endian on the way out -- producing "expected 8706 bytes, got 36
> bytes" / "Failed to set blocked keys: Invalid Parameters" errors in
> dmesg/bluetoothd logs.
>=20
> add_advertising()'s cp->duration and refresh_extended_adv()'s
> cp.duration/cp.min_interval/cp.max_interval have the identical bug.
> It
> is inert with bluetoothctl's default (0) duration/interval values (0
> byte-swapped is still 0), but A/B tested live (patch removed vs.
> applied, bluetoothctl's advertise submenu "interval 100 100" set
> explicitly) confirms this is not just a theoretical correctness fix:
> with the bug present, the device stops being discoverable by a real
> BLE scanner the moment a non-default interval is requested, and
> becomes discoverable again immediately once patched. Any application
> that sets an explicit advertising interval or duration hits this.
>=20
> v2: use cpu_to_le16()/cpu_to_le32() instead of htobs()/htobl(), as
> requested by Luiz. Retested live on the same MIPS big-endian board
> (blocked keys + explicit advertising interval): behaves identically
> to the v1 fix, no regressions.

This paragraph above, goes below the "---" underneath this comment,
just above the diff stats.

configuration is=C2=A0
[sendemail]
  annotate =3D true
or --annotate on the command-line.

I believe Luiz might be able to fix this before pushing the patch.

> ---
> =C2=A0src/adapter.c=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++--
> =C2=A0src/advertising.c | 8 ++++----
> =C2=A02 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/src/adapter.c b/src/adapter.c
> index 7390ceeee..edbdb53b5 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -10219,10 +10219,11 @@ static bool set_blocked_keys(struct
> btd_adapter *adapter)
> =C2=A0					sizeof(blocked_keys)] =3D { 0
> };
> =C2=A0	struct mgmt_cp_set_blocked_keys *cp =3D
> =C2=A0				(struct mgmt_cp_set_blocked_keys
> *)buffer;
> +	const uint16_t key_count =3D ARRAY_SIZE(blocked_keys);
> =C2=A0	int i;
> =C2=A0
> -	cp->key_count =3D ARRAY_SIZE(blocked_keys);
> -	for (i =3D 0; i < cp->key_count; ++i) {
> +	cp->key_count =3D cpu_to_le16(key_count);
> +	for (i =3D 0; i < key_count; ++i) {
> =C2=A0		cp->keys[i].type =3D blocked_keys[i].type;
> =C2=A0		memcpy(cp->keys[i].val, blocked_keys[i].val,
> =C2=A0						sizeof(cp-
> >keys[i].val));
> diff --git a/src/advertising.c b/src/advertising.c
> index 1ed09c902..3f70fb4e9 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -1042,7 +1042,7 @@ static int refresh_legacy_adv(struct
> btd_adv_client *client,
> =C2=A0
> =C2=A0	cp->flags =3D htobl(flags);
> =C2=A0	cp->instance =3D client->instance;
> -	cp->duration =3D client->duration;
> +	cp->duration =3D cpu_to_le16(client->duration);
> =C2=A0	cp->adv_data_len =3D adv_data_len;
> =C2=A0	cp->scan_rsp_len =3D scan_rsp_len;
> =C2=A0	memcpy(cp->data, adv_data, adv_data_len);
> @@ -1093,13 +1093,13 @@ static int refresh_extended_adv(struct
> btd_adv_client *client,
> =C2=A0	 */
> =C2=A0
> =C2=A0	if (client->duration) {
> -		cp.duration =3D client->duration;
> +		cp.duration =3D cpu_to_le16(client->duration);
> =C2=A0		flags |=3D MGMT_ADV_PARAM_DURATION;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (client->min_interval && client->max_interval) {
> -		cp.min_interval =3D client->min_interval;
> -		cp.max_interval =3D client->max_interval;
> +		cp.min_interval =3D cpu_to_le32(client->min_interval);
> +		cp.max_interval =3D cpu_to_le32(client->max_interval);
> =C2=A0		flags |=3D MGMT_ADV_PARAM_INTERVALS;
> =C2=A0	}
> =C2=A0
