Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4883CC4
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704676; cv=none; b=H6ew83hLgzt8HHUsH5KTUCye/ux1tl2vSqI+Iuu3xJJwCpzbQw2jthv+VwStNY+k3xpEtwJPm3JemWn5o4pYrtcskpVH5uy6fOblesRgIoUKP4M2q+vVFMig9fIwTyCwdsRpmoG9aSS10x5wRB6Pu+XPejudKrBFkVD3JzIa8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704676; c=relaxed/simple;
	bh=HGJAZRttBu7ddvyu1NervLedClmNxrwEVuTGtyOPrX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEVx+tLxrlusBHx0llXjShNUvdHQTR+XFr03lNYqsxhvuOCTgLhlw+056T/Lpv+xoJfYQoZnBlDmjT8el9MdY47M8VXJt9wylbht1DXT5T7m/pcfOaWZYH4Tqk7QVKBDiUJzrKHMauK9yV8LVoEsiYm22w8ZNn044RS3LYkdioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw3upe8T; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw3upe8T"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso510927276.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 08:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708704673; x=1709309473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FHnlV/CYmELsG47n2Wbuoo7uVOVLwu6AlkI1Xc1Uju8=;
        b=Uw3upe8Tu6x5bw864gqUftpGmhLZiXI0n7msxWGiI2uIdPa/kWiZ5sbnP2IXi+2w2j
         Ny+J2LlNbwHOvBXg74a79F63rbdcp0gMTlhYVBSD02l+QRQg3fGTx681+V2i9/+K8HqB
         nUacKC9sHeUR6NSUiCWQnBvVte01J6aTLpREppfxCRsCwFDdQcjDAzM98CZ92zNrhngj
         AZEA5taMHmqinW4jWI4gpsaDsLL6j2moPkvd6Dnxr2ejlBtR1qUtn7gRZXnpfAedIVEA
         fay+A9dTItFzCH7/bcS+O6o8rT3G/w04HIXBdUWmMe/Apulz7jwQD5DGAbULKbCciBYK
         KQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704673; x=1709309473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHnlV/CYmELsG47n2Wbuoo7uVOVLwu6AlkI1Xc1Uju8=;
        b=Q0k/fTmdC7V7nKcigLOXWBOk5Lm479IW2J+46Qu+5nyB8yX+1n16NfQGHxAGNxXfnu
         c9G/UGhbOkGJgKDJu4PDVO+yOQ88wSIqeQY5V35OVNDM4uRJ1lY+cUyuBP3uonZnjfWy
         ut3pPfETrLmb7DO4xK7soh2BqrmSUj0B2kGDgp2aTdT8XsJOCY1QRIeHN2JEpmhsvc5o
         X4vAsM+BIqAUqacxNSknrFhXlqkePzc0iow2JF1tJ1GoCNcwXYWuHHwDPGfCoKRPiFqv
         VU/z59iIc9q4Lzlk0KJTbk8CM6EZfbbG1m2v9wQAk2jTtVCyo14scj+Sk67BRCnVYgpA
         0+Ug==
X-Gm-Message-State: AOJu0Yz5QiXNvoLY+KIXRJZ5iTR/MYzTqdx6UmyGiuQlhQbxXIQ1Jzk7
	2sfiiERjGy6n85vRuaE1yDP98TYlke1YA7WH+bHzKThbU5cynCsmO5wd2Nl+QmgpwTLUUpZ+t9p
	YqdgMl0jmP83y7FERTvz/2nEP1mghwLDI
X-Google-Smtp-Source: AGHT+IF5N54WRtZ6R7vNed4RZylXvjreVKpUXQe4ESRtmeoS3sGszAcXahGc4bvl8/0HMBrU8SMvc3jbjeARpKz69rs=
X-Received: by 2002:a25:d696:0:b0:dc6:b779:7887 with SMTP id
 n144-20020a25d696000000b00dc6b7797887mr275090ybg.20.1708704672472; Fri, 23
 Feb 2024 08:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
 <CACvgo529avv_gypHc4tO6VNmZU6Md0V9ZapQnLLCE_3vdjOT2Q@mail.gmail.com>
 <38504363a13524443f21f1c0a50653bead0742bb.camel@infinera.com>
 <CACvgo53fT8Siqm9SL2Gs4x+2iVqNEwSxe=rpwD6L81Tvd+Oo0w@mail.gmail.com> <1502e3caf12aaf8ce25062dab434fff3d27896a4.camel@infinera.com>
In-Reply-To: <1502e3caf12aaf8ce25062dab434fff3d27896a4.camel@infinera.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 23 Feb 2024 16:11:00 +0000
Message-ID: <CACvgo51fuutLWoLAt8Rf5Jr-Vh3A-6pfATd1dqP1019p-ZX2Hw@mail.gmail.com>
Subject: Re: [PATCH] bluez.pc.in: Add definition of libexecdir
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 12:09, Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> On Fri, 2024-02-23 at 11:14 +0000, Emil Velikov wrote:
> > On Thu, 22 Feb 2024 at 13:10, Joakim Tjernlund
> > <Joakim.Tjernlund@infinera.com> wrote:
> > >
> > > On Thu, 2024-02-22 at 12:54 +0000, Emil Velikov wrote:
> > > > On Wed, 21 Feb 2024 at 11:19, Joakim Tjernlund
> > > > <joakim.tjernlund@infinera.com> wrote:
> > > > >
> > > > > From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > > >
> > > > > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > > > ---
> > > > >  lib/bluez.pc.in | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/lib/bluez.pc.in b/lib/bluez.pc.in
> > > > > index 3d6e59616..1c2f30b33 100644
> > > > > --- a/lib/bluez.pc.in
> > > > > +++ b/lib/bluez.pc.in
> > > > > @@ -1,6 +1,7 @@
> > > > >  prefix=@prefix@
> > > > >  exec_prefix=@exec_prefix@
> > > > >  libdir=@libdir@
> > > > > +libexecdir=@libexecdir@
> > > > >  includedir=@includedir@
> > > > >
> > > >
> > > > It seems to be unused in the pkg-config file. Why do we need this?
> > > >
> > > >
> > >
> > > Bluez does not but pkg-config is for other apps so if some app needs to know
> > > something about bluez stuff living in libexecdir it can find out where that is.
> > >
> >
> > "_some_ app needs to know _something_" sounds like the key here (emphasis mine).
> >
> > Do you have an example? Is the (bluetoothd/obexd) daemon location of
> > interest, the cups backend, other?
>
> No example. I just think it is proper form to publish this info.
>

Looking through my system, literally every project apart from one
defines _and_ uses libexecdir. The only exception being Qt6.

Skimming through the pkg-config documentation I cannot see any
mentions, so it seems to be that this isn't the proper way.

-Emil
