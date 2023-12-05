Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn+UOA1g"
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C8BA
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 10:40:58 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9f9db9567so35267001fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Dec 2023 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701801657; x=1702406457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I39hTg0EiGJixeGmFzo1fbQWYgX0mLDDpiIbEwbzBnQ=;
        b=gn+UOA1gh2cIr1WGsKNWZZgPN3T3f/Xv25Oh7ud7gCIq6ys71PkxUxCgVTMCJEIjC/
         6Lf2A9woPXk8E92Ac1vbt341EiGwF0KngxGAcKslA1lhu4gxow0FrTCWLU2IJ7pa9ho+
         xNEGvPhNIdL0mIvXdxUNRxUj12cxwf07eHlpKSE1gtlQCmN6mqTE38ftY9ajMvJ5weD+
         kw3xha+Q6Wj5L+eL75lcv7F8A0XggETmkCGPu+NDCJAj7eu5sAecdVf7Hs0qwTO9JFdv
         MTFjls/Dov+m5hjx2umRwHMYtwlkrKkxmy6sRQRDrkAzzab9Lzc6geIXrzCfujMk551u
         iXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701801657; x=1702406457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I39hTg0EiGJixeGmFzo1fbQWYgX0mLDDpiIbEwbzBnQ=;
        b=rnXEuf/RMHnByIjFZVTH2LPMh0a3+5+aaMvSi0xJMF/7TdtQOAf7mRPoYmjJ2IJacv
         QRpDwblbj1s3kLHH98IN4KPDadHCfOwUgCsChIcZl1ubpwcDx8fh2pDwIV7pF/UgROc/
         0aLYSMwwmE4u32/fEGq4bcr5RxERGhcQEdBtI3n1cgNUW9ODYiRzAKVWyrVwj5WtXU6l
         4i/0rSo982RO01bExrnUCabHCPH0cQNqy3Mdbu5/TTufHpbgj/8jK6NdG8aCxlS1pvrA
         r7rk0SZGv7n+rWt+fFwacBaVhyyJEsES9XQ9fHLlbV18ckakSzW7w+qdjMaJxGmD4/tq
         nqDQ==
X-Gm-Message-State: AOJu0YyicBjhTmq1+8cCLvoE55a1GpRssufxAPyZzf5cQonip5ZK/1Y/
	Yc0WKe/Jd9oLKAH198OWl2/2PXNTagK+UO4w5RJkiZgB
X-Google-Smtp-Source: AGHT+IHdFjFaJ54O3zplcyYmaaB1rcb8A3y/jMj03TzhwIJEJqgIXKfpr3I5gcsUaGL4Xhs77jCqUosYJM3/S4jSULU=
X-Received: by 2002:a2e:9d42:0:b0:2c9:fde5:a354 with SMTP id
 y2-20020a2e9d42000000b002c9fde5a354mr2233080ljj.44.1701801656429; Tue, 05 Dec
 2023 10:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205114924.834626-1-xiaokeqinhealth@126.com>
In-Reply-To: <20231205114924.834626-1-xiaokeqinhealth@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 Dec 2023 13:40:44 -0500
Message-ID: <CABBYNZKgyBiU4-h5ivBV=mt1XMTiZc_6ftmTeHZqo1hZzGyt0g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT/SMP: Fix address type when using smp over BREDR
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, xiaoyao@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 5, 2023 at 7:05=E2=80=AFAM Xiao Yao <xiaokeqinhealth@126.com> w=
rote:
>
> From: Xiao Yao <xiaoyao@rock-chips.com>
>
> When using SMP over BREDR, the identity address(irk/ltk/csrk) is
> distributed during the SMP key distribution phase.
>
> > ACL Data RX: Handle 11 flags 0x02 dlen 12
>         BR/EDR SMP: Identity Address Information (0x09) len 7
>         Address: F8:7D:76:XX:XX:XX (OUI F8-7D-76)
> @ MGMT Event: New Identity Resolving Key (0x0018) plen 30
>         Store hint: Yes (0x01)
>         Random address: 00:00:00:00:00:00 (Non-Resolvable)
>         BR/EDR Address: F8:7D:76:XX:XX:XX (OUI F8-7D-76)
>         Key: 30cac11ec2bbc046a3658f62xxxxxxxx
> @ MGMT Event: New Long Term Key (0x000a) plen 37
>         Store hint: Yes (0x01)
>         LE Address: F8:7D:76:XX:XX:XX (OUI F8-7D-76)

So I assume the above should change to BR/EDR after applying these
changes? It probably make sense to have the trace of before and after
just to be clearer.

