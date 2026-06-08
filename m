Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A4A31E827
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934317; cv=pass; b=mK3BW44n/QrEcHajPv/OlMOAgCKeL/Cy8jY3jdWf7LUFCL4K1bkEiClSepRPNSKhayxy5AGBFtJqshjch55ALNPj5s5vLOyGONdIK7rkPXFzS/vukRA3V4+PYgrMImHtFBOYTQYjPa9yoLm7LKTN+vuFEAqs4ehp1HkCoKlnuwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934317; c=relaxed/simple;
	bh=BTkl2NzTF+pTZUKCCjORFd+kBxyLBLXi++BRPsEeclY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MbPj7r3qzDnxtAGihkwENhT58XDCjU5NXur7gSTKwzoYvCaHHvDMweiaflA7/0aJYGbGK3M7O/oHo65uMGOTi4q01qs8hxZfOh5ycK89jFk4fczIuen/Ju7jGFuM+fsgtwZSzoHCKYAcmLZ8gRZflfbKf2MJFYXp1a1LFl1K5qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=BcEv7BS8; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="BcEv7BS8"
Received: from [192.168.1.196] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gYxXg5njgz49QGn;
	Mon, 08 Jun 2026 18:58:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1780934308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OeeeoEU4f/nzy+cZPsd81NGPMfdt+EHLtUmr2q1repQ=;
	b=BcEv7BS8jgCWYNMPnnf4AEZ0u1+BWxQ9uUAnvfXL2VYcdZhnYn+CxvvJ76oMYX1QfGm3Yq
	vEG/CkbuTt2QAQOqUKHvc9DHQGVoxABJzXOCskAohya6uNbIVZnSYjiACAJVjnCjj9qvrx
	ywE6ctCUpjmscJbwfOMq+qO6zYZdy/7VnxO4We3fg7o4K+tJzyXtadH580b1vglv5Y9/6i
	Sc6bHAcI9eWfdVWUX/mkYtL/fQl5eDxzQe0KtoboIJd9gcR6gNB5adS4+e4i9ojS/XRy4x
	DFy5Qbnx4T1fbnxq/4wQK9/n3cyQRVd3oW0DTM+s5sjzLhzeDHvjmjjOSwakGQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1780934308;
	b=q9O9LCwXWw/UVErXKRNhv8Jcn2p13+gjyKcJiOKMMdeqAUNte45sb5RQ9sXbew49F4zpUp
	NpbU8SGCYtxY+9j0zxRO/RbaPl8Y7eiK32lpvR9XKI+3n7JvidvOZSChw+OsvR3j/bVDUi
	bnPb00Ntrgh0z+Mae6icMuR6ht4r99g1pvF7yW+N4JsM4A155cLJuvZJzDj3uk6fIuhbPO
	FIuSrsg5ez5Csi5LDg2H6QTvKwGUemk6lt4n+cleYgM2CackP2DrGlO9VdWALLFXWK/2dT
	QkHcmjKa/v4mPsi32OlCMbUEXdusVwcmJArFo9LdhItO8dfgPskmmX6uJnjppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1780934308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OeeeoEU4f/nzy+cZPsd81NGPMfdt+EHLtUmr2q1repQ=;
	b=BzNTDrKbIXYVI1P/ByFdIiWusI0tFDoFH3Sju+mPzhjuKuzK3IraXiZlXD2OwMU8ypOve9
	/gaMizR/mtDm8cCmF9bk1hUjRoazaGIMCCMLP4Ic36o9EC/jJTZ/DvzeN+ZhfuadVWXf1k
	8PEPmNiI2G4fu6gM1kqYClAu09/d7qcGQoO4FJRSDk4bUupZM1M+VJ72ExQ9mBUG1rxObP
	22lK3WEvaXiiWkUsC8L+UJzymW5JXEAd6uzrzq3JmccRliviEpA/EN2gIylrUWIIbiCJZ1
	Z9l1lpnMhm7CvPIvPpZeNVsrl7vipLFuiOYO1cURDCJKnqSSf44UfdU5aCd3hg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <f10de0ea2a69c48b40d66b79d4236b17f932c05c.camel@iki.fi>
