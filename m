Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF531155CBA
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499419; cv=none; b=P4E4MmicT65E/gqY70oOhMDRCWS0N7OOlghw434mJ2/Re86oqhv4iwBBt6U/qFrKGtBhK7N779npladOt48EuJNsbTJ7Ay4okYEFIthDVlrD7F/U6yJQC30VSAfBacEKOuiUfs+e9odzbSQ2UdJ63qhlRDCoMWpuhHKh5Fcb4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499419; c=relaxed/simple;
	bh=Plw5KV8TI2SveoCrqGUgbkK+8ItkRTCNwHREJn2mCUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5IErEw2UBGGw5BUEP6pQTZy3OevPlBoUiHU8tgRjH0E8u+c5NL0tDrgD1DiRaNV+epaooVyEOeK0SjqQbrHKWsc3oaVrhjjc5fyVlH6p6FQlQ+HVQYBsgedtFOsHZwdAO+oDR+G12CYRnhNhkAW7WFnDIX7pMMIWh+XfmHAMNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc38t0zk; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc38t0zk"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f66423686bso41082551fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726499416; x=1727104216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXdmYN3d4ZjnVSL2HqhjH98VAW0HBwoiTNbWXUHFTDU=;
        b=Jc38t0zkHTN0rXLR13gWmcR4M82pdlS1QTFPc2XlTcNLHfiddhBLaEtGOE1LrjYw8H
         Jmb3aa+Ag1Jv8eMM9p9noQRNRUJidv5wPzg128u7mMvxbSA2wqaLFsdDljXanKU4Qxu8
         nimTwCgc79XXsu2IEZPGxdTDOfWSWA6vL4QUNMgf8Hq4SMj0DYlCx8mJpRT/zC/7Z07z
         AYoFYlCXsfVWRZjMoqis641XR3ENg7CedsqrJ0mEst1la7Zs5LV4CQHbTbQM9/CBUkvW
         3X3S4w7UHfXEMyWn6CXuYkf6mHehGa3GSDNjaSwvXOPSa4Neqe9rwtSuKsaFKi4i096w
         kDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726499416; x=1727104216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXdmYN3d4ZjnVSL2HqhjH98VAW0HBwoiTNbWXUHFTDU=;
        b=Sc0cHZr/2Uu5IJj2nwAERSx0zti9cctnGabxAZae8w54fOFGvIvMJl1e2o/LxoPWcL
         nMTHsJYmye7+nNOvWcSdCaxshIScIPlPQTsxGAOHSK3NHuzQ7b1ihR0ufdja4s4cZHnX
         5uz5ulqA69lc6FyhxDWvH/HxxMig7TO8fQKzTEDkbdGrJuDWFLX0A+6Rzs+CJpct5RbY
         tCyFWUa2/RgHa3ZV3Ijg4icJwdXDXrn8oJlLGWKehHhu9GZPu6cinsnmpFqP7J7LQgOI
         W15ff2gRSk4vXY8gBM9zY396f2tJlGePS/1J86aab81nuyI3F+CrUwgnLdlRtrwAMsuk
         qUVQ==
X-Gm-Message-State: AOJu0YxSY4s6zsOzWfEMfDPwhOCnUh992Guf2P8+vu++4LuI0+GH06fy
	yd9g25JYsgH49r9mODtUuksbn/4WXvUQITIq6cnSEaTV4OGU1jsgaq6u1fDz427dUSd6FHwyGR3
	F4f3jt+Xoqtf8pAWL5m/dBW8mx8A=
X-Google-Smtp-Source: AGHT+IEToY6FNsOd3nvjsWuhPPZK0SRCBaB0+piqKZcwFrrmDRCViJIIrzfPjbYOfbjTvhZV6vtt6iaR5ndN6FmqjI4=
X-Received: by 2002:a2e:a98c:0:b0:2f4:f279:36d3 with SMTP id
 38308e7fff4ca-2f787da0b3fmr82352181fa.4.1726499414886; Mon, 16 Sep 2024
 08:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com>
In-Reply-To: <20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Sep 2024 11:10:02 -0400
Message-ID: <CABBYNZ+YMC856CdhETpCM9u4OYeO5+R+3hSbgigLszVaa+UPQQ@mail.gmail.com>
Subject: Re: [PATCH bluez v2] monitor: fix buffer overflow when terminal width
 > 255
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: Bluez <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Celeste,

On Sat, Sep 14, 2024 at 12:10=E2=80=AFPM Celeste Liu <coelacanthushex@gmail=
.com> wrote:
>
> In current code, we create line buffer with size 256, which can contains
> 255 ASCII characters. But in modern system, terminal can have larger
> width. It may cause buffer overflow in snprintf() text.
>
> We need allocate line buffer with size which can contains one line in
> terminal. The size should be difficult to calculate because of multibyte
> characters, but our code using line buffer assumed all characters has
> 1 byte size (e.g. when we put packet text into line buffer via
> snprintf(), we calculate max size by 1B * col.), so it's safe to
> allocate line buffer with col + 1.
>
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
> Changes in v2:
> - Add free() forgot in v1.
> - Link to v1: https://patch.msgid.link/20240914-fix-log-buffer-overflow-v=
1-1-733cb4fff673@gmail.com
> ---
>  monitor/packet.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index c2599fe6864ab44d657c121fcc3ceecc1ebc52a6..bef55477a221b6cb43ff22445=
4ac3fa593cd8221 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -376,7 +376,8 @@ static void print_packet(struct timeval *tv, struct u=
cred *cred, char ident,
>                                         const char *text, const char *ext=
ra)
>  {
>         int col =3D num_columns();
> -       char line[256], ts_str[96], pid_str[140];
> +       char ts_str[96], pid_str[140];
> +       char *line =3D (char *) malloc(sizeof(char) * col + 1);

Perhaps we could replace malloc with alloca here so we allocate the
line on the heap rather than stack.

>         int n, ts_len =3D 0, ts_pos =3D 0, len =3D 0, pos =3D 0;
>         static size_t last_frame;
>
> @@ -525,6 +526,7 @@ static void print_packet(struct timeval *tv, struct u=
cred *cred, char ident,
>                 printf("%s%s\n", use_color() ? COLOR_TIMESTAMP : "", ts_s=
tr);
>         } else
>                 printf("%s\n", line);
> +       free(line);
>  }
>
>  static const struct {
>
> ---
> base-commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
> change-id: 20240914-fix-log-buffer-overflow-9aa5e61ee5b8
>
> Best regards,
> --
> Celeste Liu <CoelacanthusHex@gmail.com>
>
>


--=20
Luiz Augusto von Dentz
