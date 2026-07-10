Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128020C00C
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711989; cv=pass; b=Bv3I/mBeGVXv/PZaHmjchMQQ6c4l4KX8V/FWamcHJu/QEy3Q7w1oM8xjt7scb8VKkNVHJwD7oHGJzY3BqXk3j+IOI98zRBF9htZuXuuBwGcmhHxBJtHHhQerAEr6fXg8n4j9mhajPcknSSyhi9UtkaPrJlZp6st/4K80fKGeNu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711989; c=relaxed/simple;
	bh=CXfu9D06VinujM6cu4eghA7eA8do2Py5+4fuQuDMfRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jox6xeflRVaayIu68hs9owRUs/c9JPCvfFP37AMWq0UNbYTJfkuJZEHBixDLXmtamXeHTn0B4QCuyhst11BhBi/pouk4c4QzW0WB6SxbDnFw0cFyMspMrWD6P2HlwuxpEKjEIeR3M2dIBuKZSV6m1T5ni+vG7FwJUyILsMuQfWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKbsE8XJ; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKbsE8XJ"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-96925a563b5so908046241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 12:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783711986; cv=none;
        d=google.com; s=arc-20260327;
        b=MEiIDsQKosjomosrSod50Yslzv6hlLGUiwc5rNmkWmeiT/FCy8MSyUtfJcNn7y5ltr
         jQakOocmjKP6zhksrJDCZkCRbJbXrkU2o5KTLar4NE4eO1VrTmMmvWXOQkPtiAbEbGz4
         6aEf1yEfOkdguWAqbhW+pzM8w79MZ5sp6ATRE6GT0VvP1JsMkrnL9Oy+uqLHFRlbpwbv
         c4s26HXv16j1ojuBR/j66ZgS/jjxaO/8+ULb5Bx6SLP7JIlyTb/COyoRarH82WywMmyM
         OwZD7tJ+qlrXdQKcivVgI6OMmM08sr6n/Mxs6JwYCKgIku9/0j+6r/j6vSUs73anDuPa
         +z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2eYPM8bU9mH8qpavXlZH9UZTK26JBRecfCtx7SDTAFY=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=hJhTiatz4RP2QfJP0DZLl1y6T+mN1MUqVXVb0sqNQWMdxAvTm1JxfL55FTbpBXkTtv
         kHnGYUw2dUYvIOGUoaXlaydX+TnZ1RteY7gUzU5dB+QOaCtazp7oOZuvyhBE3cQQApeW
         d7H5Skbr+iHBVBhRm7UNI25mT8OFgRFnbjTQb5MJCBwViBoqr+8375iYGiLESwvwPs4A
         pEKeH0sfJW29dKRgSa0g7NZgiU+9L1oOGEomjWTjgi99esFZNZXrOjet0F877k4Ndi+Q
         L1GXPnOgkCK8+RJUiCpDVA/PGOC00yW3xQW0smrcRKcylU3FLlNQn+w4zVi7xMgWrNlp
         r0/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783711986; x=1784316786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2eYPM8bU9mH8qpavXlZH9UZTK26JBRecfCtx7SDTAFY=;
        b=NKbsE8XJN96H6TH+yBxdxktMcDT9/ue+dWpRikMlz6XPzU1cxi4B6QoW4nNURzdXZ3
         MWSZ8weBRHEqNY512d5NXzBdw5xvQajcVWZTfuU3PG9ncY0oWG9pD8FqqB0nRgQucc3a
         WwsXzVdPDF4rD7IFFHOj9YJqkEQb0Jq3VcWatWKQDfJlf+gJWL45Q9UCMzGj/wcYEiNd
         4k5f2Ew9TV/Y9g0UWIjL6r6BSeDQeVNVIWhB6AUm3aZcQvEUh90GlvES7k4BdYkdiULY
         Nq3W0m0qNHyeb2D+gGnknecDXZyCtzOo+wFfzGh7fNfO1TfI/m5mqNxeQWb5+ijIlLvl
         /izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711986; x=1784316786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2eYPM8bU9mH8qpavXlZH9UZTK26JBRecfCtx7SDTAFY=;
        b=oCQCMBaQA7N8bcWv372GZ7eU/KEWNjeBSJWdEahxxv9yH6xKoLYn44x6wg9Gy3wPPF
         dWavd4GE8onZqT85FPlcup3jUwpj2/clAQLHBmEyCW2+lNUH9KZc79eo8CpBNpNBlYSD
         7vgxkUY46Mt2w6CW9TZN1x6VbnhFaMFM/b+SiLlomDnKyyGPCMJxHwo5Zj5DIcZgR3b4
         Q8sDdI8sSA4V01spoHBhB3jz8kSkQ9BlKn6JcSMA/D+gofnPRtH0Z6CBijefXnZn+Qys
         WA9jYDa3/mzicY1YrEujhKjtqN7S6Cu4RbBJJABSjye+Nghr3v0e0DCLmt20t0IFHgfw
         xM7g==
