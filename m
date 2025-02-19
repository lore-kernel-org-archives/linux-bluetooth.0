Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18D22DF83
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996546; cv=none; b=C0fDDaDWCx+ZeJdSQiuH2HsByiePeJSU3rBVGYkW/DFSK9qiwCsqTuLoPuUGworqInJviDW1owViWEROOztK/DYfxr/728d5Vt7h27yJC+bIQIP7uazdIXrUb8klQnDX882bwY9HrLm0AVbn77/d3js87HDTEw1nW1I5cc+l7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996546; c=relaxed/simple;
	bh=9YZy4QJTNtBo7j15AkbAMOkwsQ2LisyYTAnTx5Nn8G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2oFa0CJ1FVMdUv5Jc+dSOG94id5QLh7pZlQZbWrvjhBFKxcK3nZHixJM0XoHfROnCxofIP8IPzzYRsLum77KH4HWnQzXwXkXl7DFCGn1AiVCtjDs7NiMo+/XSA7vs7ncf6+BQ5h9LBM2b8Bo8rtt37IMcJ/Nh/4VL279g714pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br/H2h+m; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br/H2h+m"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a303a656aso1880801fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739996543; x=1740601343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAa6jHbwqlM3cMu3oxUdt2jI4znKcwSvmiAZqr1n6gc=;
        b=br/H2h+mZ8WtLAlcJxbkGWvy5YmlRIgZv2NIhIjgxBy2hBPHVOPFRg+1H97wa9tC7a
         S9fTUhf1sLBSp5E9YXjsEVsFUwjgaDE2jfztWSJUWr9NWKoI2km+bNsbxfy1UhCj5VqX
         UY4BbzP/ObkeCz63gyIE/r4lAzyPWhzUSfSbnBehbE+545kGqrQVQTTj5X969/lJLKAv
         BaU2Xeq4OxThEGRf/1eHr9GIQp6A+v9zPHZgXxt1LLCK0A7DUSjuHBUWtXJg0Jo5GRhL
         6n7rpKtU3FjCt97Ic7P6rBdfQRFvjptXZFt5SoD38bE+OO7dz2ecXRdrHv0sM5nT2uae
         e5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996543; x=1740601343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAa6jHbwqlM3cMu3oxUdt2jI4znKcwSvmiAZqr1n6gc=;
        b=nJ6LJ+RrKXJ6t99ycHNacov+ywrEC2+ppDJVnlPg72VkX8F616uzP7ny5pXFug0NNs
         cVfHGUbVXyr9kIcD6ct5po3JqQUguM5DCGPhcZhGh+3FAsILlTvuxL3i4OkVLq5hTQL3
         uV1pHlxNv8hcUbUSj463Rk8nCbDGXk+G6YjequpjjpFaMiYgsf0ZtCgLKeIhY+tOGjKe
         lucuFrxeYAL7qaQPjF/4eI7vSSUXknzw+DX/E/A3BbDYBsX6cW2KKhYnBNomDX4nKXhp
         E0Bir7KUNNDsUJvgk9wzacr014patzq27tq6yHVy0i7g2C6O/22stOaCa04D4QSTbUEi
         2FjQ==
X-Gm-Message-State: AOJu0YyZvaNR0XogYnxb86KGGlwec8YKwfZW4Z+Gu4DQRbbZzkRxMf44
	cx1sAvV6YcP8fWZdZ9evDcygLwlh1tP6e1mfggzizv0sJ8xpNl+dfjz8QYUelKcnY5LarVKkrT6
	oqzIiviE/5jN9AeNwzsSUrh46E+c=
X-Gm-Gg: ASbGncsYYmsGKXGyntsEMsuegumqecuXGpyxb2Mm25oc0nJ4/djZLm7Ke1/5R6qF5dp
	+eswY6WepKtDVK9kLIoLO1V+n1XFq9hkXvqSMay8XpbP7CeyCrlxHpBD5r2Hjp9XvMMCwC08zZw
	==
