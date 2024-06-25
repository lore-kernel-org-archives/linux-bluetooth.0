Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378D17C98
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323407; cv=none; b=Z8EyXcTermqkQ3t/J0pPcIgKVHAAtQcF8dWzQdWiAu8u0iEhz45ekHONDhZhblH4E83UJaSfIV3iGDgeMnvxkgOxQxPFbEiIwdzKXaOGJKS/wtGGAwm8aTDBIgx9YjLKb/deCiTPEdhUAwTtVw1OBgDGoFUbUIjjnsont1YAmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323407; c=relaxed/simple;
	bh=lPkR57PaUJiozhuNqHBvDwUcbcDx6dgY1VlLL75ZBds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMVGd3dR/erDywT/COdAAY/1VB02KgZ4KYC3CHKuXDsbBOS6HFIfclACP75Ujq3sHfOfWUJ47gGWD7q8N7bZvYTU+bw5AeII0GRIR1HctACcGHv+/T2vvCm/yjajk7JOdWegEZN3gpxZyHIHH0kA41JhW3GnWYlxlZPn9XVU290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpIOYdnd; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpIOYdnd"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso24523891fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719323404; x=1719928204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x58qO/tK3eO4BJzDJbXsHqtuIx6wnD4Fqs7aw59Rias=;
        b=CpIOYdndhq/ESvsiPQL/1fH7cEPUMgjksV0WSQ/uzZ/O1lG+bmXMwr8ZlIONV7wzv1
         Wa50yHxsg7S0BbEC1RubEu+7f1FC0hNeIXnWtHlt9lxgziQc0z5S/FoIucmue0lxoFUU
         f9bt8aMqdFnXmo+Hc4hhNtC7QANwFJeCoyFiJd0xOYpMJd00vNDxp2uJwQ2hO7eNwYRk
         MhsaaL2lfU33kDlx7vf5aYpcEDZ4Zl3cGDWEG7MIkcwtE3LRLGGQKJ3sON78zgC7+d3Q
         Or5GxROIoQueH4fdComyEHDn9dCYYKDOpg9oko9tHa+/amAxZpP2TRdA3pzZAw51AIEr
         MC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719323404; x=1719928204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x58qO/tK3eO4BJzDJbXsHqtuIx6wnD4Fqs7aw59Rias=;
        b=CTx1J5i6j30Rrib81+4vmI2BTtHwltZoNPREiKB7fFZI/UYV57icgI8EsLNtdGjm5N
         GxxwQRdZ4T+2ICFlZ645rsguK4C9l3WBwtHn4sGUkTarRSLD4xoZfpLQavoDSSq9jvd7
         J/D43Oj+Gs8b5gsCRMWCrBRsARtruTb7j0chFnYAfTKgKmEI4p856KvE40/lG25Y5YTc
         ZHjIpjijHyyPp1bMzfbA3QwzIAFKW6GBm1SeZBqIZxXqEofoCnV80ehWRSxprdt4qQsO
         y4Gc06DoEMUJt2vtwG2Xz/PFw4ifkVF3omKizn4E5jN9Ib+hkQx+2ZWhKlPZ2Z1aOhy/
         usLQ==
X-Gm-Message-State: AOJu0YxZ3WoXJvLg08K2m4JbgwYrh2xmoG+PwnDtnVqp/wXfRRT0ckv0
	zii3B4oaGLw0n7P++Eit/B4lvCSb7vwczjr9p86Zvvl3DSvWRmZUNTbdflq6A5uuUPQNzwj4uNn
	yGOqRPWsLvNpi42vrAxhcKdU7aoNFyZpf4Bg=
X-Google-Smtp-Source: AGHT+IFXWWTZze1xrrGW/NzJOEwEW/DHUC1wr75ULTicznAztfNcpViH6c1Apum1jw6klvu4rmLbRMaNJVh3kEF9aaE=
X-Received: by 2002:a2e:720b:0:b0:2ec:4096:4bc6 with SMTP id
 38308e7fff4ca-2ec5b318000mr43258811fa.7.1719323404080; Tue, 25 Jun 2024
 06:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625063533.30536-1-quic_amisjain@quicinc.com>
In-Reply-To: <20240625063533.30536-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Jun 2024 09:49:51 -0400
Message-ID: <CABBYNZJXjxL8_ZB6k6Paa3rg5b7nu08==NZzo73a85XcQwy5fg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth : Update the mas session structure
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Tue, Jun 25, 2024 at 2:36=E2=80=AFAM Amisha Jain <quic_amisjain@quicinc.=
com> wrote:
>
> Update the 'mas_session' structure such that
> manager_emit_transfer_property(os->service_data, "Size")
> will get the proper structure in arguments as
> expected like structure 'obex_transfer' and transfer->path
> won't be populated with inappropriate value.
>
> As there is no new transfer registered during mas connect,
> hence setting the path to NULL to avoid invoking the
> g_dbus_emit_property_changed() property.
>
> Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
> ---
>  obexd/plugins/mas.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> index 10b972d65..71bf12ad3 100644
> --- a/obexd/plugins/mas.c
> +++ b/obexd/plugins/mas.c
> @@ -51,6 +51,8 @@
>  #define ML_BODY_END "</MAP-msg-listing>"
>
>  struct mas_session {
> +       uint8_t notification_status;
> +       char *path;
>         struct mas_request *request;
>         void *backend_data;
>         gboolean finished;
> @@ -59,7 +61,6 @@ struct mas_session {
>         GObexApparam *inparams;
>         GObexApparam *outparams;
>         gboolean ap_sent;
> -       uint8_t notification_status;
>  };
>
>  static const uint8_t MAS_TARGET[TARGET_SIZE] =3D {
> @@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session *os, int=
 *err)
>                 goto failed;
>
>         manager_register_session(os);
> +       mas->path =3D NULL;

There is something missing here, you introduce a new field and set it
to NULL but you never use it?

>         return mas;
>
> --
> 2.17.1
>
>


--=20
Luiz Augusto von Dentz
