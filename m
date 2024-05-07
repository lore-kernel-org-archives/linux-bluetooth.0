Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0216DEAF;
	Tue,  7 May 2024 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110165; cv=none; b=aVB+LQ/WCsahhueYw6tNjSs7aajCNBPnPMEJ67NAGAGv+Gt2KIWK2LVvAAzCWv/ZStos7iO5syqHh9a8p5UaO2vQHY6sqd8O9DEZhYCkoVjjLbH2VUXG32o2hjukmv3ceAJ8RGrSHpQtB5UWw3NpJxclVZpa4KtMMANEKmJe9qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110165; c=relaxed/simple;
	bh=YA3vrAt5ghTUgBT/wl1g2ybOyF2Dm7BJbFH3IgYhJQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBt60VrgRvspNBHx2YqRDQNsFJRy8D+N//PifETPvAi9WapzBLqU8gEV7OmSVWouIsaJeWrYsuwgEVCYGRnBvgr3zQpyxCkc18EMkQbs167ei4UxGO04xqGeNVt80bEnKnN5Ez6q0Nd+3dT8cu4SWIHfo0+9Z9ps7XPyRon+Mk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgSqjBdy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgSqjBdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E462C4AF67;
	Tue,  7 May 2024 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715110165;
	bh=YA3vrAt5ghTUgBT/wl1g2ybOyF2Dm7BJbFH3IgYhJQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LgSqjBdyXvuZAFBAirjp+OXT4c1wV2tRSE1ZZg0iV4XnCvq2xoVi3IpgV+motAvTB
	 iAChl0yAOZ2bcaWkN3irXXWZnC96szXE/3cOrZtYglNd+cwdu2wagZRu38RlMzqHge
	 4dIaa0Aj8bC3kxkIUUyeo0Lvo3QjnA0M4cg18jT6i2dh7y9Hh41J6FiIHc38EG4THu
	 r19w0WcR3OEjNGcWIV86+QIHjZ3ZaHJQisxP305ZfBPFeU3hl8OXKdNBpSO0Whe9HN
	 bKzayfZPnB3RKSaKt6v/m5D8VAOWTie80NmFues3liCVYCutBcYcr2tP6EG225GUa0
	 qvGXf3681+7WA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a86fb052so116220366b.0;
        Tue, 07 May 2024 12:29:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxlPN1sDu5eHDE4MM778KrqAJiTtFBShEVg7sjS+yHkH5OFucVgpKtzUM/aS/n1iXdHytfEqEfHONTrlsd72HquLGM7PezPdYj624t0U+L6Nj409e/yvx93h01ZprzcDX0twBn88dxI94iKifr
X-Gm-Message-State: AOJu0Yy6Si+wFWf36qcdQrvIni5t6ceikF4LY9MmydyrzJKhXbVtJzIU
	yb0quvae/+NknUjxVvhtqISCMwW7PdUMY+ssEedbwjofvUTDnQZ+jlT7NaYrmfO8P60ZdUspRsL
	EBWQ1vUQkJvEyMencY2jGSm8qAM4=
X-Google-Smtp-Source: AGHT+IEByuVf6m8ECWyAQP2z5SKrVhqt0T0clfFQazWHlWdEvX3IQG+zZQYGAX9Sn7FPQMTkdGRAMLoNYnu6b+HjNXA=
X-Received: by 2002:a17:907:910c:b0:a59:bfab:b24f with SMTP id
 a640c23a62f3a-a59fb9e5f9fmr22357066b.3.1715110163810; Tue, 07 May 2024
 12:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412095713.25641-1-hao.qin@mediatek.com> <CABBYNZJ-rvMuqHjFmQuxhmWv_K5fGFktAk-CeZfx8rw36L-Etg@mail.gmail.com>
In-Reply-To: <CABBYNZJ-rvMuqHjFmQuxhmWv_K5fGFktAk-CeZfx8rw36L-Etg@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 7 May 2024 12:29:11 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzquy_NzVwF24va87QViucpF6y-zxv1gECy2sJ5J5pFy_g@mail.gmail.com>
Message-ID: <CAGp9Lzquy_NzVwF24va87QViucpF6y-zxv1gECy2sJ5J5pFy_g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: mediatek: Support auto revert for MT7922
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hao Qin <hao.qin@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Chris Lu <chris.lu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Please disregard the patch. We will proceed with the journey using the
latest patchset I provided in the following link
https://lists.infradead.org/pipermail/linux-mediatek/2024-May/079017.html

                 Sean

On Wed, Apr 17, 2024 at 2:18=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Fri, Apr 12, 2024 at 5:57=E2=80=AFAM Hao Qin <hao.qin@mediatek.com> wr=
ote:
> >
> > Add support for auto reverting MT7922 during reset process.
>
> Need some more information of what auto reverting means in this
> context and what problem does it solves?
>
> >
> > Signed-off-by: Hao Qin <hao.qin@mediatek.com>
> > ---
> >  drivers/bluetooth/btusb.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 4c0cc13adb47..0ad96ec8d31d 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3032,7 +3032,16 @@ static int btusb_mtk_reset(struct hci_dev *hdev,=
 void *rst_data)
> >         usb_kill_anchored_urbs(&data->tx_anchor);
> >         mediatek =3D hci_get_priv(hdev);
> >
> > -       if (mediatek->dev_id =3D=3D 0x7925) {
> > +       if (mediatek->dev_id =3D=3D 0x7922) {
> > +               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> > +               val |=3D 0x00002020;
> > +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
> > +               btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x0001000=
1);
> > +               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> > +               val |=3D BIT(0);
> > +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
> > +               msleep(100);
> > +       } else if (mediatek->dev_id =3D=3D 0x7925) {
> >                 btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &=
val);
> >                 val |=3D (1 << 5);
> >                 btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, =
val);
> > @@ -3072,6 +3081,9 @@ static int btusb_mtk_reset(struct hci_dev *hdev, =
void *rst_data)
> >         if (err < 0)
> >                 bt_dev_err(hdev, "Reset timeout");
> >
> > +       if (mediatek->dev_id =3D=3D 0x7922)
> > +               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x00=
0000FF);
> > +
> >         btusb_mtk_id_get(data, 0x70010200, &val);
> >         if (!val)
> >                 bt_dev_err(hdev, "Can't get device id, subsys reset fai=
l.");
> > --
> > 2.18.0
> >
>
>
> --
> Luiz Augusto von Dentz
>
