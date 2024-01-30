Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817FD65BB9
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610460; cv=none; b=J9LI6KoZzB9SbQ5xV/0Yo4ggg45LARPF7VdjgJvb9HuW+ZqnfJGil0+HQ4FRRl5rmIhD+cc21ujju9kzzgzWVIc1XExP4f2RRJ+DhOiQdfB22e73QU6ryHAFoy1dCD2tx0GUlW660JoLowk82d3rGK70Rm7FtLU1cvTx16/4qzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610460; c=relaxed/simple;
	bh=6282+jmI3j2M3TvDGB1Bvm7do+FcQcpp6OqEZLdRtT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZU2QBCmKPrL3RMAljRBEqVgYwOHoVhvb0RV7lmH1iU61rnLneLUmyxaWrFmFEjib+f4tfRY+lKgoEtyC6+45+ACrqUbqJQA9urhKex+pvZrQ/lbVLREU/Yc+oSJsCqd1PJbo0yDXuhfNQ7V9k0sHDjShYI0NJza8PZc8Mvgb1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pxzyo6nK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pxzyo6nK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ef9382752so48745e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 02:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706610456; x=1707215256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDrJO8ydCY5Tl1JoeeEwDeVWfv8bpBsBunRNvbjag8Q=;
        b=Pxzyo6nKH8FzMNZR0qaBBKMG167dK8r/cHY9wnWgOTpGO6247rcRfcc51BjaMWnWIx
         i1DfUcmFFN3uKUrpksj/EOAexNQ2qeJg0GZMOAa3oo/6Lns9gCRk+n/SeEQfhLKf5Xng
         QHiYH13IQukHf8HHv5wYWYorYp7RgSotv9k2yE2PKwpoVqIxXU5OhB+0u+jU6zIXiOJ2
         MfHGZkH9oZwSb7AcZxuN+fHRAo047cVq8FWdP+WMvikv/ei7fg8g1pXuSaxjsWhxeCLQ
         PtIwZ6EAIGdKI0vEIIv/pGRuC1D6qRm4YMaNKORxOHYZ1UqkgdeTmIJxbQxNwGezEZ9J
         k5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610456; x=1707215256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDrJO8ydCY5Tl1JoeeEwDeVWfv8bpBsBunRNvbjag8Q=;
        b=ntjPeiC3xWsybx5eQA6Zi8O49C4isC1mu3av8KVPP29HTTVB/2rozOPAz9qZReiETZ
         lgA1xMq/l1OKsZMPzHooP9Dc7NAHxztIE/XPV0GuecCRNcCI4PxDO0OK/q/aAIjT4jXe
         EpxAxXwZ9uuuROitxnImwhFOvadnQnZjWZtcLY1O0psb0qu9Oyk7QVtnrC6WgdIwh3Jk
         qOmWW+liercpVTR7gg3RqZFDMuF7EYllVZ4OrZPOYR/tagPa1p4ssnaMy0fjbqeigbJG
         /Oq7PPxzLcry6a70jLrgVPtvBCSFQ92wP6MRRZaqXgnRXvhAKSA1YrTty8/NIeBgWoIP
         EsYA==
X-Gm-Message-State: AOJu0YysG4t1pERiTlAuGU6yB7jOTgOcUQybEa+qR9Q9L/kPL3WtVFo/
	lNGbo+WmY+zbFsWeVyyOSBZYUqhVJNzxPuHhQS5YbDvnjo8mZv4GlNvC/c8glfJ5aiHe3yB2OTJ
	KVJw8eKXgg3KRd13ImiOPpgTgWKObajL/PagJ
X-Google-Smtp-Source: AGHT+IFtADk+hGdPmpj6pBh2boGZLqfcBJrIosYwkF632X+/2TExmo6rVIrsZWJZ7VrxLWijrKUFLvTPuoAKgOxN/vk=
X-Received: by 2002:a05:600c:1e13:b0:40e:fa92:e52d with SMTP id
 ay19-20020a05600c1e1300b0040efa92e52dmr136674wmb.2.1706610456401; Tue, 30 Jan
 2024 02:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126144120.Bluez.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
 <CABBYNZL3yZ1_7wVyGg6fMZ=a3thqia2i+WSBFFyvBxTt4KPEgA@mail.gmail.com>
 <CAJQfnxFwuhDnZRKYXMO3-i0YVuHTXgp6wdRNmAmob_xMm4n+5Q@mail.gmail.com> <CABBYNZL2Nuv2LVDHE11rMaZTeLO6Jw7uEabij4A+2N1G-xf33w@mail.gmail.com>
