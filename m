Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45481AAC4
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716238122; cv=none; b=nOCSZgwEjPpaCHDaqeaPpGFvYasArRlUrnOcXxc54nwWiwlsEHiix/bcq8bPAzOuFJqNzsKHVzoj9WJdZZ3W36QJkfYnDfdHxJAqYI5G9aRn3sxGlqWVxkUswNfbHKmWRRL6Q1RJQb2N3S/raG/vLKclulzniUM6dKqcZUu5JKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716238122; c=relaxed/simple;
	bh=qaBtM51SlDVT//cwI5nUb16oU8864M7ZpJUQBoZeWc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVEVuh/kkquNaxVFaUZtINUxNYbbyEV34fauDEsc/Z8i4j82xwFXUBiP+TKoUD7hogzp2jJxw1KhF+mxi48jdco8xzmlcRtv9mOwKG8r3xFgLQ3UvNIyCLVUwxQDhUdtwOS82Bk/HZOLoM3C79bTf9dvBilY4RSffzm1rkzyJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8ub+zqo; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8ub+zqo"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e576057c56so35258321fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716238118; x=1716842918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avyWnSeXWLPg5DEwFEYW8hqZC91etf38zAOZ8qV8oCE=;
        b=f8ub+zqo1+841tFxAXJppQdAy6HkdFLskTFddQPEB5wox/NjFhU1cztXoDA5iYnBUa
         K3kiyxqqqyErm/BuOHwB+Z//+ILzNJq8b1a3SDviYn9QI19mvhjDJehpeuLJleU/2pxQ
         FhWdYrK/Fwq3RnGcf31zJPq6xZiLerNogpzegOv6vZMuLmPHiAS8qAUY38q41ttIjeKT
         sbYM8uhP47ostsGdlrx3GB7vmRzbF57Mij6V+Ka06TGVw04I9Xq3biYMxXByGWlPPAEb
         1NDDqZWDQ4mYIoIEhD+lG7DVIJhNkhi1SXkWOedsf8HZAl59sqk4l5+dddjkxo76qRTF
         5IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716238118; x=1716842918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avyWnSeXWLPg5DEwFEYW8hqZC91etf38zAOZ8qV8oCE=;
        b=BvIt6lq3jwMdzHK4BH7JyhkK9XjtGv+0oKQpkAE8wxAuN2DUb3gDiIih4n4PY1x66Y
         M+TTLUYTuFa/uJqsdjEhbEgo1sk1m4XmeslKZwe+Xw+YQhVTgQ8iW3R51nMDO+9ORGJ8
         I2wJsMRJD8brxpf8EgYQo3BVi89kCeRGGfnZMOIJ1fZzPChTjvTckIiTpaaze8pEUJE3
         10eKjFaaGy+2rTkUp3w4JCqxvmDam8o91JHVCCCGe+hawj9tnXXW3rnx7qUH5PUIm4Pi
         5Ty6pTDIz3aJvjAzVIdRPdbniXkdFlorYXwHSupQM0BOH9fpLCP9Lc1MNwChimvtmWoC
         eWmQ==
X-Gm-Message-State: AOJu0Yy/ad+Qzpkv1kkEw3Sfice/nMghzhN8i/NQ3xNDO4LIkxSIMv5l
	uIIaucKvGFP3BtH+lDNZqrO515Lju1bunIrtTEJ3yvQNMGr89jk51WFYX4s0tehlR54IeKSrsx+
	Ubqwu1bi7aRjHPb6nNXq0j7plBL44DwtW
X-Google-Smtp-Source: AGHT+IF7Q3rRB/BtMehaq5oxgLzRxO8V1N1QN5SWmvFl8BJxUbl1uccL/CbM4AtWaAsQAuHc4TVRkDBX8QD5+VHbry4=
X-Received: by 2002:a2e:3c1a:0:b0:2e5:62e4:33ec with SMTP id
 38308e7fff4ca-2e562e434acmr171094561fa.33.1716238118066; Mon, 20 May 2024
 13:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520201023.1437548-1-luiz.dentz@gmail.com>
In-Reply-To: <20240520201023.1437548-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 May 2024 16:48:25 -0400
Message-ID: <CABBYNZJy7jdo0TP768ONje_shZiHtod+sBau7FbvDBXmTWN35Q@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
To: linux-bluetooth@vger.kernel.org
Cc: kai.heng.feng@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kai,

On Mon, May 20, 2024 at 4:10=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This removes the bogus check for max > hcon->le_conn_max_interval since
> the later is just the initial maximum conn interval not the maximum the
> stack could support which is really 3200=3D4000ms.
>
> In order to pass GAP/CONN/CPUP/BV-05-C one shall probably enter values
> of the following fields in IXIT that would cause hci_check_conn_params
> to fail:
>
> TSPX_conn_update_int_min
> TSPX_conn_update_int_max
> TSPX_conn_update_peripheral_latency
> TSPX_conn_update_supervision_timeout
>
> Link: https://github.com/bluez/bluez/issues/847
> Fixes: e4b019515f95 ("Bluetooth: Enforce validation on max value of conne=
ction interval")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 5b509b767557..c49e0d4b3c0d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4647,13 +4647,7 @@ static inline int l2cap_conn_param_update_req(stru=
ct l2cap_conn *conn,
>
>         memset(&rsp, 0, sizeof(rsp));
>
> -       if (max > hcon->le_conn_max_interval) {
> -               BT_DBG("requested connection interval exceeds current bou=
nds.");
> -               err =3D -EINVAL;
> -       } else {
> -               err =3D hci_check_conn_params(min, max, latency, to_multi=
plier);
> -       }
> -
> +       err =3D hci_check_conn_params(min, max, latency, to_multiplier);
>         if (err)
>                 rsp.result =3D cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
>         else
> --
> 2.45.1

I hope that doesn't break the testing you have done, you should really
be setting the invalid values with use of the fields about and not use
hcon->le_conn_max_interval as upper limit of the stack, for more
details check the discussion at
https://github.com/bluez/bluez/issues/847.

--=20
Luiz Augusto von Dentz
