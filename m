Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E328314B6C;
	Tue,  2 Sep 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826970; cv=none; b=JtoaetKwej7URl9zhP2p6xaqGzY3/9ysLctjd/9DPb+oq9N/X/o8bLUW0aN9N486NQGUXmNxrB1zjGrbi9jRYKpsglpO/ikW7nixbJLAiW0/RgVnMP7Wf2pupHVWWO2AcBBDWaOUMMQ81zkbnZoPDwKGtrHrKr/QE9qE/ZoCmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826970; c=relaxed/simple;
	bh=h/7pKLheTp60yfS64v6Q3yrnFtkNU0n6rfzoGNGi9Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GASL/i4I20aeiZIfnKAF6Dbnta/5dXxcVPa3Ikfvb9Ojqv3aU8fDo/qf1lUYfIX4xfrBZnkTFZOfjfUOxT/CvcZYiZBbV2pw6r7uqBWU2EdEVOvOemWOgC6Qoldo1GhxhaSESWbc5Og1DS/16PkFmem2YkTvwSJGQnd4mFwDbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhMxOzD7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhMxOzD7"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-336dc57f562so20003851fa.1;
        Tue, 02 Sep 2025 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756826966; x=1757431766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45D3H8+xv+cJQOWaurVBdJjz0km7uhmNmdRtwG5A/1w=;
        b=RhMxOzD7DL1nUu+JmYC4SZwZNUQGFjYVlPM1a7vi/OoaQk/WtE3caOJzBRfTnlbFeY
         grZrRgp8ubJzGexiEmlxAGKcJBFbsspyjBiYuSDZVQcp7G/AFxfwySFCNTw6NLD7FYV2
         Hd4kPQ79+vRgD6G6izuDrUSwoLm26QJdlEUkMdZh3W0AF+sgGvFUTGGvHjt5vl9NozwV
         1TsPCCPMEjrASSjPbbbz6hx+rvs+IoHxHevDfZnSKtQwR4JHiNsYSK7koyZ0DToGujdG
         6oEj0ODua3NK/L1AsvwlJ35d6UbpP7MfeE9Z43tOi4in049EWS03aePOLzd4JcPkhCqy
         E4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756826966; x=1757431766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45D3H8+xv+cJQOWaurVBdJjz0km7uhmNmdRtwG5A/1w=;
        b=fWvMSzig3oR31qElk27TNAIPdZVOUqrC//C5dBQIDxs2P1eVi6J+m1m9QRhM1yvhU0
         MSZn8cQeO5hrfqre/OhYsSzvMWgA4GFtQci3NGsmUb6VInCxhletxZR4bUupj9ZECoI3
         QoxTAxUFPzK3ZyvdA5tZ1NDqu+kjoBN8FTZt02uH1diATtBFz15+zuNt8kt9J3o6BaKN
         hKn4W5hGub+iFV5/3fU7wKO5/nTl5Kfz/cz69oJ7FNABE2mF1foJw0k99P/Lbs3V3if9
         rA8xEbGeEqx9ZHUDgX8WyAG7MekZbFae2O36cOhJObSmzyVfbQ3qmMkg9Ut3oQP/7gNJ
         mS/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+4EL5bhQPtXmaJ/4ITaVs6VrKYeUDqLmemSG2SXFCD8qKLqqd1QYyBznrc7anc82FebOSdAPYGLUYjXlxw1w=@vger.kernel.org, AJvYcCWDFk4Coggs89XL2Bf/Ppo+H2Ct72xhkoprslfQjeqh95qN4OcJUHsBw3SnUSicdZDWOE5QJOiP2THOcNIJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyuivZhmqPqPHZfQh8HboAjt2II1ZX0Lv48U5AU6n3+uAhp4LMi
	aoPd1IUJq/TDv4XZmMItQtzG4Q2QM1r6M/Djft1ne6BnLjsI4xVc3RD3H7UFdG0q2cWg/QBNZpm
	U+V5ngrEFa+bM9UCsKx5rOjdm/ocTFUM=
