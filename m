Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9C33DEC2
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926544; cv=pass; b=GGaH8rNbhY6Qsmu7vHIFc4DVMgypxcF+Hr4hgZo+xpWOiqqGLAK7OKCcZ8ObJaHeikWXDNVgpKwr5xNsq/f4VWvtcxbomWF8qLANdQd5m3iL3ukcWUqx2CChMjQFkWmF6claYE7NFPgswnTuoeB4Q7pdm9u+wc5dNl1s6n+EvVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926544; c=relaxed/simple;
	bh=27f55uUsf/NeLL+ozt166XxYkPciWXtYi/uoe7VfszM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiXlQvC4CxJbMXgxnbKOITwF/4PRF5HPft8uI9kP4Xqy/3oILRT7IWa5SsocWeUHjI7tRKQe8+ygWqNzTJzN39fOZhTjalx+GGRgBcY44KGQsfSLv44idXOuaUGCYljaR8aKzaHNMk/gODK5RnzR+Onv5i2C73KRqs28Su96CMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2ll88Jr; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2ll88Jr"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6603246b66dso4286969d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 06:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780926543; cv=none;
        d=google.com; s=arc-20240605;
        b=V9hjClxX44rskvTHTH3vtnDdUeuMgvjPiEU3q34JHgD/UGojVcLtpP554jyY9e63GO
         UAPoPH/Cf264uHHodF48cepcCmhKlWWdDOgj18v3iXRTa7G+6qAvbq4Y+g9dNeCvDWxw
         YMSPJ1vyDGlR1knZNymlexwM8bBnEG2UWxA4SZAm/GwEb+TQo7o9c64HAa+SRpAPM19e
         3wsAnP0zxxMmnsl5N6iqECUqJ9bZABRHTCeVeMukJjQn/rYPYMMao6/3UfPFIuM8cv5f
         W3mBTb4uRlMceGCNyzA0Qbgai04bhKUV+E5NTzyGKHZQ4MXsvXHTUGkSOosUV0sNujyE
         gnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3rJ+OnVyAbZqi93HvWlQx93MJtyUJfD5PT9D/T9kkBY=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=QQc4MMzyZe0UCWdbH7lAQD0eon2RyM0WS3DuSc7uesYDWXczI6TB2YSFyUGk2/zab2
         nzXZVJ5nvpN1vYT/rp6x5z0t2xesav+jNElRpu33AEIcud0FX7fy3xRtYnDW4pMFldya
         8mGFMvXHXgLliizS/yo1Mrq64cPCHDjl4wUZjjPasG1HBZGVc5iHfGbSPKp7vvTm/ifl
         Ew+6jumm4F7reVUyECeoPqAKiiplzgRwxtxOPgwKNRP7ZreUCrdEh9pJieijNCTe7yMY
         1LtCzFWXzdMbgZmnzOSBhaHIB/zdx7Q1vFXCeFUQ44KGYFQbiV/iG0YoobkfS7G16TpZ
         7bHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780926543; x=1781531343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rJ+OnVyAbZqi93HvWlQx93MJtyUJfD5PT9D/T9kkBY=;
        b=r2ll88JrbqfZy6ZCq1s0yR1UNAvR9n+nIWgABu7u1KpE8mLIs+AwBWuUkHVtbl1nPq
         g+rtEhXR5XZ2DvX9AVqEA1kEp9dmhUUBUsHC5P8KbrZmfTp9q54L2h9lACINGjssm9mG
         NYhaFFl4ksYMQjQvgbb2yqeb2Drn9UemSbq9x3NFPnZUTUfPskFz1WXO/Zyhi2wrbEPB
         r8CIWyP+O/eJqcJR6bamH9aEDSYkocjQd+QY8ryhAZqLgt9xSh16afskU3NQhSFhJEXh
         tks2qvlwX9a/FxHgvGaG6gt35pnKq9TtvlpAsOjB5y8CRkn/B0F33KgTrBwrYTsia1F4
         D32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926543; x=1781531343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3rJ+OnVyAbZqi93HvWlQx93MJtyUJfD5PT9D/T9kkBY=;
        b=lMHP/CAPQuQHlQA6AXa7lP2dW8Wv15seC0ghyX/dlqgCGSgres1xp5zrezHxOpr12w
         UZ0szGtzIjZ8K3yQuGGeycwNAOaW0q26dPyCDlG7X8Bm6p0Yd/VnA53dTDoXY3XJ8rBZ
         Lz28kuMu27IqmDCiRwy5UwBXX1SYrexZKmaNY32+zfYbSyjVJS28AZHRGBZo7yEdnd92
         0bsacyuqlm/VoXnDv61tGQtqfHvFUw+6kbvQVXTcfYUIc+H5QAuIW2ZbXGVeUJB9dEh5
         AHkdFGjeTWKC2JJKAA4r0rE76OTjQI9PnXRKRAVfvY3iHTgsSqwudjaac35Elu0KGuBJ
         Po+Q==
