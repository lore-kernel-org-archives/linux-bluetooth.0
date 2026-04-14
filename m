Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904172FD69A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198621; cv=pass; b=W0QGriLz2muHUHdVEIaznaqOMMx4fw40un4SE0mI0aqcLjrH5vheNDe0TOQZ4mVfpvE2+aZ8cyPOsCKupYt3OCBLU0h9AEe0rrYfGVwWk6aA3/9H2cQ04VBdXJuCTVePd3CRB9mIwv0Oom9GSd3LprMEr6BO5VBYCLZcoPWNC74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198621; c=relaxed/simple;
	bh=5qy3Znzp/yWh7dYE6MtKqW5O0zkQ1reIG0SVynwg8Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFZNPbyNGwSjJIsiKjtzGY8Ek3d8+RZfT4oin+ZwdnowdaItdDXVQJo4qrHgpAXBLnXnLLwtjXee1RxD3eLqHqKhJgoWBUyhj/a5hRNkwy8IDQ8bzDpb3VFfuLpUAytd7ZBVfPYLJrLQabMMqrJnPxVmSWHvkr83gXzb1bdR7/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J93Os8bA; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J93Os8bA"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-67934c83063so2238218eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 13:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776198618; cv=none;
        d=google.com; s=arc-20240605;
        b=bw3yy+yDGOxJVCkShoID4lQGMJQCyjuxpBCtcIAh6bnYHs/ZwkF20pot7CapgH0cAz
         5+M5QNQV316SaopEgQJEdeHyyoCAho3A7vNL8m6OnBmVa6Hrl6e5Pn49Z175nGeGiCxX
         NrEQNvop1Lh5oqCnHE6aVXymao8V+DQZe891wp23v+lTcF21bunyhAN8Gh+ptV7odAoI
         iiF4G/MHPRBEMlXDADLWFoFR6PnMqYFwhgdV/f5+E5ZIgnt7Z+MkRa7LN9KziyDymSGE
         QFiLNQ/PO7Ee8Ngh265SSnLxSOXJrVkKKaXZsMljjlOTB6oFMbAtNo66k7tUnneT5h7z
         AitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xHixtiJQ3/jFaNGrF1wVlnEpwpJ9330rNs3ejgyZBAE=;
        fh=w+fmsyF/zgwiCMUI0BfIATTDWmInKwdEpBshVTvR7Uc=;
        b=hiRBkw3NnNWDIRLf3Ih7zDMJQUnjLeR1zWnTjjsL9gmuj+7thu6uWNMM/ZrmNE0ksb
         zOF0Mwqg5FghUS+rOn8KhI8kQ7QLWsDThI/KjBP5zw69J45tj9XNDPGmD1ij3GNENtAb
         /Kkltm6YNWmrLqWWB7ffCTtWFUN2KCb5Jb0OR/oG+6/V0Euo4IakVUrSBo1e/zr3qS1f
         mo9jo5yRVMUCcaJFMc9l/CNKIpZ8iSmTbgR5Ptm0cln9rAoenxK3GabrO7aKpBmCtWG3
         rrVGg/A6uCCgKkOG2VFgYxwkm/rxI2xGpqNVfO2wUfGUqlXNbh8F4+/n4eI7E0tlcW88
         A6AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776198618; x=1776803418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHixtiJQ3/jFaNGrF1wVlnEpwpJ9330rNs3ejgyZBAE=;
        b=J93Os8bAG+HGs9iLTWm3wuug4d5v87ZMZs7IR0gxtZmyes4De3BU8QUvp7oJqxM0lK
         USUOy0JWOjHvL2o2ekOeFB9Zkr5de6pMm3wB4BRnf5bji4q2OTrKBAanJuUJ2SRUAQ0V
         ZzSozBi2K1fhLyX9aWnDHNy37J5YnRrP1RqlP26NLFvl3kHmQ9H9ZzfDdMqtHTda0qz9
         jrWJ8C6aTXjocrxF3dGhU0TYXwXu9o7wZBCr0GBgqvP0fVOs1/rW3jHhXtwANxspreFc
         kl+Ycz6VKqxzxgJ9uZ5NN0YonFnUoPw51RCFgzwMM11bZnZKASS+y+bhaiMndhNGtl7Y
         fr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776198618; x=1776803418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xHixtiJQ3/jFaNGrF1wVlnEpwpJ9330rNs3ejgyZBAE=;
        b=kHyl+Hd/3W83vJvwpZa/3hixyPwGAdJ/z11xGFkGCKPYdDX11dxeb08xkNB/enW/mU
         1V6M+cY9SUJYV+1TtG/hY5ycGQ1qoPimT6kt8YzvWfneZZvO60AFO0uXFpg7BMQMOchR
         RRfSLBz+TauavCivFgLC+dURDwtLKjewZSK9feplfRL9DOFGOBCJJQv6Gt/xuDSIqDUc
         itahsLTJw6OYSjm9+qBb6Z2+jf4hiaWuTJIzHsppjKr8Q8IKHWeql0EU/WisO3J7NKgH
         XfSDh23QYgjg/ZZS9BpdtY6eamToN27Me3qDTBEyCiW2NJ8qwTkXzFjj6ddXY3ds4BST
         0Juw==
X-Forwarded-Encrypted: i=1; AFNElJ8v1oZ090BGU96DJD3btMMWq5iJ9v/eaIQz1togUABD5M8OS+VmXDqEhAcoGh4jKrWREMeq0YsD4fGVMGTa1UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRFJfqTPSFZw5BGsz1tBYhIusQhkbEIdVfNEFhMGv9C41VBBrP
	2hFtEAJWYtTeTG6whOnYLDxctBekeL7/P9QNMrPEJvs5lWci27z2YaE6mWb5lm8FZ8gddNgCBKs
	Y8NkB7TFKBoqBDDePypHdgFeLYmacnd8=
X-Gm-Gg: AeBDies7l3VLP9HSxsgAXvHZnLmi6zN49iK6dXPFTadqcpsZ1GuM/5DgpFADbEaPw+u
	KsRO+zmdm1X/ebIdvVValFJDZ3WGhIrCUTIAPCWJfL8MEGYk7iXUeyCc9pQ/ZCaQ6Yh2aVCOmdu
	TCiPgoimuIwOZaCiFyEBSMVGq1lecIK0WQayAsYEflDv0HxD0ZAJ1SfRlr5cR7ilG4jlMvCipg5
	xlL5TuHmLcw8zjX7f0d6I/0a3kpBsvb5NrVgyAejUP5ivM4isHLQmGpHyPVp28GOIscroyqFCud
	4Uw/osXCfdXXFRmet4aEHRNun8PmkI0evwqvqowhICHYV3CEe1LH5iMZBgoVm8kaJnaEVkKHTL7
	xlw==
X-Received: by 2002:a05:6820:178e:b0:689:dfc8:5e3c with SMTP id
 006d021491bc7-68be596a84emr10590014eaf.3.1776198618354; Tue, 14 Apr 2026
 13:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414184415.17114-1-mikhail.v.gavrilov@gmail.com> <4ab9bc90237c575f5d508b1dd93d4ab71fb6f961.camel@iki.fi>
In-Reply-To: <4ab9bc90237c575f5d508b1dd93d4ab71fb6f961.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Apr 2026 16:30:06 -0400
X-Gm-Features: AQROBzAzqg60mGeSusML3GtW5Q46NCCrMzXKQM4OrhcvHr_OWtnztaLcJE76pt0
Message-ID: <CABBYNZK_53HeD6HFTgGYiC2eAtJq1AebqJ=08QE_YKJf=+ksug@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
To: Pauli Virtanen <pav@iki.fi>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, marcel@holtmann.org, 
	pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Apr 14, 2026 at 4:26=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> ti, 2026-04-14 kello 23:43 +0500, Mikhail Gavrilov kirjoitti:
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
> > removed while the work was pending.
> >
> > Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout =
in connection params")
> > Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > ---
> >
> > Changes in v4 (Luiz Augusto von Dentz, Sashiko/Gemini AI review):
> > - Use hci_conn_get()/hci_conn_put() to hold a reference while work is q=
ueued
> > - Use __hci_cmd_sync_status_sk() to wait for HCI_EV_LE_CONN_UPDATE_COMP=
LETE,
> >   then do params update + mgmt notification in the sync callback =E2=80=
=94 removes the
> >   need for hci_event.c changes and hci_sent_cmd_data()
> > - Use kzalloc_obj() per checkpatch recommendation
> > - Fix checkpatch alignment issues
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
> >  include/net/bluetooth/hci_core.h |  2 +-
> >  net/bluetooth/hci_conn.c         | 98 +++++++++++++++++++++++++-------
> >  net/bluetooth/l2cap_core.c       | 12 +---
> >  3 files changed, 82 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index a7bffb908c1e..aa600fbf9a53 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -2495,7 +2495,7 @@ void mgmt_adv_monitor_device_lost(struct hci_dev =
*hdev, u16 handle,
> >                                 bdaddr_t *bdaddr, u8 addr_type);
> >
> >  int hci_abort_conn(struct hci_conn *conn, u8 reason);
> > -u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 lat=
ency,
> > +void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 l=
atency,
> >                     u16 to_multiplier);
> >  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> >                     __u8 ltk[16], __u8 key_size);
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 11d3ad8d2551..c9cc18fab1f2 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -480,40 +480,100 @@ bool hci_setup_sync(struct hci_conn *conn, __u16=
 handle)
> >       return hci_setup_sync_conn(conn, handle);
> >  }
> >
> > -u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 lat=
ency,
> > -                   u16 to_multiplier)
> > +struct le_conn_update_data {
> > +     struct hci_conn *conn;
> > +     u16     min;
> > +     u16     max;
> > +     u16     latency;
> > +     u16     to_multiplier;
> > +};
> > +
> > +static int le_conn_update_sync(struct hci_dev *hdev, void *data)
> >  {
> > -     struct hci_dev *hdev =3D conn->hdev;
> > +     struct le_conn_update_data *d =3D data;
> > +     struct hci_conn *conn =3D d->conn;
> >       struct hci_conn_params *params;
> >       struct hci_cp_le_conn_update cp;
> > +     u8 store_hint;
> > +     int err;
> >
> > +     /* Verify connection is still alive. */
> >       hci_dev_lock(hdev);
> > -
> > -     params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_typ=
e);
> > -     if (params) {
> > -             params->conn_min_interval =3D min;
> > -             params->conn_max_interval =3D max;
> > -             params->conn_latency =3D latency;
> > -             params->supervision_timeout =3D to_multiplier;
> > +     if (!hci_conn_valid(hdev, conn)) {
> > +             hci_dev_unlock(hdev);
> > +             return -ECANCELED;
> >       }
> > -
> >       hci_dev_unlock(hdev);
> >
> >       memset(&cp, 0, sizeof(cp));
> >       cp.handle               =3D cpu_to_le16(conn->handle);
>
> hci_conn_valid() should be in the same hci_dev_lock() critical section
> as where the conn is dereferenced, otherwise the lock is not doing
> something useful.

This means we should only unlock after we finish using hci_conn,
including conn->handle above.

> > -     cp.conn_interval_min    =3D cpu_to_le16(min);
> > -     cp.conn_interval_max    =3D cpu_to_le16(max);
> > -     cp.conn_latency         =3D cpu_to_le16(latency);
> > -     cp.supervision_timeout  =3D cpu_to_le16(to_multiplier);
> > +     cp.conn_interval_min    =3D cpu_to_le16(d->min);
> > +     cp.conn_interval_max    =3D cpu_to_le16(d->max);
> > +     cp.conn_latency         =3D cpu_to_le16(d->latency);
> > +     cp.supervision_timeout  =3D cpu_to_le16(d->to_multiplier);
> >       cp.min_ce_len           =3D cpu_to_le16(0x0000);
> >       cp.max_ce_len           =3D cpu_to_le16(0x0000);
> >
> > -     hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
> > +     err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CONN_UPDATE,
> > +                                    sizeof(cp), &cp,
> > +                                    HCI_EV_LE_CONN_UPDATE_COMPLETE,
> > +                                    HCI_CMD_TIMEOUT, NULL);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Update stored connection parameters after the controller has
> > +      * confirmed the update via the LE Connection Update Complete eve=
nt.
> > +      */
> > +     hci_dev_lock(hdev);
> >
> > -     if (params)
> > -             return 0x01;
> > +     params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_typ=
e);
> > +     if (params) {
> > +             params->conn_min_interval =3D d->min;
> > +             params->conn_max_interval =3D d->max;
> > +             params->conn_latency =3D d->latency;
> > +             params->supervision_timeout =3D d->to_multiplier;
> > +             store_hint =3D 0x01;
> > +     } else {
> > +             store_hint =3D 0x00;
> > +     }
> >
> > -     return 0x00;
> > +     hci_dev_unlock(hdev);
> > +
> > +     mgmt_new_conn_param(hdev, &conn->dst, conn->dst_type, store_hint,
> > +                         d->min, d->max, d->latency, d->to_multiplier)=
;
> > +
> > +     return 0;
> > +}
> > +
> > +static void le_conn_update_complete(struct hci_dev *hdev, void *data, =
int err)
> > +{
> > +     struct le_conn_update_data *d =3D data;
> > +
> > +     hci_conn_put(d->conn);
> > +     kfree(d);
> > +}
> > +
> > +void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 l=
atency,
> > +                     u16 to_multiplier)
> > +{
> > +     struct le_conn_update_data *d;
> > +
> > +     d =3D kzalloc_obj(*d);
> > +     if (!d)
> > +             return;
> > +
> > +     hci_conn_get(conn);
> > +     d->conn =3D conn;
> > +     d->min =3D min;
> > +     d->max =3D max;
> > +     d->latency =3D latency;
> > +     d->to_multiplier =3D to_multiplier;
> > +
> > +     if (hci_cmd_sync_queue(conn->hdev, le_conn_update_sync, d,
> > +                            le_conn_update_complete) < 0) {
> > +             hci_conn_put(conn);
> > +             kfree(d);
> > +     }
> >  }
> >
> >  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 95c65fece39b..aac2db1d6fbb 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -4706,16 +4706,8 @@ static inline int l2cap_conn_param_update_req(st=
ruct l2cap_conn *conn,
> >       l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
> >                      sizeof(rsp), &rsp);
> >
> > -     if (!err) {
> > -             u8 store_hint;
> > -
> > -             store_hint =3D hci_le_conn_update(hcon, min, max, latency=
,
> > -                                             to_multiplier);
> > -             mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_typ=
e,
> > -                                 store_hint, min, max, latency,
> > -                                 to_multiplier);
> > -
> > -     }
> > +     if (!err)
> > +             hci_le_conn_update(hcon, min, max, latency, to_multiplier=
);
> >
> >       return 0;
> >  }



--=20
Luiz Augusto von Dentz