X-Gm-Gg: ASbGncstkC4zEoCdpDxKBdu/Tv5vcvKZrOh2BlOojri78d13eo3wSssXR3tWINGBV6L
	w+Z1QkCVe+br7lsmQyqls+MvzP9lSX9/8tp4BoA8QQtevZGLZA07cou4myb/3ih/DFRlCsgicWN
	Md5GXhSQr/c0AxMi3sUMN4SQH1bpY+DcrRuRYY0U81LqgiD/TcD+DMxGbqyXQK7SC5KnrIoxnoG
	8QmxFkZ45uNa4eFpxDp6S0o7RFl8qUV+x9aR19QIFKbWQ==
X-Google-Smtp-Source: AGHT+IHJ+ifO3wbwufUVcTFDMp7vzAFqN/JcOC4u8JhOqaNrPYiCiSR9o2M3s+tthdJTnwxOiQhxQf4CM1nG6ewI/aE=
X-Received: by 2002:a05:651c:551:b0:336:e22d:804a with SMTP id
 38308e7fff4ca-336e22da0cdmr26270971fa.17.1756826966207; Tue, 02 Sep 2025
 08:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202508300413.OnIedvRh-lkp@intel.com> <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
 <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de> <aLNRvzXE4O9dKZoN@mozart.vkv.me>
In-Reply-To: <aLNRvzXE4O9dKZoN@mozart.vkv.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Sep 2025 11:29:13 -0400
X-Gm-Features: Ac12FXxpABT60qjwT9pgH_IdUsZUdnJMAR-u1w75YMCcYqqH0yYBL57h5ICrG1c
Message-ID: <CABBYNZJBDgQHwmx82H2XJ-LCeOsxc77PPo6NA4zzT0dt7Uxddw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtksdio: Fix build after header cleanup
To: Calvin Owens <calvin@wbinvd.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, oe-kbuild-all@lists.linux.dev, 
	Marcel Holtmann <marcel@holtmann.org>, Sean Wang <sean.wang@mediatek.com>, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Calvin,