X-Google-Smtp-Source: AGHT+IG14IpXKZ+nVR2mEfyQSBGJ94/unILzmjGnuCuq2d1zM8+ThUtqMjiE4aZyLFKnwIvdgxp/8LyVzpc6198YFus=
X-Received: by 2002:a2e:9dc9:0:b0:308:eabd:299b with SMTP id
 38308e7fff4ca-30927a2e076mr44900881fa.7.1739996542946; Wed, 19 Feb 2025
 12:22:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219184758.115316-1-quic_amisjain@quicinc.com>
In-Reply-To: <20250219184758.115316-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Feb 2025 15:22:10 -0500
X-Gm-Features: AWEUYZmgVJzN8Iec3SkUX3T320AKypw0Q-XS7ITt4kx4k5XjVAwA47X4tvIropE
Message-ID: <CABBYNZ+A01k8PsvAmafCHNTfZiHCuU-gML-Q4Sk9-buePrCDkQ@mail.gmail.com>
Subject: Re: [PATCH v1] obex: Add messages_get_message() implementation for
 MAP plugin
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Wed, Feb 19, 2025 at 1:48=E2=80=AFPM Amisha Jain <quic_amisjain@quicinc.=
com> wrote:
>
> GET Message() operation should be supported for passing below PTS
> testcases -
> 1.MAP/MSE/MMB/BV-12-C
> Verify that the MSE can return an email message to the MCE.
> 2.MAP/MSE/MMB/BV-13-C
> Verify that the MSE can return a SMS message in native format to the MCE.
> 3.MAP/MSE/MMB/BV-14-C
> Verify that the MSE can return a SMS message with text trans-coded to UTF=
-8
> to the MCE.
>
> Currently get message operation is not implemented, hence above
> testcases are failing.
> Added code to send the complete bmessage in response
> to the get request for the requested message handle.
>
> ---
>  obexd/plugins/mas.c            |  4 ++--
>  obexd/plugins/messages-dummy.c | 32 +++++++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> index 10b972d65..f63fcf6c6 100644
> --- a/obexd/plugins/mas.c
> +++ b/obexd/plugins/mas.c
> @@ -612,11 +612,11 @@ static void *message_open(const char *name, int ofl=
ag, mode_t mode,
>                 return NULL;
>         }
>
> +       mas->buffer =3D g_string_new("");
> +
>         *err =3D messages_get_message(mas->backend_data, name, 0,
>                         get_message_cb, mas);
>
> -       mas->buffer =3D g_string_new("");
> -
>         if (*err < 0)
>                 return NULL;
>         else
> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dumm=
y.c
> index e313c6163..93648831a 100644
> --- a/obexd/plugins/messages-dummy.c
> +++ b/obexd/plugins/messages-dummy.c
> @@ -516,7 +516,37 @@ int messages_get_message(void *session, const char *=
handle,
>                                         messages_get_message_cb callback,
>                                         void *user_data)
>  {
> -       return -ENOSYS;
> +       struct session *s =3D  session;
> +       FILE *fp;
> +       char *path;
> +       char buffer[1024];
> +
> +       DBG(" ");
> +       path =3D g_build_filename(s->cwd_absolute, handle, NULL);
> +       fp =3D fopen(path, "r");
> +       if (fp =3D=3D NULL)

The Coding style is if () {, so not a new line.

> +       {
> +               DBG("fopen() failed");
> +               return -EBADR;
> +       }
> +
> +       /* 1024 is the maximum size of the line which is calculated to be=
 more
> +        * sufficient*/
> +       while (fgets(buffer, 1024, fp)) {
> +               if (callback)

Ditto, for the while statement you got it right so it beats me why you
are doing it differently for if statements, that said if it just one
line you don't need braces.

> +               {
> +                       callback(session, 0, 0, (const char*)buffer, user=
_data);
> +               }
> +       }
> +
> +       if (callback)
> +       {
> +               callback(session, 0, 0, NULL, user_data);
> +       }
> +
> +       g_free(path);
> +       fclose(fp);
> +       return 0;
>  }
>
>  int messages_update_inbox(void *session, messages_status_cb callback,
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
