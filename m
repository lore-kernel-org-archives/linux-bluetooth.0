Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F53302CC9
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720153; cv=none; b=W3hmAp8vDI8An3dWdKqJ5fKepXH8RIGpudV6jhrvruxXBMT/4xlV4D0ohGHNqbmIBsiPq3LACnAhzGqCdXdYSWT8leGMQbSKiTOTCiYRzsbkIQVu6fiy0WUfGT36XSFfW8IuDkVEKi5gFkNITYg8yPPnX+FNMbiGvBJyxpDOl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720153; c=relaxed/simple;
	bh=3A4gergA1bOyV4Nu1njljHRSXIZP1/K/3dS4tIvRb/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbOmOpqpzuyb2xAPB+rgdB/HxlXql8qZAnDnCJ5QdmzCr5cuxnsUAfFbO0nA5aYLlcpCoCmpODho2tQsrZmXb8h5E7nubsuIfrmENc+2E1DOTjMjNmPstK4CWg45GtGXz6Qw0tLLwPHUHJ265/+QrxJxNrChMh+JX0tfq2Gz7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja41Hciz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja41Hciz"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-36bf096b092so35847101fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758720150; x=1759324950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1dasbZkHw9ekpzHtJePl+9WGaytlyRmtZTiADU0GdU=;
        b=ja41HcizWJruPlAuUqpcdqQkxnL3nREGPuILEqL2APrxtaophbQridnSM6EwwkIG+g
         LHHqsAytluGGyZb3PSdUg5kTjzYp7zpZ3SVolk11tcqEvAlJG0Bef1YdN8OpVh5dH0ht
         Hc1tNWDWxgklj4cyqLXEvbfz8ufFtJbmtn/FCMoe6URTuevQzuJ4sOkBuFARXZdZcO9/
         08RpqNZq+VPNkDGP4ysCerEBe+hjfMyoW1Xa5/3x5TzZ/1QcxRTBs/Ab3IZE3HsWqqgx
         q+5J4xPSzuHP5fNENAtIhc9JAr2mZ40zYolAg2AsMCuJ40KR1ZbmRhVbHAQN68uP+16l
         Ud3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758720150; x=1759324950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1dasbZkHw9ekpzHtJePl+9WGaytlyRmtZTiADU0GdU=;
        b=ka+qt9DCQPiupmvNwAswGvGuZFQUR2dBw7gyARmvK97ftj1AZ3fnEjgS0OXYf0LXDn
         aqXZ2LgWTnigO2SGJd0rz4yQ7D2tQzszr6CSC/PNu3kLboD8BxFWKYx6ycXAaUTkWUAG
         ZhNxHVsO7vSXCoeI55chc082+QJ2wQzPvZvuPWstaAfqw2B6ptX3LMpx7weg4+xrdYLf
         mS5tLaJ5/VDHyXLJHjIMwPkA3KVv+uSVEX2u2TPrJ/QukmkZn2Y3Epx2cXbKoGorO4t6
         f/4dPYKuUI0SfXYCT5UUXae2ASKeOIgv9sAIimY6I1UC8WXSphw8jocC8V7AvY6jKqeE
         /VPw==
X-Gm-Message-State: AOJu0YwRrPoAkTnjjY6NhQTR3RZF5eDUjZekSWQ7j3i0Zxgxcc4Go9r4
	U6N0W9atL1DjuQN6KPQgRxkyiJ8NeutEkyLPCt2iLvZsBd/oop0XKEuoFhxcHYe43US8DrH++/E
	YghiI3Mcft68X+9J40qXvs0sOrojyOXc=
X-Gm-Gg: ASbGnctn7Yj1eQnMmx4yZkLxyLsPcCCMzHP60uvcvDz2x2hm0FrhF9FzJ52knEunUHu
	dUDjnh6/McH9DZac7YK5dzM4N1izL4UNKOJgrADCq9os7iWQTpcMtCSUVYPew3F/9mpO9ZNij+9
	0oyz8tdI4uu5EosvJjosED/no/6pOm1q9+rCqPdkewWsuihQKhMt0PArGjwXXIyAqxA6HgyI0PX
	LfIMeVaMfREE3P4
X-Google-Smtp-Source: AGHT+IEoLtNaGvYkloY2WEN+NK4v4zagj7VGGF/x4Uca/pxMw/xkNJZzdnMDT2H28e05omnv/ANa/ijOKAehK1L5bkY=
X-Received: by 2002:a05:651c:40c9:b0:36b:93b0:2a6f with SMTP id
 38308e7fff4ca-36d172ed7abmr13262541fa.34.1758720149452; Wed, 24 Sep 2025
 06:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9a2cc5fe58b706247b74adeaa5f0b774432f837.1758215957.git.pav@iki.fi>
 <c234cdf8c79f4d73e4ef32be757ec0ae2dde4935.camel@iki.fi>
In-Reply-To: <c234cdf8c79f4d73e4ef32be757ec0ae2dde4935.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Sep 2025 09:22:16 -0400
X-Gm-Features: AS18NWA--Eyd-OKJzQ6p_6PIEJS7gAUpQuwTstzcyyll2vhgNE5Kwp2hOOnERQM
Message-ID: <CABBYNZJEyqgot0yzFke5AEJtOoajaHA9cp_HjMgFZ0Wo-RwmBQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] media: fix pac_config_cb() error code return
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Thu, Sep 18, 2025 at 2:11=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> Looks like BlueZ 5.84 was just tagged. Unfortunately BAP was in broken
> state at commit da5daf532409812c41a237a6a6126868f6867079, see below.

Looks like BAP/LE Audio is broken on 5.84, should we proceed with 5.85 then=
?

> to, 2025-09-18 kello 20:19 +0300, Pauli Virtanen kirjoitti:
> > Fixes: a887b1a1b91f ("audio: Add support for specific error codes for A=
2DP configuration")
> > ---
> >  profiles/audio/media.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > index 332f643bb..deb321e6c 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -1110,7 +1110,7 @@ static void pac_config_cb(struct media_endpoint *=
endpoint, void *ret, int size,
> >       if (!transport)
> >               return;
> >
> > -     data->cb(data->stream, error_code =3D=3D 0 ? 0 : -EINVAL);
> > +     data->cb(data->stream, (error_code && *error_code =3D=3D 0) ? 0 :=
 -EINVAL);
> >  }
> >
> >  static struct media_transport *pac_ucast_config(struct bt_bap_stream *=
stream,
>
> --
> Pauli Virtanen
>


--=20
Luiz Augusto von Dentz
