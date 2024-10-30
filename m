Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82C1D1E7C
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319243; cv=none; b=AtPf/LpiN+w/jqGTqjwl/7pIbNQyl41Pepz9cClAF31uO8WGMszXZZN/6M6FKdlXOMecV6YLKgHEf/TRxPyLjsPPUOF5D4IWunv+RiL/8WDPDagiZ4Yt/Wuzk6OJdlgVhULIx6ZZZM5yexWrL9+qRiBgZ+8LNE5anCvpBNSKgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319243; c=relaxed/simple;
	bh=1MSWCxepsAoQ8WikjMPGQlz3CaiFPZQaev87yzy9wBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cc3A0JfVz+0myn0d7ZKivsFqNp2REtpE9oEOsxpcj5sCztB1rjOtVV6zHevmSkaKxOb0gNOIlXz3+tzBPwJZffpjAD5lLLnqji9sDWezZmpqG7+4JuwDruXwVIAIo8LGHntYOiO1h1eOBaTkkp1pLv2F3b7tYJqHSZfQrWZnslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVQKTr7r; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVQKTr7r"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb443746b8so1972961fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 13:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730319239; x=1730924039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lyxdvIZJtYUtofs63l2EHmfFczjS1c6af7PehmrMuo=;
        b=YVQKTr7ryvhbPgsfOITcdbzW1xbZZ/DaWSHOAUNko12ZcQCTZ+qoVtCONHw0WWMnAS
         cFpvZBwwhjS9lUx84RkEoo57anozIZhq+Wjw0t5UhjCEPNn/+KnQEM5YXrn7A1aoENUk
         lmIv6TQNsDfqLlLaBnIe2q36tBuOCAZXT43JsXw5I0efr46NAjH0JUjwIroCyoliwhlc
         wgb0mKNIVrFZhTzpwD7jJ6av3XM4Ly6raxISS6bNMNcxYbgaD8qlTwWA6a0AHXcbNyDO
         tF1JTiq0CeFqaNJJibBrySMDCggBwRXKI/7UmAHAhmYmR2IwQVA+0TC46hTitb7nqlTG
         oOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319239; x=1730924039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lyxdvIZJtYUtofs63l2EHmfFczjS1c6af7PehmrMuo=;
        b=RVzlKbjx39AgWJpe6ZmP9LIEVo2FWQRswCEXDcn3ZbE6RbMqlKBwPhYn5H5TubaUw+
         naxejuoWtvoH2epwDlrNvxg1/MG80BiXm3Nk2GQGyiBZxnzNmXLYVg3vHtMImFakCEiG
         zeloP9KnYYVW1AGmLwmVSQpAhEL1TNC+H4Ai4HVx8oJ3x1HXt9Z4eSNcHdqmvuK5VzyM
         czrrsed2Gb3q50+nh/tHmJ7GfYNB5pma6akKGQDZijWb7HJgSTdYrtX6xLKiHQ4vQn5C
         M8PuSeSFlz/0aJbZMqNcSX2pspbuwV0Mvm2e6VLhFPkMxhUhGDlOK0o5E438cOD9s4+6
         kPxg==
X-Gm-Message-State: AOJu0YzbrO/3CGc96Te3pIevlddoccKwSb3I07mzMtZaXSox53dKg1DU
	RZF8gx7fPxes9LGqgSgLQkUMfjFsnrk9nYzf/Xnt2WIT4/oy8CXVKRxN+E0h7ADc5I9xUXxVwsT
	fubUO0/BhKFwf/Byp1T2UCfolmOH6iaaf
X-Google-Smtp-Source: AGHT+IEIIl7fbRrBIG/YJTQNphy6sBHKjKg0QJ0k0Lg95N25309NqsCPLmdLp6hPzMjVQ9VRWtuun4WUxqTrDL4QkZg=
X-Received: by 2002:a05:651c:1989:b0:2fb:b8a:7abb with SMTP id
 38308e7fff4ca-2fcbdff7529mr80070121fa.21.1730319238466; Wed, 30 Oct 2024
 13:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030083803.153001-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241030083803.153001-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Oct 2024 16:13:46 -0400
