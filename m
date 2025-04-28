Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F14155C82
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876895; cv=none; b=hEadMpMi8v7YgPaioPg5FJe3iqkpEOP2UITp1XUjdqGKCjY/LUdKmawItBwwYchrfu5jA19Te9PJWmpk10yWaCz9zLuPXf7AVk+5nJcftnn+diBc4O4p+86Vq3k+LeGB7nIxbAyalJ+OAn1RkSVgVsKPesInm37bp5klo2QaL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876895; c=relaxed/simple;
	bh=ipviPHmnKOeRXz2/WDGviXnXcUnnv8Hn2Q6vyHJjaJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNem8wkpnDwF1fKYY1tXhsWu1dDXIS+4sXFlnoqSHoscq+vYsiRKsik/Q12do0LsvlGM5TDPyWbx6HMm1vw2e/iaTnOBHyC5c993A/LqtaRtHFAJmxPI/KqcY0ZYgNA4gqmDhowOC+6zEk2nKMSLetepu8PXZKma41/1vSqlx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXutrOiT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXutrOiT"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfca745c7so47430541fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745876891; x=1746481691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uln41Dh+xXw18imPXZzMgwrx6TKc2NZQu3FKxwcPAdM=;
        b=SXutrOiToVAgL/IGlg/N0L7U9YsKYWyck7v2Lm3XF/yP+uX9f/gpETfWCcZos39E1m
         V9v7M6aOhvEY+R85vFsLurXP8RPfCKGYlmvtYSF+26kt9onVYT5SRHvGpYsSHpnYDX7F
         +sG/OelNO1M9CCDkiMgIES8DqVBp8k0oY0Lp0K/82tNZLAat2eQCV3/QwNan+p1mxqEu
         CZ4bpIESq0dS4m3w1PNcNKc6noYIi+nGr1bkx3eC/F4Qq0L9nqwAg9H27qyX3+3vAwgo
         GkV+SFdCZ1XIyWKiFCao9wGKaq3/qsVzqHUu8F4uRjUFN1DmqtrC2jH7+9ZcQ9Cu82Ud
         nN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745876891; x=1746481691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uln41Dh+xXw18imPXZzMgwrx6TKc2NZQu3FKxwcPAdM=;
        b=ib+25He85AWXv2Z6c/9uoAER0y2CHfw5X0pBYaU6E5OvcpoLo8/1mnfCt57zpLvt+S
         0+6je3A7iQMC+ysCDN42FIk+gna1OQBO5OukkoXhA/uQy1AgAmGCpKNojXJvAICZaDYh
         9oAsBDAYfN/e3ohwe48ArSuwjfD3MDnvOrUqLxzFh5/k7mZY/VxU0uj8ODND/DmAjB5I
         kTI5pu0cnx3fodu1ndL05aCyG3fgzSy/TBgtxnRSLgVN8jUE9Ef2zuZO/i6Lw5/0Sn0v
         wUvgVeS0Mcqmz1H38yMuB2KJTjvi2KA1s5fh8/6DHj5llfE9LLHF6SgQ8YVlPcpuGSnz
         Ckug==
X-Gm-Message-State: AOJu0Yxd54rCVQevz51RTcH9fnEkPgWvS0T7F0gMoh8tqlNe5svQEK+Q
	jrmbrMatpsKI6FZar3EQ4UxwGp06CNkm9Dnw3540pQeffrk2TcM4yizSL/cr1N870cGLwfkURIC
	o+6GJqb6Jq3seb/v3PmVWECeeWKc=
X-Gm-Gg: ASbGncvx5O9uU5tYH22n+GWDAnlYt4jAcYKSXhA33qYePKjLBKboEgyFv5hvToRIozt
	4OnnnC8Qk56r2QfyzrLZNLm7yI4hL9uQpo+Kk37NaWWC/zl/N36WuedxgOjMY2cF18cpSWl53cc
	ZWOqxwzIt5m03W40eGY8sh
X-Google-Smtp-Source: AGHT+IEgMb+aFjZIlWbv/GdznJJTFgu7gC0cHZna66m/meKU/VqhsDMhU6lhFUeC9X3S04c/ELmLumW5ItBvQYoa/is=
X-Received: by 2002:a2e:be0d:0:b0:30b:b204:6b98 with SMTP id
 38308e7fff4ca-31d5b02d72fmr1262171fa.12.1745876891027; Mon, 28 Apr 2025
 14:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428131842.488921-1-kernel.org@pileofstuff.org> <20250428131842.488921-2-kernel.org@pileofstuff.org>
In-Reply-To: <20250428131842.488921-2-kernel.org@pileofstuff.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Apr 2025 17:47:58 -0400
X-Gm-Features: ATxdqUFHfJijLUr0MT1pAEuHl7mHg65YHLuQyQKf-VSdduWIL06k8YwFkkILKBU
Message-ID: <CABBYNZJYXti3xR5MqkOTva0T2U7__17VAmfjJyyy6iBhUSRf7Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 1/6] pbap: Support calling pbap_init() after pbap_exit()
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Apr 28, 2025 at 9:19=E2=80=AFAM Andrew Sayers
<kernel.org@pileofstuff.org> wrote:
>
> pbap_exit() didn't previously unregister itself thoroughly.  That
> was fine if it was only called when the service was about to exit,
> because everything was implicitly unregistered when the process ended.
> But we need to be more scrupulous if this can be called throughout
> the program's lifecycle.
>
> Send the UnregisterProfile message directly from pbap_exit(),
> then call unregister_profile().
>
> The UnregisterProfile message can't be sent directly from
> unregister_profile(), because that also needs to be called when
> register_profile() fails halfway through.
>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>  obexd/client/pbap.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 2f234fadf..90f8bdc02 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -1485,8 +1485,20 @@ void pbap_exit(void)
>  {
>         DBG("");
>
> -       dbus_connection_unref(conn);
> -       conn =3D NULL;
> +       g_dbus_remove_watch(system_conn, listener_id);
> +
> +       unregister_profile();
> +
> +       if (system_conn) {
> +               dbus_connection_close(system_conn);
> +               dbus_connection_unref(system_conn);
> +               system_conn =3D NULL;
> +       }
> +
> +       if (conn) {
> +               dbus_connection_unref(conn);
> +               conn =3D NULL;
> +       }
>
>         obc_driver_unregister(&pbap);
>  }
> --
> 2.49.0

Quite a few errors still: https://github.com/bluez/bluez/pull/1208

--=20
Luiz Augusto von Dentz
