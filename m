Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41032367B1;
	Fri,  9 May 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807236; cv=none; b=tPfxrbzF/Qj44/lcw7K8SSNxwkRkYv+CKTNn1+Rq/Ae+gH8iHUoRLZuvr9JOuVaWsSnGbTWYtjXk+rZLWeTlxjwDX8eS8c/7o/c03P2ba9+/JjoAFZbjr4DRUuCNJY7TAtmyoK+Dtt1rnjrqVqdu+FGxdLxUD47PXih/dO0qB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807236; c=relaxed/simple;
	bh=DvqUdBGK3qqM5NpI6UbmFyhga1fK3OK92MfA9hlg8+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZb3nHaoeLL2jhMGyMsRD6WWKd+frGieCoXtsbsIKf+d3D9s9eojjA+nu9PnpR2Ju11c/GgPqK/LilMiJD6PbxKFtFTo4ZgvAeEpT8lKcFvMTvim5/kqdTgtM1EbFFvEAH1PR0cZesYqgVA757sqESe7sXHHnnFKp6wjBxrn7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQRgdvbE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQRgdvbE"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3105ef2a071so26012471fa.1;
        Fri, 09 May 2025 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746807233; x=1747412033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdjRZ8kWgdlygetbiJM8snNNIhyxMwsGsBXVDaSIIV0=;
        b=iQRgdvbEm1HjSIqr5qyLnF8wMeF3CKBbaZIuM89N0YNi5tfuuDDzqK+wvK15a27j58
         UKClJu9noby2XH3mRuz4Ozl1bILuMMjdpu6nkZ/ECAkYHKdKXKqbW5zPD9b74yRz9CCj
         iDQemNDKN0D81xK8m5kUNnUK7fbbTtDWRdw2PAFFMo3xi5t9czI8W/C1XrAMX1glRn+w
         PDYDmEpv6aYht9Gzq2iZKxmklajZTnLiwxKd44XzJFvqxa1IlVIS1xdNhblVnFmtDJHe
         Wlc0OAujXmASWfS0OA6mxn1D6nasZyRo81cZqVSawoHLEoQcdf2s5UJE4d0Bi4MooY3o
         cOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746807233; x=1747412033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdjRZ8kWgdlygetbiJM8snNNIhyxMwsGsBXVDaSIIV0=;
        b=L8c60wDyRS1hQDQxZCG69lvRlfQ/EYLtdWU3zYBvGSmt6I0JLt4TsgmlkSy6BYAeEr
         z2nIq+thKpkK0iw/cIy6Xtz2vcx0JYwxepiWcCGpTggWOjLdzkinQJCb9CYjCB2ddHtq
         f2D0DQBaZn7QeintWkuGrhfuCpo5qRqAnE5rgydSk4yTEuIUPUcqbCcwicpbkauQ/4wH
         Ysxt0g7eEGk2z4PjKgO3TEIYjFHPWN6XmJ4kOHes29pu8BH5obE1dIwT6xY9FCKRgJZw
         t/Fguc2StmQPGRG4QjAB/vZD3+skFQQrJjviLSHSyuNgG4Zw9MaQ4UPR8k4+VvpZkMyd
         LG1w==
X-Forwarded-Encrypted: i=1; AJvYcCURxmJPaixdIX2YJ5CV3FFPx1Umyels6+/rICTTdtK0N1ojWRVhCyRf6byepwHel/YOy6AcJV6Yjd7yyf/e@vger.kernel.org, AJvYcCUrQ1VLqh50wEZ80LEVxkk3Cc2tRyyYRH5sW5pwpDZhroAqwxHHHtOA3mNJDWc/iKzvZjbWOeiY3/gvDZQfx0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wr2EaOrULc5QeiZTGho82YTOjp4uhyOl203AZyNUO7EM3aeU
	LK9NAgD+HKOWb8mAMm8hbpk1PfR0usHKbWyKjcjznL4Ppzf0rhMYbphUVR5lHa+k3zRAFX+RnJm
	emgLro7zXE80YWeOdofLhfNHD4GM=
X-Gm-Gg: ASbGncv6mCs0QnxPInPKJhOxiCPTSvIa6K5oriusKdgDlxXEFB7yLIRaCnWD9d0zCBw
	pt5I3YUiAXK3HnVQsoELgTPDU51HPOmSr2AgPX2gp3MQQopjwVe7r4myvj16XXOxtC6kab1TM/h
	BlggieiXZHN9dW14O8HlPs
X-Google-Smtp-Source: AGHT+IF5h2wKi/PV1ym86BhwV6SUssh82eTXTBtJP150byFQVhdhBW+dhLFoUNrv4VOPR9XfWl0M41Hg2+O2Fznf+zs=
X-Received: by 2002:a2e:a542:0:b0:30c:5c6:91e0 with SMTP id
 38308e7fff4ca-326c459a4abmr20414131fa.2.1746807232323; Fri, 09 May 2025
 09:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-iso-v2-1-da53bd18c193@amlogic.com> <772853441dbc7bef7dc49741d2a76aedaf92525d.camel@iki.fi>
