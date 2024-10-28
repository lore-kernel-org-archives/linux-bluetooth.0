Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B71DD54E
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125630; cv=none; b=Mz0CVwvf+sPqo1Z+r4cF3MsE9iMyqUFigINYj1dsHKelmFebBr7+W8UF6tZTkRG6PA1ERRAseO6RBua9CCYHa9q2biQbzQp94ryc9PoKiabaarXqZlatSlnNsVN/78/9fIHahNkbiW9hTu9M2ogE5bZd0RXQLoYxuDzEw1iQ8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125630; c=relaxed/simple;
	bh=UML5sPurDsAhsS1K7ZZNcVlw8lT7xsjYUs2BhclkXcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3gMLRMFPOxdq45dEMikc8fRl4ymEvFQQp5aw0OwgKNT4ByA+clcAaGWpTdE/TqBc9YNXZvkzJdV1ma6TZWjj82rKqoFeiBvXgUkkzYkMrIIk9fWGzp7zU4zx+Bcf19rF4hNQQPBCrW5aVuHfg3xcLcS0WiM3DhLtjbWya5qP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdc9sR/0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdc9sR/0"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb51f39394so42572061fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730125627; x=1730730427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb0yqeiH/pv/u9dI7GGOyonu4DBbKpPHHvT5cvRyyzo=;
        b=mdc9sR/0Fd4fSA3bZGu0QI3/xEz/TiOpH1GCJOMsqRdg8DTZtX8F5Dzlj/HeILN5dw
         QT3a5MAmQsfDFC836P7UJ0fQ3IAxqCWstHlXPJyrUEwMe3TM41GktWAbb4C8hPTuTgq+
         S3cu5UCwwDx/mO0IqxmwnnObUvOeDLQzEGWkOpDiIZbBw1FoLNMH0mglwkasi+D3dgLX
         mWljDMgyvmx7/QPsPxkmjuBwanl8s0AA6cYZrYdaCrdkfG33j9M9zuQojvYewKBDGVNI
         mAxTWH4PG1sj3tlmO/U3UK07dsewA6gg2Y8sQXe+EIEAy6ae6qnSKcMIxq/qOx5T6gPA
         bsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730125627; x=1730730427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb0yqeiH/pv/u9dI7GGOyonu4DBbKpPHHvT5cvRyyzo=;
        b=LASPwWKOPDnaJjcwidNQdg2J/Glpfyv6ebEhrh9sNW4TG4JDL7i7bV8Ykcq20k7WQc
         VECsn+uFZnx5Q11Su+0mxOL/4gWMF5kv5PRxEb5ZN7Dy89u1ZD0zxMnW9GReRwg2TGuR
         60UwyakcCssoAKra+I9p3Qo5ngZM6Vwphar+OOHPvlGHZUfDlUNgQ1qjOR0qP0hKWmb6
         jpkLXzmUhbRrdwmoTnM5OgcnRW6Qeu8HkLQXigrmZ7+yCftQxKzvdAR+xjD2RUsb7YRx
         v2vMg+X/UNyDFYrATDPFIyhV7mv1RrHRaQqMvb0eW89PNGBb9xQpMOPGA3jkQxKzMnWf
         CQ5w==
X-Gm-Message-State: AOJu0Ywiv2EAAEFrY/eO47DSw8JGEUFQYv6F6b0GN9rayLI+IXBRIMkZ
	iJoRgQusI7EUfhKrid3Tx6AQ91zLMHJV7SpoH/SNj+po3roq+4P6rsdDp2SXv+u16+fHbIiKJ9+
	OVlKfiTr0aWMuBx+2ipOe/uEaI/I=
X-Google-Smtp-Source: AGHT+IHg4xTeynBVaRdVNkP1MqY2fvIyFFyLGQrGhvSg3KJOG+y3P41T5M1w4e6I6xOtHL1FhG56CQMpXBszou10pTw=
X-Received: by 2002:a05:651c:1501:b0:2fb:584a:8ea6 with SMTP id
 38308e7fff4ca-2fcbe00f5a6mr35510181fa.27.1730125626515; Mon, 28 Oct 2024
 07:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028105326.3159618-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241028105326.3159618-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 10:26:54 -0400
Message-ID: <CABBYNZKj+pr5yLmrOEcDH9LCDBpvaq0XeBuN8nDzB1SnkNbY-Q@mail.gmail.com>
Subject: Re: [PATCH v1] obex : Fix for PBAP GET request in PTS testing
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Mon, Oct 28, 2024 at 7:10=E2=80=AFAM Amisha Jain <quic_amisjain@quicinc.=
com> wrote:
>
> This change is required for passing below PTS testcases -
> 1. PBAP/PSE/PBD/BV-02-C
> 2. PBAP/PSE/PBD/BV-03-C
> 3. PBAP/PSE/PBD/BI-01-C
> 4. PBAP/PSE/PBD/BV-13-C
> 5. PBAP/PSE/PBD/BV-14-C
> 6. PBAP/PSE/PBD/BV-17-C
>
> For all the GET phonebook request sent by PTS has no extra params
> added in it, therefore PBAP server is rejecting the request
> by sending 'Bad Request' as response.
> So appending few default params in GET request to avoid
> testcase failure.
>
> ---
>  obexd/plugins/pbap.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
> index 4175f9de8..3c23815ba 100644
> --- a/obexd/plugins/pbap.c
> +++ b/obexd/plugins/pbap.c
> @@ -524,6 +524,11 @@ static int pbap_get(struct obex_session *os, void *u=
ser_data)
>                 };
>                 buffer =3D default_apparams;
>                 rsize =3D sizeof(default_apparams);
> +       } else if (!rsize && g_ascii_strcasecmp(type, PHONEBOOK_TYPE) =3D=
=3D 0) {

Hmm, where do these values come from though? Are they defined in the
PBAP spec, if they are then we can probably quote the spec.

> +               static const uint8_t default_apparams[] =3D {
> +                       0x04, 0x02, 0xff, 0xff };
> +               buffer =3D default_apparams;
> +               rsize =3D sizeof(default_apparams);
>         }
>
>         params =3D parse_aparam(buffer, rsize);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
