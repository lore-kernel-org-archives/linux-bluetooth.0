Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ECB3A9002
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536310; cv=pass; b=RltQrjdNPhJ1S6mIm2tSEN5rOZLFcTfeq76UnoqNe1vPK5Ey/uv5d6+UHqn2V2OxEUZvXLfJePCNRUYnL5fKu3deTF5JqeyLf7gCjx6se1+lLhYUioFHO7lpxURo+t3GcRPW9l0ji11Q4oHtu7MhnSQCIiCbER0YdzlGlgngX0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536310; c=relaxed/simple;
	bh=THLL80YilPR8giVKMO/OwjAxfNY9lxj7lov4ZhBgvig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3qNmHB2GM90TxNgW18kEdvdzaj/Z3k9zJiZrV3KxFkrs+LINB4Y6zBvL6XKwdWpwYUQMprq5RSAsNoFAv8QxW54XvIHuyN0Pv+asokwTmwwmKKNkn9uh3HsqInLYB9t8HRQ2VqoC3hbNniq6mQZ+tsqLvxuQqKdnwlXx/PrBy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMaLCnw7; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMaLCnw7"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7efd2dc350cso26263337b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 08:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781536308; cv=none;
        d=google.com; s=arc-20240605;
        b=Gu4P30aoLsakLUt0J44VoGHfWMCDMvbU31oCd61krIhg+ackoe7gX9K3OUMCtRwC/s
         aR07oHLBfNoYSe/zht7HPTKiDApLMwIsl2J2DZu4tbWwHtURpcZebcbAI1N/fmhvKBMT
         bXaDD2ZhC3CwpOKcUxgJRMN7K3ZIvswl2d8hb1crxNFBFjGs1+egcYjwOhMQl7MORMId
         +r+NbHe84csVIJrGUNzVp46ai6l4koOZj/Q0CyGYP0njq6qUtFOLU054EzUCVKvOFg8Q
         UJYUYRGJkmgxf/vxx4XWMWylQpEX28A3twHNpvoSbpiW287XyTc8XGpSdcxEE8gxI+1/
         VWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9DNC33rDW0wzaMzj2OnxeTKvilt9ihOkyshv/EckoBk=;
        fh=9lo8cyVUGGTIRIKeU2FrYHNTfOxxSqR6XceQXkU4JZY=;
        b=XIIa9Hs3VjUmdwo5+KCcGZwgRcU0Icnm89hR4vB2HExo92bHQ/hNgqkFEs01GJsZW0
         RREKBkYQsP5YKe9rLODxscGbD2zxb5L1hl5JvRETG+HkOSP7FWEoIXYDNFX11WVYDlgi
         gbVjSKxx0QUOq6etNQE0IMUj1zr0wq1ynJJcaNMwPwqdK12Xe8jKlQ1Yw7hBSKK5auuY
         hl8i9orBLs/EqGTl87cVOPcV2hNE1HxR1Y2nTpapYjgywTx1XPCnmRLlsfyJHEVMAND5
         UW04BxU7yJPLE45clE94C3o01c7zkXMG9i/AZEr+ZC6riGezbGLVMxcjKdWmlKMdK7d7
         Si9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781536308; x=1782141108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DNC33rDW0wzaMzj2OnxeTKvilt9ihOkyshv/EckoBk=;
        b=TMaLCnw7WTBl+8LARZJ/BVx0IKGXqQV8dQ9NMmvqwmwFdUllQvOpcsHfgQbR4b5GY6
         4gBCpXViN6c3tzAmXIGArq80s9Bo5bYOBampQuf8WzQntsN8V7TgFN+6+NBPGVCM8Ms7
         qAMCbPaFFQFIPohMwiFyOIvfgFZx3cH6KAfxhGxGvGQ/JExfz56P6r7Dt626OdXx4JaH
         ShVbzDzBaAQbHQlCVlo1GukcLq/mjMcDtKpcXAWgOWXnSczXj/Kft/aAxAR8ePFyhWqn
         iCQnrNjKqYhZpwgJS62nHAYn/ODgKmjjKTW0/vUNisLsNL3bKePFq0mKxvqCWSCvRS5/
         VQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536308; x=1782141108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9DNC33rDW0wzaMzj2OnxeTKvilt9ihOkyshv/EckoBk=;
        b=cmMQuRR07Sv93bQmxZTvPM4M7QzxFYzFd+IIYrPRxIGcfOfBMC8GQ79CxVY2iOgarh
         f+JOqC86zl6TOxdk8hzf23HUHU5kW92P0XrivPab9dB9YVZA7cVg++UZBYohT6udfjd4
         pod4jubTi1RYyRcxKJtTa30ISc73og7JPfILBrN7AT1Hg9JSkt0dBlmJobl8fGZmrdm9
         OxpXcBK9E0ir57Wi+LacNugPwHow9jaStBzijGcaUIQAwLdc7h+qIIiU9WXu6QS7iVcu
         FteSuqVcbXT0uxrJT284s0MyZwA1qr8EQEma1EZxWVhCkHwIC3Xa5xNAKE/fdBiCYaud
         yD4w==