X-Gm-Message-State: AOJu0YxxiKuHUmFT68gY/6S+zsE0WMbBo6V1y4Lfhn5W0tubltJ+Cqlv
	PNvgKJg1j2uxZltQ5QN+DQ+Te4o88Tn/Bhi0Ap5r4nL37WbOKScaQatWc9csVIXd/1WlZk3KX9A
	Iumzaz1SzmuLfV40GS9R4CxMgioRhCfovb3ivsB8=
X-Gm-Gg: Acq92OEoOlJa4qm/fZ5JoXQvxwTZi7+/nb4RxN6ftyK3MV1Ia9M2o2LrpVxVBxnK7iu
	9pwJbqIOjKHPopc0Z5kZWRMRMD0+egOXDYtd7E4t+HRGVAFqlBD1r6B/4yjz6E5343WxjKJJIe2
	qO4LndnEo2LbvkwSiGedKNEUlEbLkcd6d+BF7o2OrPtG2x7vdRdB/dTWDuZYNvDOFitvUdFwhmc
	OrHVTwFrxjNktlo7DxWUBW3xInY7xYvlflAhwyFqLTuyObjPWy8Qv8N4/vz6NWv7/IIzJ4j6RMP
	6j8xA7PYKSdup6061O1A0Nca4bBwCOiggbS2t7WCbFoPskAO71MGf+XItzH2Uur0TEE9qjELkke
	EvWa3
X-Received: by 2002:a05:690e:484f:b0:660:4538:2331 with SMTP id
 956f58d0204a3-66106f38f8dmr9134238d50.36.1780926542763; Mon, 08 Jun 2026
 06:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608111658.3686364-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608111658.3686364-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jun 2026 09:48:51 -0400
X-Gm-Features: AVVi8CdXxH0xbZShxeptt6xNZlRWx7GPCRtwTLjT7VU7A5p48ljmsmAIbxMicGU
Message-ID: <CABBYNZ+HPDOdhW+236pd8BRp1L+he4d4=sEQd5Q+5OZ+xPgO1w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: Add codec prioritization
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Jun 8, 2026 at 7:19=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> This change will select best codec when connecting to A2DP:
> LDAC > AptX HD > AptX > AAC > SBC
> ---
>  profiles/audio/avdtp.c | 51 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index d475a545e..a8733a7e1 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -42,6 +42,8 @@
>  #include "sink.h"
>  #include "source.h"
>
> +#include "a2dp-codecs.h"
> +
>  #define AVDTP_PSM 25
>
>  #define MAX_SEID 0x3E
> @@ -1293,10 +1295,49 @@ static struct avdtp_stream *find_stream_by_lseid(=
struct avdtp *session,
>         return find_stream_by_lsep(session, sep);
>  }
>
> +static unsigned int get_codec_priority(
> +                               struct avdtp_media_codec_capability *code=
c_cap)
> +{
> +       unsigned int priority =3D codec_cap->media_codec_type;
> +
> +       if (codec_cap->media_codec_type =3D=3D A2DP_CODEC_VENDOR) {
> +               a2dp_vendor_codec_t *vendor_codec =3D (void *) codec_cap-=
>data;
> +
> +               switch (A2DP_GET_VENDOR_ID(*vendor_codec)) {
> +               case APTX_VENDOR_ID:
> +                       return priority + 100;
> +               case APTX_HD_VENDOR_ID:
> +                       return priority + 200;
> +               case LDAC_VENDOR_ID:
> +                       return priority + 300;
> +               }
> +       }

Nak, not going to accept fixed, made up, ranking, the ranking should
be per endpoint source by ordering from higher to lower priority.

> +       return priority;
> +}
> +
> +static int sep_codec_cmp(gconstpointer a, gconstpointer b)
> +{
> +       const struct avdtp_remote_sep *sep1 =3D a;
> +       struct avdtp_service_capability *cap1 =3D sep1->codec;
> +       unsigned int priority1 =3D get_codec_priority((void *) cap1->data=
);
> +
> +       const struct avdtp_remote_sep *sep2 =3D b;
> +       struct avdtp_service_capability *cap2 =3D sep2->codec;
> +       unsigned int priority2 =3D get_codec_priority((void *) cap2->data=
);
> +
> +       if (priority1 < priority2)
> +               return 1;
> +       if (priority1 > priority2)
> +               return -1;
> +       return 0;
> +}
> +
>  struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
>                                                 struct avdtp_local_sep *l=
sep)
>  {
>         GSList *l;
> +       GSList *sorted =3D NULL;
>
>         for (l =3D session->seps; l !=3D NULL; l =3D g_slist_next(l)) {
>                 struct avdtp_remote_sep *sep =3D l->data;
> @@ -1325,7 +1366,15 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(str=
uct avdtp *session,
>                                 continue;
>
>                 if (sep->stream =3D=3D NULL)
> -                       return sep;
> +                       sorted =3D g_slist_insert_sorted(sorted, sep,
> +                                                       sep_codec_cmp);
> +       }
> +
> +       if (sorted) {
> +               struct avdtp_remote_sep *sep =3D sorted->data;
> +
> +               g_slist_free(sorted);
> +               return sep;
>         }
>
>         return NULL;
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
