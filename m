Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F82309AA
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532330; cv=pass; b=pWObLPOYni1pRKBfnFW1Vn/nbMrRP23NFjdEz0IB8vbZm4zNNoQl4QT43WYTaX46tIgz3yAVrese5q//gH4AwG4xw6UUb0gIsdGLiauXKAM7s1AXp9p2SQOwTBuBwgUDmIyEsjdmeESVIC7ERUKwNxfrlv6dwBZVnrimZS7neFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532330; c=relaxed/simple;
	bh=dB2rGxT2EoQiq/FPhoTVjaXTAAAmusckwM6LcDc4JpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCdgeuOnlwlNG2PLerDpWZyHL4C/vDc3ACHUrPWnHtFJpsgbTJ1G2o60RIAb9ErGicePRu55GTyHpFl8QYOaGDKwdRwSNwCXjmf3+c0ucRYO0g1pyqJqRcbvMD0ZVK+BmNdFfq6PdjGK3EhbHPf2UcRcYTmVzxSTSPrWeVkoYwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtH4X5nk; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtH4X5nk"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6603d8697d2so3141445d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 07:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781532328; cv=none;
        d=google.com; s=arc-20240605;
        b=bf/Sa01IHjOl4dVEXvm/N04TnnggdCQ+DJg8gCt8ggh0IBR6762pRDHnoquEiFZfmu
         Tr9TTdXupAo+xD2wFAqkI/Eo01oi+urG3KngJNK6G8zMC62iySmooDsHz7GOKNKN02oN
         xgcIlKfjPrRSXZ1Ox5WL5MsUP4CMZIrddRgjMJgaaL/9qccrOn8LuGu1w9PO7tfRlcia
         fTFqe6J+Sky5lzCoXlXVUEs6Ub+Lw2IqjNk8rDi1WHE3vd8k3436ql//DXjsXBfyD/K4
         KrZa2mMIwNhf89f+8hmnXW0bx6fB0Bu3j9GjgSLhdGKgwrdEqsXqEr1AMR3EkAkxI5bD
         eSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xYixKWq9UOH+uNO0ZY3VrznudDINOGgNx5ZK5i0tBI4=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=iloPwsdsR36nmfwWKG5xrXiMlbIyGxRaNF3wjzCTPaNc+FMOvqXSPisFxWq7JVQDH2
         zpxInip2cmYNZZFeeydlxa31f/K6mziB5Ju80VMbOugd6OrAibm2OxDxeoTxzNP44Tld
         BAmsBuhFyDStf9EUNoQeBsTbsTiPXrkcupmrQMx6tGt6W5fOe/7lXKEstXzxVSP/T40f
         G79Cb6b3UNab9If3Z/olAlnOZOB/NhVbyc3Bae5dygMb0ui1gkvsNAbBAypEBlRLjkyi
         vwhPOuWt3Px1ehkbq/dkgOpiWXBdOXaJaXdfDjGjk9sNE54fTafvW24/5eOdzpY0kISW
         POZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781532328; x=1782137128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYixKWq9UOH+uNO0ZY3VrznudDINOGgNx5ZK5i0tBI4=;
        b=LtH4X5nkgpO5CF1z2Y92f6pJAeqkViF8+BUXhMvySTQLxgMLg1od/1M4n+gUEfNCQD
         AzcXt4PfmlE/XS2ih2as8Xm6kG8FZRakJqcA8CELjlYC9KZPwFk1d3ZSVS5JH64V0Th5
         T69/Tk/x9qoc9W/Xi6UjP+/Lqb54lgkJOq9jtbx/v/mJmNoONYurVL8nG2FSF9WT1aIp
         zDOO/MSpBy8++OzJNVbL3uW4pGvjqELyvLhyrpgvxwgwfWlqu4r7Zzp5aMmpdmGplb1V
         msWlIYhtMv043DMMERiBOgk/1S4jXIHAeeCMMs4EqBlWKIb+Jx/yJmZ8+nsfWnzsexem
         mubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532328; x=1782137128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xYixKWq9UOH+uNO0ZY3VrznudDINOGgNx5ZK5i0tBI4=;
        b=iioUWiVKgGK11uezZ4d1qnMd+0u1sRGLiC1caITLHbwBmpYRtBEIxGyCPJxiFqC5r0
         4RN5QTa7Im32PfmdknMFTyS5CXfd+kqUXVP4t5z5a3YeYtTVCovbeGbiRdj0CS5RP59P
         rXh8qDAzjS+6mR1rdFrva8s3wCmj9mOkMfW0lDxbP4/4ZXlZlynehcuwVE9eAWg80x8o
         Uqexppg9UpRPU+zPvu5ogP7A/lGIskSfSotWv4DNY3GklPCE2eA1zbe8y4oO5viHFjlG
         KUDAEC5S57JgvkxObTdr36s7GdgACG4P/ByYkzEk8JQvtv6/dcwDXfcSUygZ+SWmHZLf
         i5dw==
