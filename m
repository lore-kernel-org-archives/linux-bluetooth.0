Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794844238;
	b=ZYP/tC+GxaSw0pMR5fDHYtLVuA7AzW2pyHnjWXiCD2VHlHnp0bibh/1hO7P25MRHFIG9
	 76PrpwNHrJsgipNNXxLBQJCFNPk2ZK9GNw6qnZfur2BMf1tBvhEzweCjTWOyUmFIlEpSb
	 33ECAT7vNF6Q8gIP1jFGiYWRgA7gcQkysc2QNKY3wxBVtE7u8ErsOegB2rnGZUVWr8h9g
	 Vb6snhX0djeVtyA+qP7SSpRRJPRAvFsTgvptIYdDZhShknbNTYLi/WiQhIkjuJG9F57on
	 yqPexN3I+wIeL5a7NXTK2sCdOTRDSTMTFsleL5vT9INtFz/jjSk+74C5l/s+5DtkW8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tRQAVEUrwPn7KB5j8sbB4XJLkyOTZHtLUOo/IakLPGE=;
	b=XfaVimMuqkAb8qBgydDvxMNSsXnh+1cyYAXuXvw97Lax9Ie0jppYU+x0HW4QmTsk5SSk
	 7lTxCuQW+j5qa/U2/gYFmDIW99k+3YQ0m2b9gHM9Ww41/1uQdC4WFfkzBpSxOj0OSSj6X
	 9a7dmWBtzPBKnwtZG32vmmX9Fbc4G1DjS93vdrQEeOe+iWXidlHKVxMDtwV2Sfl3QEdSf
	 CGEC3Czjn0qAJYW5X0Mtw1yIQdF/dSdGhXpIQGYov38MwRKxqJtca44180QGneXVB65lg
	 ACXGbq33LWonXMCTAXXDYYepHRSX9pH45MxMwXlgaE3JYCbO6wYS7ASoY9sbwWyxKFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z6R7ja1s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C64606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 15:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C64606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z6R7ja1s
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0d126f631so32303597b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 07:50:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794844237; cv=none;
        d=google.com; s=arc-20260327;
        b=VZo2TARZdDMCI60xd9CbKmDRlqXEXonWQD3Jgkq4RbJ+8bZeit7iELTUuYYT0TaB5H
         5+qFXSch4ZdE845OmNPOVg1ZhJnaW8sfu2ikY+fSqag/g7q4q+YLKjA2aANrIdT9nMvi
         l1ENvBv57D9TDFmAkRrjP7qOYSYYl2fJWvWQwRmasPZNMZ2DgHLu4i7QX7O0bVBldSiC
         x+PtNiDezEIqpqHiPPiZmTGvTk1Cye/z/3IAZ4/CPX5R7gq7fcqkVCeDi3km+Vsa5sTC
         vfI/2+zumQ3XgQNbrwM5wswvapweln59ff/Rz54jvUgO9Ew/T+GSsdErfCpTABIMrRsS
         AGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tRQAVEUrwPn7KB5j8sbB4XJLkyOTZHtLUOo/IakLPGE=;
        fh=n8wrWE1t/lyfxjWisXGrsQ7sWCnDfoGxkXTDYOeVxfY=;
        b=S9ssTV29HKU+pjt68OPOU6uhgUWnQAtD2AFY4F3+R0hXK0wJ17f/l7hl/DcCbJ+Olc
         8qvAHXpIpEsf4kVj8sCD7L2G1jNpFr2VuNOxiARSJ9Z+VjOpXRGIn1XPbbEeG+q5FzLo
         eEK4DBWmvJ+yxNThazQJGrxGSQ99SRKwozKhk0nSY7tSkm10TaOgxSEM4b80SuJVp8No
         iOO8LtXQ5BqsRR2+lvtx7kDS0oVQDx2uxjliQYrRBuzP6tPf9Rpib+if2SwRBfS4WSOE
         nTzLCvFwJKefokg7KCH3jaY1Z4892Ii16pC0tQjXxmPWYuJawVgZO27iuBmTB095ka4x
         VWww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794844237; x=1795449037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tRQAVEUrwPn7KB5j8sbB4XJLkyOTZHtLUOo/IakLPGE=;
        b=z6R7ja1sUv+jj18Ye5cNZ935nPwCJXtlxtmdHHDq8ZXUeCvNAH2ToYzG6kpiY9oJqv
         K02z/mF9OoTc79tF+Qw30J6cRgfUQmbl074Mf6303QLQHKLz5DvOYxlf2UG8BbYe55Kh
         NHHehfLcZrjoqH36tkELliJaMuT1WrT1H6XOPKMvyobu1GhE6SdEC6Vd1hNvchjIHCrD
         nxIoyO3FoQopxZiI0q3MeQcIlu7yO2AqXQBW3rLnGgF+5lPqHOkQGe1QVd6LmD1AtxkJ
         HizjAo3MOLp+U72z7NnZyPynVTkRFLK77v7K8J5SANEovypYS6t/s1s3PK5SoDfHUEAu
         XhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844237; x=1795449037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tRQAVEUrwPn7KB5j8sbB4XJLkyOTZHtLUOo/IakLPGE=;
        b=X45rROYN21LHP6nr0PDCmGtq4bnkvGGD+pyp982vx+ZR4QQ0yee17G8AyfoxZpRmvM
         Ou2j4ipoQSN//EtvzHHaotbbS1WNdd1tdKGEnVrJPTEQbA3t2k6QyFmzfWHeTB92s6uw
         NrdN+kUBUxCOSFX4UzyyEsqYQqL+776jblbO0o/JVtLiROaaLsnFVoVkSF145X7lL9kc
         X27K03GeJuib2V8MnTuUP9LgVsST8zg0fdBJO5HMbsAYp2SFMr5euu1e9LLLRmDaeR6/
         SvQY4pph5CzrNuCOIkQO0X0feLZ73VkvIS+noenO4+t3Mo0D17B6Mx7l7qx2Z9Z6YP96
         AzzQ==