In-Reply-To: <772853441dbc7bef7dc49741d2a76aedaf92525d.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 May 2025 12:13:39 -0400
X-Gm-Features: AX0GCFuaOvOT5CZ4bNWnll19k0oXV44m2rJ5l6zh1ZEB6GoH-8LqQY07w7qXvTw
Message-ID: <CABBYNZLjLw0AasZj4Wyo2cag1CqaketCxGUB5ceNx9s9m+ydZg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix socket matching ambiguity between BIS
 and CIS
To: Pauli Virtanen <pav@iki.fi>
Cc: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, May 9, 2025 at 11:46=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> pe, 2025-05-09 kello 18:17 +0800, Yang Li via B4 Relay kirjoitti:
> > From: Yang Li <yang.li@amlogic.com>
> >
> > When the DUT acts as a sink device, and a BIS already exists,
> > creating a CIS connection can cause the kernel to incorrectly
> > reference the BIS socket. This occurs because the socket
> > lookup only checks for state =3D=3D BT_LISTEN, without
> > distinguishing between BIS and CIS socket types.
> >
> > To fix this, match the destination address (dst addr) during
> > ISO socket lookup to differentiate between BIS and CIS sockets
> > properly.
>
> Does it work if you have both CIS and BIS established between the same
> two machines?
>
> Now that CIS_LINK and BIS_LINK are separate hci_conn types, it could
> make sense to introduce `__u8 hcon_type;` in iso_pinfo, maybe set in
> iso_connect/listen so that also the socket types won't be confused.

We do store the hci_conn as part of iso_conn which is already a member
of iso_pinfo, so the information of the conn type is already
accessible from the iso.c.

