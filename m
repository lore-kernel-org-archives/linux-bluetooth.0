Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F197C139E
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501981; cv=none; b=EX8Yr4/5onV2rBX0jZ00TkrEBTwhi9D0oSpusgncqDFEpwa8wTqCtxNVz3OuOby5tL4kg5e+wLVh2c6nLUzo0h6ELGQm3+M6Oue8gvG7JfMUzjcJN8/9ZElVJjr1qAg2VqcS6Gu+XyfCco47lp6njj/JEAUoNH/VS8TT6kyp6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501981; c=relaxed/simple;
	bh=ArI0GMic8uk/1kAkM79WN6gznjdosKe4PSqQZ8k9PK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXXACoBVGX7/2j63dvnlEB3X25tejJbWfoERfrVNnwR87/qLpOExx1l3X0RvIW26mbCmAonW0vV4o4utPNqAFAbQVvqWFcVmCCbvTAN8WCEIuwR3qhIXFgEZcwuKnnFFe2tfD1sssckkzBg8YMUhMwOsmVy7FFx4kTMysMnsA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgtkU7tp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgtkU7tp"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3737d09d123so25397581fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759501978; x=1760106778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mxBl+91XREs3rrt+Mm+HGe169ZpfgbUuMF9IKmnb3I=;
        b=fgtkU7tp8t9FJx+n6MdmpSaI96wKnMB946Ia6juEpMapqFaiDzBKU6Myu/l99TPONl
         X5NzYAznh9OzpsvyXuK+O8vHNGlTTUQ1WjUPFWSSi1o3O4pVptvRrU7M0ADp7xg313qo
         Go50Y9Q+75bf4JbHAzc72ujOQu5a5jJUpSrzrR3PA09KstyJbTEkjzZNOvf5fBxYqROX
         5v8IYWSutFofAk1ESXC42mRAIHRn3kXhGopqySi46gJwiXHBTy6/rvHRwNdFwxLx1PN+
         M4zyU0ka9hzeLELILZOgUcgvH3jnrvBJJn/8HxfwzfpX0Iloz7Z9St9zi8x8iRLHF+7d
         r6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501978; x=1760106778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mxBl+91XREs3rrt+Mm+HGe169ZpfgbUuMF9IKmnb3I=;
        b=YivGefxay59M+QQ6s+f9t/0X6pyb1DS4m24EmLaa5CVtZkxHAPbihCFwfhVYJrCn9v
         ZekXmLNn/+iqJXtmB+8tZ1uBB/tsvmbq5r6SeFB0O5E45neGcJuhE+PPpJNq7OYk7iyx
         hbPm74aDCGHge8TrExnBExl69KpIuqx8Ca9wGX0gAmRC9sYFz2KWBNkxgS7O4wtUChlq
         F1Up8YKg+Jket0HwkwNJBr38XxEc5nbpz9zIyYR6j+MRn1AfSYG7ifs4H7X84YJur09p
         UfnRhqotS4nGKTm6XejUb9q8YtnMgegYqQFeuqSwirzITZA0HRpH/O4tSHoPJz18cUnO
         9W0A==
X-Forwarded-Encrypted: i=1; AJvYcCXpc0QXvh1LOBwNsRkzVTuH6Qr52POIukyirmTJ3+QTqXEMXuYkNySqHFLXlv3NlgSwMr2R8rufFvdUWnHifVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF45d7Giqvle6X8Au8LAAwW6ATQvfjiICHj56FYJRSAg8bZzcK
	Au8qhLEOPEOI+Gf0hq+AitbtW5bQKtECQ8Zwg3Ghb7F2hKtvmrIAMmVTnGaLKt8bwgsAC6mkJAP
	KA9A+JplZm/hq/KeYm9kUu3xUyGxMOKg=
X-Gm-Gg: ASbGncsqWYyFcM/wLI1lB0FMA9l6nalPnLzgcZSW1v7DQv/8u/NF8cjFMgF0ho61+H8
	+to9vyn3Kq27+3HzdwMeLO7XhmPEsRPdx8LvtDiBK7UbzDhAV6+g6rHeXnnW9hoD5TM4+dp/hvE
	JOkHj8/dRhBEKy27JXhf0SR3jmDy1SNLPArNvFNbh2xgaz6pata907wwbEO3LOW6jybpk1ssF2y
	qjrBeG88jMdTrpYFPB5JI9uA0ioFtPennNFqt4Q
X-Google-Smtp-Source: AGHT+IHMEYf9LUvT+7M4GPywBvEmEbLwMBFLFIBedNHzqtzmaPYWYwMrkMOiqneX0J3Yyd6PeW5sBlD7r5kNWSSHALo=
X-Received: by 2002:a05:651c:a07:b0:372:950f:2aff with SMTP id
 38308e7fff4ca-374c37eb5d7mr10596021fa.27.1759501977328; Fri, 03 Oct 2025
 07:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
 <175943240204.235529.17735630695826458855.robh@kernel.org>
 <CABBYNZKSFCes1ag0oiEptKpifb=gqLt1LQ+mdvF8tYRj8uDDuQ@mail.gmail.com> <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Oct 2025 10:32:44 -0400
X-Gm-Features: AS18NWAxN1IhfgHRDQEAVNRk-gv2qRra_zfz_DZsOprYcJI8wwK8KzxwPe_vG4Y
Message-ID: <CABBYNZKxGNXS2m7_VAf1d_Ci3uW4xG2NamXZ0UVaHvKvHi07Jg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT schema
To: Rob Herring <robh@kernel.org>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, andrew+netdev@lunn.ch, 
	conor+dt@kernel.org, kernel@collabora.com, krzk+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, kuba@kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Oct 3, 2025 at 9:38=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 2, 2025 at 2:18=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Thu, Oct 2, 2025 at 3:14=E2=80=AFPM Rob Herring (Arm) <robh@kernel.o=
rg> wrote:
> > >
> > >
> > > On Wed, 01 Oct 2025 15:33:20 -0300, Ariel D'Alessandro wrote:
> > > > Convert the existing text-based DT bindings for Marvell 8897/8997
> > > > (sd8897/sd8997) bluetooth devices controller to a DT schema.
> > > >
> > > > While here, bindings for "usb1286,204e" (USB interface) are dropped=
 from
> > > > the DT   schema definition as these are currently documented in fil=
e [0].
> > > >
> > > > [0] Documentation/devicetree/bindings/net/btusb.txt
> > > >
> > > > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> > > > ---
> > > >  .../net/bluetooth/marvell,sd8897-bt.yaml      | 79 +++++++++++++++=
+++
> > > >  .../devicetree/bindings/net/btusb.txt         |  2 +-
> > > >  .../bindings/net/marvell-bt-8xxx.txt          | 83 ---------------=
----
> > > >  3 files changed, 80 insertions(+), 84 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth=
/marvell,sd8897-bt.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/net/marvell-b=
t-8xxx.txt
> > > >
> > >
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > >
> > > You'll probably have to resend this after rc1.
> >
> > In that case I'd like to have a Fixes tag so I can remember to send it
> > as rc1 is tagged.
>
> A Fixes tag is not appropriate for a conversion to DT schema.

Ok, but then how do you justify merging it for an RC? Or I'm
misunderstanding and that should just be merged to bluetooth-next and
wait for the next merge window? In that case I can just merge it right
away.

> Rob



--=20
Luiz Augusto von Dentz