X-Forwarded-Encrypted: i=1; AFNElJ/vXcDCXztr1XvrxqKp/i9vwodVCgvksQjKyF4kkQfn4aH/mLVb1iaR451TFBi+CMcnLx4dThblL1p2DZkuoXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GMKmFRJsKpvKK8ZB5iZejLmk3kt7t9angRXJvPYdqzzsPjza
	Cj5wOwrxBw4siUc8EsZAogMFr2BvnXTTmKzxdxPHzlPobD2K78NjQuYGDvgbAUA+7DFw3TIPk4J
	OKcUi1ak/v/jeJWNHOfx11hB977RQruM=
X-Gm-Gg: Acq92OEkxFx7mU1KcIdOJdeRWynNm40jOPb58tXsZU9CMi0uaZiKC9JDWxORZd62Hu4
	KyHcYONhaZBmyhPyfAff8IhmH/gl6KQQD9ifzEGpIkePEPxQWZ6L3iLqgXJQKN7adlz9hzBAXe+
	gk7wYMe0w3J6CG7uFK4UlD4k3bHf8el0Tws2CEXm2RSWSbx9JqeQ89wX8PwI2U2qr3UYep5vykg
	1eEenIw0uu5TYraq/YMn1lCTSFd0O840rN/kqmJ+/8w9s7bSPWrIh8nSntnMkQsKv+r0VOUBcyV
	Kn4y4D5QOOvcp2fe8eG2HJvvZP9AG/AsWcsVm/6waroLIn0qIbLZswVMZadWVpm3Txs=
X-Received: by 2002:a05:690e:b88:b0:660:8fc2:cbd0 with SMTP id
 956f58d0204a3-662782c7800mr12013723d50.31.1781536307843; Mon, 15 Jun 2026
 08:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615131131.1459372-1-oss@fourdim.xyz> <CABBYNZKRTpmnQ44UWH_0jFwQY9OOP5LAHE2+1ZZn-Ckic4wGZQ@mail.gmail.com>
 <cbe3c81f-7919-4a13-b636-5d2bc776e094@app.fastmail.com>
