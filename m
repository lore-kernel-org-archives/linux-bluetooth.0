Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245921BD9F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859430; cv=none; b=eainPVV3ZhzH0ZzSnc1ENKHKLusJJJxsn3X1gjoBwTHU+lQWzMM7mGoKS5QmWAImwmMWSTh/IIQauGTgShct2Ib5chbc4xB81IK7qNS7SjAM1hJfj5XgiAppqNcUrpX9ddBdJ8NHsLNEe9RK8VgpMxBis2hRWN6JVppQeaDJfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859430; c=relaxed/simple;
	bh=z97KXTcT+/YoTVRNIcNwh1oOqLDt4ndUKyPHJQhNZwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXBYKPU6S8Qqc3U5/V9AzWs+GU5iDAuoCURdhOkdeYBZpnuFVl3PdRTJtRBYT4ziAvD70h9+B8vJcfCvFg0hlASf1/g9gJurr3LUJredoD+HZ+a5laVUJfZhOo06WqhRZTHxvf3ljiV337x7mAnH0MzYXOpGXOmlqr84AohH5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI97DUx/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI97DUx/"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-361d175c97fso63646561fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759859426; x=1760464226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2GJr5Wa9VUJc/mEJm5VNUaJW10eEpNVSRJNdXHGZxU=;
        b=nI97DUx/GsDeHdAtf45JkU6VvKpShAlRPvOVKfUWujjrFVoD9nV5r3TvLKpS38ZLJM
         AFXMhtGnNr3XVKjTHO81YyiFJfj3BL1ugHXXtol9sb/nxl19Uf27fUT9R/eXmArA92dT
         oH+QtiRUVASd+perAWq81q3lth09b6akLxVIcqoTryFraFKSOqaJSdIejy53d36MjDnH
         P9ghexOabZoZUZSlSnLDl/NAQgyAmPfwtihg8EtB5t2rluwf3BC36z6pUhUFZvrwFEBP
         a72DlpTnI97Ekg5117qg6AL0lr9ZF1PTaOXfGr3+0iz8j7p4fy4eiVPdrUuGr0rfaLNw
         94Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759859426; x=1760464226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2GJr5Wa9VUJc/mEJm5VNUaJW10eEpNVSRJNdXHGZxU=;
        b=n3YH/MjuDDg2GxaIW9vzb/Ea36SsGCdClHTSRNkqASOWZsH3an/v+A8KU1MOp0cMg1
         m9U5zfPbY39Bf8Vh/rVW3PMJ2rEh7zwO57RtPoup5dsPdvouwo5XJaTEi4655tKkHiWh
         9OfZCmtnCGubS09Ba7CwZHLxlzEYOGwam2AmHtJ/uvcs/Nh0KKBOyO1Zb3EhBvI1diSh
         CVRF2xc0bX40qkmhlwQTAeM4UUVvByedxzCMGdZgZJIo4fSAtbRqhRHlg1PYvbMwLRPl
         5SL40NjUfT9fV+Axh+YBDN+0qDWMFDplooeUy6e50AJnQa0ETPg/vjZcz+sRHLwN0W+/
         HWdQ==
X-Gm-Message-State: AOJu0YxfqzUEUHTCDuIvHQ/DsFFdj4hd15kcq7Pn7RCcEM7p1ENk4X05
	PxNC6k+aN4N0/EeAhAT25w9m6J1dl4RKeb02rjfuklSqzZe4VLkc+Flrhlo1BtUHPCcnHFyisIM
	frFiFxZffZmZM4tTjZ5cEMzJ30hC44mI=
X-Gm-Gg: ASbGncsl4C2T2mErav/CuhnqTQFICTxSo5H+bFHjpgjc0CCZhG+MVi8M/IuSId6q5m7
	dTVdpI+jXYkgzKYBiw7BpPabpUZ+ys8LKATfNspUCWoozgbs0Pdkn3GLsiZoSNCOJJDkQMVxim3
	1d/Dmz4sRuLDXXyUpEv90yltYRPgAk/fLXadOpPXd4+Ut+ZKyotIpCOxU+TIRoaD8ck7JLQouI5
	c/RNtO0t63qbVM5YHDNCbPNQlp36A==
