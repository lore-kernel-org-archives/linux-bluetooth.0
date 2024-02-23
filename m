Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5E5CDDC
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686888; cv=none; b=jvQdm/YHF0HEkMeAEZQeM+1h9vUnNOhFfWshtY++Odcqp6LGN2PUTgzdXaogkECG748GqzNumBBHX6UuceigSDf1Bm9CtoK9XSwxPxA4N7V2jvoy4i4EEQmiMpSRIYiI4r0mNB9qHBouYDraag9J1EomxrdDk17kBjU340ErEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686888; c=relaxed/simple;
	bh=2w6EPXW6U6xFs2eTzZHDenBRnSEIFDRKfrqxuOFRCNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8PyIVJAXgSiUT7LgDdQJyyNMBBQ8+7gj+8leGmoQ+o7mP+MCKInrsybSdmd2IVLGe84pXYC4sxRaFAzZS1cU6H66LGWmp/dT8fnMi0jCNaT3l6hxbDxaru3/Pzcm6auWal3T1W9mZ9YdbfkHuVk+/ZoRnPLuLJBjxo+CA7fc9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5qX7zlT; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5qX7zlT"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc73148611so742637276.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 03:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708686886; x=1709291686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dce7UEAI8WSSdi3F3OgHeRQUjPuMqq8CXG6Yx1rvSvo=;
        b=T5qX7zlThj1jPQkrP58lPCyv4cBpoS9BfourS0F0b64XFI3ENY7kp6zqX9CFaCGglt
         Dw91JTeXw2G8lTb2ebkbyiNnrJWOiT7z7x3RCC1IC5nhuS2SN6DoC6bodPYwzOIH0WIq
         87TDLTk1PGUBfwA8qNuhUHVUQ7VCe98zY8tFG5ZhDLJloTxS+wDupXQTWEtpaEK5EMWN
         17hYEb5J8i5naiySjWyllmOIeawsHqjcy6EFFWLe7qEAsFLb1lZ/0m4FbYoIIVMbXn3h
         se8ZEoISLTLA/LmGJXKb9NfC9xX5OZ88JUkzZvb6UYDSYcTM43MEhBYKBFSkXG2OOzwt
         Zo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708686886; x=1709291686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dce7UEAI8WSSdi3F3OgHeRQUjPuMqq8CXG6Yx1rvSvo=;
        b=CmTzEh/vyF4V1Tpbjs3f43EHbx1GqJiW5PxLIf2HOLtzChjTFV2ZaEa3NVSrvRm4aC
         dSojbBJ1FIQ6Nzf3DHgVDp6o3KzwXma6h6RHF95VawNDUzzhWLnGj9lZ0mQQkTU2BKBw
         4eeyMVMNhSbGFzJpXcatAAhqEW6towC6ngoU2nn6B/nwHAsYR6HhrxggoWNe6epdSim6
         bcHj5nzllU90Ybe0i5aHtIDFNz97LP2KVwJduhbFxbQoT6RCkOwCANHARRHKWjn9lvcg
         f4LwQkYN/32uwetWG6FioRjaSh7+Wbt1yVPWRLjR2mU/tok2nGQSPdI3hq1kTwuklXKz
         7Hjw==
X-Gm-Message-State: AOJu0Yxh77ALsmcuThSsWgwBOfBjKijF/hkMRftNSRY2s2uHNnn/6pBw
	rD+hzaUEvBaXzZdWuD+IO5/KQUi40CletQnAGNE9t+duZ5acgz3cKyaMv2NpxinvF+gYB5i/hkc
	RP3nzgE0akLGrwMhbLzZ/lBA85dKGP1oVuzs=
X-Google-Smtp-Source: AGHT+IHkU2Jfx3iYB2E8sCHlNHnjipO4TviSoUVxVShHlw/PMmovUQq0FUJO1K+6cJuwwnpaVT1nGt8r/01EqanGvMI=
X-Received: by 2002:a25:4e84:0:b0:dcc:e388:6db6 with SMTP id
 c126-20020a254e84000000b00dcce3886db6mr1709518ybb.55.1708686886455; Fri, 23
 Feb 2024 03:14:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
 <CACvgo529avv_gypHc4tO6VNmZU6Md0V9ZapQnLLCE_3vdjOT2Q@mail.gmail.com> <38504363a13524443f21f1c0a50653bead0742bb.camel@infinera.com>
In-Reply-To: <38504363a13524443f21f1c0a50653bead0742bb.camel@infinera.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 23 Feb 2024 11:14:35 +0000
Message-ID: <CACvgo53fT8Siqm9SL2Gs4x+2iVqNEwSxe=rpwD6L81Tvd+Oo0w@mail.gmail.com>
Subject: Re: [PATCH] bluez.pc.in: Add definition of libexecdir
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 13:10, Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> On Thu, 2024-02-22 at 12:54 +0000, Emil Velikov wrote:
> > On Wed, 21 Feb 2024 at 11:19, Joakim Tjernlund
> > <joakim.tjernlund@infinera.com> wrote:
> > >
> > > From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > >
> > > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > ---
> > >  lib/bluez.pc.in | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/bluez.pc.in b/lib/bluez.pc.in
> > > index 3d6e59616..1c2f30b33 100644
> > > --- a/lib/bluez.pc.in
> > > +++ b/lib/bluez.pc.in
> > > @@ -1,6 +1,7 @@
> > >  prefix=@prefix@
> > >  exec_prefix=@exec_prefix@
> > >  libdir=@libdir@
> > > +libexecdir=@libexecdir@
> > >  includedir=@includedir@
> > >
> >
> > It seems to be unused in the pkg-config file. Why do we need this?
> >
> >
>
> Bluez does not but pkg-config is for other apps so if some app needs to know
> something about bluez stuff living in libexecdir it can find out where that is.
>

"_some_ app needs to know _something_" sounds like the key here (emphasis mine).

Do you have an example? Is the (bluetoothd/obexd) daemon location of
interest, the cups backend, other?

Thanks
Emil