X-Gm-Message-State: AOJu0YwMu6MSk09U+oMyY/2/fPQcxI2wAE8pIy/j1Xwa0SCb6+5WKvrF
	SmzwTCBeZSyMRtplUsjcUvVkqVtI65cgT9aAF5IT/mzjH9PjM+AeKQ0dtM/wqlhmv3EAvDu5cCn
	AKOQPKszVr7av7DETDUCgNIIBY53FU95N2U/VNWY=
X-Gm-Gg: AfdE7cl1Cy+S5SLCeWMQ4DJglYdrro/spcnYDsIGeMrAeLJ66gBOsMYrTk77mjSE3Mi
	kT2kUUVT/xaDRQFM6/tq4rCPC8zkTz9B9Sk2bwWTauzlmY1/iBitb9HYvLYqzMhDXezuV18/sK7
	+FL8li7cuLoEs6LDWYEgq8AdVNbwmzxEMw+8wvPZxkOvCbMtBh1UCj7eYsHFlifMH8lFF/JsssV
	4dZtGnwtJpHoNPU4F4p8RqERqKcB34mss2hYaCKhhzJN5a3CK0TDVwNpslPADjsLOYd+8UkEoJ+
	2vVVAk9E1eB2tEQcx3fGNfvVw4F39uUjK1RYZDHzqvHWQFBE7paQkazB1tg=
X-Received: by 2002:a05:690e:4181:b0:667:6b29:2260 with SMTP id
 956f58d0204a3-667c5ae274dmr3292231d50.19.1783711549810; Fri, 10 Jul 2026
 12:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2b3c5425a653eb198700cb28c453607e2d82840.1783707145.git.pav@iki.fi>
 <c3adb30ff640e151c09b50fd7a560111f0cd6cf8.1783707145.git.pav@iki.fi>
