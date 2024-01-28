Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67F20DC1
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706444284; cv=none; b=qxf+gIyqI1X8W87uGXE1sdErmZ0O9CghBzGNc7EqsKOzSu/s2V/6ad1+ibtBgAQdga0WVjNiAJ00XWiRy/DzvDYsjN8ney0h1iFbHO7ddbaPqZ9TFU4lGheN5I4eyuyVdTDiyr+PAsP2l/8Du2oWA0DoFdxkX8M2UcKm/6AhaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706444284; c=relaxed/simple;
	bh=o+gnhH9bKTbZcPKWHQwzRTnm1rex1mIjSZu7lcAa7FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4HW5IgppdgCvf1ATf18W4ycHPlBCZ5sB9wWtBynQaixQsLYjx3+F0D07zmz3s+AW0dZ7kQC+BDhhIJbyNnwIbrQPHpCqTbH2tc6L2cegH3TNJz6e7zcVuJ7Eke3F2eHX0PdeHrw9ebmVyx4InRMgNaa6vgLSfg1fQSy9eIal+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=seo3Fbmi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seo3Fbmi"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ef0d6e5c2so13985e9.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 04:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706444281; x=1707049081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbN1jMuq8FzYNa4x/7jBDwDdnxNxzVTrCOU+MQEUobw=;
        b=seo3FbmifiEsIzAh4pozASPtjA4yonKnlEO7puWoO+veIis/MPeJKtSY/Zq016d37k
         WJJSE0Q+Y+V8DoctdkX5EvyzsQO78XcJ6uw770PAXnuT7ZouzTp9Cwi1H/BzTShHuGHR
         UGEDPjNGrRP9TfQOBYtZC0axz5vWf8VFeWqd2wF3k7mV0hDXiOA5tYrdcvTKTeYmZUkl
         lxesTUtKIVr/aed6sWKGyQAkahULze7JGii1vBsOlLz1ipxTCE6nqDKGDncrVpTRAeHy
         IKow4uwDVMlp4jI2qWwobwRxwwNz3zPqesKMFfbLexqh840MXZCYl7siDTn7WkA4Us2V
         caqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706444281; x=1707049081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbN1jMuq8FzYNa4x/7jBDwDdnxNxzVTrCOU+MQEUobw=;
        b=Oz9+SXFiPWKiemawptwNsCbirkgEOplx0t14p1TnQTWXFE5+kVcQV+aPtabIONu+RI
         G+z2ZR6OX1a+/PTsIZaP7hjn28tR/A6W9pHKoNGWZMHTURgmKj4FKJxwKr3BzYzk9Fli
         qD2lToEldl5jzaNQ2mfNrIlsepJffMhxool3n1ToJsNIXx1sWwQcOeYgBDcJnZ30iDpd
         FtxYueCwCFU7y/JOZwHtndjhWvoUY+el2r52cEZgc35QZA25vz4wkGMqUHphDK926jvF
         KzvWruCu8GHwUzq9vNPZDUWtQJ8mB3Eb+i1TVxMLFu6AdMxPKiSBMfhieJbZZ4YVtY4g
         MYNA==
X-Gm-Message-State: AOJu0YwLHiG734q7GSq/lbnh79pM9moSiXVTJczMKIGTGKrbgc78EltC
	60rgrO1dr2vDeISqnPdqZRYscrQ9b1cMRjGR3g0ok7K1nUa/z2trbrEpcv8FtqTg6Hp/wVmygEi
	+9z7rZG5bENcxmj5dq24JU20UkUBJxC0HkU/u
X-Google-Smtp-Source: AGHT+IE9MKeupfPnqLseeH01vAiT+esU/mBK3PdKOrvWumS2UIecsQ41C4crHyQ5E2cSCMJQtQoxRqpGxhq6E0liVj8=
X-Received: by 2002:a05:600c:510f:b0:40d:87df:92ca with SMTP id
 o15-20020a05600c510f00b0040d87df92camr393651wms.3.1706444281067; Sun, 28 Jan
 2024 04:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126144120.Bluez.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
 <CABBYNZL3yZ1_7wVyGg6fMZ=a3thqia2i+WSBFFyvBxTt4KPEgA@mail.gmail.com>