Message-ID: <CABBYNZ+yxUkr=S-PZPYWw4SSkvf+43w1mXrDcLiDg6TmdOGayw@mail.gmail.com>
Subject: Re: [PATCH v3] obex : Fix for PBAP GET request in PTS testing
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Hannu Mallat <hmallat@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Wed, Oct 30, 2024 at 4:38=E2=80=AFAM Amisha Jain <quic_amisjain@quicinc.=
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
> This params are already added for Vcardlisting and Vcardentry
> operations.
>
> ---
>  obexd/plugins/pbap.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
> index 4175f9de8..ae39d25b6 100644
> --- a/obexd/plugins/pbap.c
> +++ b/obexd/plugins/pbap.c
> @@ -511,7 +511,22 @@ static int pbap_get(struct obex_session *os, void *u=
ser_data)
>                 rsize =3D 0;
>         }
>
> -       /* Workaround for PTS client not sending mandatory apparams */
> +       /* Workaround for PTS client not sending mandatory apparams
> +        *
> +        * Add MaxListCount attribute, description as per PBAP spec
> +        *
> +        * 5.1.4.3 MaxListCount :
> +        * This header is used to indicate the maximum number of
> +        * entries of the <x-bt/phonebook> object that the PCE
> +        * can handle. The value 65535 means that the number of
> +        * entries is not restricted. The maximum number of entries
> +        * shall be 65,535 if this header is not specified.
> +        *
> +        * 0x04 - Tag id
> +        * 0x02 - length
> +        * next 2 bytes are value - 0xffff
> +        * */
> +
>         if (!rsize && g_ascii_strcasecmp(type, VCARDLISTING_TYPE) =3D=3D =
0) {
>                 static const uint8_t default_apparams[] =3D {
>                         0x04, 0x02, 0xff, 0xff
> @@ -524,6 +539,11 @@ static int pbap_get(struct obex_session *os, void *u=
ser_data)
>                 };
>                 buffer =3D default_apparams;
>                 rsize =3D sizeof(default_apparams);
> +       } else if (!rsize && g_ascii_strcasecmp(type, PHONEBOOK_TYPE) =3D=
=3D 0) {
> +               static const uint8_t default_apparams[] =3D {
> +                       0x04, 0x02, 0xff, 0xff };
> +               buffer =3D default_apparams;
> +               rsize =3D sizeof(default_apparams);
>         }
>
>         params =3D parse_aparam(buffer, rsize);
> --
> 2.34.1

I'm thinking we should do this a little differently:

https://gist.github.com/Vudentz/4fd0ec9cff098a0470869bc99264d7c0

We had already been setting params->maxlistcount:

    /*
     * As per spec when client doesn't include MAXLISTCOUNT_TAG then it
     * should be assume as Maximum value in vcardlisting 65535
     */
    param->maxlistcount =3D UINT16_MAX

But this code didn't account for not having any header and then we introduc=
ed:

commit bb27e5e1be7cbaac09aef5ff7a79f71a2ad8d113
Author: Hannu Mallat <hmallat@gmail.com>
Date:   Fri Jul 23 15:58:24 2021 +0200

    obexd: phonebook: Set default apparams for PTS clients

    Some PTS clients do not send all the mandatory apparams
    when retrieving the phonebook. Clients such as car multimedia systems
    cannot be fixed, therefore working around this issue by inserting
    default apparams which makes these clients work as well.

Looking in retrospect was the wrong call since we shouldn't need to
fabricate the headers if PBAP says they are the default then it is
parse_aparam that needs fixing so we just don't fail if there are no
headers. Now the only thing I don't get is why we introduce the
default to vCard 3.0 rather than vCard 2.1, or does PTS require that
for some reason?

--=20
Luiz Augusto von Dentz
