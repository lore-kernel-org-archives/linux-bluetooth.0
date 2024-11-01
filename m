Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F92146A68
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445553; cv=none; b=Wwfc8QAZv0uDIemDn/yVw+E3nSrsKotQxAsfkKWenGLjGUalqt0yqC+JAe+6udgA1GFq3cUqsZ4DLlA/7IhfUUp1N5qkNauCMeeLjNikwxGu+Uht/z7GhNqAlVqxpn3lblr/aX4rh+Pzl7pji7/s4iF6fBp0CMf0Dng/rDjXzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445553; c=relaxed/simple;
	bh=TGRdc9Ph2i5dfJ3St5yS904xN8FIFPbXoI31ulbu0zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5h9ZHtB4fPjctIbMzNrH1l612KZiDL9d/Uc87noSQG56YPdgUir9sntsc6RdAh0g4uYlYathMxtk8McFG9AqZUNVmhhxUsKZyzKoofvAIEmeCeMK4bGvYj95KUDWKQQ61RJbiHzYN7wfoKTORkDTp5Qx+7+0ZA0uAfK8nSngmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxw/LXv1; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxw/LXv1"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so165865ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 00:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730445550; x=1731050350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+wLLnLhNsXujidna1nWvg9nwHwNnXS4h7AAUXEZYZo=;
        b=cxw/LXv1imRyWCiVMleNViuqkxXdYuRNODXdwoa/16/AAt7iGf24Igq5uRRpUtLrUA
         Onpds7oBDn9YO53Z8cG9gZecOgheuxTLcfa/fvu3xK6AySieGTmYHf9rcZNA/6lfzBgl
         DKlRjKwjm4Ptb9e1UmUq+GDeJtyYFT3zvBIhhc1HtOba2xdRn31ERkCl+vewtqgeJ6QX
         Ifouwy2wYFFaLpKwXXB6xgE0fP15M1F7QbcgqmpCoXWHldo0kaRAT6IdPH9Nc6zXb3ZQ
         MVg86B6S3OOysfFHMxW2VxTSdm8ZkQW+9/h1sG+y8i5xR8VnYY/QqIR6gExP316cVwa/
         FVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730445550; x=1731050350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+wLLnLhNsXujidna1nWvg9nwHwNnXS4h7AAUXEZYZo=;
        b=deaMAYiRGWAkneHpa9zyv2g6qDZzZfxxV+RJ39toLWBJzP86YEzbU7AYa9PSRCQSI/
         HG8ELQUGLqdR0O32wcogQRYjs7ruNpxVc/okZCAEQAsco5Dkh//i5ety3gzQpHb0Ob+L
         LxPL9+f3AkC42voW5XaxsCvWRnFgm3ikLAUwzW+VeWiH4+BHAhebU6ZIfHwXxHsIY9vQ
         UqB/E3CVp50iwseUvGx9YmKPgj744Q7wgOz0Pl14NXAIvUKAWO8vmA7HDp/mLfgSlLzt
         BpztXxfjM4IMx45QuaRM6d4CY2M5OhtEUZZDaSV+KBXPPJBPW53+Z98thU8vNv/wJCMp
         gmyg==
X-Forwarded-Encrypted: i=1; AJvYcCWRY6N01Mm34fJUWC4IsrazER76LAuvqw/rBp0m+LqJhxa7mJKnD4PBJ+LiHGLFoFnlOotMwc6aTZyjXhSisIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXsCMqNBMMc6/dWUJPOPT0vjCoBSFRY1rhYKel1EkETpmcTHex
	uo+CXDbfnVaO/2x5EdgeWmo/rD1H1mJOJLN9sauzvNv0lzk+uhF43IMS0u6C5MAezHDxvI2k08O
	sVZI3XSmH8xFHSXnozQ/85wTgPRqg3aDRwJ5k
X-Gm-Gg: ASbGncs9oiquchjQyMfjasVqFE4JBOC6REZEKak1kn3JQ7z3+MZR3hc8bwi+OVuA4SA
	VF1Jo8xfviUGTYGK+P8b4ojB4Tc/VgEqE