X-Gm-Message-State: APuU4Z8+ko4YYnk/JHWIvOuWaN56pdLsdqrsMSJ/g6ZkwloTAPKMxYpo
	BOA941YBc5HPWCZSt0km8nfcQ4GoESVB59roLl3XAr2ADqOFMJzX0i14BVX/XUniak55w/JpW7v
	yZCbBaTNVCSrbjwk3dxOJi0k8khqIskU=
X-Gm-Gg: AZFdTZf8wwqW6OiKozQ6SmvwQmWRbQnw4A6ZxuBtO5PtLbNCfU3LomAQjzLb6gufYUY
	ptcFjQ9O7XoxhLIcXT1A6n+4G/kN9opbxBksEUgjHpFiw291w9UC3xaSbxqCUrD6BScW+Cz6cTC
	yTFRTQEfaG/EfFj8/fF31hi+ZYJohgyr+c5GxBRh4ff6lXAlsDyYUNqq9IdXwPWopIvBSxtX2Fv
	WFmqtUl68ofLhJsLVIzKUuBKpLO7m0iT0jupKQKwosn0eW3OiRmUZtMJ1wwufbflXogACXzqNvq
	7gkQC1iobbks7NMnVM6FeG8Shh4wu7CWukCkrBMuFCWPINvhxNyLXPxpbmRcD8duRg6ujaajn09
	ybL7YH5rmEgABCkK2szWqxg/FgOTMAuKzG7c1idr3pNOx1CjfdvsGQkhEo/GzRyKbIMIVGAy6rQ
	9LGOqp4Zz6yqXrDn04vYKK3p18UuYAvKZHt6SOx37Hbu+7G6NWQ8perlX+ug7e9ph1PCrpXbkcR
	cXxGg==
X-Received: by 2002:a05:690c:e3c9:b0:8b0:e385:edc3 with SMTP id
 00721157ae682-8b4aa331098mr67954677b3.33.1794844236760; Mon, 16 Nov 2026
 07:50:36 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115070055.45999-1-muxianli5401@gmail.com>
In-Reply-To: <20261115070055.45999-1-muxianli5401@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Nov 2026 10:50:22 -0500
X-Gm-Features: AclHuK_NmQKuXDoUZM7H28xLG_qXx3w1sDneN3gJmKJw9sCh0GFIrOy4z3mEqwk
Message-ID: <CABBYNZK7YmSeMEgn+Em3ibXq5+17B-ca1ScqaQmJZW6trt6Q_g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] device: Fix SDP records without a record handle
To: Muxian Li <muxianli5401@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Muxian,