On Sat, Aug 30, 2025 at 3:32=E2=80=AFPM Calvin Owens <calvin@wbinvd.org> wr=
ote:
>
> On Saturday 08/30 at 07:11 +0200, Paul Menzel wrote:
> > Dear Calvin,
> >
> >
> > Thank you for your patch, and addressing the regression right away.
> >
> > Am 30.08.25 um 02:50 schrieb Calvin Owens:
> > > Syzbot found a randconfig which fails after my recent patch:
> > >
> > >      drivers/bluetooth/btmtksdio.c:442:33: error: array type has inco=
mplete element type =E2=80=98struct h4_recv_pkt=E2=80=99
> > >        442 | static const struct h4_recv_pkt mtk_recv_pkts[] =3D {
> > >            |                                 ^~~~~~~~~~~~~
> > >      drivers/bluetooth/btmtksdio.c:443:11: error: =E2=80=98H4_RECV_AC=
L=E2=80=99 undeclared here (not in a function)
> > >        443 |         { H4_RECV_ACL,      .recv =3D btmtksdio_recv_acl=
 },
> > >            |           ^~~~~~~~~~~
> > >      drivers/bluetooth/btmtksdio.c:444:11: error: =E2=80=98H4_RECV_SC=
O=E2=80=99 undeclared here (not in a function)
> > >        444 |         { H4_RECV_SCO,      .recv =3D hci_recv_frame },
> > >            |           ^~~~~~~~~~~
> > >      drivers/bluetooth/btmtksdio.c:445:11: error: =E2=80=98H4_RECV_EV=
ENT=E2=80=99 undeclared here (not in a function)
> > >        445 |         { H4_RECV_EVENT,    .recv =3D btmtksdio_recv_eve=
nt },
> > >
> > > ...because we can have BT_MTKSDIO=3Dy with BT_HCIUART_H4=3Dn, and the
> > > definitions used here are gated on BT_HCIUART_H4 in hci_uart.h.
> >
> > The drivers below seem to be affected:
> >
> >     drivers/bluetooth/bpa10x.c:     { H4_RECV_EVENT,   .recv =3D
> > hci_recv_frame },
> >     drivers/bluetooth/btmtksdio.c:  { H4_RECV_EVENT,    .recv =3D
> > btmtksdio_recv_event },
> >     drivers/bluetooth/btmtkuart.c:  { H4_RECV_EVENT,    .recv =3D
> > btmtkuart_recv_event },
> >     drivers/bluetooth/btnxpuart.c:  { H4_RECV_EVENT,        .recv =3D
> > hci_recv_frame },
> >
> > > I think the simplest way to fix this is to remove the gate on the
> > > definitions in hci_uart.h. Since the constants are macros, there's no
> > > runtime cost to doing so, and nothing seems to rely on their absence =
in
> > > the BT_HCIUART_H4=3Dn case.
> >
> > Looking at the implementation, it looks like they only work with the H4
> > protocol? So maybe, that should be denoted in the Kconfig files?
>
> Thanks for looking Paul.
>
> Yes, my fix will cause a link error with other randconfigs, which my
> 'make randconfig drivers/bluetooth/' test loop missed after I made the
> function prototype always defined, whoops.
>
> We do need the dependencies here, as you note. The btmtksdio case syzbot
> found is the odd one out because it only uses the constants, and doesn't
> call h4_recv_buf().
>
> Hopefully this gets it all:
>
> -----8<-----
> From: Calvin Owens <calvin@wbinvd.org>
> Subject: [PATCH v2] Bluetooth: Fix build after header cleanup
>
> Some Kconfig dependencies are needed after my recent cleanup, since
> the core code has its own option.
>
> Since btmtksdio does not actually call h4_recv_buf(), move the
> definitions it uses outside the BT_HCIUART_H4 gate in hci_uart.h to
> avoid adding a dependency for btmtksdio.
>
> The rest I touched (bpa10x, btmtkuart, and btnxpuart) do really call
> h4_recv_buf(), so the dependency is required, add it for them.
>
> Fixes: 74bcec450eea ("Bluetooth: remove duplicate h4_recv_buf() in header=
")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@i=
ntel.com/
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  drivers/bluetooth/Kconfig    | 6 ++++++
>  drivers/bluetooth/hci_uart.h | 8 ++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4ab32abf0f48..7df69ccb6600 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -312,7 +312,9 @@ config BT_HCIBCM4377
>
>  config BT_HCIBPA10X
>         tristate "HCI BPA10x USB driver"
> +       depends on BT_HCIUART
>         depends on USB
> +       select BT_HCIUART_H4
>         help
>           Bluetooth HCI BPA10x USB driver.
>           This driver provides support for the Digianswer BPA 100/105 Blu=
etooth
> @@ -437,8 +439,10 @@ config BT_MTKSDIO
>
>  config BT_MTKUART
>         tristate "MediaTek HCI UART driver"
> +       depends on BT_HCIUART
>         depends on SERIAL_DEV_BUS
>         depends on USB || !BT_HCIBTUSB_MTK
> +       select BT_HCIUART_H4
>         select BT_MTK
>         help
>           MediaTek Bluetooth HCI UART driver.
> @@ -483,7 +487,9 @@ config BT_VIRTIO
>
>  config BT_NXPUART
>         tristate "NXP protocol support"
> +       depends on BT_HCIUART
>         depends on SERIAL_DEV_BUS
> +       select BT_HCIUART_H4
>         select CRC32
>         select CRC8
>         help
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 5ea5dd80e297..cbbe79b241ce 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -121,10 +121,6 @@ void hci_uart_set_flow_control(struct hci_uart *hu, =
bool enable);
>  void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
>                          unsigned int oper_speed);
>
> -#ifdef CONFIG_BT_HCIUART_H4
> -int h4_init(void);
> -int h4_deinit(void);
> -
>  struct h4_recv_pkt {
>         u8  type;       /* Packet type */
>         u8  hlen;       /* Header length */
> @@ -162,6 +158,10 @@ struct h4_recv_pkt {
>         .lsize =3D 2, \
>         .maxlen =3D HCI_MAX_FRAME_SIZE \
>
> +#ifdef CONFIG_BT_HCIUART_H4
> +int h4_init(void);
> +int h4_deinit(void);
> +
>  struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
>                             const unsigned char *buffer, int count,
>                             const struct h4_recv_pkt *pkts, int pkts_coun=
t);
> --
> 2.47.2

Please send a v2 then otherwise this is no pickup by the likes of CI
and patchwork.

>


--=20
Luiz Augusto von Dentz