In-Reply-To: <CABBYNZL3yZ1_7wVyGg6fMZ=a3thqia2i+WSBFFyvBxTt4KPEgA@mail.gmail.com>
From: Archie Pusaka <apusaka@google.com>
Date: Sun, 28 Jan 2024 20:17:50 +0800
Message-ID: <CAJQfnxFwuhDnZRKYXMO3-i0YVuHTXgp6wdRNmAmob_xMm4n+5Q@mail.gmail.com>
Subject: Re: [Bluez PATCH] Monitor: Remove handle before assigning
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Sat, 27 Jan 2024 at 03:01, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Fri, Jan 26, 2024 at 1:42=E2=80=AFAM Archie Pusaka <apusaka@google.com=
> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > It is possible to have some handles not removed, for example the host
> > may decide not to wait for disconnection complete event when it is
> > suspending. In this case, when the peer device reconnected, we might
> > have two of the same handle assigned and create problem down the road.
> >
> > This patch solves the issue by always removing any previous handles
> > when assigning a new handle if they are the same.
> >
> > Reviewed-by: Zhengping Jiang <jiangzp@google.com>
> >
> > ---
> >
> >  monitor/packet.c | 50 +++++++++++++++++++++++++-----------------------
> >  1 file changed, 26 insertions(+), 24 deletions(-)
> >
> > diff --git a/monitor/packet.c b/monitor/packet.c
> > index 42e711cafa..b5dea6384a 100644
> > --- a/monitor/packet.c
> > +++ b/monitor/packet.c
> > @@ -189,11 +189,33 @@ static struct packet_conn_data *lookup_parent(uin=
t16_t handle)
> >         return NULL;
> >  }
> >
> > +static void release_handle(uint16_t handle)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < MAX_CONN; i++) {
> > +               struct packet_conn_data *conn =3D &conn_list[i];
> > +
> > +               if (conn->handle =3D=3D handle) {
> > +                       if (conn->destroy)
> > +                               conn->destroy(conn->data);
> > +
> > +                       queue_destroy(conn->tx_q, free);
> > +                       queue_destroy(conn->chan_q, free);
> > +                       memset(conn, 0, sizeof(*conn));
> > +                       conn->handle =3D 0xffff;
> > +                       break;
> > +               }
> > +       }
> > +}
>
> We might as well return if we find out there is a packet_conn_data,
> that way we don't need to do 2 lookups in a row.

Do you mean to return the index, so we can immediately use the index
in the assign_handle function?
>
> >  static void assign_handle(uint16_t index, uint16_t handle, uint8_t typ=
e,
> >                                         uint8_t *dst, uint8_t dst_type)
> >  {
> >         int i;
> >
> > +       release_handle(handle);
> > +
> >         for (i =3D 0; i < MAX_CONN; i++) {
> >                 if (conn_list[i].handle =3D=3D 0xffff) {
> >                         hci_devba(index, (bdaddr_t *)conn_list[i].src);
> > @@ -225,26 +247,6 @@ static void assign_handle(uint16_t index, uint16_t=
 handle, uint8_t type,
> >         }
> >  }
> >
> > -static void release_handle(uint16_t handle)
> > -{
> > -       int i;
> > -
> > -       for (i =3D 0; i < MAX_CONN; i++) {
> > -               struct packet_conn_data *conn =3D &conn_list[i];
> > -
> > -               if (conn->handle =3D=3D handle) {
> > -                       if (conn->destroy)
> > -                               conn->destroy(conn->data);
> > -
> > -                       queue_destroy(conn->tx_q, free);
> > -                       queue_destroy(conn->chan_q, free);
> > -                       memset(conn, 0, sizeof(*conn));
> > -                       conn->handle =3D 0xffff;
> > -                       break;
> > -               }
> > -       }
> > -}
> > -
> >  struct packet_conn_data *packet_get_conn_data(uint16_t handle)
> >  {
> >         int i;
> > @@ -10076,7 +10078,7 @@ static void conn_complete_evt(struct timeval *t=
v, uint16_t index,
> >         const struct bt_hci_evt_conn_complete *evt =3D data;
> >
> >         print_status(evt->status);
> > -       print_handle(evt->handle);
> > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> >         print_bdaddr(evt->bdaddr);
> >         print_link_type(evt->link_type);
> >         print_enable("Encryption", evt->encr_mode);
> > @@ -10648,7 +10650,7 @@ static void sync_conn_complete_evt(struct timev=
al *tv, uint16_t index,
> >         const struct bt_hci_evt_sync_conn_complete *evt =3D data;
> >
> >         print_status(evt->status);
> > -       print_handle(evt->handle);
> > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> >         print_bdaddr(evt->bdaddr);
> >         print_link_type(evt->link_type);
> >         print_field("Transmission interval: 0x%2.2x", evt->tx_interval)=
;
> > @@ -11077,7 +11079,7 @@ static void le_conn_complete_evt(struct timeval=
 *tv, uint16_t index,
> >         const struct bt_hci_evt_le_conn_complete *evt =3D data;
> >
> >         print_status(evt->status);
> > -       print_handle(evt->handle);
> > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> >         print_role(evt->role);
> >         print_peer_addr_type("Peer address type", evt->peer_addr_type);
> >         print_addr("Peer address", evt->peer_addr, evt->peer_addr_type)=
;
> > @@ -11206,7 +11208,7 @@ static void le_enhanced_conn_complete_evt(struc=
t timeval *tv, uint16_t index,
> >         const struct bt_hci_evt_le_enhanced_conn_complete *evt =3D data=
;
> >
> >         print_status(evt->status);
> > -       print_handle(evt->handle);
> > +       print_field("Handle: %d", le16_to_cpu(evt->handle));
> >         print_role(evt->role);
> >         print_peer_addr_type("Peer address type", evt->peer_addr_type);
> >         print_addr("Peer address", evt->peer_addr, evt->peer_addr_type)=
;
>
> Are these changes really intentional? Or perhaps we don't want to
> attempt to resolve the address since these are the event that would
> assign them in the first place? In that case I had these fixed
> separately with a proper patch description.

Yes, these are intentional. Otherwise, we would still print the
previous (faulty) address as the printing happens before we release
the handle.
Also, we print the (correct) address anyway immediately on the next line.
Do you still want this to be in a separate patch?
>
> > --
> > 2.43.0.429.g432eaa2c6b-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
