Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC201401B
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554622; cv=none; b=gSxiR8fG7J1bgYR2Iupb7KVtZeHDq/aDlqmrFVABD+aIJskMwB4+shg4yHF+c1tNOn5crkQac/O5+ZWnZEzhbJZNqF63renpLJ/vHwGwst4L5x3a/X6ygkDu+E5rz1+u4Zy2D1eyrNpKHHY7PAb09bGZQ5dxquUBbNEEPpAxNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554622; c=relaxed/simple;
	bh=7jsfESa16tF72PrFeTagVIkD2vTafOm1hJIC4TN8GjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5fJwkfXzqx50bNX4uu6GYZEOdSKLahRhfiRkvAbuVGZLKcccUale6dBWOLkLl4Ch3yg/vSHkzPat7lUoUSQSSN9eBu+rNUvLVErqdDJNNkr7rXJ3o7j7EAK0MkpB2Fn+3xIf6Wo2dNpS5/82sr5Zjikih0uiBtFLZqP6ccmQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3lTo9fx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3lTo9fx"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so34651211fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 10:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706554619; x=1707159419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG1yg9tBWVpe35MH1+QdL5Hp5IXxNk/FndR393UxD/M=;
        b=I3lTo9fx8FaukbviYtQZVhW0CCaZif8j/dKoQbQM7FSIcuu72pUBfZX6hL1neZXbJ1
         pXNHHDEuqtaPkrWKhUSMbhfPjJtaFt1vnXNJ/hNYGD3z17R4x+nOKnsUYloKtcVsvgLt
         Oc/0rEIaVzIfOM6ECjd/z5N+rM0c0WjI8wj/6D3Ud6UsZNdTUHx01YQ/ma6IFYiB0jJM
         CS3oPK5wNM98nBhHrkaTa0jThJE9Tyt9AZLLdh6GwUVEcahRtoKdQFUAgPrlQOcqGwMu
         oTvrzbay3JPEQgAjyAz9Wi/gQZz26B/ouDl8CaJ6Q0HySpomYkvH5IVHeNIJcpOIem+V
         oI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706554619; x=1707159419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aG1yg9tBWVpe35MH1+QdL5Hp5IXxNk/FndR393UxD/M=;
        b=VIMmhgq/yzSTfJlBEVpuz23MgQTap29xnEgIOylyPQZOUdhs8YJ1D0EVVZ8O/kgpr0
         zGt1lg44FrEIDYP2kgNjkXhEW1qOjvdiNdfd1PKivLgfl5BtDVMX/loMnBTsWtFQIEsX
         E5WxkSu0qHF8HRe2wBMTreYVGvGwpsjlzpKQOsOPhdvA+UGKFP3pRPdlrkeHReE3he7F
         803n66/QBJdGgRjjfJslW0CPLKqcEH78Jfrw0RBZbN5MUcQzLQD+q4Aw8fWB3sAxqNf6
         9oQ7tijSAqgwpHqfmByHDzmdYMPv+vQqZLrK2bIWdGdBH5DUpgGNg9UydR2qVZztn4wh
         j+Uw==
X-Gm-Message-State: AOJu0YwgiadmRAb89OVdz+9W3YzwBuWkaGkcJIzSJlUZFMVBMHPE2Fmm
	C7SyicI6ib/wRnJ12ivRjD8ptd0pttSd3+YYif84tCuLYjFG4Wxu4BPGNXPBSgHXfN0CIOolEao
	jzQToNiFqN8K0P14KLj66DYM8/Do6BHVQ
X-Google-Smtp-Source: AGHT+IHZ48MVb7DqCgA/To2zUUC1IBD7RGEZCx5VB3HNbmk2HIDjrJIX60dNBQdH9Wqm+vnN/bVKTSHrKAs809a5v7M=
X-Received: by 2002:a2e:a586:0:b0:2cd:27b0:bfd with SMTP id
 m6-20020a2ea586000000b002cd27b00bfdmr5272243ljp.29.1706554618531; Mon, 29 Jan
 2024 10:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126144120.Bluez.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
 <CABBYNZL3yZ1_7wVyGg6fMZ=a3thqia2i+WSBFFyvBxTt4KPEgA@mail.gmail.com> <CAJQfnxFwuhDnZRKYXMO3-i0YVuHTXgp6wdRNmAmob_xMm4n+5Q@mail.gmail.com>
In-Reply-To: <CAJQfnxFwuhDnZRKYXMO3-i0YVuHTXgp6wdRNmAmob_xMm4n+5Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jan 2024 13:56:46 -0500
Message-ID: <CABBYNZL2Nuv2LVDHE11rMaZTeLO6Jw7uEabij4A+2N1G-xf33w@mail.gmail.com>
Subject: Re: [Bluez PATCH] Monitor: Remove handle before assigning
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Archie,

