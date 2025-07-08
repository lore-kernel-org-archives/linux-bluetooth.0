Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3872DEA9B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982962; cv=none; b=dOA9vog9Zl52LSY/FiWrgOw+1vHv4iVQ+MNu5xvAJXW/CjMtfd4HLDudntoZUKDShAB7y8ou9qVhxcF5bs84a5AElfGbVbidV3aqRMwRAhPW9sVO1N0lnp554sLxmPblYkq5abK0T/JroP/Xp8tMsajwYiYQEpfP32i88R67KzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982962; c=relaxed/simple;
	bh=ERTuQF11AHfOgr7f8ngFC/OV4WGyqjDt/UBy+r0SEWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcwROZJzBSncXJIgr4DWS/SJ+1NdrQ68RHTQD+aUiUavGin9utZHPlVQHebS/EcuamyQYw85UGfwF6ZiOFA6viCprdnx8DsmxsVcAD1zF0zvUaAwNvAPphTKZ5nZFMWPNC5t9lnOzQJ6xdbPYYeqIk0yATW1jG/repERVc2mdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlFPcZAH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlFPcZAH"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b43846e8cso35851521fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982958; x=1752587758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saSnqxM+UTx/oPu3s0Lx6y7+c55GBinULqdPU6oAqkk=;
        b=FlFPcZAH8zYpaesX1MfF4wJlEq1R1DKgCjIVlZyIk4esdsGvBXpLhCVuLOst67u7JN
         UO3J5pCdin5XuDTgxa3pUh3pvz509wIjlH9N6qAix2VBIkaCLlG8/0WC4cnaKjm3eQ31
         8bweQxPze9t3cS8utdzxGKdAq/xl2mgu20FdFnop/3mLTe0Mr/X5Jh243+zkn3qgoE/1
         iB4uYkSd1N3V7IdEpPeanC0OAj3mH5Q3EsB+1c15CVXKvO06WbDXxmdhKKRr0Uu4vxir
         d8SlgA77ZJ/vLjTIR391tP48jZjrjo2r09nv5gsIclsWAPlnFKT9tQmXUCRE+TwxKGXE
         +N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982958; x=1752587758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saSnqxM+UTx/oPu3s0Lx6y7+c55GBinULqdPU6oAqkk=;
        b=Or/kiDBb7G+R4GeesXwhE7wMhUevh4nh2tkO1nnxZ0OeV/S1B8hT0I56tLXI9dAWQx
         IIxa2wRS8v/hDKYiemZ1JFN3+0nHm9vj0ee2ugVF3EZXcLCgaAewUpso78HJxtRdMRST
         gzR2L21vtcwg/oDhN2tHotkWgC6W9HLa/APukAVlT0512fZN79HPfY3A/coqN+c1bgqu
         9rZmtjiKq/gGFHNR8X7eE4iO4u9Ou/GRJQFB7ume5lo6B3YHlBK9Z0GS+GuKiqPSFDoH
         YzXVHO+x98DUVfPjHb65JWAYUfXN78o2mlIqlKQFYt8I9YZUjWRuACkGcUN7gzTgj6my
         qCvA==
X-Gm-Message-State: AOJu0YyS5+XKiGspkQv65B5s0rWwivsqt+sj1/1JFYwGfgbaSZBcs2mk
	OHmgOrqRfHV+nnM5XN9EIiRADV+RhS46hgIy3DKWoW05Xh93GbBbEBjSgK2mBUy+ruLIUb/6C1O
	AgbfCVJpmhCz1kV6aTOG/VUziMCZVqg6e8BDG
X-Gm-Gg: ASbGncsn18JXtDYKPBCW+zFzrZMUSJPDIS4MMyIrxgzOGTHccfslTUT7Udd443lm4g6
	fCp7AvjDk0kQLQLlVTbfmJnOtGdmmoQSJljeXGv3DF2c/t920IXb7hHG6xlKUkjw00sRHyQfNFm
	ydaMLP/MpxuuziqJyPQntQlUDDtJz4rNyTuyDRQe32RQ==
X-Google-Smtp-Source: AGHT+IEph9J0WtsAelsrrmjH6M2dD3P2JOhfNOo8eFyEnfPABxQqCbO0yBz+XON15eAvkHhXraSq6nNcNi1njoNLVhs=
X-Received: by 2002:a2e:a99e:0:b0:32a:8855:f214 with SMTP id
 38308e7fff4ca-32f39b3ade4mr10465711fa.27.1751982958190; Tue, 08 Jul 2025
 06:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708070822.185375-1-frederic.danis@collabora.com> <20250708070822.185375-2-frederic.danis@collabora.com>
In-Reply-To: <20250708070822.185375-2-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 09:55:44 -0400
X-Gm-Features: Ac12FXxEAdR3EMxMBtbYZgX_-P-QfUlgzdz6Hyg47uA4X91Ida33kstG08AG3mU
Message-ID: <CABBYNZKcwLeAv9YG2JU9J8qdkKKo3WSF45aF428TrRUsOu4wfg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/5] shared/util: Add strtoutf8 function
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Jul 8, 2025 at 3:08=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This adds the strtoutf8 function that truncate a string before the
> first non UTF-8 character.
> This truncation is done in place.
> ---
>  src/shared/util.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  src/shared/util.h |  1 +
>  2 files changed, 43 insertions(+)
>
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 5d3a14d96..5262458cb 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -1959,3 +1959,45 @@ bool argsisutf8(int argc, char *argv[])
>
>         return true;
>  }
> +
> +char *strtoutf8(char *str, size_t len)
> +{
> +       size_t i =3D 0;
> +
> +       while (i < len) {
> +               unsigned char c =3D str[i];
> +               size_t size =3D 0;
> +
> +               /* Check the first byte to determine the number of bytes =
in the
> +                * UTF-8 character.
> +                */
> +               if ((c & 0x80) =3D=3D 0x00)
> +                       size =3D 1;
> +               else if ((c & 0xE0) =3D=3D 0xC0)
> +                       size =3D 2;
> +               else if ((c & 0xF0) =3D=3D 0xE0)
> +                       size =3D 3;
> +               else if ((c & 0xF8) =3D=3D 0xF0)
> +                       size =3D 4;
> +               else
> +                       /* Invalid UTF-8 sequence */
> +                       goto done;
> +
> +               /* Check the following bytes to ensure they have the corr=
ect
> +                * format.
> +                */
> +               for (size_t j =3D 1; j < size; ++j) {
> +                       if (i + j > len || (str[i + j] & 0xC0) !=3D 0x80)
> +                               /* Invalid UTF-8 sequence */
> +                               goto done;
> +               }
> +
> +               /* Move to the next character */
> +               i +=3D size;
> +       }

Perhaps we should split this part on its own function or use strisutf8
but somehow return the last valid character found.

> +
> +done:
> +       /* Truncate to the longest valid UTF-8 string */
> +       memset(str + i, 0, len - i);
> +       return str;
> +}
> diff --git a/src/shared/util.h b/src/shared/util.h
> index dd357fb93..6fc02a9dc 100644
> --- a/src/shared/util.h
> +++ b/src/shared/util.h
> @@ -92,6 +92,7 @@ int strsuffix(const char *str, const char *suffix);
>  char *strstrip(char *str);
>  bool strisutf8(const char *str, size_t length);
>  bool argsisutf8(int argc, char *argv[]);
> +char *strtoutf8(char *str, size_t len);
>
>  void *util_malloc(size_t size);
>  void *util_memdup(const void *src, size_t size);
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