>         Key type: Authenticated key from P-256 (0x03)
>         Central: 0x00
>         Encryption size: 16
>         Diversifier: 0000
>         Randomizer: 0000000000000000
>         Key: a3ca3f9e06cfa8c512edc13axxxxxxxx
>
> In the mgmt_new_irk/ltk/csrk() function, addr.type is forcefully converte=
d
> to BDADDR_LE_PUBLIC using link_to_bdaddr(LE_LINK, irk/ltk/csrk->addr_type=
).
> However, the actual address type should be BDADDR_BREDR. Therefore, let's
> pass the actual link type to determine the address type.
>
> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> ---
>  include/net/bluetooth/hci_core.h |  8 +++++---
>  net/bluetooth/mgmt.c             | 14 ++++++++------
>  net/bluetooth/smp.c              | 10 +++++-----
>  3 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index eed6c9f37b12..5088fbf4c7f5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2278,10 +2278,12 @@ void mgmt_suspending(struct hci_dev *hdev, u8 sta=
te);
>  void mgmt_resuming(struct hci_dev *hdev, u8 reason, bdaddr_t *bdaddr,
>                    u8 addr_type);
>  bool mgmt_powering_down(struct hci_dev *hdev);
> -void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persis=
tent);
> -void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persis=
tent);
> +void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persis=
tent,
> +                 u8 link_type);
> +void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persis=
tent,
> +                 u8 link_type);
>  void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
> -                  bool persistent);
> +                  bool persistent, u8 link_type);
>  void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
>                          u8 bdaddr_type, u8 store_hint, u16 min_interval,
>                          u16 max_interval, u16 latency, u16 timeout);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index da79a2369dd7..fdfb395e29ba 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -9550,7 +9550,8 @@ static u8 mgmt_ltk_type(struct smp_ltk *ltk)
>         return MGMT_LTK_UNAUTHENTICATED;
>  }
>
> -void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persis=
tent)
> +void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persis=
tent,
> +                 u8 link_type)
>  {
>         struct mgmt_ev_new_long_term_key ev;
>
> @@ -9574,7 +9575,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_=
ltk *key, bool persistent)
>                 ev.store_hint =3D persistent;
>
>         bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
> -       ev.key.addr.type =3D link_to_bdaddr(LE_LINK, key->bdaddr_type);
> +       ev.key.addr.type =3D link_to_bdaddr(link_type, key->bdaddr_type);
>         ev.key.type =3D mgmt_ltk_type(key);
>         ev.key.enc_size =3D key->enc_size;
>         ev.key.ediv =3D key->ediv;
> @@ -9593,7 +9594,8 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_=
ltk *key, bool persistent)
>         mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL=
);
>  }
>
> -void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persis=
tent)
> +void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persis=
tent,
> +                 u8 link_type)
>  {
>         struct mgmt_ev_new_irk ev;
>
> @@ -9603,14 +9605,14 @@ void mgmt_new_irk(struct hci_dev *hdev, struct sm=
p_irk *irk, bool persistent)
>
>         bacpy(&ev.rpa, &irk->rpa);
>         bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
> -       ev.irk.addr.type =3D link_to_bdaddr(LE_LINK, irk->addr_type);
> +       ev.irk.addr.type =3D link_to_bdaddr(link_type, irk->addr_type);

Perhaps we should incorporate the link_type as part of irk, ltk, csrk,
etc, to guarantee this information is always available.

>         memcpy(ev.irk.val, irk->val, sizeof(irk->val));
>
>         mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
>  }
>
>  void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
> -                  bool persistent)
> +                  bool persistent, u8 link_type)
>  {
>         struct mgmt_ev_new_csrk ev;
>
> @@ -9632,7 +9634,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp=
_csrk *csrk,
>                 ev.store_hint =3D persistent;
>
>         bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
> -       ev.key.addr.type =3D link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
> +       ev.key.addr.type =3D link_to_bdaddr(link_type, csrk->bdaddr_type)=
;
>         ev.key.type =3D csrk->type;
>         memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index f1a9fc0012f0..3f640741e07b 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -1060,7 +1060,7 @@ static void smp_notify_keys(struct l2cap_conn *conn=
)
>         }
>
>         if (smp->remote_irk) {
> -               mgmt_new_irk(hdev, smp->remote_irk, persistent);
> +               mgmt_new_irk(hdev, smp->remote_irk, persistent, hcon->typ=
e);
>
>                 /* Now that user space can be considered to know the
>                  * identity address track the connection based on it
> @@ -1081,25 +1081,25 @@ static void smp_notify_keys(struct l2cap_conn *co=
nn)
>         if (smp->csrk) {
>                 smp->csrk->bdaddr_type =3D hcon->dst_type;
>                 bacpy(&smp->csrk->bdaddr, &hcon->dst);
> -               mgmt_new_csrk(hdev, smp->csrk, persistent);
> +               mgmt_new_csrk(hdev, smp->csrk, persistent, hcon->type);
>         }
>
>         if (smp->responder_csrk) {
>                 smp->responder_csrk->bdaddr_type =3D hcon->dst_type;
>                 bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
> -               mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
> +               mgmt_new_csrk(hdev, smp->responder_csrk, persistent, hcon=
->type);
>         }
>
>         if (smp->ltk) {
>                 smp->ltk->bdaddr_type =3D hcon->dst_type;
>                 bacpy(&smp->ltk->bdaddr, &hcon->dst);
> -               mgmt_new_ltk(hdev, smp->ltk, persistent);
> +               mgmt_new_ltk(hdev, smp->ltk, persistent, hcon->type);
>         }
>
>         if (smp->responder_ltk) {
>                 smp->responder_ltk->bdaddr_type =3D hcon->dst_type;
>                 bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
> -               mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
> +               mgmt_new_ltk(hdev, smp->responder_ltk, persistent, hcon->=
type);
>         }
>
>         if (smp->link_key) {
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
