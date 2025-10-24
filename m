Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E21C860E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325852; cv=none; b=jmAQOywalj7P21Xzn/vREj97KqaZmSp4IuxuJ8xyYsdaCUfA7r3ikglO8jKVNcYXgCBNN5h/hT/Xq4eDs8bkgt0KZ991rDUqCcbqgTIUJpYT0936usPmQmyxJ0V2vM4tnvEd8cKinSoL3fb+rmDd6kw30IVG+THBOO43Luk2rtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325852; c=relaxed/simple;
	bh=GdOKVcVxWIYVdHeYTzUFacYZkQbUVpcSXn4/u82IQ4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CF3RpP0rI+uYdvaly0SyArmfzpctEHiHr6zKFVZdeluKArQ7AicqlsbLhPHDqVcrrETli/mN1VJvZ/IQeQ1YHuKrcq1r4i3R6Ei3QKMFuroPpi4Lef9yIY7FwaBn8Dj6d+1JjQTVTvXcFM+RoNB3RLqkwqObU+qwiqwDC15KTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUSYZykY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUSYZykY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDEEC4CEFB
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761325851;
	bh=GdOKVcVxWIYVdHeYTzUFacYZkQbUVpcSXn4/u82IQ4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZUSYZykY9yk3dmtM/dB3+gcFHK+xBS4dbrjv02L5CrvD9DPMJEnKwiRf0MO/lxP5E
	 jwPhF27oZDwHnE9Ckv8EfBE5cNuIaLYNlxsvd5fTgZ40KRllKLsMJ3b0zWjVwbX2P7
	 yohudETHBhH0QKZgy6CXpLN6Zz7I0jKNOYY31JVYLWYdD90I5GhfC4caOaunyDnHLY
	 56nCGNc7z8jtE/uZ3c9/lyMUR9Zn/LNO5bRePOruiivyW1RInOhJ8BHy0LcCWu+/uH
	 ClPZ1Lkz7BlU9HV6BtOXUWJjo/N6Mv7HgYClTCHWiG11h7rFrjwtbwd6dM2zd51b2E
	 8qA/+OzvRVtkg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso4918733a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 10:10:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvcTBvxsaBsXpDE47KOF95WwYy0Z3O6qVg9UZLByJ2StDh1bCFh9p/hxSFGkyGHeqcdG1NNLHHbs8SG9TGPbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+pH1conpBnOp7HoS3dQd96bo02e5jBsyP9SczCd+OQ3sGVHy
	V23JZqv6f6wyF0AIwKRNKdBmwhibC9+G1iUuRCGNuCJj4tuKMzY5vaUVPTWeNnH8W0t+tflHVXT
	YPXNYIFaYUHHjsA2DhuQzVok7QAgUIg==
X-Google-Smtp-Source: AGHT+IG/3WEThz7PazPn+Pa/kjHjCobatN9xX8Xpu3xgx4wz+CQWm8nO+WeSfGQCmjID3LuEq7En1oyBdhiGX59jKTE=
X-Received: by 2002:a17:906:3c9:b0:b6d:7f68:7874 with SMTP id
 a640c23a62f3a-b6d7f6878famr57952766b.44.1761325850450; Fri, 24 Oct 2025
 10:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
 <175943240204.235529.17735630695826458855.robh@kernel.org>
 <CABBYNZKSFCes1ag0oiEptKpifb=gqLt1LQ+mdvF8tYRj8uDDuQ@mail.gmail.com>
 <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
 <CABBYNZKxGNXS2m7_VAf1d_Ci3uW4xG2NamXZ0UVaHvKvHi07Jg@mail.gmail.com> <CAL_Jsq+aO8Fdq_7PHvh0aTb00qvGdKe2RDRotYcWjqGHppyL4g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+aO8Fdq_7PHvh0aTb00qvGdKe2RDRotYcWjqGHppyL4g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 24 Oct 2025 12:10:38 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+vOKpR+YZWdsT5o=CrB=MT1ZeK0=_HuLG33p_wnj-MNA@mail.gmail.com>
X-Gm-Features: AWmQ_blrtMIqgkYEu8hw0I_RorB-tKtgwstXs8EHR-BCdkzmS79EpyfM_OAhwFY
Message-ID: <CAL_Jsq+vOKpR+YZWdsT5o=CrB=MT1ZeK0=_HuLG33p_wnj-MNA@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT schema
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, andrew+netdev@lunn.ch, 
	conor+dt@kernel.org, kernel@collabora.com, krzk+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, kuba@kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 2:22=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 3, 2025 at 9:33=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, Oct 3, 2025 at 9:38=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> > >
> > > On Thu, Oct 2, 2025 at 2:18=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Oct 2, 2025 at 3:14=E2=80=AFPM Rob Herring (Arm) <robh@kern=
el.org> wrote:
> > > > >
> > > > >
> > > > > On Wed, 01 Oct 2025 15:33:20 -0300, Ariel D'Alessandro wrote:
> > > > > > Convert the existing text-based DT bindings for Marvell 8897/89=
97
> > > > > > (sd8897/sd8997) bluetooth devices controller to a DT schema.
> > > > > >
> > > > > > While here, bindings for "usb1286,204e" (USB interface) are dro=
pped from
> > > > > > the DT   schema definition as these are currently documented in=
 file [0].
> > > > > >
> > > > > > [0] Documentation/devicetree/bindings/net/btusb.txt
> > > > > >
> > > > > > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.=
com>
> > > > > > ---
> > > > > >  .../net/bluetooth/marvell,sd8897-bt.yaml      | 79 +++++++++++=
+++++++
> > > > > >  .../devicetree/bindings/net/btusb.txt         |  2 +-
> > > > > >  .../bindings/net/marvell-bt-8xxx.txt          | 83 -----------=
--------
> > > > > >  3 files changed, 80 insertions(+), 84 deletions(-)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/net/bluet=
ooth/marvell,sd8897-bt.yaml
> > > > > >  delete mode 100644 Documentation/devicetree/bindings/net/marve=
ll-bt-8xxx.txt
> > > > > >
> > > > >
> > > > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > > >
> > > > > You'll probably have to resend this after rc1.
> > > >
> > > > In that case I'd like to have a Fixes tag so I can remember to send=
 it
> > > > as rc1 is tagged.
> > >
> > > A Fixes tag is not appropriate for a conversion to DT schema.
> >
> > Ok, but then how do you justify merging it for an RC?
>
> I don't.
>
> > Or I'm
> > misunderstanding and that should just be merged to bluetooth-next and
> > wait for the next merge window?
>
> Yes, this is 6.19 material.
>
> > In that case I can just merge it right
> > away.
>
> That's up to you.

Luiz, Are you going to pick this up or do you want it resent?

Rob