On Sun, Nov 15, 2026 at 2:09=E2=80=AFAM Muxian Li <muxianli5401@gmail.com> =
wrote:
>
> Devices that leave the ServiceRecordHandle attribute out of their
> Service Search Attribute responses, such as the Nintendo Switch 2,
> produce records that all carry the 0xffffffff placeholder handle.
> update_record() then drops every record but the first as a duplicate,
> so e.g. the AVRCP Controller record of the Switch 2 is lost and
> absolute volume is rejected.
>
> Compare such records by content instead, so copies returned by the
> different searches are still merged while distinct records are kept,
> and cache them under distinct keys, where they would otherwise
> overwrite each other. As for records with a handle, cached entries are
> not removed when a later browse returns fewer records.
>
> Fixes: 8b2e688eaf5b ("Check for duplicate record handles and not UUIDs")
> Assisted-by: Claude:claude-opus-5-5
> ---
>
> Notes:
>     Tested with a Nintendo Switch 2 as A2DP source on BlueZ 5.85 with the
>     rec_cmp() change backported: its volume keys work, while without it
>     bluetoothd rejects SetAbsoluteVolume. The new functional test fails
>     without this patch and passes with it, also with AddressSanitizer and
>     UBSan.
>
>  doc/settings-storage.txt |  3 +-
>  src/device.c             | 68 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
> index 8bd677e24..2b075725d 100644
> --- a/doc/settings-storage.txt
> +++ b/doc/settings-storage.txt
> @@ -187,7 +187,8 @@ Each file, named by remote device address, may includ=
es multiple groups
>  (General, ServiceRecords, Attributes, Endpoints, NameResolving).
>
>  In ServiceRecords, SDP records are stored using their handle as key
> -(hexadecimal format).
> +(hexadecimal format). Records without a ServiceRecordHandle attribute ar=
e
> +stored as 0xFFFFFFFF, 0xFFFFFFFE, ... in the order they were found.
>
>  In "Attributes" group GATT database is stored using attribute handle as =
key
>  (hexadecimal format). Value associated with this handle is serialized fo=
rm of
> diff --git a/src/device.c b/src/device.c
> index 36a980d1e..a042f6267 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -5948,14 +5948,15 @@ add_uuids:
>         device_add_uuids(device, uuids);
>  }
>
> -static void store_sdp_record(GKeyFile *key_file, sdp_record_t *rec)
> +static void store_sdp_record(GKeyFile *key_file, sdp_record_t *rec,
> +                                                       uint32_t handle)
>  {
>         char handle_str[11];
>         sdp_buf_t buf;
>         int size, i;
>         char *str;
>
> -       sprintf(handle_str, "0x%8.8X", rec->handle);
> +       sprintf(handle_str, "0x%8.8X", handle);
>
>         if (sdp_gen_record_pdu(rec, &buf) < 0)
>                 return;
> @@ -6024,8 +6025,41 @@ static int rec_cmp(const void *a, const void *b)
>  {
>         const sdp_record_t *r1 =3D a;
>         const sdp_record_t *r2 =3D b;
> +       sdp_buf_t pdu1, pdu2;
> +       int ret;
>
> -       return r1->handle - r2->handle;
> +       if (r1->handle !=3D r2->handle)
> +               return r1->handle - r2->handle;
> +
> +       /*
> +        * Some devices (e.g. the Nintendo Switch 2) omit the
> +        * ServiceRecordHandle attribute from their Service Search Attrib=
ute
> +        * responses, so all of their records keep the 0xffffffff placeho=
lder
> +        * set by sdp_record_alloc(). Comparing handles alone would treat=
 every
> +        * such record as a duplicate of the first one, so compare their
> +        * contents instead: copies of one record returned by different
> +        * searches are identical, different records are not.
> +        */
> +       if (r1->handle !=3D 0xffffffff)
> +               return 0;
> +
> +       if (sdp_gen_record_pdu(r1, &pdu1) < 0)
> +               return -1;
> +
> +       if (sdp_gen_record_pdu(r2, &pdu2) < 0) {
> +               free(pdu1.data);
> +               return -1;
> +       }
> +
> +       if (pdu1.data_size !=3D pdu2.data_size)
> +               ret =3D pdu1.data_size < pdu2.data_size ? -1 : 1;
> +       else
> +               ret =3D memcmp(pdu1.data, pdu2.data, pdu1.data_size);
> +
> +       free(pdu1.data);
> +       free(pdu2.data);
> +
> +       return ret;
>  }
>
>  static int update_record(struct browse_req *req, const char *uuid,
> @@ -6054,6 +6088,31 @@ static int update_record(struct browse_req *req, c=
onst char *uuid,
>         return 0;
>  }
>
> +/*
> + * Records without a ServiceRecordHandle all keep the 0xffffffff placeho=
lder,
> + * so store them as 0xffffffff, 0xfffffffe, ... in the order they were f=
ound
> + * instead of under the same key.
> + */
> +static uint32_t record_storage_handle(struct browse_req *req,
> +                                               const sdp_record_t *rec)
> +{
> +       uint32_t handle =3D 0xffffffff;
> +       sdp_list_t *l;
> +
> +       if (rec->handle !=3D 0xffffffff)
> +               return rec->handle;
> +
> +       /* The last entry is the copy of rec added by update_record() */
> +       for (l =3D req->records; l && l->next; l =3D l->next) {
> +               const sdp_record_t *r =3D l->data;
> +
> +               if (r->handle =3D=3D 0xffffffff)
> +                       handle--;
> +       }
> +
> +       return handle;
> +}
> +
>  static void update_bredr_services(struct browse_req *req, sdp_list_t *re=
cs)
>  {
>         struct btd_device *device =3D req->device;
> @@ -6136,7 +6195,8 @@ static void update_bredr_services(struct browse_req=
 *req, sdp_list_t *recs)
>                         goto next;
>
>                 if (sdp_key_file)
> -                       store_sdp_record(sdp_key_file, rec);
> +                       store_sdp_record(sdp_key_file, rec,
> +                                       record_storage_handle(req, rec));
>
>                 if (att_key_file)
>                         store_primaries_from_sdp_record(att_key_file, rec=
);
>
> base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
> --
> 2.53.0
>

Copilot flagged some problems:
https://github.com/bluez/bluez/pull/2828#pullrequestreview-5922806710


--=20
Luiz Augusto von Dentz
