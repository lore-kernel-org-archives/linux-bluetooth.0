Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A596712F5A3
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672280; cv=none; b=m2kxm2kgDJYOZ8zScFTgL+H7UEAOgJMKw2MloRQZdjohQlTjtvCH1Yv5kgQKGxnTc9cZUOzlkURoKGwTSY8LQNU33ujDzG54IlPRcl8PI4xAkfu5RLimI3PedpFVr+P71wLtOaJmdJORllseCAiot93QLC/pv8fwXwTgIQWWPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672280; c=relaxed/simple;
	bh=CQJJ+EXkS8vzXDSQGCdhZzOcQSnJl9LGsjKU2h6iW4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFq9wdBLtKG9+HDMpMleoA8oH2J8rZ654kUjJMUCnnbqIElD7zFBq66zTLj1keYjmi4jLPGTmxbOCwtwwXH/c7OXqAEBZrybqYOLGYKs5f4QsKKjhJprDQqcAlJ+ZlFxrgpJkWhUs/ATWkArpcUV+obMxxMNQh8LV0KsHoeytSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5m0cUey; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5m0cUey"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e5bba0908so12383a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712672277; x=1713277077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmZzs0VOF7pCa24C6qKP0DzgKs89B6zI1lNihOdcCC8=;
        b=g5m0cUeyt3OPmYkjeSaCYLiqKCKoOiiJTSs8Hmnilp+hftyUFIBS1fVNM/3U1waNh1
         jufjXbupOQXE7izYYd2czwgvfM+BH8UiDEnRT6+891cKMjOLoJF6C7tGfkz4A3Kn7/yn
         FAF1Spp8EgkxJ/B/UNYkXLq4F11OdyBLFTD26Ejp/vbnqjqOc0Y51THJ94qjUs5s7bT1
         Nzgwn3/2S6/2LdD8G/5xS8Y59feo2Mvj2fRQeoju8BmsHHvYUULBLbVmypi458U+FmNE
         3wQ+UUU+//UXMxgFXw+QdH6D/CcAddYcSkk106wULLqMkvVgvarBxFak6a9OG/LVXzfy
         Douw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672277; x=1713277077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmZzs0VOF7pCa24C6qKP0DzgKs89B6zI1lNihOdcCC8=;
        b=WmFM8M+xqNHQ2hvuV9hRyrJC9quzjxhND3LaEOMLKeyHhbx8QXCZvqfEjfCbXUQtpN
         Oj9MalNd750z1+d8Eh6S+5TNLWoO7scCZYCaxZX59buGnDbwyzXyLdYecEkiBS0x1kO5
         00Q2G4vDffTM0/Lsi+F3Jk9I5chDL3aGvc7nugPi+huQq2CVcEmDHdW4qjRs1WaRMm3c
         2rsRs1Gqf2QUBTdllNdIDP5oRusxj0E18y/8HgBXFoEwnNfRSWIkB+jgmPmjjOLoME0+
         RpkdjkCNJOrMByhQp+IZo3Ni49SKTRECnzxSp+BGVw+AvTIf+hFtEOriZGMyROO6mnXh
         s1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVkEXDZgoenQsy76h04yZ0l6oqQBOVjn0tYm4fqYx9wV29j4mdKzq/BKcUVNXI4Yd7yELueyEJyxTEXWWAOQ3e2N9/fH361kORKeuYSjFOA
X-Gm-Message-State: AOJu0YxRarZ7ETorjbAH5HKZKEVQgwBvjKvx5IDND6yauM46PDD4cnBO
	B7CMrv40GEbVX5VMPlKuMktdJbO2qbAa2HsEivtJKpmemZ0neaBTTeRUjLVOtaz76QDVGvGXnOQ
	+0CvHNFWUawzuWYhunS9cuHmgDTCaUJCRdGyv
X-Google-Smtp-Source: AGHT+IEotRWbGGi6bZ2X7QllsriEs5XuAfrmYSsR3+QQhN3IykwUSZgSv9+89fLvM1ymkT3RaeWYlpR5hL6VjU0ap8U=
X-Received: by 2002:a05:6402:40cc:b0:56e:72a3:e5a8 with SMTP id
 z12-20020a05640240cc00b0056e72a3e5a8mr161277edb.3.1712672276490; Tue, 09 Apr
 2024 07:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com> <tencent_88401767377846C9736D0363C96C23BB4405@qq.com>
In-Reply-To: <tencent_88401767377846C9736D0363C96C23BB4405@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 16:17:42 +0200
Message-ID: <CANn89iJAyCKbL1Gx9mbBMuEvDB7nr-Ao6vB7KbtOK5D0UhiQNQ@mail.gmail.com>
Subject: Re: [PATCH] net/socket: Ensure length of input socket option param >= sizeof(int)
To: Edward Adam Davis <eadavis@qq.com>
Cc: eric.dumazet@gmail.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	pmenzel@molgen.mpg.de, syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:02=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> On Tue, 9 Apr 2024 15:07:41 +0200, Eric Dumazet wrote:
> > > The optlen value passed by syzbot to _sys_setsockopt() is 2, which re=
sults in
> > > only 2 bytes being allocated when allocating memory to kernel_optval,=
 and the
> > > optval size passed when calling the function copy_from_sockptr() is 4=
 bytes.
> > > Here, optlen is determined uniformly in the entry function __sys_sets=
ockopt().
> > > If its value is less than 4, the parameter is considered invalid.
> > >
> > > Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
> > > Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
> > > Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> >
> >
> > I think I gave my feedback already.
> >
> > Please do not ignore maintainers feedback.
> >
> > This patch is absolutely wrong.
> >
> > Some setsockopt() deal with optlen =3D=3D 1 just fine, thank you very m=
uch.
> It's better to use evidence to support your claim, rather than your "main=
tainer" title.

I will answer since you ask so nicely,
but if you plan sending linux kernel patches, I suggest you look in
the source code.

Look at do_ip_setsockopt(), which is one of the most used setsockopt()
in the world.

The code is at least 20 years old.

It even supports optlen =3D=3D 0

               if (optlen >=3D sizeof(int)) {
                       if (copy_from_sockptr(&val, optval, sizeof(val)))
                               return -EFAULT;
               } else if (optlen >=3D sizeof(char)) {
                       unsigned char ucval;

                       if (copy_from_sockptr(&ucval, optval, sizeof(ucval))=
)
                               return -EFAULT;
                       val =3D (int) ucval;
               }
       }

       /* If optlen=3D=3D0, it is equivalent to val =3D=3D 0 */