In-Reply-To: <cbe3c81f-7919-4a13-b636-5d2bc776e094@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Jun 2026 11:11:36 -0400
X-Gm-Features: AVVi8CfzjzqpsQBG8ZeZajZ6N-hmec--m_LndK4OjMyEeUN_31zzN-BTo2XGhMk
Message-ID: <CABBYNZLvSOHWQVmCX_T6wEXTPuS=JCii8Aujdh-C6Oo__1CGSw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Pauli Virtanen <pav@iki.fi>, XIAO WU <xiaowu.417@qq.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Mon, Jun 15, 2026 at 11:06=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrot=
e:
>
> Hi Luiz,
>
> On Mon, Jun 15, 2026, at 10:09 AM, Luiz Augusto von Dentz wrote:
> > Hi Siwei,
> >
> > On Mon, Jun 15, 2026 at 9:12=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> w=
rote:
> >>
> >> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
> >> was pending, but hdev->sent_cmd can be NULL while req_status is still
> >> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
> >> protection fault from the hci_rx_work() receive path.
> >>
> >> Instead of inspecting hdev->sent_cmd, track the in-flight create
> >> connection command with a new per-connection HCI_CONN_CREATE flag and
> >> route all cancellation through hci_cancel_connect_sync(). The create
> >> command is in exactly one of two states: still queued, or in flight.
> >> hci_cancel_connect_sync() holds cmd_sync_work_lock across the whole
> >> decision: the worker takes this lock to dequeue every entry, so while =
it
> >> is held a queued command cannot start running and an in-flight command
> >> cannot complete and let the next command become pending. This keeps th=
e
> >> flag test and hci_cmd_sync_cancel() atomic with respect to the worker,
> >> so a queued command is simply dequeued, and an in-flight command owned
> >> by this connection is cancelled without the risk of cancelling an
> >> unrelated command that became pending in the meantime. CIS uses the sa=
me
> >> path via the existing HCI_CONN_CREATE_CIS flag.
> >>
> >> hci_acl_create_conn_sync() and hci_le_create_conn_sync() clear
> >> HCI_CONN_CREATE after the create command completes, but the command
> >> status handler can free conn via hci_conn_del() (for example when the
> >> controller rejects the connection) while the worker is still blocked o=
n
> >> the connection complete event. Hold a reference on conn across the
> >> create command so the flag can be cleared without a use-after-free.
> >>
> >> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborti=
ng connections")
> >> Cc: stable@vger.kernel.org
> >> Suggested-by: XIAO WU <xiaowu.417@qq.com>
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> >> ---
> >>  include/net/bluetooth/hci_core.h |  1 +
> >>  net/bluetooth/hci_conn.c         | 21 +------
> >>  net/bluetooth/hci_sync.c         | 96 ++++++++++++++++++++++++++++---=
-
> >>  3 files changed, 88 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h
> >> index aa600fbf9a53..aa554c34f9ec 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -988,6 +988,7 @@ enum {
> >>         HCI_CONN_AUTH_FAILURE,
> >>         HCI_CONN_PER_ADV,
> >>         HCI_CONN_BIG_CREATED,
> >> +       HCI_CONN_CREATE,
> >>         HCI_CONN_CREATE_CIS,
> >>         HCI_CONN_CREATE_BIG_SYNC,
> >>         HCI_CONN_BIG_SYNC,
> >> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >> index 54eabaa46960..eba4a548bef5 100644
> >> --- a/net/bluetooth/hci_conn.c
> >> +++ b/net/bluetooth/hci_conn.c
> >> @@ -3181,26 +3181,11 @@ int hci_abort_conn(struct hci_conn *conn, u8 r=
eason)
> >>
> >>         conn->abort_reason =3D reason;
> >>
> >> -       /* If the connection is pending check the command opcode since=
 that
> >> -        * might be blocking on hci_cmd_sync_work while waiting its re=
spective
> >> -        * event so we need to hci_cmd_sync_cancel to cancel it.
> >> -        *
> >> -        * hci_connect_le serializes the connection attempts so only o=
ne
> >> -        * connection can be in BT_CONNECT at time.
> >> +       /* Cancel the connect attempt. A return of 0 means the create =
command
> >> +        * was still queued and got dequeued, so there is nothing to d=
isconnect.
> >>          */
> >> -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_statu=
s) =3D=3D HCI_REQ_PEND) {
> >> -               switch (hci_skb_event(hdev->sent_cmd)) {
> >> -               case HCI_EV_CONN_COMPLETE:
> >> -               case HCI_EV_LE_CONN_COMPLETE:
> >> -               case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
> >> -               case HCI_EVT_LE_CIS_ESTABLISHED:
> >> -                       hci_cmd_sync_cancel(hdev, ECANCELED);
> >> -                       break;
> >> -               }
> >> -       /* Cancel connect attempt if still queued/pending */
> >> -       } else if (!hci_cancel_connect_sync(hdev, conn)) {
> >> +       if (!hci_cancel_connect_sync(hdev, conn))
> >>                 return 0;
> >> -       }
> >>
> >>         /* Run immediately if on cmd_sync_work since this may be calle=
d
> >>          * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
> >> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >> index df23245d6ccd..06b87e9cd999 100644
> >> --- a/net/bluetooth/hci_sync.c
> >> +++ b/net/bluetooth/hci_sync.c
> >> @@ -6611,6 +6611,11 @@ static int hci_le_create_conn_sync(struct hci_d=
ev *hdev, void *data)
> >>
> >>         bt_dev_dbg(hdev, "conn %p", conn);
> >>
> >> +       /* Hold a reference so conn stays valid for the HCI_CONN_CREAT=
E
> >> +        * clear_bit() at done.
> >> +        */
> >> +       hci_conn_get(conn);
> >> +
> >>         clear_bit(HCI_CONN_SCANNING, &conn->flags);
> >>         conn->state =3D BT_CONNECT;
> >>
> >> @@ -6623,6 +6628,7 @@ static int hci_le_create_conn_sync(struct hci_de=
v *hdev, void *data)
> >>                     hdev->le_scan_type =3D=3D LE_SCAN_ACTIVE &&
> >>                     !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES=
)) {
> >>                         hci_conn_del(conn);
> >> +                       hci_conn_put(conn);
> >>                         return -EBUSY;
> >>                 }
> >>
> >> @@ -6668,6 +6674,12 @@ static int hci_le_create_conn_sync(struct hci_d=
ev *hdev, void *data)
> >>                                              &own_addr_type);
> >>         if (err)
> >>                 goto done;
> >> +
> >> +       /* Mark create connection in flight so hci_cancel_connect_sync=
() can
> >> +        * cancel it while blocking on the connection complete event.
> >> +        */
> >> +       set_bit(HCI_CONN_CREATE, &conn->flags);
> >> +
> >>         /* Send command LE Extended Create Connection if supported */
> >>         if (use_ext_conn(hdev)) {
> >>                 err =3D hci_le_ext_create_conn_sync(hdev, conn, own_ad=
dr_type);
> >> @@ -6703,11 +6715,14 @@ static int hci_le_create_conn_sync(struct hci_=
dev *hdev, void *data)
> >>                                        conn->conn_timeout, NULL);
> >>
> >>  done:
> >> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
> >> +
> >>         if (err =3D=3D -ETIMEDOUT)
> >>                 hci_le_connect_cancel_sync(hdev, conn, 0x00);
> >>
> >>         /* Re-enable advertising after the connection attempt is finis=
hed. */
> >>         hci_resume_advertising_sync(hdev);
> >> +       hci_conn_put(conn);
> >>         return err;
> >>  }
> >>
> >> @@ -6982,10 +6997,25 @@ static int hci_acl_create_conn_sync(struct hci=
_dev *hdev, void *data)
> >>         else
> >>                 cp.role_switch =3D 0x00;
> >>
> >> -       return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> >> -                                       sizeof(cp), &cp,
> >> -                                       HCI_EV_CONN_COMPLETE,
> >> -                                       conn->conn_timeout, NULL);
> >> +       /* Hold a reference so conn stays valid for the HCI_CONN_CREAT=
E
> >> +        * clear_bit() below.
> >> +        */
> >> +       hci_conn_get(conn);
> >> +
> >> +       /* Mark create connection in flight so hci_cancel_connect_sync=
() can
> >> +        * cancel it while blocking on the connection complete event.
> >> +        */
> >> +       set_bit(HCI_CONN_CREATE, &conn->flags);
> >> +
> >> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> >> +                                      sizeof(cp), &cp,
> >> +                                      HCI_EV_CONN_COMPLETE,
> >> +                                      conn->conn_timeout, NULL);
> >> +
> >> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
> >> +       hci_conn_put(conn);
> >> +
> >> +       return err;
> >>  }
> >>
> >>  int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
> >> @@ -7039,20 +7069,62 @@ int hci_connect_le_sync(struct hci_dev *hdev, =
struct hci_conn *conn)
> >>
> >>  int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *co=
nn)
> >>  {
> >> -       if (conn->state !=3D BT_OPEN)
> >> -               return -EINVAL;
> >> +       struct hci_cmd_sync_work_entry *entry;
> >> +       hci_cmd_sync_work_func_t func =3D NULL;
> >> +       hci_cmd_sync_work_destroy_t destroy =3D NULL;
> >> +       int create_flag =3D -1;
> >> +       int err =3D -EBUSY;
> >>
> >>         switch (conn->type) {
> >>         case ACL_LINK:
> >> -               return !hci_cmd_sync_dequeue_once(hdev,
> >> -                                                 hci_acl_create_conn_=
sync,
> >> -                                                 conn, NULL);
> >> +               func =3D hci_acl_create_conn_sync;
> >> +               create_flag =3D HCI_CONN_CREATE;
> >> +               break;
> >>         case LE_LINK:
> >> -               return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_=
conn_sync,
> >> -                                                 conn, create_le_conn=
_complete);
> >> +               func =3D hci_le_create_conn_sync;
> >> +               destroy =3D create_le_conn_complete;
> >> +               create_flag =3D HCI_CONN_CREATE;
> >> +               break;
> >> +       case CIS_LINK:
> >> +               /* LE Create CIS is shared by the whole CIG and cannot=
 be
> >> +                * dequeued per-connection; only cancel it in-flight b=
elow.
> >> +                */
> >> +               create_flag =3D HCI_CONN_CREATE_CIS;
> >
> > Instead of doing everything in the same function, it probably makes
> > more sense to add dedicated functions for each type, for example,
> > `hci_acl_cancel_create_conn_sync`, etc.
> >
>
> int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
> {
>         switch (conn->type) {
>         case ACL_LINK:
>                 return hci_cancel_create_conn_sync(hdev, conn, HCI_CONN_C=
REATE,
>                                                    hci_acl_create_conn_sy=
nc,
>                                                    NULL);
>         case LE_LINK:
>                 return hci_cancel_create_conn_sync(hdev, conn, HCI_CONN_C=
REATE,
>                                                    hci_le_create_conn_syn=
c,
>                                                    create_le_conn_complet=
e);
>         case CIS_LINK:
>                 return hci_cancel_create_conn_sync(hdev, conn,
>                                                    HCI_CONN_CREATE_CIS, N=
ULL,
>                                                    NULL);
>         default:
>                 return -ENOENT;
>         }
> }
>
> I would like to have something like this.
> hci_acl_cancel_create_conn_sync will have an unnecessary wrapper.
> What do you think?

No, just do what I said. Things like hci_cis_cancel_create_conn_sync
are actually quite different on their own. In fact, if we handle more
variants of conn->type the differences will actually become more
pronounced so let's not pretend they are similar.

> >> +               break;
> >> +       default:
> >> +               return -ENOENT;
> >>         }
> >>
> >> -       return -ENOENT;
> >> +       /* The create command is either still queued or in flight. Hol=
d
> >> +        * cmd_sync_work_lock across the test and the cancel: the work=
er takes
> >> +        * this lock to dequeue every entry, so while it is held no ot=
her command
> >> +        * can become pending, which keeps hci_cmd_sync_cancel() from =
racing with
> >> +        * completion and cancelling an unrelated command.
> >> +        */
> >> +       mutex_lock(&hdev->cmd_sync_work_lock);
> >> +
> >> +       /* The flag is set while the worker blocks on the connection c=
omplete
> >> +        * event, so if it is set this connection owns the pending req=
uest.
> >> +        */
> >> +       if (create_flag >=3D 0 && test_bit(create_flag, &conn->flags))=
 {
> >> +               hci_cmd_sync_cancel(hdev, ECANCELED);
> >> +               goto unlock;
> >> +       }
> >> +
> >> +       /* Otherwise it may still be queued; dequeue it. A successful =
dequeue
> >> +        * means it never started, so there is nothing to disconnect.
> >> +        */
> >> +       if (func) {
> >> +               entry =3D _hci_cmd_sync_lookup_entry(hdev, func, conn,=
 destroy);
> >> +               if (entry) {
> >> +                       _hci_cmd_sync_cancel_entry(hdev, entry, -ECANC=
ELED);
> >> +                       err =3D 0;
> >> +               }
> >> +       }
> >> +
> >> +unlock:
> >> +       mutex_unlock(&hdev->cmd_sync_work_lock);
> >> +       return err;
> >>  }
> >>
> >>  int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *co=
nn,
> >> --
> >> 2.54.0
> >>
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Best,
> Siwei



--=20
Luiz Augusto von Dentz
