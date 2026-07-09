Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A77330D3B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606913; cv=none; b=S5BdJZZU23+NGyVnPjTFQLpTLegTF0MRjl2H0I4ZZd2PHJyM2cK8uNm6umQVW6csjxQEi8cI/1mcO8p490P8lPcGC2wvTNQgsnsok+gswH56OcooQ9bvQF7JgQe1uN1QGsBc2FRsJZMItfJfGGj9xEOKtEdDV3bb/djs2fN7wNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606913; c=relaxed/simple;
	bh=difH9GbaET8Rhru0GV41xEpGX/KL75uz77wTry5xCH0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vj21s6Ge8NafyMqZb8dW6UQB2xr+vfFYh8LnpVJyeD27oWBzL4b6l0/ZBXBGjT2YLRL+0lwMWsGQqLdqnIcPUiOBwl/UB7FyEMo3iI4I2tQ+spirvQx0Tq1GMLn1MAUn0DMHY4mYF46GHZ6TxTVpbKjlLOjFVIt8ioeqr8ioYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A87183EDBA;
	Thu,  9 Jul 2026 14:21:42 +0000 (UTC)
Message-ID: <a2d7c978a97b5e55a05cb7000f4d20d8c8dc542e.camel@hadess.net>
Subject: Re: [PATCH BlueZ] adapter: Fix crash on UUID discovery filter match
From: Bastien Nocera <hadess@hadess.net>
To: Tom Catshoek <tomcatshoek@zeelandnet.nl>, linux-bluetooth@vger.kernel.org
Date: Thu, 09 Jul 2026 16:21:42 +0200
In-Reply-To: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
References: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
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
X-GND-Cause: dmFkZTGhVF2/IS+jXN9DkX4NOivjVdU+te5YuW6bGZaV+3KAvkyYuqh+wpZyTt8vEIfLvnhOOcQWFSaD5B90zxPv4ZcVlOStzAYHny+ESjeTwqL3KpYHzXfm5ATzIj2s7lW/JRp/LoqvytkOdgiMo6s6QGiMGRp6AE802U2+rn7ri9nrRNv5MZNR2vgu05vuU1PaN1axJ/v6j9mmQ6nfnAMMxSoq+yHnn+h/WnKLF2mawXyvHUFWe6LdVkXnCxphwK+yx8cmfu2s5rVfXEExVVqh4OEZlj8UtP9Du1axR8f8mTHdZunPxbPEiiqGTQR/MlwY+3STJL73ea+Q69iTi14+14dKkHABNr+cfIDIvbE5He24mM2PIkqYwsK77mWEImFtVFQO6RAapk+XU5VEheClItqYXLru7TH5SiHn1m9k6k48VDaWbayhINGACtlHTFykV88yg+LEjhPj8WPZPRJacmnqpUckMxzTFxFDTLCoNI1FaduZm3AIxtDisi1SyDnlIKfNwYv9M4KOKridR+nJTg3rUl3aelFqo91AIS04BetWpJ8ssxOB3j8VNpWwCArKQRQukQ3vFnTKDm5ZXq0g0qILjV0wqik9gDNzsofsxa1WbtjGvH6O0Hardf6I6zfBtub0kqCbjDlDfscvagVnrbGebCrsvhK09xzr7Rhzbgs7pQ

On Thu, 2026-07-09 at 14:27 +0200, Tom Catshoek wrote:
> is_filter_match() looks up each discovery-filter UUID in the queue of
> services parsed from a device advertisement. When that services list
> was
> migrated from a GSList to a struct queue, the queue_find() call kept
> GLib's g_slist_find_custom() argument order, passing the UUID string
> where queue_find() expects a match function and the comparison
> function
> where it expects the match data.
>=20
> As a result queue_find() calls the UUID string as if it were a
> function,
> jumping into non-executable heap and crashing bluetoothd with SIGSEGV
> as
> soon as an advertisement matches a UUID filter configured via
> SetDiscoveryFilter.
>=20
> Add a queue_match_func_t helper and pass the arguments in the correct
> order.

That'd be my fault, can you please add:
Fixes: 91c340d359b7 ("shared: Remove glib dependency from src/shared/ad.c")
to the commit mesage.

I checked the other queue_find() change in the same commit, and the
args were reordered correctly.

I don't understand why we need match_uuid() though, does it fix a
warning? If so, it might be nice to do in a separate commit (fix the
order first, fix the warning second).

>=20
> Fixes: https://github.com/bluez/bluez/issues/2282
> ---
> =C2=A0src/adapter.c | 11 +++++++++--
> =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/adapter.c b/src/adapter.c
> index 210225243..4ffa32a52 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7184,6 +7184,14 @@ static void adapter_msd_notify(struct
> btd_adapter *adapter,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static bool match_uuid(const void *data, const void *match_data)
> +{
> +	const char *uuid =3D data;
> +	const char *match =3D match_data;
> +
> +	return strcmp(uuid, match) =3D=3D 0;
> +}
> +
> =C2=A0static bool is_filter_match(GSList *discovery_filter, struct
> eir_data *eir_data,
> =C2=A0								int8
> _t rssi)
> =C2=A0{
> @@ -7216,8 +7224,7 @@ static bool is_filter_match(GSList
> *discovery_filter, struct eir_data *eir_data,
> =C2=A0				 * uuid.
> =C2=A0				 */
> =C2=A0				if (queue_find(eir_data->services,
> -							m->data,
> -							g_strcmp) !=3D
> NULL)
> +							match_uuid,
> m->data))
> =C2=A0					got_match =3D true;
> =C2=A0			}
> =C2=A0		}
