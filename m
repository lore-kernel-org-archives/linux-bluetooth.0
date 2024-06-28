Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7781BF312
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581920; cv=none; b=HL6HGQNdMN+zUPMj5ZoNg/f1M8qtU8sM5XuuWFEcbzOugG5HXrFvOFxFoo58d7yjgyh4HkPqrQ9Vw4Yuj9va5y9Lpwhb9FPb6IgjFvcr+uNrBjdY/tuNrkwp9gWW2M3Ej2SIJ1MhdyqNJ60SjU9Wt2EbL83PBpAkbzLmlnhWmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581920; c=relaxed/simple;
	bh=py/RemTgKzlBoSJXwZ0ajSUsJfonUKzy3baWgF4gtMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+0bgaoLvrZhEHfsNeGxhGXqJj4PmYemJrBk153n1l1HtxikI7NKLuV316UQwvprzNmqfsJgRTH7rA+jgu7QYXnr6DQYcTuGAj1haX63TwtLDsigeam4hzNN8ZU+mNKujrrbfe09JLa7rcjwEVGYlekmHpHSNWHfOnv0dMrUXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULyr81Jn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULyr81Jn"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so7211841fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719581917; x=1720186717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUOW4zPAXIpM86Igv82M37jRYOHKECfR91TAQpEdRQw=;
        b=ULyr81JnHLFuIBGJUru+Bk//L/q9HmA3bEdOynDA6JUOVMThCJYop0TzcTPCdBdX15
         J6Et9T+UxMWsW6ECZS01i3wXvSeFzxBexWOPCK+Y7KQ/Iz8IFV8tvPF4LzGsixCM5Igl
         FACAoJyLKni2wjgFOoJwdnkn9Ewit5cCp/hOqsFUiQTbCglKNNtbBwIcStu9w7jyg5t6
         l6RmQ8154fjvaKn3VJJt34gju+/FpGPy4LncfSQFrrsPi85a7YDw165EcuDlxvptzkgJ
         /yoJeUQmaXRajTrYnnFM9oHxWta30X6mi0SN/eI6Ut9Bp9gh2dd28v67m7PykXxDCj2l
         uKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719581917; x=1720186717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUOW4zPAXIpM86Igv82M37jRYOHKECfR91TAQpEdRQw=;
        b=P88BrydHhYciwesRGenfm1dM5I7JqK/LlkFQykKEdM+O+sckTGSAnY5bvklM8iAnkr
         Xan6nCRcrcpLm3/8pmc63AcWPIPhZgmYrsydyQFx1HGb0Kci+EsW1twLmr4BD1icYUcx
         5rKCjuiHuehsq8PnDTxCvr4tZSZSw/SYs8uwKAkRZKhxd2/iHbVP7WEc0gqf+UTsl2/T
         3A7r4cQ//FlYlHCoG3GLrcZkmHEem31CCKG1IrW3cczRTDEi6lXyNmmqhqNzwNwXg/kx
         tvxvZAv8cGMljAZ9y2IeCR8qK9FUWAhdVg9eQs/YfjWEE9F4Sa9HxXTw9OkOIqIKxJab
         pXqA==
X-Gm-Message-State: AOJu0YxCJFr8fF20XYVWqk0MMgRI5VG7H6NJFdzXGDFRs/3/nudQef0g
	bFw8yCgJ+X1g2VDSRMAPhALlVMemMvKFubtzxiMrKRBwNKAgbXgEohoto7eoPKMDjBpe2T4iA7S
	KQ+8o6u/nwa5ynwKNX9iUqYy2lZEWwA==
X-Google-Smtp-Source: AGHT+IE80XluZgvhAU0ceJgD3vO2SSj09k5mVBm+fBMPjZcT5DwYwWBRV8CAodImBrXEUcMIXsFxKI2mJZ0BfvfvBHY=
X-Received: by 2002:a05:651c:211d:b0:2ec:5dfc:a64f with SMTP id
 38308e7fff4ca-2ec5dfca710mr123801211fa.10.1719581916770; Fri, 28 Jun 2024
 06:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628072342.2256-1-quic_prathm@quicinc.com>
In-Reply-To: <20240628072342.2256-1-quic_prathm@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Jun 2024 09:38:24 -0400
Message-ID: <CABBYNZJ7RfPu61tt7R-nrUfZX1DnSY73KS84p9QiyTW7WDpfXQ@mail.gmail.com>
Subject: Re: [PATCH v1] Added BREDR not supported bit in AD Flag when
 discoverable is off
To: quic_prathm@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 28, 2024 at 3:24=E2=80=AFAM <quic_prathm@quicinc.com> wrote:
>
> From: Prathibha Madugonde <quic_prathm@quicinc.com>
>
> Fix for GAP/DISC/NONM/BV-02-C
> As per GAP.TS.p44 test spec
> IUT does not contain General Discoverable mode and Limited Discoverable
> mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
> case, thus added BR/EDR not supported bit in the AD Type Flag when
> discoverable is off.
>
> Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>
> ---
>  src/advertising.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 5d373e088..9857ceceb 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -1444,6 +1444,7 @@ static DBusMessage *parse_advertisement(struct btd_=
adv_client *client)
>  {
>         struct adv_parser *parser;
>         int err;
> +       uint8_t flags;
>
>         for (parser =3D parsers; parser && parser->name; parser++) {
>                 DBusMessageIter iter;
> @@ -1499,6 +1500,21 @@ static DBusMessage *parse_advertisement(struct btd=
_adv_client *client)
>                 goto fail;
>         }
>
> +       if (!btd_adapter_get_discoverable(client->manager->adapter)) {
> +               /* GAP.TS.p44 Test Spec GAP/DISC/NONM/BV-02-C
> +                * page 158:
> +                * IUT does not contain
> +                * =E2=80=98LE General Discoverable Mode=E2=80=99 flag or=
 the
> +                * =E2=80=98LE Limited Discoverable Mode=E2=80=99 flag in=
 the Flags AD Type
> +                * But AD Flag Type should be there for the test case to
> +                * PASS. Thus BR/EDR Not Supported BIT shall be included
> +                * in the AD Type flag.
> +                */
> +               flags =3D bt_ad_get_flags(client->data);
> +               flags |=3D BT_AD_FLAG_NO_BREDR;
> +               bt_ad_add_flags(client->data, &flags, 1);
> +       }

I think we would be much better off using broadcaster role for such a
test case or does it require to be connectable? Anyway I don't think
there is a requirement to disable BR/EDR when not discoverable, so if
we really need to pass specific flags then perhaps it would be better
to create a Flags property so clients can set themselves.

>         err =3D refresh_advertisement(client, add_adv_callback);
>
>         if (!err)
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz
