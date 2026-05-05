Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEC35F189
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990109; cv=pass; b=sHAQa3fipSfv93ku4WzmCO+AWh6mqdViYpKxJnUygx3reSY2OeMXTd/EzBw5UHRijFFKJDxUkX69eDG78i528vNr8/cHtpufgp34/9oCopqwss5eUavlUJW0jLpKlE4F6tcciUcMst8988BRb3hB+fO5ML4BOw3YFpg91xb6W1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990109; c=relaxed/simple;
	bh=OeXGGIqL1Q0NyByQQSOL6fkohDGoDsXFwXyBdjCM9Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYQzdozVmP2oWgWsFafUeo5/mpoUNli9QszVohbWDiSn/h98peCQYXzE7iz6S1DpxeQgkVIPj3/P8bGzxr4VW9hgPgpdwow6XZp0YSD15VVIPBUCKzvhbod7LNO7BpkVUG5SKIWp+1jsDgVs78tI/VIbnBAhv9Es1sccSndgo4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT+/aOCb; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT+/aOCb"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c21049dafso5046514d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 07:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777990106; cv=none;
        d=google.com; s=arc-20240605;
        b=cQPaDzSe4MKEpItxuM1v9Nx692vqDeHvzVWXwqXkB4CyWk7OdbwDFbaZzGKaEMhU+0
         snqi6UdP/42X8deiG/xSBmrm6+mot2TOEYOwwxR+uAhY8lerf/XKZrQ7SyXSx8a7gRF9
         B8OJD7unfuaNaquOpS249CWh2LP1bWSP2ilOHOseGKNSxbEmqWoMN+3ppAO/9pvDHxRP
         MfwmKbgLKzYvtO8G4wFmDVdCG8t7yanbKk7UuPR/z2YH8LKTPtMIV1X32aXUvYZ9NoMP
         5y5c32L9MMey6Vjib7Jv8NXK4IGt6JGnXcxayzR55hR+JEDhZD2d0M+7Efwc7jEHbS2I
         3+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WtjQVmGHKYK47rH5pRvbl0pEGk5NR8BGr2nMWcgP5ZU=;
        fh=AsR/IwPBz5f0GPh5mYn/uJ6QUBW8xQ4bv8FcumDMvWk=;
        b=GwHugz0JfHcGAbW7nl+S/GKHufC6h+EBeViFC9TXAip+ETKcG16CeqZ9w7o+G23Iar
         b0ntlg/Ytv45AKyVMwRr8IjdOBesKarmmqd92e3JDzfTJEkMzp8gU9b2+bh7lOOKKD2C
         K0kh8WdCxdDijODclu9rh6pT9HSNCk9WJZav3WNngHtrF70/nfxnP/l9LLfnxOsrxyvS
         w7vj/cT8xbeIe+vwFP5ERv+hVNgWYu+YLeclBzdi3Q5gzCBNB/+I1cDAK+dFSQAdEb/Y
         B5+EsliBx+YZMTIEBrZ1ERT3L0+oYZJmwUzydFGHsBNToEsqxNnhD+rpfahMIX6wNRCq
         e+dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777990106; x=1778594906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtjQVmGHKYK47rH5pRvbl0pEGk5NR8BGr2nMWcgP5ZU=;
        b=jT+/aOCbqv8cp4qN9xyo+xay9MAGI6iq6/3S5sScKDcl5slhanA32a4up9zaqUtuUm
         3Nbtjg3dCNGgB7f/ZNT0sEGHHjvrkNUnguRx7+n063sO3uSs0HdDVVS1Me3jDJj0tjuQ
         ZgXTroIkMuv7xQdJRAWaEANnQmeP/bT7mAkhJaIIdHv7aUpMZx+IllECZpGof9ovCjD0
         wD+/Lfv6AbNiZj/fHghPBxhdq0Po1FL1igHlK1By48g1c8Cf9bKktEI3SLifpR6ONy2D
         neUGy8OUhTuA04NjgPuhRxM11rDis5g4T0chAbRNA9LWkHjYcQc6LMNy4oSZtYAHiHZp
         5pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990106; x=1778594906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtjQVmGHKYK47rH5pRvbl0pEGk5NR8BGr2nMWcgP5ZU=;
        b=qsvqMiiuLtDqjB7EN+7OgnKaP4tT88hzQ+PG/hwWZZrWZvSTyRwyMs+x3Rs7d7gg9J
         Cos07KTuXp10+/3MCwduhVIIRbsnchGs1NeIpBHbyONIJz9ZhuHpkIgx36vpOU2x80c/
         u4dXh3meGQD8CuAC9GU4jv31rQKSRmjFbz9VxHGhSTtcry6TkHC23ItDt5eufo8nx5GN
         JOc2O0mG0AKv3Hdd4obF14J0ZdQ025pFagVPKIFlFo3ddKBt4+MYWpkEh0dLINsRP7Io
         DsiO1vinwgcaaCfD9RY7A0k6md4AfQkRXKiBSkw5mOM/nQ2AUuxDNlgAzWA/ZYgrdTGZ
         I3XA==
X-Forwarded-Encrypted: i=1; AFNElJ+NAY6SWCnpqGg6sdt2M3GNoFkm5OERBHarAKjiCPxCNJTE+E55C3Jv94FY/6RalBmBlQcWFoz1N9Pel5/r3XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKKNNYyeENXU0ztaGlT0frv6tkLQfWOEuR9shAy1B5z7hnBIn
	sZCVOaxM57X0z1SDawsVOG3KbilYMazm25OxUyY8EAnGgLoKR8W1BNoZ0P3DW9+dNCzeL7hTZG2
	pDL48wEl8u04u+vioS00+I9+bu5e4I9w=
X-Gm-Gg: AeBDieuFg+XX1Vu0zNBmw4xhiCRoYYdHSUw1lddDovxeJ1HuR99qjZ/4OP1ozNMVOyb
	SLN1vSGofrIcVKRQSJuswnne3R2Y0PVHzBncxSxt9MtTLydyMhjxHrsX9ylm89wNmBatZ2iWhT5
	uy8VhrY4CzkZ4UNtzfLonPEsJxhgzYwNQ+p6lFbUnUDXD3hYFXQ/O3H3MXhlwZTRxD22JOmof3a
	LQh3hoM8P8jh3o2jOTQSl8D21ptmfbRN/X5FzoEGNt+/IPjn0ljigoaGopKmnxdgzpR7IRYgh0E
	NrZUmYZk2tPdT2bJKRWdqfW74cpZ4jk4ZH1NnJUWt5RkxWRJb/mEAy6Yy11EfLraSg2ABHPm487
	hqw==
X-Received: by 2002:a05:690e:130b:b0:658:a95b:894a with SMTP id
 956f58d0204a3-65c3d9734bemr15423523d50.13.1777990106186; Tue, 05 May 2026
 07:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414215237.17791-1-mikhail.v.gavrilov@gmail.com> <CABXGCsOnsqL6-6boHSkaXdjAnpwfyhK7d_poNRFftTnH43Dhdg@mail.gmail.com>
In-Reply-To: <CABXGCsOnsqL6-6boHSkaXdjAnpwfyhK7d_poNRFftTnH43Dhdg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 May 2026 10:08:15 -0400
X-Gm-Features: AVHnY4Lep6wbQdvhwsZVHjFXi4i5mjuCiYAxub7nV3y5IzvEStFEZfi2p2xSCRM
Message-ID: <CABBYNZLzWSBE5RSgL0RWvYjA6oX2Pnp7H4A4x3g5gRDX8KwHSA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: marcel@holtmann.org, pav@iki.fi, pmenzel@molgen.mpg.de, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On Tue, May 5, 2026 at 6:39=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Wed, Apr 15, 2026 at 2:53=E2=80=AFAM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > When a BLE peripheral sends an L2CAP Connection Parameter Update Reques=
t
> > the processing path is:
> >
> >   process_pending_rx()          [takes conn->lock]
> >     l2cap_le_sig_channel()
> >       l2cap_conn_param_update_req()
> >         hci_le_conn_update()    [takes hdev->lock]
> >
> > Meanwhile other code paths take the locks in the opposite order:
> >
> >   l2cap_chan_connect()          [takes hdev->lock]
> >     ...
> >       mutex_lock(&conn->lock)
> >
> >   l2cap_conn_ready()            [hdev->lock via hci_cb_list_lock]
> >     ...
> >       mutex_lock(&conn->lock)
> >
> > This is a classic AB/BA deadlock which lockdep reports as a circular
> > locking dependency when connecting a BLE MIDI keyboard (Carry-On FC-49)=
.
> >
> > Fix this by making hci_le_conn_update() defer the HCI command through
> > hci_cmd_sync_queue() so it no longer needs to take hdev->lock in the
> > caller context.  The sync callback uses __hci_cmd_sync_status_sk() to
> > wait for the HCI_EV_LE_CONN_UPDATE_COMPLETE event, then updates the
> > stored connection parameters (hci_conn_params) and notifies userspace
> > (mgmt_new_conn_param) only after the controller has confirmed the updat=
e.
> >
> > A reference on hci_conn is held via hci_conn_get()/hci_conn_put() for
> > the lifetime of the queued work to prevent use-after-free, and
> > hci_conn_valid() is checked before proceeding in case the connection wa=
s
> > removed while the work was pending.  The hci_dev_lock is held across
> > hci_conn_valid() and all conn field accesses to prevent a concurrent
> > disconnect from invalidating the connection mid-use.
> >
> > Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout =
in connection params")
> > Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > ---
> >
> > Changes in v5 (Pauli Virtanen, Luiz Augusto von Dentz):
> > - Keep hci_dev_lock held across hci_conn_valid() and all conn field rea=
ds
> >   (including conn->handle) to close the race window noted by Pauli
> > - Use conn->conn_timeout instead of HCI_CMD_TIMEOUT for the sync wait,
> >   matching hci_le_create_conn_sync() pattern
> >
> > Changes in v4 (Luiz Augusto von Dentz, Sashiko/Gemini AI review):
> > - Use hci_conn_get()/hci_conn_put() to hold a reference while work is q=
ueued
> > - Use __hci_cmd_sync_status_sk() to wait for HCI_EV_LE_CONN_UPDATE_COMP=
LETE,
> >   then do params update + mgmt notification in the sync callback
> > - Use kzalloc_obj() per checkpatch recommendation
> >
> > Changes in v3 (Luiz Augusto von Dentz):
> > - Move hci_cmd_sync_queue into hci_le_conn_update itself instead of ope=
n-coding
> >   the deferral in l2cap_core.c
> > - Move conn_params update and mgmt_new_conn_param into
> >   hci_le_conn_update_complete_evt, using hci_sent_cmd_data to retrieve
> >   the originally requested parameters
> >
> > Changes in v2 (Paul Menzel, Sashiko/Gemini AI review):
> > - Allocate before sending ACCEPTED response to avoid state mismatch on =
OOM
> > - Verify connection handle and address in sync callback against reuse r=
ace
> > - Expand commit message with implementation details
> >
> >  include/net/bluetooth/hci_core.h |   2 +-
> >  net/bluetooth/hci_conn.c         | 105 +++++++++++++++++++++++++------
> >  net/bluetooth/l2cap_core.c       |  12 +---
> >  3 files changed, 89 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index a7bffb908c1e..aa600fbf9a53 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -2495,7 +2495,7 @@ void mgmt_adv_monitor_device_lost(struct hci_dev =
*hdev, u16 handle,
> >                                   bdaddr_t *bdaddr, u8 addr_type);
> >
> >  int hci_abort_conn(struct hci_conn *conn, u8 reason);
> > -u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 lat=
ency,
> > +void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 l=
atency,
> >                       u16 to_multiplier);
> >  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> >                       __u8 ltk[16], __u8 key_size);
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 11d3ad8d2551..fea0764b8ba3 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -480,40 +480,107 @@ bool hci_setup_sync(struct hci_conn *conn, __u16=
 handle)
> >         return hci_setup_sync_conn(conn, handle);
> >  }
> >
> > -u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 lat=
ency,
> > -                     u16 to_multiplier)
> > +struct le_conn_update_data {
> > +       struct hci_conn *conn;
> > +       u16     min;
> > +       u16     max;
> > +       u16     latency;
> > +       u16     to_multiplier;
> > +};
> > +
> > +static int le_conn_update_sync(struct hci_dev *hdev, void *data)
> >  {
> > -       struct hci_dev *hdev =3D conn->hdev;
> > +       struct le_conn_update_data *d =3D data;
> > +       struct hci_conn *conn =3D d->conn;
> >         struct hci_conn_params *params;
> >         struct hci_cp_le_conn_update cp;
> > +       u16 timeout;
> > +       u8 store_hint;
> > +       int err;
> >
> > +       /* Verify connection is still alive and read conn fields under
> > +        * the same lock to prevent a concurrent disconnect from freein=
g
> > +        * or reusing the connection while we build the HCI command.
> > +        */
> >         hci_dev_lock(hdev);
> >
> > -       params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_t=
ype);
> > -       if (params) {
> > -               params->conn_min_interval =3D min;
> > -               params->conn_max_interval =3D max;
> > -               params->conn_latency =3D latency;
> > -               params->supervision_timeout =3D to_multiplier;
> > +       if (!hci_conn_valid(hdev, conn)) {
> > +               hci_dev_unlock(hdev);
> > +               return -ECANCELED;
> >         }
> >
> > -       hci_dev_unlock(hdev);
> > -
> >         memset(&cp, 0, sizeof(cp));
> >         cp.handle               =3D cpu_to_le16(conn->handle);
> > -       cp.conn_interval_min    =3D cpu_to_le16(min);
> > -       cp.conn_interval_max    =3D cpu_to_le16(max);
> > -       cp.conn_latency         =3D cpu_to_le16(latency);
> > -       cp.supervision_timeout  =3D cpu_to_le16(to_multiplier);
> > +       cp.conn_interval_min    =3D cpu_to_le16(d->min);
> > +       cp.conn_interval_max    =3D cpu_to_le16(d->max);
> > +       cp.conn_latency         =3D cpu_to_le16(d->latency);
> > +       cp.supervision_timeout  =3D cpu_to_le16(d->to_multiplier);
> >         cp.min_ce_len           =3D cpu_to_le16(0x0000);
> >         cp.max_ce_len           =3D cpu_to_le16(0x0000);
> > +       timeout                 =3D conn->conn_timeout;
> > +
> > +       hci_dev_unlock(hdev);
> > +
> > +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CONN_UPDATE,
> > +                                      sizeof(cp), &cp,
> > +                                      HCI_EV_LE_CONN_UPDATE_COMPLETE,
> > +                                      timeout, NULL);
> > +       if (err)
> > +               return err;
> > +
> > +       /* Update stored connection parameters after the controller has
> > +        * confirmed the update via the LE Connection Update Complete e=
vent.
> > +        */
> > +       hci_dev_lock(hdev);
> > +
> > +       params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_t=
ype);
> > +       if (params) {
> > +               params->conn_min_interval =3D d->min;
> > +               params->conn_max_interval =3D d->max;
> > +               params->conn_latency =3D d->latency;
> > +               params->supervision_timeout =3D d->to_multiplier;
> > +               store_hint =3D 0x01;
> > +       } else {
> > +               store_hint =3D 0x00;
> > +       }
> >
> > -       hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
> > +       hci_dev_unlock(hdev);
> >
> > -       if (params)
> > -               return 0x01;
> > +       mgmt_new_conn_param(hdev, &conn->dst, conn->dst_type, store_hin=
t,
> > +                           d->min, d->max, d->latency, d->to_multiplie=
r);
> >
> > -       return 0x00;
> > +       return 0;
> > +}
> > +
> > +static void le_conn_update_complete(struct hci_dev *hdev, void *data, =
int err)
> > +{
> > +       struct le_conn_update_data *d =3D data;
> > +
> > +       hci_conn_put(d->conn);
> > +       kfree(d);
> > +}
> > +
> > +void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 l=
atency,
> > +                       u16 to_multiplier)
> > +{
> > +       struct le_conn_update_data *d;
> > +
> > +       d =3D kzalloc_obj(*d);
> > +       if (!d)
> > +               return;
> > +
> > +       hci_conn_get(conn);
> > +       d->conn =3D conn;
> > +       d->min =3D min;
> > +       d->max =3D max;
> > +       d->latency =3D latency;
> > +       d->to_multiplier =3D to_multiplier;
> > +
> > +       if (hci_cmd_sync_queue(conn->hdev, le_conn_update_sync, d,
> > +                              le_conn_update_complete) < 0) {
> > +               hci_conn_put(conn);
> > +               kfree(d);
> > +       }
> >  }
> >
> >  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 95c65fece39b..aac2db1d6fbb 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -4706,16 +4706,8 @@ static inline int l2cap_conn_param_update_req(st=
ruct l2cap_conn *conn,
> >         l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
> >                        sizeof(rsp), &rsp);
> >
> > -       if (!err) {
> > -               u8 store_hint;
> > -
> > -               store_hint =3D hci_le_conn_update(hcon, min, max, laten=
cy,
> > -                                               to_multiplier);
> > -               mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_t=
ype,
> > -                                   store_hint, min, max, latency,
> > -                                   to_multiplier);
> > -
> > -       }
> > +       if (!err)
> > +               hci_le_conn_update(hcon, min, max, latency, to_multipli=
er);
> >
> >         return 0;
> >  }
> > --
> > 2.53.0
> >
>
> Hi Luiz,
>
> Gentle ping on this patch.  The v5 addresses the review comments from
> you and Pauli (extended lock scope around hci_conn_valid + conn field
> reads, conn->conn_timeout for the sync wait).  CI is clean aside from
> the usual pre-existing failures.
>
> Is there anything else that needs to be changed?

This has already been applied, though.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Dc6aa629c96d757ff8bbf04b19e2dd3d40e99a998

> --
> Thanks,
> Mikhail



--=20
Luiz Augusto von Dentz