Subject: Re: [PATCH BlueZ] a2dp: Add codec prioritization
From: Pauli Virtanen <pav@iki.fi>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>, 
	linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 08 Jun 2026 18:58:27 +0300
In-Reply-To: <20260608111658.3686364-1-simon.mikuda@streamunlimited.com>
References: <20260608111658.3686364-1-simon.mikuda@streamunlimited.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-06-08 kello 13:16 +0200, Simon Mikuda kirjoitti:
> This change will select best codec when connecting to A2DP:
> LDAC > AptX HD > AptX > AAC > SBC

Currently it's media server's job to decide what A2DP codec to use.

What they do for this sort of static ordering, is to register endpoints
in the wanted priority order, so I think another mechanism for fixed
ordering is not really needed.

What could be useful is=C2=A0something that allows per-device priority
selection, e.g. DBus callback that BlueZ uses to query which endpoint
to configure, before starting SelectConfiguration.

I'm not sure this is highly needed though, as iirc BlueZ remembers what
configuration was used on previous connects, and if BlueZ gets it wrong
the sound server can just reconfigure as needed at the cost of some
extra delay when connecting.

> ---
>  profiles/audio/avdtp.c | 51 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index d475a545e..a8733a7e1 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -42,6 +42,8 @@
>  #include "sink.h"
>  #include "source.h"
> =20
> +#include "a2dp-codecs.h"
> +
>  #define AVDTP_PSM 25
> =20
>  #define MAX_SEID 0x3E
> @@ -1293,10 +1295,49 @@ static struct avdtp_stream *find_stream_by_lseid(=
struct avdtp *session,
>  	return find_stream_by_lsep(session, sep);
>  }
> =20
> +static unsigned int get_codec_priority(
> +				struct avdtp_media_codec_capability *codec_cap)
> +{
> +	unsigned int priority =3D codec_cap->media_codec_type;
> +
> +	if (codec_cap->media_codec_type =3D=3D A2DP_CODEC_VENDOR) {
> +		a2dp_vendor_codec_t *vendor_codec =3D (void *) codec_cap->data;
> +
> +		switch (A2DP_GET_VENDOR_ID(*vendor_codec)) {
> +		case APTX_VENDOR_ID:
> +			return priority + 100;
> +		case APTX_HD_VENDOR_ID:
> +			return priority + 200;
> +		case LDAC_VENDOR_ID:
> +			return priority + 300;
> +		}
> +	}
> +
> +	return priority;
> +}
> +
> +static int sep_codec_cmp(gconstpointer a, gconstpointer b)
> +{
> +	const struct avdtp_remote_sep *sep1 =3D a;
> +	struct avdtp_service_capability *cap1 =3D sep1->codec;
> +	unsigned int priority1 =3D get_codec_priority((void *) cap1->data);
> +
> +	const struct avdtp_remote_sep *sep2 =3D b;
> +	struct avdtp_service_capability *cap2 =3D sep2->codec;
> +	unsigned int priority2 =3D get_codec_priority((void *) cap2->data);
> +
> +	if (priority1 < priority2)
> +		return 1;
> +	if (priority1 > priority2)
> +		return -1;
> +	return 0;
> +}
> +
>  struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
>  						struct avdtp_local_sep *lsep)
>  {
>  	GSList *l;
> +	GSList *sorted =3D NULL;
> =20
>  	for (l =3D session->seps; l !=3D NULL; l =3D g_slist_next(l)) {
>  		struct avdtp_remote_sep *sep =3D l->data;
> @@ -1325,7 +1366,15 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(str=
uct avdtp *session,
>  				continue;
> =20
>  		if (sep->stream =3D=3D NULL)
> -			return sep;
> +			sorted =3D g_slist_insert_sorted(sorted, sep,
> +							sep_codec_cmp);
> +	}
> +
> +	if (sorted) {
> +		struct avdtp_remote_sep *sep =3D sorted->data;
> +
> +		g_slist_free(sorted);
> +		return sep;
>  	}
> =20
>  	return NULL;

--=20
Pauli Virtanen
