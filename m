Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7A1CD2C
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432693; cv=pass; b=BBayD05sljUo3gaLHztqi6aeDp0xApRSkKCVzNZ7VHRfpq/rp3u0AzmMiqeqd3g8PJWd88Qnm9YdJ95vs69+62ZmamLbv97tmmV2vd2bRezG0kCMkkSxlnRIADMwM09Ypjba2o/5+Wvx8ZeYSFWunlqMBGcDdBQJ/HNjupVYJ/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432693; c=relaxed/simple;
	bh=mCgQI8rCkqtiF9/+TBFwjPvCW2uwfFMQJQpmdrAL+So=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=alvoBZP+UGMDEH84uqF8VRs3piwf9so9wNiJgWb8hnAMIo1nW8+ME7jEJhO3xIkS9J9ldF2RNYbHzmk3ZNCUNKK0WuyASKTJwaz7vi7bGzRdo+JXCpbtvX7Sp4LXL1b5LtyB5UgN+ldHkpJ6b3Nl4iRgDeHO3n3W5uGylRnQEyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=gTqBLDac; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="gTqBLDac"
Received: from [192.168.1.196] (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gdTrq3Hvjz49PwG;
	Sun, 14 Jun 2026 13:24:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1781432683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kNX9IzWo4C09DqDLUo1cydMLqiKLsAwEOMlelEekzkM=;
	b=gTqBLDackqph6ZOTxdWVJG9aDOqbRatZh3CSNhwyU5SQxyj2a7sMhbYLszGRcmQPuGxVlY
	RhTtaiwG97GZ89qbeAOjiu62UFnWaLAGsla14AA0BpdJVdNxmWW3P9oKPoAuks3WKR9TLY
	37wpyzuOC0ZiP5f/kj6PpEt1xjPULuaITWKMGNE85vazFSktQ2k/xD82X3GmyCdwq4lhDL
	ER3H48yyZ0mFyJ+NysWg0No522ci7Vxx+Xrug48K+b9SDU0YFDCTvumsqKkrh55zdEO/FZ
	K1MlIU+WsYdIitxcOe+CUNt03gjK8g08e5taM21+QKs8y+dvdhgQuT52RccT4A==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1781432683;
	b=pFbN69yGH+cZEriysB5nzYcOB9HxTCKsCkbZSpoqdpYtOy9cGTevXP7sc9BW/KXNjaDyMd
	mtmc+nZ2WP85HkKVrdbkc66yS4FJkKubpl3eerIsipwWZgichTv92pIj5nCSXr2k/wadBS
	GV5o1uMgJAOV4eSxmsmVVNyi6iOMA3IuTxzvrwWN+5LcddOIDRF0Re0jmToaG7ljXYhD3K
	GCi5BGPq7FfEOyZh1S9HYgcPUd+SC5PLtArtVI7Ia5X5/rgKYh8prMNj1Yg848Mzgv/aDa
	FGU+/HgAYOiqKwx3xlB4RlIPCJUOiQDt/spU0Ul9Ji3bWRVz/OCkz66l0IfvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1781432683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kNX9IzWo4C09DqDLUo1cydMLqiKLsAwEOMlelEekzkM=;
	b=CVDc3FQ7e5KNUAAMcgW+UgHWQjJLm1x98daDe2FtJNieuk3KATVUoPU4s8JhBS/1WqVDIT
	vt4YfE1XlYscrd1rjpQZz0LxUdvS3/f3qkaCLqdqqeEM1VctRNm9XWIxIg68GjvrkssEz/
	CRSI04+0x/dqPv2aeYSF/Wqm78CTW+hnKud1YZh3e1WHhQZxvfVLq3i5uYCUVgpK7XsR7D
	9sr6OD2MXzw87hdeACC0yKYz52/9ru6KPsg72t4tvGwOdOdMgyYLwZh0fESO8qQ1CuCksL
	gkWy032edTgGrhM/XvGR9MjL/pvfX47s7BswJZb6YFA+qAlKHretzan1GAIwNg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <5ad48a8e2152a58f4113f10944944f191007d9bc.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 1/2] shared/bap: Initialize ucast/bcast IDs as
 unset
From: Pauli Virtanen <pav@iki.fi>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>, 
	linux-bluetooth@vger.kernel.org
Date: Sun, 14 Jun 2026 13:24:41 +0300
In-Reply-To: <20260614095520.1090106-1-simon.mikuda@streamunlimited.com>
References: <fa0febe1-5866-4a3f-9f86-ae70e9d4b22d@streamunlimited.com>
	 <20260614095520.1090106-1-simon.mikuda@streamunlimited.com>
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

su, 2026-06-14 kello 11:55 +0200, Simon Mikuda kirjoitti:
> Also change some lines where CIS should be used instead of CIG
> ---
>  src/shared/bap.c | 4 ++++
>  unit/test-bap.c  | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index deb85b264..41139181b 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2901,6 +2901,10 @@ static struct bt_bap_stream *bap_stream_new(struct=
 bt_bap *bap,
>  	stream->client =3D client;
>  	stream->ops =3D bap_stream_new_ops(stream);
>  	stream->pending_states =3D queue_new();
> +	stream->qos.bcast.big =3D BT_ISO_QOS_BIG_UNSET;
> +	stream->qos.bcast.bis =3D BT_ISO_QOS_BIS_UNSET;
> +	stream->qos.ucast.cig_id =3D BT_ISO_QOS_CIG_UNSET;
> +	stream->qos.ucast.cis_id =3D BT_ISO_QOS_CIS_UNSET;

qos.bcast and qos.ucast are overlapping union members, so strictly
speaking this should check bt_bap_stream_get_type(stream) and set the
relevant union member.

> =20
>  	queue_push_tail(bap->streams, stream);
> =20
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index 03b19678e..4ac9a207c 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -9894,7 +9894,7 @@ static int streaming_ucl_create_io(struct bt_bap_st=
ream *stream,
> =20
>  	i =3D qos[0] ? qos[0]->ucast.cis_id : qos[1]->ucast.cis_id;
> =20
> -	if (i =3D=3D BT_ISO_QOS_CIG_UNSET) {
> +	if (i =3D=3D BT_ISO_QOS_CIS_UNSET) {
>  		for (i =3D 0; i < ARRAY_SIZE(data->fds); ++i) {
>  			if (data->fds[i][0] > 0)
>  				continue;
> @@ -10000,7 +10000,7 @@ static void test_select_cb(struct bt_bap_pac *pac=
, int err,
> =20
>  	if (!data->cfg->streams) {
>  		qos->ucast.cig_id =3D BT_ISO_QOS_CIG_UNSET;
> -		qos->ucast.cis_id =3D BT_ISO_QOS_CIG_UNSET;
> +		qos->ucast.cis_id =3D BT_ISO_QOS_CIS_UNSET;
>  	} else {
>  		/* All streams to separate CIS.
>  		 *

--=20
Pauli Virtanen