X-Google-Smtp-Source: AGHT+IEc+M85P/bonhPBXC/Mb/5OHab9zYnBAfaD9+BfPikp8qEz77St1LiPfmTkcIXViyEZ7wGm5E3ERnz7KggBRwg=
X-Received: by 2002:a05:6e02:13a3:b0:3a0:9f85:d768 with SMTP id
 e9e14a558f8ab-3a6a943543fmr6084865ab.11.1730445550040; Fri, 01 Nov 2024
 00:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101101345.Bluez.v2.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
 <197d3a7e-256b-4567-bbbb-fa2d326fce69@molgen.mpg.de>
In-Reply-To: <197d3a7e-256b-4567-bbbb-fa2d326fce69@molgen.mpg.de>
From: Yun-hao Chung <howardchung@google.com>
Date: Fri, 1 Nov 2024 15:18:58 +0800
Message-ID: <CAPHZWUdKjBfHo5OQASrz3kSPrR5T0-Dz+i8-eV89fqkegUwM+g@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] textfile: Fix possible bad memory access in find_key
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

> I=E2=80=99d also add the URL to the commit message.
Will do in the next patch

> Also for the OSS Fuzz ignorant, how would I reproduce the issue? Could yo=
u please add the commands?
To reproduce the problem, I simply followed the description in
https://google.github.io/oss-fuzz/advanced-topics/reproducing/

Here is the command to build environment for bluez and reproduce the issue
python infra/helper.py build_image bluez
python infra/helper.py build_fuzzers --sanitizer address
--architecture x86_64 bluez
python infra/helper.py reproduce bluez fuzz_textfile ${PATH_TO_FUZZ_TESTCAS=
E}



On Fri, Nov 1, 2024 at 3:06=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Howard,
>
>
> Thank you for your patch.
>
> Am 01.11.24 um 03:13 schrieb Howard Chung:
> > From: Yun-Hao Chung <howardchung@google.com>
> >
> > If the searched key is a prefix of the first key in the textfile,
> > the code will assume it's not the first line which is wrong.
> >
> > The issue can be reproduced by a fuzzer.
> >
> > Stack trace:
> >      #0 0x55e1c450e7ce in find_key /src/bluez/src/textfile.c:133:9
> >      #1 0x55e1c450e7ce in write_key /src/bluez/src/textfile.c:244:8
> >      #2 0x55e1c450dc33 in LLVMFuzzerTestOneInput /src/fuzz_textfile.c:6=
1:3
> >      (...trace in fuzzer)
> > ---
> > This is reproduced by https://issues.oss-fuzz.com/issues/42515619
>
> I=E2=80=99d also add the URL to the commit message.
>
> Also for the OSS Fuzz ignorant, how would I reproduce the issue? Could
> you please add the commands?
>
> > Changes in v2:
> > - Add stack trace in commit message
> >
> >   src/textfile.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/textfile.c b/src/textfile.c
> > index 313098f38..8188d2ebe 100644
> > --- a/src/textfile.c
> > +++ b/src/textfile.c
> > @@ -127,10 +127,10 @@ static inline char *find_key(char *map, size_t si=
ze, const char *key, size_t len
> >       while (ptrlen > len + 1) {
> >               int cmp =3D (icase) ? strncasecmp(ptr, key, len) : strncm=
p(ptr, key, len);
> >               if (cmp =3D=3D 0) {
> > -                     if (ptr =3D=3D map && *(ptr + len) =3D=3D ' ')
> > -                             return ptr;
> > -
> > -                     if ((*(ptr - 1) =3D=3D '\r' || *(ptr - 1) =3D=3D =
'\n') &&
> > +                     if (ptr =3D=3D map) {
> > +                             if (*(ptr + len) =3D=3D ' ')
> > +                                     return ptr;
> > +                     } else if ((*(ptr - 1) =3D=3D '\r' || *(ptr - 1) =
=3D=3D '\n') &&
> >                                                       *(ptr + len) =3D=
=3D ' ')
> >                               return ptr;
> >               }
>
> The diff looks good.
>
>
> Kind regards,
>
> Paul
