Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1A2AF12
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736869; cv=none; b=bCY3qb7xTemFpVkJ6XNNFw1Im4u429ICDE+s8Pc2Yuv1br8iyzKljDCRPEmtfRHTpiCV1z/bfnQyYH+IHKOQdPJgV6hAZgVFzoFYO8hulWOkw7lSTwKxBSnhPxFhXYaVqNbryNdIhFaanvzZi1ptAnL13yfzUUCjxE1PQACMe7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736869; c=relaxed/simple;
	bh=je1iZJWpwdJUUi2Xg794PuVstQuYe9oOyrOBtMn647Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plGwz2oFvyqulVm4n8X/Q4khrNvUv3mt7Vjz3y4RsfayXrZ0u6V6FEsVRDRJGYt1btviG8/LNgD3E31Mt8N9kKQeA9PWORhxTcp6ZaIAQhq64bQ2WCJd3Oa24j1HWRUW/BYOGZf2vmH0uhyCScMJqjcIG7yI98JcW5nvMbG1kBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+JbJ+8G; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+JbJ+8G"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fe02c386so4832615e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730736865; x=1731341665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjYXhhVySXCxTl79TxbDQLx+i1NIPPkfoV77KHOirww=;
        b=a+JbJ+8GLD5wp8GATIHAU7/6MGOpVszI71bYqPvzko2meWpB+aP6gfi75eZnf/yWB7
         dNQXyDIGzDWEn/yYyvae4hBB6ceEng8JoOiG68AFxWxTqg9ClKaQdDzq6bJfasUZnGGW
         lrm///uomyceOb6kQOPseTGJRryLPE+a95efCM1z3/XnJi+Owfv+TUalPAZUUTLDux+M
         lWaOgMnLLL07zb/YVOiidskRgzGY2iwcJMPZPUrigOYExvl6WJydj2IT8IhydQjUr3XN
         yGKOhxtvKOWvJP6vD0SX+3RRKpZ25oZKGJaNKbZsC247wRf5KpDi+NvcXWFOivQkXeNt
         2spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730736865; x=1731341665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjYXhhVySXCxTl79TxbDQLx+i1NIPPkfoV77KHOirww=;
        b=YZUSnZtbtcY3fEgiYe+nAAB1LNJzKTwjBFcb8Bd7iQcp3A6YDYv8mfieB1opNwO+2q
         nBQpIsbbhcRYAL5U4eEmf8odulupKZfnsKMun4qdCevAQk0jmCypUMte4GqrJdJeeJck
         2TSmdwW/2PymglyAWOEnf4jt9E8mgdr1iZgfVNSumyd4RHv1ji9S9lIDqcyedcejL4ev
         GfzwZpIcWsL4P6wVH/13vmE0t9z167JgUOreWGEo3/rKCwPHmEe3soU8jWaBAfjX2lrC
         9BfYrtEIL9F/CE6MSNuRRFz6b7/iwWm8QiBwWbo4Hft1RJ8ZCAt5SdOF5zeiUgGLcfy2
         RbjA==
X-Gm-Message-State: AOJu0YwQ8pNSgbb5gMWg+9ki4tFoomr5CxAt0Qx86U0QiOv5N8AlCbgE
	b7OZgsSWn8XDuIPg8zU1LTIMwxOqbbtloadRWD2nDT5Xfe4oMXtIqnTm9QTCdB4l98nCJNr8AbE
	cDHxCwnY2pXLeA2ZEgT7Aylba4THGdHXE1SU=
X-Google-Smtp-Source: AGHT+IGBGhS++e2q4jaP1sBgG143u8AL2LlHyExs6YFUfI3zLPnZQvfcuxGMLyMwm5Z5Gmu8wm7l0Mv6zmhYpBWdtnY=
X-Received: by 2002:a05:651c:2228:b0:2fb:49d7:8009 with SMTP id
 38308e7fff4ca-2fedb3c5e38mr45309231fa.3.1730736865342; Mon, 04 Nov 2024
 08:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104091944.411353-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241104091944.411353-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Nov 2024 11:14:13 -0500
Message-ID: <CABBYNZ+K2KaztUPU_e7Zk8OfNSKJCRDMqw+9mR14rH8+0i7ziQ@mail.gmail.com>
Subject: Re: [PATCH v5] obex: Fix PBAP GET request in PTS testing
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Mon, Nov 4, 2024 at 4:26=E2=80=AFAM Amisha Jain <quic_amisjain@quicinc.c=
om> wrote:
>
> This change is required for passing below PTS testcases:
> 1. PBAP/PSE/PBD/BV-02-C
> 2. PBAP/PSE/PBD/BV-03-C
> 3. PBAP/PSE/PBD/BI-01-C
> 4. PBAP/PSE/PBD/BV-13-C
> 5. PBAP/PSE/PBD/BV-14-C
> 6. PBAP/PSE/PBD/BV-17-C
>
> PTS sends all the GET phonebook requests without extra params.
> Therefore, the PBAP server is rejecting the requests with a
> 'Bad Request' response.
> So append few default params in GET request to avoid
> testcase failure.
> These params are already added for Vcardlisting and Vcardentry
> operations.

Didn't I give feedback to have this fix move up to parse_aparam:

https://gist.github.com/Vudentz/4fd0ec9cff098a0470869bc99264d7c0

We don't need to keep doing this fabrication of the tags, which is
rather hackish, if we do something like the above.

> ---
>  obexd/plugins/pbap.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
> index 4175f9de8..fb5b6b696 100644
> --- a/obexd/plugins/pbap.c
> +++ b/obexd/plugins/pbap.c
> @@ -511,7 +511,23 @@ static int pbap_get(struct obex_session *os, void *u=
ser_data)
>                 rsize =3D 0;
>         }
>
> -       /* Workaround for PTS client not sending mandatory apparams */
> +       /*
> +        * Workaround for PTS client not sending mandatory apparams
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
> +        */
> +
>         if (!rsize && g_ascii_strcasecmp(type, VCARDLISTING_TYPE) =3D=3D =
0) {
>                 static const uint8_t default_apparams[] =3D {
>                         0x04, 0x02, 0xff, 0xff
> @@ -524,6 +540,12 @@ static int pbap_get(struct obex_session *os, void *u=
ser_data)
>                 };
>                 buffer =3D default_apparams;
>                 rsize =3D sizeof(default_apparams);
> +       } else if (!rsize && g_ascii_strcasecmp(type, PHONEBOOK_TYPE) =3D=
=3D 0) {
> +               static const uint8_t default_apparams[] =3D {
> +                       0x04, 0x02, 0xff, 0xff
> +               };
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