X-Gm-Message-State: AOJu0Yzx6WY4KEi1qV/pRRALMObgOW1/HD1UKYfSz1P25utHbZOBZJLL
	1bZw497Uqo8HGYYdW/6AXagmZtpQJRELMMYkuUECYGKnhgC3sL8YqmAyuGl6uxPTmZuRfpjp07B
	yVYsEzdJzuYhUhGbZ8yDicu6lVOHm18exbdVv
X-Gm-Gg: Acq92OEN251F6K7pnMds9k2p4qYZL5EeDn2pEIlzfsMa1qISVKm9gRopMCZdtM/C+V4
	5hQgaJ62TlJ8I0v89Ym3ZlallL12kzh1Hn/pd088ADRq9Jqbexbioukivnme2FMiXeLRh9CnR2U
	fNJzU6E+CmJWzGYd3L418GG2x9+XAkCLDAEd550UG2oo42ugxLov7P1fpYgOwtkL/cxGcAvzIQh
	xc47hr5tLH/1fmeUc/NSvwXeJzisUSUCKsDjvhPm7duVc/8rnuFCTug+g0Yxdoha/iJWqanBZPc
	7jJ1ajK2m1ATutujfe1V87rEg29xINJkwruFqx6eMwfEkH7NztJzxI0AnN1K0nr/5GmgkA==
X-Received: by 2002:a05:690e:b45:b0:660:eada:ea0e with SMTP id
 956f58d0204a3-662782d0467mr12300519d50.39.1781532327471; Mon, 15 Jun 2026
 07:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa0febe1-5866-4a3f-9f86-ae70e9d4b22d@streamunlimited.com> <20260614105016.1147112-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260614105016.1147112-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Jun 2026 10:05:15 -0400
X-Gm-Features: AVVi8CeNBO74o1dKqnru5IgbfOKsmzxFugwV2kTUmdew-NH7VrIJ_USc5yp_fE0
Message-ID: <CABBYNZJvmr2Y1s=euVyZcEWoALq4oOfu2ZtLQbzd+Mj3AuX5rA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/2] shared/bap: Initialize ucast/bcast IDs as unset
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Sun, Jun 14, 2026 at 6:50=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> Also change some lines where CIS should be used instead of CIG
> ---
>  src/shared/bap.c | 13 +++++++++++++
>  unit/test-bap.c  |  4 ++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index deb85b264..e8fbf0899 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2902,6 +2902,19 @@ static struct bt_bap_stream *bap_stream_new(struct=
 bt_bap *bap,
>         stream->ops =3D bap_stream_new_ops(stream);
>         stream->pending_states =3D queue_new();
>
> +       switch (bt_bap_pac_get_type(lpac)) {
> +       case BT_BAP_SINK:
> +       case BT_BAP_SOURCE:
> +               stream->qos.ucast.cig_id =3D BT_ISO_QOS_CIG_UNSET;
> +               stream->qos.ucast.cis_id =3D BT_ISO_QOS_CIS_UNSET;
> +               break;
> +       case BT_BAP_BCAST_SOURCE:
> +       case BT_BAP_BCAST_SINK:
> +               stream->qos.bcast.big =3D BT_ISO_QOS_BIG_UNSET;
> +               stream->qos.bcast.bis =3D BT_ISO_QOS_BIS_UNSET;
> +               break;
> +       }
> +
>         queue_push_tail(bap->streams, stream);
>
>         return bt_bap_stream_ref(stream);
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index 03b19678e..4ac9a207c 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -9894,7 +9894,7 @@ static int streaming_ucl_create_io(struct bt_bap_st=
ream *stream,
>
>         i =3D qos[0] ? qos[0]->ucast.cis_id : qos[1]->ucast.cis_id;
>
> -       if (i =3D=3D BT_ISO_QOS_CIG_UNSET) {
> +       if (i =3D=3D BT_ISO_QOS_CIS_UNSET) {
>                 for (i =3D 0; i < ARRAY_SIZE(data->fds); ++i) {
>                         if (data->fds[i][0] > 0)
>                                 continue;
> @@ -10000,7 +10000,7 @@ static void test_select_cb(struct bt_bap_pac *pac=
, int err,
>
>         if (!data->cfg->streams) {
>                 qos->ucast.cig_id =3D BT_ISO_QOS_CIG_UNSET;
> -               qos->ucast.cis_id =3D BT_ISO_QOS_CIG_UNSET;
> +               qos->ucast.cis_id =3D BT_ISO_QOS_CIS_UNSET;
>         } else {
>                 /* All streams to separate CIS.
>                  *

This fixes to test-bap should be in a separate patch.

--=20
Luiz Augusto von Dentz
