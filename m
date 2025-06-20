Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFBA28B40A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426028; cv=none; b=nxz6BM3RqbQIXcacYNF1MZsmiJHC36flj+RWvN+1DgMNaoElBe2YXi/kOACjoGvmSaz2Qr0Q0PSnOquj4OjgEV6KrSrNlMPAdZ5NY5IjH3EmgH5JpqxTzvpwF2x4OaPZnqbVD7iGa3bmUF2jc3esPWSC/S9Pg6LjKwOoza9cmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426028; c=relaxed/simple;
	bh=8qQhvUL0VOx1miSWimNVT8mwuTKdOL/HbpNBNfipGF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meRJVFIsjG9KWaNpMvGfhdVab/YK5VDJ+Jt6oOzzLaHdENXUn4hWzY6Xn+my4dbS6Pwpw+1o4lbYVR9+1WR8LU8RYjj6hGiEGSwl0afY3gy3dJzy6KfLBtM+q9M1ITGNRFcSPDG6dv9GFPJq7eEXA+xKqU9h3v24RARh587M+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0x01vRI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0x01vRI"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b435ef653so16903361fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426025; x=1751030825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/FCaZFDLo72CedfL6avvJnefKCwVwsrdS0z+TrVbv4=;
        b=D0x01vRIdfwlqQCPPPQi191H8aysH7F2KC49Wr8pihvQTQVb2FglEa/keGE0Xxlxug
         Ht+IDpwKYIScUtTF7TIb3BIsfQNfmCaqnHdkfVf79rwbgkbseseuE/kA25b0MSDnpRoO
         U0nMjVY5Vxi/tY7f8GqIzuC+J86Jw/FctcpqmdBmJ6mPsPi6IhbwfD2A83KXSqIskyDT
         YSTC9vCWUrW4ioHM0zM2RmieCHYT2KbVv4H5Mv7XdOJ2IhEdyvsVMrnPaLD4Kmd1w44G
         K8yscLh4sciQXV/9CK4kTsJaSUyIzf3AkGSie6shGFzpb64tYVgNzM2SapgZUaVDtKwJ
         SISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426025; x=1751030825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/FCaZFDLo72CedfL6avvJnefKCwVwsrdS0z+TrVbv4=;
        b=nzRrhMD5dBkpyfXY3Gzty8Rm9oft7n+XBGGY55u0FcAS0trsTMzR+vntCi3OUd+IYu
         K35aKLnB27s/qOlm1R7P+MyTJ/rzaY4QH4Lr97ESWBrskaxJ2miP5oGI9Yh/VDeddg3+
         UlBmaPsf4j14wThwGws5LWK29n95SElMR9ABXgTlH/9JvbJr+AQSRbfPnZ3mK/k/p01P
         fmGMvEQgQxwADzXZ8mG2y1P3yGtqdPLJ7CL4YgQd109Go3Y5YPwZIYlnWTtor0WuxV9/
         rdp3zUsNjy4doM7RnMySY2I6+7OEIEsFWzqU6o2AXxm+oAiO6pyL7CJoAlODIHHqnJ+d
         1GEg==
X-Gm-Message-State: AOJu0YyxVg3IObSIjdDIntrEMxj47JTYTmEfRPrHc1Q62svDYzegJixi
	iFFkjepURM0zQpAVKcO2Zv4+PA5cm+tFoZAZG+lrzxcG6vpUC+rAOJslxSuoJAlAqTDZ1bXg2hr
	5CVZwX5vtsmGH3W9m54UhhHrq0v4cLWjYNp0Jjpg=
X-Gm-Gg: ASbGncuSEkxBRfz95oQbc/N8LChPH6VpKgJPwHxBW4td/7ISHTh38JogZ/gnn4YoBit
	tqH00GOSZBvcs1GMHDQ7IiVKP1Q8v4yB+Ok/wFNn0LtdIN1Vcps7rKBVQ1Espb5PW3s7QD8LtPM
	E/myR0+2dSfmPfzaMgI95SB7N3aEAwfSOavk8VwDYo8w==
X-Google-Smtp-Source: AGHT+IGA3Lyo5/nBi7l12PrKCUkQC+Oq7QOK7z1vweJFsX8k+M+JQX5Yp4ZzamsPvTEdzVzGHI5XY/s+BofJnr46oZ8=
X-Received: by 2002:a05:651c:4189:b0:30c:aae:6d4a with SMTP id
 38308e7fff4ca-32b9901b993mr8266301fa.26.1750426024860; Fri, 20 Jun 2025
 06:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c257288ce21dd2c25624d0adda2f42b0428f7a43.1750409838.git.pav@iki.fi>
In-Reply-To: <c257288ce21dd2c25624d0adda2f42b0428f7a43.1750409838.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Jun 2025 09:26:51 -0400
X-Gm-Features: AX0GCFtF0QbabVA3U527io3jDztjrjGvm16SLSGLJl0bjDQTrVJBqOKHoBMmU_k
Message-ID: <CABBYNZ+o8v5_QXfXDRHN5NYBiVnFfKJ2NGxRSXYO53D9GqheQg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] bap: don't pass in stream's own metadata to enable()
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Jun 20, 2025 at 4:59=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Stream owned metadata pointers may be invalidated in bt_bap_stream
> operations.  Callers should make copies and not rely on details of their
> invalidation semantics.
>
> Fixes:
>
> ERROR: AddressSanitizer: heap-use-after-free
> READ of size 8 at 0x7b86a76f5d18 thread T0
>     #0 0x000000836745 in util_iov_dup src/shared/util.c:353
>     #1 0x0000008ea96b in bap_stream_metadata src/shared/bap.c:1991
>     #2 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
>     #3 0x0000009226e7 in bt_bap_stream_enable src/shared/bap.c:6392
>     #4 0x00000044037d in transport_bap_resume profiles/audio/transport.c:=
1981
> freed by thread T0 here:
>     #0 0x7f66a92e5bcb in free.part.0 (/lib64/libasan.so.8+0xe5bcb)
>     #1 0x000000837002 in util_iov_free src/shared/util.c:392
>     #2 0x0000008ea94e in bap_stream_metadata src/shared/bap.c:1990
>     #3 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
> ---
>
> Notes:
>     The other option is to do like in v1 and specify the semantics.  In t=
hat
>     case, it's best to be the same as in the other bt_bap functions, whic=
h
>     use util_iov_memcmp.
>
>  profiles/audio/transport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 9bf3b47ee..62abd83d7 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -1977,9 +1977,10 @@ static guint transport_bap_resume(struct media_tra=
nsport *transport,
>                 return bap->resume_id;
>         }
>
> -       meta =3D bt_bap_stream_get_metadata(bap->stream);
> +       meta =3D util_iov_dup(bt_bap_stream_get_metadata(bap->stream), 1)=
;
>         id =3D bt_bap_stream_enable(bap->stream, bap->linked, meta,
>                                         bap_enable_complete, owner);
> +       util_iov_free(meta, 1);

Oh, that is what was causing the problem, well in this case the
bt_bap_stream_get_metadata returns the stream->meta but
bt_bap_stream_enable would already be using it anyway, so I think we
can just remove this entirely and just pass NULL as metadata, perhaps
we can remove the argument as well and just leave it up to
bt_ba_stream_set_metadata to update it.

>         if (!id)
>                 return 0;
>
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