On Sun, Jan 28, 2024 at 7:18=E2=80=AFAM Archie Pusaka <apusaka@google.com> =
wrote:
>
> Hi Luiz,
>
> On Sat, 27 Jan 2024 at 03:01, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Fri, Jan 26, 2024 at 1:42=E2=80=AFAM Archie Pusaka <apusaka@google.c=
om> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > It is possible to have some handles not removed, for example the host
> > > may decide not to wait for disconnection complete event when it is
> > > suspending. In this case, when the peer device reconnected, we might
> > > have two of the same handle assigned and create problem down the road=
.
> > >
> > > This patch solves the issue by always removing any previous handles
> > > when assigning a new handle if they are the same.
> > >
> > > Reviewed-by: Zhengping Jiang <jiangzp@google.com>
> > >
> > > ---
> > >
> > >  monitor/packet.c | 50 +++++++++++++++++++++++++---------------------=
--
> > >  1 file changed, 26 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/monitor/packet.c b/monitor/packet.c
> > > index 42e711cafa..b5dea6384a 100644
> > > --- a/monitor/packet.c
> > > +++ b/monitor/packet.c
> > > @@ -189,11 +189,33 @@ static struct packet_conn_data *lookup_parent(u=
int16_t handle)
> > >         return NULL;
> > >  }
> > >
> > > +static void release_handle(uint16_t handle)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < MAX_CONN; i++) {
> > > +               struct packet_conn_data *conn =3D &conn_list[i];
> > > +
> > > +               if (conn->handle =3D=3D handle) {
> > > +                       if (conn->destroy)
> > > +                               conn->destroy(conn->data);
> > > +
> > > +                       queue_destroy(conn->tx_q, free);
> > > +                       queue_destroy(conn->chan_q, free);
> > > +                       memset(conn, 0, sizeof(*conn));
> > > +                       conn->handle =3D 0xffff;
> > > +                       break;
> > > +               }
> > > +       }
> > > +}
> >
> > We might as well return if we find out there is a packet_conn_data,
> > that way we don't need to do 2 lookups in a row.
>
> Do you mean to return the index, so we can immediately use the index
> in the assign_handle function?

I think you can return the pointer directly:


conn =3D release_handle(handle);
if (conn)
   hci_devba(index, conn->src);
...


> >
> > >  static void assign_handle(uint16_t index, uint16_t handle, uint8_t t=
ype,
> > >                                         uint8_t *dst, uint8_t dst_typ=
e)
> > >  {
> > >         int i;
> > >
> > > +       release_handle(handle);
> > > +
> > >         for (i =3D 0; i < MAX_CONN; i++) {
> > >                 if (conn_list[i].handle =3D=3D 0xffff) {
> > >                         hci_devba(index, (bdaddr_t *)conn_list[i].src=
);
> > > @@ -225,26 +247,6 @@ static void assign_handle(uint16_t index, uint16=
_t handle, uint8_t type,
> > >         }
> > >  }
> > >
> > > -static void release_handle(uint16_t handle)
> > > -{
> > > -       int i;
> > > -
> > > -       for (i =3D 0; i < MAX_CONN; i++) {
> > > -               struct packet_conn_data *conn =3D &conn_list[i];
> > > -
> > > -               if (conn->handle =3D=3D handle) {
> > > -                       if (conn->destroy)
> > > -                               conn->destroy(conn->data);
> > > -
> > > -                       queue_destroy(conn->tx_q, free);
> > > -                       queue_destroy(conn->chan_q, free);
> > > -                       memset(conn, 0, sizeof(*conn));
> > > -                       conn->handle =3D 0xffff;
> > > -                       break;
> > > -               }
> > > -       }
> > > -}
> > > -
> > >  struct packet_conn_data *packet_get_conn_data(uint16_t handle)
> > >  {
> > >         int i;
> > > @@ -10076,7 +10078,7 @@ static void conn_complete_evt(struct timeval =
*tv, uint16_t index,
> > >         const struct bt_hci_evt_conn_complete *evt =3D data;
> > >
> > >         print_status(evt->status);
> > > -       print_handle(evt->handle);
> > > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> > >         print_bdaddr(evt->bdaddr);
> > >         print_link_type(evt->link_type);
> > >         print_enable("Encryption", evt->encr_mode);
> > > @@ -10648,7 +10650,7 @@ static void sync_conn_complete_evt(struct tim=
eval *tv, uint16_t index,
> > >         const struct bt_hci_evt_sync_conn_complete *evt =3D data;
> > >
> > >         print_status(evt->status);
> > > -       print_handle(evt->handle);
> > > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> > >         print_bdaddr(evt->bdaddr);
> > >         print_link_type(evt->link_type);
> > >         print_field("Transmission interval: 0x%2.2x", evt->tx_interva=
l);
> > > @@ -11077,7 +11079,7 @@ static void le_conn_complete_evt(struct timev=
al *tv, uint16_t index,
> > >         const struct bt_hci_evt_le_conn_complete *evt =3D data;
> > >
> > >         print_status(evt->status);
> > > -       print_handle(evt->handle);
> > > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> > >         print_role(evt->role);
> > >         print_peer_addr_type("Peer address type", evt->peer_addr_type=
);
> > >         print_addr("Peer address", evt->peer_addr, evt->peer_addr_typ=
e);
> > > @@ -11206,7 +11208,7 @@ static void le_enhanced_conn_complete_evt(str=
uct timeval *tv, uint16_t index,
> > >         const struct bt_hci_evt_le_enhanced_conn_complete *evt =3D da=
ta;
> > >
> > >         print_status(evt->status);
> > > -       print_handle(evt->handle);
> > > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> > >         print_role(evt->role);
> > >         print_peer_addr_type("Peer address type", evt->peer_addr_type=
);
> > >         print_addr("Peer address", evt->peer_addr, evt->peer_addr_typ=
e);
> >
> > Are these changes really intentional? Or perhaps we don't want to
> > attempt to resolve the address since these are the event that would
> > assign them in the first place? In that case I had these fixed
> > separately with a proper patch description.
>
> Yes, these are intentional. Otherwise, we would still print the
> previous (faulty) address as the printing happens before we release
> the handle.
> Also, we print the (correct) address anyway immediately on the next line.
> Do you still want this to be in a separate patch?

Yes, please split these changes since they should be considered a different=
 fix.

> >
> > > --
> > > 2.43.0.429.g432eaa2c6b-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks,
> Archie



--=20
Luiz Augusto von Dentz