In-Reply-To: <CABBYNZL2Nuv2LVDHE11rMaZTeLO6Jw7uEabij4A+2N1G-xf33w@mail.gmail.com>
From: Archie Pusaka <apusaka@google.com>
Date: Tue, 30 Jan 2024 18:27:24 +0800
Message-ID: <CAJQfnxEossFEWJNj8pnRo_JEbAZNv_MSEuoT4q2w7i3Yu_37RA@mail.gmail.com>
Subject: Re: [Bluez PATCH] Monitor: Remove handle before assigning
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Tue, 30 Jan 2024 at 02:57, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Sun, Jan 28, 2024 at 7:18=E2=80=AFAM Archie Pusaka <apusaka@google.com=
> wrote:
> >
> > Hi Luiz,
> >
> > On Sat, 27 Jan 2024 at 03:01, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Fri, Jan 26, 2024 at 1:42=E2=80=AFAM Archie Pusaka <apusaka@google=
.com> wrote:
> > > >
> > > > From: Archie Pusaka <apusaka@chromium.org>
> > > >
> > > > It is possible to have some handles not removed, for example the ho=
st
> > > > may decide not to wait for disconnection complete event when it is
> > > > suspending. In this case, when the peer device reconnected, we migh=
t
> > > > have two of the same handle assigned and create problem down the ro=
ad.
> > > >
> > > > This patch solves the issue by always removing any previous handles
> > > > when assigning a new handle if they are the same.
> > > >
> > > > Reviewed-by: Zhengping Jiang <jiangzp@google.com>
> > > >
> > > > ---
> > > >
> > > >  monitor/packet.c | 50 +++++++++++++++++++++++++-------------------=
----
> > > >  1 file changed, 26 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/monitor/packet.c b/monitor/packet.c
> > > > index 42e711cafa..b5dea6384a 100644
> > > > --- a/monitor/packet.c
> > > > +++ b/monitor/packet.c
> > > > @@ -189,11 +189,33 @@ static struct packet_conn_data *lookup_parent=
(uint16_t handle)
> > > >         return NULL;
> > > >  }
> > > >
> > > > +static void release_handle(uint16_t handle)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       for (i =3D 0; i < MAX_CONN; i++) {
> > > > +               struct packet_conn_data *conn =3D &conn_list[i];
> > > > +
> > > > +               if (conn->handle =3D=3D handle) {
> > > > +                       if (conn->destroy)
> > > > +                               conn->destroy(conn->data);
> > > > +
> > > > +                       queue_destroy(conn->tx_q, free);
> > > > +                       queue_destroy(conn->chan_q, free);
> > > > +                       memset(conn, 0, sizeof(*conn));
> > > > +                       conn->handle =3D 0xffff;
> > > > +                       break;
> > > > +               }
> > > > +       }
> > > > +}
> > >
> > > We might as well return if we find out there is a packet_conn_data,
> > > that way we don't need to do 2 lookups in a row.
> >
> > Do you mean to return the index, so we can immediately use the index
> > in the assign_handle function?
>
> I think you can return the pointer directly:
>
>
> conn =3D release_handle(handle);
> if (conn)
>    hci_devba(index, conn->src);
> ...
>

Sure, let's implement it this way.

