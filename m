Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E71343207
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624796; cv=pass; b=Rong+9Hye6wSo4WUsvVNgWBOGlqjUBcvvJQXGnWCsq9FP9HBJJCA7UuiFfmZ+BDJRY06VQ6d3lYXtil+VLSWQso587sJT6jzfdj3WBQP5heO/vZwR/wvgvkEn5233lpGlAB5lXIzuY3KEQLD3aA+PX/KcmOzZ4Mwe6YwRq+wcuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624796; c=relaxed/simple;
	bh=EbWCtaTF/5ETZm6xKPyTEaBpW0sSQaeXXNcjHzOajdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qID2yD+J3nNxLlkP1BI7d8uiSxBF3xp9CJZF2NxEuMOLwvSipSzD/WMynMZFCsVBHrSCQLRSjNcAnz0aY65k1+CuZu3V7jdJolYCtH92uLb3nCAErUDT2KDe/n5dTWx8hVnM6CWH28SENdKzV4brZ+ajvFXNzaxWs4QI0CER3Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDLFklQA; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDLFklQA"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6446c924f9eso94164d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 10:26:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769624794; cv=none;
        d=google.com; s=arc-20240605;
        b=HIPgzokirAdxaaE7nZR8RbZaKKP6PL8ZWVcPTEBlNqN5os6P6/s7dSMXJJJQSM9QCy
         xQ7MGs9uP3+ikUEmiIPR9ysWLqgJl/YyRKz18G5wfH4unmf8cWm0HKTYkMfYgBXO2aBB
         lf6V4CCPnsAC7myTyz7ua37zWp8lCg8wTC0YQDu+WYdicHx/yoLtHg05JgIS7jIw3WxV
         breJl1ZiWURPM6wJ0ngUIvzzC93bTAoaDhKL/p3nxNR1oCyjnfpTzV/Y5toHmYu3kInP
         RZIJd/WOGEOpmH9zXQE+yc2/ZUC5u9GXaTvUwuU1jlHzEmMWXZhDkHGkQ3lwok0CqEh3
         HKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bv9//WLlhd7ScuP1V2RDzRmJCiZS+8brU7BdsRLdhdI=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=eWfgAfFCjVT6It5y07oVIExcrchs2WAiykzO4Z3vMQc8iF0rrCRY+INRz8IcqZFJFM
         mg0cljh3oLf2OILv/0jy3SvKb1DRq2Coot+geF1cI6hN7pE1eZ9uKLtY8VTfkByZz4HQ
         QAEyM+fMe1GiTQxadZBZVRcFIEyssvtCEFXNZcJCouQYgdEJyA+pk0Q35lrX84FbV8ou
         g1NAtSWixRzyFqV6g42eNZonIGLxz68M51q6sjz91HrdSzws7I1GB/mf0Tp+OHZaEjeG
         EIvjT8iBXWAWXWRPyxqD4YX1XrOCaVCi1/ntzh8OWLN0AY1QIAvC0oM/zYq5OFwUkUXx
         8zXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769624794; x=1770229594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv9//WLlhd7ScuP1V2RDzRmJCiZS+8brU7BdsRLdhdI=;
        b=RDLFklQAZhRLT99Z+6UrcqlM8/FC5rJK3MOd7fU/Hg4dcvUEDqjtPZeqcVE0T/L569
         xreiyTYVXSSDzVI6u3m0KTVFSSBC+3N6IxSeu5S3BP1cbPPOvK2wDsbZx3mE0sUEXMbg
         MkPsqT5dqiSpm7JYwiLMnuQ8IUj0CVCwz8moSW7l+D4C1N7Uhuljj57QquilSslCWgZo
         B+Uoj2FFOuokZoSRJ4d7EB5lsaowmjAR1aRVzGJyi0NZ19K2UBDLMKFTw5rpeF7L9YnO
         KgwqbX8Zfq/+B6g0V/vsjy2C9TUpiSYbxd/tczy26eQ531ss5x7TANvVqhRWUSU4kYx2
         2JkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769624794; x=1770229594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bv9//WLlhd7ScuP1V2RDzRmJCiZS+8brU7BdsRLdhdI=;
        b=bfGay1oKThJW/U6Fnj7lTXxW2LJEhK0smJa2t7Q+6oqb6Gr4Rk99NcRivAkn9AH96O
         u3EVpxhoUUMXAU5OKAqrIbHjrb6zI6HE3zMNHmA+2oJxoNFIe6FXQm5tFbwgJCbdpg5E
         4Bk0DhS3hadCl6NI2RaqcUT/OZ+gb2zYiW+bqfq6oJmQSSJ18500bWkZ+ifTYiY674iu
         DJZjrW9SJxIHfMmDN25XmvK/CKWYrC976A+aLFF7b4Rwul8ELO6mYG+ck7ZVzR/fC2Uj
         Jczh94N462QpwN21iIuFsTC1jpCtmjAu3701LXQh2xJXFvBnicaxwZ/VS1Zds/gElHQT
         LO4A==
X-Gm-Message-State: AOJu0Yy/JK4pGVBQ2ZK9UcoPM9vbZ1/+2qNQ3LRjmxnHMvqHNBnAJSW4
	dmSyvq+3u0HJeKrIFB8lleTnNCNFUZTqxH9l+Aygs6D9M+9J1BWztu5Xu4ZmXi+HpTgKr4QGQ8e
	LQctSHEdt/r6mHfXdfQZZfdfKW5x6Ol7OHA==
X-Gm-Gg: AZuq6aL4NYJY1Hm6W/VCkeIKfIu44v6qB4SjLvoe6t+MsLUsj377tpLVsFrEasHXK8r
	tlRRSWQT9Q+wwYiqJCjG49LMAD0kidvq8/LM6FwzbYpwKwv2c3CbEA5vvBwWJhj0EXfd6XqZu9S
	TsXpEN8gySmVhw7C78b2E9IZglE6eaBBcefma3OzpXPFUak6gDHryANBhCA76SpyJ1bz188Bmo6
	0RnUQs1Bp9A+FNZ5q5e14DX9vO421Vk9PtlIBJ9YDBFaQj+MiIBlxmc9eagMSOICIu7JnTwzAOW
	E5I5byLbJcCECVNN2X6vzBHRfwSwpLqXGSMfNTiXcLK90QdYl0G28iizwg==
X-Received: by 2002:a05:690c:6d8b:b0:792:7745:72d3 with SMTP id
 00721157ae682-7947ac5d6bemr48906907b3.70.1769624793759; Wed, 28 Jan 2026
 10:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128155548.2025252-1-hadess@hadess.net> <20260128155548.2025252-11-hadess@hadess.net>
In-Reply-To: <20260128155548.2025252-11-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Jan 2026 13:26:21 -0500
X-Gm-Features: AZwV_QjY1GfLoE-C0I1MoxKxuxmxb5FO5eXhGEQGpv2W-r4sin395bEIQKo_aoY
Message-ID: <CABBYNZLzbZMfjW1RNOs8yiFdthPXgMukprbS2LO9EMAA+YbLXw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v6 10/20] tools: Install btmgmt along with other tools
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Wed, Jan 28, 2026 at 11:50=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> btmgmt is not installed by default, but it is useful for debugging
> some issues and to set the MAC address on HCIs which don't have their
> MAC address configured.
> ---
>  tools/meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/meson.build b/tools/meson.build
> index 63ae1363972e..40215df691b7 100644
> --- a/tools/meson.build
> +++ b/tools/meson.build
> @@ -160,7 +160,8 @@ if get_option('tools').enabled()
>    if readline_dep.found()
>      executable('btmgmt',
>        sources: [ 'btmgmt.c', '../src/uuid-helper.c', '../client/display.=
c', '../client/mgmt.c' ],
> -      dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep,=
 readline_dep ]
> +      dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep,=
 readline_dep ],
> +      install: true
>      )
>      executable('obex-client-tool',
>        sources: [ 'obex-client-tool.c', gobex_sources, btio_sources ],
> --
> 2.52.0
>

Bluetoothctl support mgmt menu nowdays, the code behind it is the same
as btmgmt.


--=20
Luiz Augusto von Dentz