> >
> > Link: https://github.com/bluez/bluez/issues/1224
> >
> > Signed-off-by: Yang Li <yang.li@amlogic.com>
> > ---
> > Changes in v2:
> > - Fix compilation errors
> > - Improved the problem description for clarity.
> > - Link to v1: https://lore.kernel.org/r/20250507-iso-v1-1-6f60d243e037@=
amlogic.com
> > ---
> >  net/bluetooth/hci_event.c | 34 +++++++++++++++++++---------------
> >  net/bluetooth/iso.c       | 12 +++++++++---
> >  2 files changed, 28 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 66052d6aaa1d..6b26344ad69f 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6413,6 +6413,8 @@ static void hci_le_pa_sync_estabilished_evt(struc=
t hci_dev *hdev, void *data,
> >
> >       conn->sync_handle =3D le16_to_cpu(ev->handle);
> >       conn->sid =3D HCI_SID_INVALID;
> > +     conn->dst =3D ev->bdaddr;
> > +     conn->dst_type =3D ev->bdaddr_type;
> >
> >       mask |=3D hci_proto_connect_ind(hdev, &ev->bdaddr, BIS_LINK,
> >                                     &flags);
> > @@ -6425,7 +6427,7 @@ static void hci_le_pa_sync_estabilished_evt(struc=
t hci_dev *hdev, void *data,
> >               goto unlock;
> >
> >       /* Add connection to indicate PA sync event */
> > -     pa_sync =3D hci_conn_add_unset(hdev, BIS_LINK, BDADDR_ANY,
> > +     pa_sync =3D hci_conn_add_unset(hdev, BIS_LINK, &ev->bdaddr,
> >                                    HCI_ROLE_SLAVE);
>
> Do these make the update of conn->dst in iso_conn_ready() unnecessary?
>
> It should be documented somewhere what are the different types of
> BIS_LINK hci_conn that exist, and what are their invariants...
>
> >       if (IS_ERR(pa_sync))
> > @@ -6456,13 +6458,6 @@ static void hci_le_per_adv_report_evt(struct hci=
_dev *hdev, void *data,
> >
> >       hci_dev_lock(hdev);
> >
> > -     mask |=3D hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flag=
s);
> > -     if (!(mask & HCI_LM_ACCEPT))
> > -             goto unlock;
> > -
> > -     if (!(flags & HCI_PROTO_DEFER))
> > -             goto unlock;
> > -
> >       pa_sync =3D hci_conn_hash_lookup_pa_sync_handle
> >                       (hdev,
> >                       le16_to_cpu(ev->sync_handle));
> > @@ -6470,6 +6465,13 @@ static void hci_le_per_adv_report_evt(struct hci=
_dev *hdev, void *data,
> >       if (!pa_sync)
> >               goto unlock;
> >
> > +     mask |=3D hci_proto_connect_ind(hdev, &pa_sync->dst, BIS_LINK, &f=
lags);
> > +     if (!(mask & HCI_LM_ACCEPT))
> > +             goto unlock;
> > +
> > +     if (!(flags & HCI_PROTO_DEFER))
> > +             goto unlock;
> > +
>
> Commit message should explain what this reordering of *_ind after
> pa_sync lookup/update are for.
>
> >       if (ev->data_status =3D=3D LE_PA_DATA_COMPLETE &&
> >           !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags)) {
> >               /* Notify iso layer */
> > @@ -6993,6 +6995,8 @@ static void hci_le_big_sync_established_evt(struc=
t hci_dev *hdev, void *data,
> >                       set_bit(HCI_CONN_PA_SYNC, &bis->flags);
> >
> >               bis->sync_handle =3D conn->sync_handle;
> > +             bis->dst =3D conn->dst;
> > +             bis->dst_type =3D conn->dst_type;
> >               bis->iso_qos.bcast.big =3D ev->handle;
> >               memset(&interval, 0, sizeof(interval));
> >               memcpy(&interval, ev->latency, sizeof(ev->latency));
> > @@ -7038,13 +7042,6 @@ static void hci_le_big_info_adv_report_evt(struc=
t hci_dev *hdev, void *data,
> >
> >       hci_dev_lock(hdev);
> >
> > -     mask |=3D hci_proto_connect_ind(hdev, BDADDR_ANY, BIS_LINK, &flag=
s);
> > -     if (!(mask & HCI_LM_ACCEPT))
> > -             goto unlock;
> > -
> > -     if (!(flags & HCI_PROTO_DEFER))
> > -             goto unlock;
> > -
> >       pa_sync =3D hci_conn_hash_lookup_pa_sync_handle
> >                       (hdev,
> >                       le16_to_cpu(ev->sync_handle));
> > @@ -7054,6 +7051,13 @@ static void hci_le_big_info_adv_report_evt(struc=
t hci_dev *hdev, void *data,
> >
> >       pa_sync->iso_qos.bcast.encryption =3D ev->encryption;
> >
> > +     mask |=3D hci_proto_connect_ind(hdev, &pa_sync->dst, BIS_LINK, &f=
lags);
> > +     if (!(mask & HCI_LM_ACCEPT))
> > +             goto unlock;
> > +
> > +     if (!(flags & HCI_PROTO_DEFER))
> > +             goto unlock;
> > +
> >
> >       /* Notify iso layer */
> >       hci_connect_cfm(pa_sync, 0);
> >
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 6e2c752aaa8f..1dc233f04dbe 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -641,11 +641,12 @@ static struct sock *iso_get_sock(bdaddr_t *src, b=
daddr_t *dst,
> >                       continue;
> >
> >               /* Exact match. */
> > -             if (!bacmp(&iso_pi(sk)->src, src)) {
> > +             if (!bacmp(&iso_pi(sk)->src, src)
> > +                  && !bacmp(&iso_pi(sk)->dst, dst)
> > +                     ){
>
> Code style issues here.
>
> >                       sock_hold(sk);
> >                       break;
> >               }
> > -
> >               /* Closest match */
> >               if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY)) {
> >                       if (sk1)
> > @@ -1962,7 +1963,7 @@ static void iso_conn_ready(struct iso_conn *conn)
> >               }
> >
> >               if (!parent)
> > -                     parent =3D iso_get_sock(&hcon->src, BDADDR_ANY,
> > +                     parent =3D iso_get_sock(&hcon->src, &hcon->dst,
> >                                             BT_LISTEN, NULL, NULL);
>
> I think the code here would be more clear if it's refactored to handle
> hcon->type =3D=3D CIS_LINK and hcon->type =3D=3D BIS_LINK with explicitly
> separate code path.
>
> What happens here if we have a BIS listener socket for `dst`, and `dst`
> initiates a CIS connection? Won't the CIS connection get resolved to
> the BIS listener socket?
>
> IIUC CIS listeners always have dst =3D=3D BDADDR_ANY. BIS listeners have
> dst !=3D BDADDR_ANY.
>
> Perhaps there could also be `__u8 hcon_type` in iso_pinfo that gets set
> to CIS_LINK or BIS_LINK in iso_connect/listen.
>
> >
> >               if (!parent)
> > @@ -2203,6 +2204,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr=
_t *bdaddr, __u8 *flags)
> >       } else {
> >               sk =3D iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
> >                                 BT_LISTEN, NULL, NULL);
> > +             if (!sk)
> > +                     sk =3D iso_get_sock(&hdev->bdaddr, bdaddr,
> > +                                       BT_LISTEN, NULL, NULL);
> > +             else
> > +                     iso_pi(sk)->dst =3D *bdaddr;
>
> This updates the listener socket dst address with that of the
> connecting device? I think what is set in bind() shouldn't be modified
> later on.
>
> Isn't this wrong for CIS, won't it block connecting another device?

On top of these comments this lacks proper testing with iso-tester
which seems to be failing with these changes, beside that we would
probably benefit from having a test that emulates this topology, which
appears to mix CIS and BIS together, which doesn't seem to be covered
in any audio configuration (AC-#) from the spec, although it seems
valid to support it if controllers are capable of doing it.

> >       }
> >
> >  done:
> >
> > ---
> > base-commit: f3daca9b490154fbb0459848cc2ed61e8367bddc
> > change-id: 20250506-iso-6515893b5bb3
> >
> > Best regards,
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