>
> > >
> > > >  static void assign_handle(uint16_t index, uint16_t handle, uint8_t=
 type,
> > > >                                         uint8_t *dst, uint8_t dst_t=
ype)
> > > >  {
> > > >         int i;
> > > >
> > > > +       release_handle(handle);
> > > > +
> > > >         for (i =3D 0; i < MAX_CONN; i++) {
> > > >                 if (conn_list[i].handle =3D=3D 0xffff) {
> > > >                         hci_devba(index, (bdaddr_t *)conn_list[i].s=
rc);
> > > > @@ -225,26 +247,6 @@ static void assign_handle(uint16_t index, uint=
16_t handle, uint8_t type,
> > > >         }
> > > >  }
> > > >
> > > > -static void release_handle(uint16_t handle)
> > > > -{
> > > > -       int i;
> > > > -
> > > > -       for (i =3D 0; i < MAX_CONN; i++) {
> > > > -               struct packet_conn_data *conn =3D &conn_list[i];
> > > > -
> > > > -               if (conn->handle =3D=3D handle) {
> > > > -                       if (conn->destroy)
> > > > -                               conn->destroy(conn->data);
> > > > -
> > > > -                       queue_destroy(conn->tx_q, free);
> > > > -                       queue_destroy(conn->chan_q, free);
> > > > -                       memset(conn, 0, sizeof(*conn));
> > > > -                       conn->handle =3D 0xffff;
> > > > -                       break;
> > > > -               }
> > > > -       }
> > > > -}
> > > > -
> > > >  struct packet_conn_data *packet_get_conn_data(uint16_t handle)
> > > >  {
> > > >         int i;
> > > > @@ -10076,7 +10078,7 @@ static void conn_complete_evt(struct timeva=
l *tv, uint16_t index,
> > > >         const struct bt_hci_evt_conn_complete *evt =3D data;
> > > >
> > > >         print_status(evt->status);
> > > > -       print_handle(evt->handle);
> > > > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> > > >         print_bdaddr(evt->bdaddr);
> > > >         print_link_type(evt->link_type);
> > > >         print_enable("Encryption", evt->encr_mode);
> > > > @@ -10648,7 +10650,7 @@ static void sync_conn_complete_evt(struct t=
imeval *tv, uint16_t index,
> > > >         const struct bt_hci_evt_sync_conn_complete *evt =3D data;
> > > >
> > > >         print_status(evt->status);
> > > > -       print_handle(evt->handle);
> > > > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> > > >         print_bdaddr(evt->bdaddr);
> > > >         print_link_type(evt->link_type);
> > > >         print_field("Transmission interval: 0x%2.2x", evt->tx_inter=
val);
> > > > @@ -11077,7 +11079,7 @@ static void le_conn_complete_evt(struct tim=
eval *tv, uint16_t index,
> > > >         const struct bt_hci_evt_le_conn_complete *evt =3D data;
> > > >
> > > >         print_status(evt->status);
> > > > -       print_handle(evt->handle);
> > > > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> > > >         print_role(evt->role);
> > > >         print_peer_addr_type("Peer address type", evt->peer_addr_ty=
pe);
> > > >         print_addr("Peer address", evt->peer_addr, evt->peer_addr_t=
ype);
> > > > @@ -11206,7 +11208,7 @@ static void le_enhanced_conn_complete_evt(s=
truct timeval *tv, uint16_t index,
> > > >         const struct bt_hci_evt_le_enhanced_conn_complete *evt =3D =
data;
> > > >
> > > >         print_status(evt->status);
> > > > -       print_handle(evt->handle);
> > > > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> > > >         print_role(evt->role);
> > > >         print_peer_addr_type("Peer address type", evt->peer_addr_ty=
pe);
> > > >         print_addr("Peer address", evt->peer_addr, evt->peer_addr_t=
ype);
> > >
> > > Are these changes really intentional? Or perhaps we don't want to
> > > attempt to resolve the address since these are the event that would
> > > assign them in the first place? In that case I had these fixed
> > > separately with a proper patch description.
> >
> > Yes, these are intentional. Otherwise, we would still print the
> > previous (faulty) address as the printing happens before we release
> > the handle.
> > Also, we print the (correct) address anyway immediately on the next lin=
e.
> > Do you still want this to be in a separate patch?
>
> Yes, please split these changes since they should be considered a differe=
nt fix.
>
OK, I split them into two patches for v2.

> > >
> > > > --
> > > > 2.43.0.429.g432eaa2c6b-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Thanks,
> > Archie
>
>
>
> --
> Luiz Augusto von Dentz

Cheers,
Archie