In-Reply-To: <c3adb30ff640e151c09b50fd7a560111f0cd6cf8.1783707145.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Jul 2026 15:25:38 -0400
X-Gm-Features: AUfX_mwnDICzER46cpJlJLqma-gJqq5px2tO9oOoHkJxmbofWjarFxctNmDpqGw
Message-ID: <CABBYNZL2puRO_kEm0h2D1fe0B6k0us4XyZ2Hqe57Ci5dF_HDxA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] monitor: fix parsing of ISO packet data
 header and slen check
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Jul 10, 2026 at 2:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Check PB flag to see whether timestamp and data headers are present.
>
> Check bounds before accessing data. Bump handle_str length to fit
> maximum.
>
> Byteswap length values, and mask Packet_Status_Flag correctly.  Remove
> SDU length check, as we are not tracking fragmentation.
>
> Fixes: https://github.com/bluez/bluez/issues/2292
> Assisted-by: GLM-5.2
> ---
>
> Notes:
>     v2:
>     - increase extra_str size to avoid old gcc version static analysis
>       false positive
>
>  monitor/packet.c | 60 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 23 deletions(-)
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index e62ad4cfb..a478cf93a 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -14540,20 +14540,23 @@ void packet_hci_isodata(struct timeval *tv, str=
uct ucred *cred, uint16_t index,
>                                 bool in, const void *data, uint16_t size)
>  {
>         const struct bt_hci_iso_hdr *hdr =3D data;
> -       const struct bt_hci_iso_data_start *start;
> -       uint16_t handle =3D le16_to_cpu(hdr->handle);
> -       uint8_t flags =3D acl_flags(handle);
> +       uint16_t handle, dlen;
> +       uint8_t flags, pb_flag;
>         char label[8];
> -       char handle_str[56], extra_str[50], ts_str[16] =3D { 0 };
> -       struct index_buf_pool *pool =3D &index_list[index].iso;
> +       char handle_str[100], extra_str[70], ts_str[16] =3D { 0 };
> +       char sn_str[16] =3D { 0 }, slen_str[32] =3D { 0 };
> +       struct index_buf_pool *pool;
>         struct packet_conn_data *conn;
>         size_t ts_size =3D 0;
> +       bool have_hdr;
>
>         if (index >=3D MAX_INDEX) {
>                 print_field("Invalid index (%d).", index);
>                 return;
>         }
>
> +       pool =3D &index_list[index].iso;
> +
>         index_list[index].frame++;
>
>         if (size < sizeof(*hdr))
> @@ -14562,11 +14565,18 @@ void packet_hci_isodata(struct timeval *tv, str=
uct ucred *cred, uint16_t index,
>         data +=3D sizeof(*hdr);
>         size -=3D sizeof(*hdr);
>
> +       handle =3D le16_to_cpu(hdr->handle);
> +       flags =3D acl_flags(handle);
> +       pb_flag =3D iso_flags_pb(flags);
> +       dlen =3D le16_to_cpu(hdr->dlen);
> +
> +       have_hdr =3D (pb_flag =3D=3D 0x00 || pb_flag =3D=3D 0x02);
> +
>         /* Detect if timestamp field is preset */
>         if (iso_flags_ts(flags)) {
>                 ts_size =3D sizeof(uint32_t);
>
> -               if (size < ts_size)
> +               if (size < ts_size || !have_hdr)
>                         goto malformed;
>
>                 snprintf(ts_str, sizeof(ts_str), " ts %u", get_le32(data)=
);
> @@ -14575,20 +14585,31 @@ void packet_hci_isodata(struct timeval *tv, str=
uct ucred *cred, uint16_t index,
>                 size -=3D ts_size;
>         }
>
> -       start =3D data;
> +       if (have_hdr) {
> +               const struct bt_hci_iso_data_start *start =3D data;
> +
> +               if (size < sizeof(*start))
> +                       goto malformed;
> +
> +               snprintf(sn_str, sizeof(sn_str), " SN %u",
> +                                                       le16_to_cpu(start=
->sn));
> +               snprintf(slen_str, sizeof(slen_str), " slen %u sflags %u"=
,
> +                               iso_data_len(le16_to_cpu(start->slen)),
> +                               iso_data_flags(le16_to_cpu(start->slen)))=
;

I wonder if we could just skip displaying `slen` when it is 0 so we
only decode `sflags` for incomplete packets (0xxx).

> +       }
> +
>         conn =3D packet_get_conn_data(handle);
>
>         if (!in && pool->total)
> -               sprintf(handle_str, "Handle %d [%u/%u] SN %u",
> -                       acl_handle(handle), ++pool->tx, pool->total, star=
t->sn);
> +               sprintf(handle_str, "Handle %d [%u/%u]%s",
> +                       acl_handle(handle), ++pool->tx, pool->total, sn_s=
tr);
>         else
> -               sprintf(handle_str, "Handle %u SN %u", acl_handle(handle)=
,
> -                       start->sn);
> +               sprintf(handle_str, "Handle %u%s", acl_handle(handle), sn=
_str);
>
>         handle_str_append_addr(handle_str, conn);
>
> -       sprintf(extra_str, "flags 0x%2.2x dlen %u slen %u%s", flags, hdr-=
>dlen,
> -                                                       start->slen, ts_s=
tr);
> +       sprintf(extra_str, "flags 0x%2.2x dlen %u%s%s", flags, dlen, slen=
_str,
> +                                                                       t=
s_str);
>
>         if (conn)
>                 sprintf(label, "%s", conn_type_str(conn->type));
> @@ -14600,18 +14621,11 @@ void packet_hci_isodata(struct timeval *tv, str=
uct ucred *cred, uint16_t index,
>
>         if (!in)
>                 packet_enqueue_tx(tv, acl_handle(handle),
> -                                       index_list[index].frame, hdr->dle=
n);
> +                                       index_list[index].frame, dlen);
>
> -       if (size + ts_size !=3D hdr->dlen) {
> +       if (size + ts_size !=3D dlen) {
>                 print_text(COLOR_ERROR, "invalid packet size (%d !=3D %d)=
",
> -                                               size + (int)ts_size, hdr-=
>dlen);
> -               packet_hexdump(data, size);
> -               return;
> -       }
> -
> -       if (size !=3D start->slen + 4) {
> -               print_text(COLOR_ERROR, "invalid packet slen (%d+4 !=3D %=
d)",
> -                                                       start->slen, size=
);
> +                                               size + (int)ts_size, dlen=
);
>                 packet_hexdump(data, size);
>                 return;
>         }
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