X-Google-Smtp-Source: AGHT+IHs4iD/eL55Z1cXnbZ5kLyX3N0LYINdl7XvYPLMKrC6LiC3uqbGUzdjaPWkoFuYyqUEpPWd+cdMcURi73fOC8U=
X-Received: by 2002:a2e:a595:0:b0:372:4d3d:aaee with SMTP id
 38308e7fff4ca-37609e92e3bmr842481fa.34.1759859425890; Tue, 07 Oct 2025
 10:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007144930.1378274-1-luiz.dentz@gmail.com>
 <20251007144930.1378274-3-luiz.dentz@gmail.com> <00e427f14250d2e81c520a6f66f67337366f1c53.camel@iki.fi>
In-Reply-To: <00e427f14250d2e81c520a6f66f67337366f1c53.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Oct 2025 13:50:13 -0400
X-Gm-Features: AS18NWCT6MOWncDNtjl46FbJRTLTLEgypH9Vrk_icandi9ONP2XFTAJh-o3AaMg
Message-ID: <CABBYNZKN6Td_0ZidHBp9066x9nzppdKw1W7Gf+RvuQP4umabtg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] Bluetooth: ISO: Add support to bind to trigger PAST
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Oct 7, 2025 at 12:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> ti, 2025-10-07 kello 10:49 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This makes it possible to bind to a different destination address
> > after being connected (BT_CONNECTED, BT_CONNECT2) which then triggers
> > PAST Sender proceedure to transfer the PA Sync to the destination
> > address.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci_sync.h |  1 +
> >  net/bluetooth/hci_sync.c         | 90 ++++++++++++++++++++++++++++++++
> >  net/bluetooth/iso.c              | 80 +++++++++++++++++++++-------
> >  3 files changed, 153 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/h=
ci_sync.h
> > index e352a4e0ef8d..3133f40fa9f9 100644
> > --- a/include/net/bluetooth/hci_sync.h
> > +++ b/include/net/bluetooth/hci_sync.h
> > @@ -188,3 +188,4 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, s=
truct hci_conn *conn,
> >
> >  int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
> >  int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
> > +int hci_past_sync(struct hci_conn *conn, struct hci_conn *le);
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 5051413f1a97..571e07f81523 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -7228,3 +7228,93 @@ int hci_connect_big_sync(struct hci_dev *hdev, s=
truct hci_conn *conn)
> >       return hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn=
,
> >                                      create_big_complete);
> >  }
> > +
> > +struct past_data {
> > +     struct hci_conn *conn;
> > +     struct hci_conn *le;
> > +};
> > +
> > +static void past_complete(struct hci_dev *hdev, void *data, int err)
> > +{
> > +     struct past_data *past =3D data;
> > +
> > +     bt_dev_dbg(hdev, "err %d", err);
> > +
> > +     kfree(past);
> > +}
> > +
> > +static int hci_le_past_set_info_sync(struct hci_dev *hdev, void *data)
> > +{
> > +     struct past_data *past =3D data;
> > +     struct hci_cp_le_past_set_info cp;
> > +
> > +     hci_dev_lock(hdev);
> > +
> > +     if (!hci_conn_valid(hdev, past->conn) ||
> > +         !hci_conn_valid(hdev, past->le)) {
> > +             hci_dev_unlock(hdev);
> > +             return -ECANCELED;
> > +     }
> > +
> > +     memset(&cp, 0, sizeof(cp));
> > +     cp.handle =3D cpu_to_le16(past->le->handle);
> > +     cp.adv_handle =3D past->conn->iso_qos.bcast.bis;
> > +
> > +     hci_dev_unlock(hdev);
> > +
> > +     return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST_SET_INFO,
> > +                                  sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +}
> > +
> > +static int hci_le_past_sync(struct hci_dev *hdev, void *data)
> > +{
> > +     struct past_data *past =3D data;
> > +     struct hci_cp_le_past cp;
> > +
> > +     hci_dev_lock(hdev);
> > +
> > +     if (!hci_conn_valid(hdev, past->conn) ||
> > +         !hci_conn_valid(hdev, past->le))
> > +             return -ECANCELED;
> > +
> > +     memset(&cp, 0, sizeof(cp));
> > +     cp.handle =3D past->le->handle;
> > +     cp.sync_handle =3D cpu_to_le16(past->conn->sync_handle);
> > +
> > +     hci_dev_unlock(hdev);
> > +
> > +     return __hci_cmd_sync_status(hdev, HCI_OP_LE_PAST,
> > +                                  sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +}
> > +
> > +int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
> > +{
> > +     struct past_data *data;
> > +     int err;
> > +
> > +     if (conn->type !=3D BIS_LINK && conn->type !=3D PA_LINK)
> > +             return -EINVAL;
> > +
> > +     if (!past_sender_capable(conn->hdev))
> > +             return -EOPNOTSUPP;
> > +
> > +     data =3D kmalloc(sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     data->conn =3D conn;
> > +     data->le =3D le;
> > +
> > +     if (conn->role =3D=3D HCI_ROLE_MASTER)
> > +             err =3D hci_cmd_sync_queue_once(conn->hdev,
> > +                                           hci_le_past_set_info_sync, =
data,
> > +                                           past_complete);
> > +     else
> > +             err =3D hci_cmd_sync_queue_once(conn->hdev, hci_le_past_s=
ync,
> > +                                           data, past_complete);
> > +
> > +     if (err)
> > +             kfree(data);
> > +
> > +     return err;
> > +}
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 7f66f287c14e..d4c8772152bd 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -987,20 +987,13 @@ static int iso_sock_bind_bc(struct socket *sock, =
struct sockaddr *addr,
> >       return 0;
> >  }
> >
> > -static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *s=
a,
> > +static int iso_sock_rebind_bis(struct sock *sk, struct sockaddr_iso *s=
a,
> >                              int addr_len)
> >  {
> >       int err =3D 0;
> >
> > -     if (sk->sk_type !=3D SOCK_SEQPACKET) {
> > -             err =3D -EINVAL;
> > -             goto done;
> > -     }
> > -
> > -     if (addr_len !=3D sizeof(*sa) + sizeof(*sa->iso_bc)) {
> > -             err =3D -EINVAL;
> > -             goto done;
> > -     }
> > +     if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
> > +             return -EBADFD;
> >
> >       if (sa->iso_bc->bc_num_bis > ISO_MAX_NUM_BIS) {
> >               err =3D -EINVAL;
> > @@ -1023,6 +1016,58 @@ static int iso_sock_bind_pa_sk(struct sock *sk, =
struct sockaddr_iso *sa,
> >       return err;
> >  }
> >
> > +static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa=
,
> > +                           int addr_len)
> > +{
> > +     struct hci_conn *bis;
> > +     struct hci_conn *le;
> > +     int err;
> > +
> > +     if (sk->sk_type !=3D SOCK_SEQPACKET || !iso_pi(sk)->conn)
> > +             return -EINVAL;
> > +
> > +     /* Check if it is really a Broadcast address being requested */
> > +     if (addr_len !=3D sizeof(*sa) + sizeof(*sa->iso_bc))
> > +             return -EINVAL;
> > +
> > +     /* Check if the address hasn't changed then perhaps only the numb=
er of
> > +      * bis has changed.
> > +      */
> > +     if (!bacmp(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr) ||
> > +         !bacmp(&sa->iso_bc->bc_bdaddr, BDADDR_ANY))
> > +             return iso_sock_rebind_bis(sk, sa, addr_len);
> > +
> > +     /* Check if the address type is of LE type */
> > +     if (!bdaddr_type_is_le(sa->iso_bc->bc_bdaddr_type))
> > +             return -EINVAL;
> > +
> > +     iso_conn_lock(iso_pi(sk)->conn);
> > +     bis =3D iso_pi(sk)->conn->hcon;
> > +     iso_conn_unlock(iso_pi(sk)->conn);
> > +
> > +     if (!bis)
> > +             return -EINVAL;
> > +
> > +     hci_dev_lock(bis->hdev);
>
> No lock is held here before hdev lock. If bis is freed concurrently,
> this is UAF.
>
> Maybe:
>
>         hdev =3D hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
>                              iso_pi(sk)->src_type);
>         if (!hdev)
>                 return -EHOSTUNREACH;
>
>         hci_dev_lock(hdev);
>
>         iso_conn_lock(iso_pi(sk)->conn);
>         bis =3D iso_pi(sk)->conn->hcon;
>         if (bis->hdev !=3D hdev)
>                 bis =3D NULL;
>         iso_conn_unlock(iso_pi(sk)->conn);
>
>         if (!bis) {
>                 hci_dev_unlock(hdev);
>                 hci_dev_put(hdev);
>                 return -EINVAL;
>         }
>
>         ...
>
>         hci_dev_put(hdev);
>
> Or maybe hdev can be get also from iso_pi(sk)->conn->hcon, how the
> locking and ownership seem to work currently for iso_conn need
> contortions:
>
> /* Must be called on unlocked sk */
> static struct hci_conn *iso_get_sk_hdev(struct sock *sk)
> {
>         struct hci_dev *hdev =3D NULL;
>
>         /* Lock sk: access to iso_pi(sk)->conn needs sk lock because
>          * iso_disconn_cfm() -> iso_conn_del() -> iso_chan_del()
>          * sets iso_pi(sk)->conn =3D NULL under hdev->lock & sk lock
>          */

This is a good comment, but in practice the race mentioned above only
happens between bind and a disconnect/release/shutdown if the socket
itself is shutdown concurrently, which is why we almost never
experience this sort of UAF with the likes of bluetoothd since we
don't do threads in the daemon, in fact this might only be possible
with virtual controller where the fuzzy testing goes to extreme with
both doing threads and artificially generating responses from the
controller.

>         lock_sock(sk);
>
>         conn =3D iso_pi(sk)->conn;
>
>         /* Lock conn: does not seem to be really necessary as code
>          * paths that touch conn->hcon seem to all hold sk lock
>          * based on a quick look
>          */
>         iso_conn_lock(conn);
>         if (conn->hcon)
>                 hdev =3D hci_dev_hold(conn->hcon->hdev);
>         iso_conn_unlock(conn);
>
>         release_sock(sk);
>
>         return hdev;
> }

This may not be a bad idea, that said perhaps we will need to
generalize it and then export as bt_sock, anyway I can incorporate
something like this first to see the behavior in the context of PAST.
Btw, Ive seen some subsystem do use sk_bound_dev_if then use
netdev_get_by_index which seem to be the equivalent to hci_dev_get,
but I don't know if it is safe to use sk_bound_dev_if since that seem
to assume a net_dev not hci_dev so maybe it is safer to store the
hci_dev index somewhere else.

>
> > +
> > +     /* Lookup existing LE connection to rebind to */
> > +     le =3D hci_conn_hash_lookup_le(bis->hdev, &sa->iso_bc->bc_bdaddr,
> > +                                  le_addr_type(sa->iso_bc->bc_bdaddr_t=
ype));
> > +     if (!le) {
> > +             hci_dev_unlock(bis->hdev);
> > +             return -EINVAL;
> > +     }
> > +
> > +     BT_DBG("sk %p %pMR type %u", sk, &sa->iso_bc->bc_bdaddr,
> > +            sa->iso_bc->bc_bdaddr_type);
> > +
> > +     err =3D hci_past_sync(bis, le);
> > +
> > +     hci_dev_unlock(bis->hdev);
> > +
> > +     return err;
> > +}
> > +
> >  static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
> >                        int addr_len)
> >  {
> > @@ -1038,14 +1083,13 @@ static int iso_sock_bind(struct socket *sock, s=
truct sockaddr *addr,
> >
> >       lock_sock(sk);
> >
> > -     /* Allow the user to bind a PA sync socket to a number
> > -      * of BISes to sync to.
> > -      */
> > -     if ((sk->sk_state =3D=3D BT_CONNECT2 ||
> > -          sk->sk_state =3D=3D BT_CONNECTED) &&
> > -         test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
> > -             err =3D iso_sock_bind_pa_sk(sk, sa, addr_len);
> > -             goto done;
> > +     if ((sk->sk_state =3D=3D BT_CONNECT2 || sk->sk_state =3D=3D BT_CO=
NNECTED) &&
> > +         addr_len > sizeof(*sa)) {
> > +             release_sock(sk);
> > +             /* Allow the user to rebind to a different address using
> > +              * PAST procedures.
> > +              */
> > +             return iso_sock_rebind_bc(sk, sa, addr_len);
> >       }
> >
> >       if (sk->sk_state !=3D BT_OPEN) {



--=20
Luiz Augusto von Dentz
