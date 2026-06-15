Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F321C16A
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532575; cv=pass; b=Hw2vwiKNE+Nzj+yh8uOm+DEPOZF8nQtIyki71zi0yzaJIYfpB2oc1TXULycDJqMF2SI7vBCN3xgi7Ta9MrX1V8iBkLtD8j0UwY0f0W5UKqswOO4OGto32CVwlnc9Gx/1LYt1AVvNDpAV5khMkEjJStMtdmFuVdz+WkhKDecwl4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532575; c=relaxed/simple;
	bh=va/FiAuymZqsc8bSqRNd7zHCNBil2uWfzAt6YbM3prM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N69LyJ+hGviWOuIAN8nUDzS0v4OWsheX7/SBnIbuOXa0G/sC9GLFXm/ZT58OP4LeWZ9S7n8Zc/Qnu4G9qOGycfPG7F6kof/hI7OwI2Kzp+GSwIl0XHN9dtW0UaNuQ36H8p4Kh4R3Wh+L1mo8eHBTxexLrrjPVA7MhA/vCNEYNyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfNBzFNJ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfNBzFNJ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66077f6c438so3235295d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 07:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781532573; cv=none;
        d=google.com; s=arc-20240605;
        b=VJf3P2ahFYrnTbxfcVXMR9qbEhyAxzJgIZO26/5jKfiu+xP87N8LT6hhiuDpTu6wV8
         +VPKjYRqc/2l9XFnAJZtGdW0/sJB8kSe1dAiTcGcNeUzwJfmwwp3G4QoF7ElP2Ky6mAY
         FzvXVpl2v4Ib6GcSMbq465UwcgWJVMwmAf8uNJg22kn8HMsJsuaA8bxeUjLPs804sXfc
         9rcy6p0C4tgjWO3Bx3kbUMGKW8mPf5QQ0uKdgPe4XmoJqusgVCrtNmzbcPwKJ6x7ace4
         ydM82CTx7rJj99XRtNu1nE/RFPQzM6FsMmLvizt1ddMOGs+qTPLppA2ftqdh+XlsYZ0O
         5TKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BLLbGUEfrVutTYnILa5BJD3wFHvrOmdbyOsWb1KPRZE=;
        fh=ampdtAw1quBdcmo4a8rUXwGU4YDrL2NuDzOd+0ptnO4=;
        b=itHVlKLLEQ+2n8tVNz11QSF8qKw3etcsJQjjuOLewfSLLao3U0B2TtHW+m1UbdDp9b
         wMAP9ksZEcvV5nW2y+UR4E3TjAhuieMECPyufmwJcmJ6C/dvJrStxwzCqLfa1/YSH/rf
         fG/tn7Bn3qmiYQQOqy4vdx7PUEP6XP2QZQrkhZa0wrOjuK59f20KoOshSTBJcKhgLfv9
         01LjHFnk0bgO8cbBCTjzt4+Evr73wa3vxzCLC85bPvjgUcdTgkvfxkzdBBwwhHrYLYhN
         LSm1kzOOh2Yf5baJ1J6kswKo5uvXIcSjyO14ka3DUw8LT5sULOQycmA2HAs87dCJp4bj
         Gyuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781532573; x=1782137373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLLbGUEfrVutTYnILa5BJD3wFHvrOmdbyOsWb1KPRZE=;
        b=UfNBzFNJpf/PraQbLD4tC8xI8jiCDMSUJEhlwNTWgw49hjuRLTEnkc7qY/bVUamGfT
         aJ4hndccU7Vm9wMUr+uDgi66iW0mLI0LydhvFaUI94UOpgW5dlZXtwNtgmwrdyJLXBDZ
         jJ71VFObXlgmKWpyJsR+R6Fxgm/jxQOZDB5maAGO/RoiVECQYh0Bqf5EAhDUuaGsu7pY
         e1SMXnUqqPXauF56fCAqzjjrmktJ/PKmg0rF6cqB1E36NQMWR3qSXDwipTo2vMUNmwow
         ckXcGicMdMua8PLrxQ4oEfkamOqU2TG0h7j9edLedkDl2JyDO1ymRWq6E42An04YwTum
         3pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532573; x=1782137373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLLbGUEfrVutTYnILa5BJD3wFHvrOmdbyOsWb1KPRZE=;
        b=Y8gPSOeA4gmzC7UERYkVjmj5Xz+6U6syBRoei4lOL/4cHGzCMAvwS/2J+Whevua6FE
         Aq7q0dvnFppAp8hbWqt1CtwmNIP1mZXqTu1c88MRszdp88HVf/3mXa5IHmxDzTqVQRLV
         QW12sRItZ0GoSOCpXzqwjzph+EQbnRo2VuBFLFhwNEX5DK/Li6DYCXixfK0G9/VsNIjI
         hpUiJPt2vnL46h2YcVE4HWANNYZGi4l2tqE7etYkqN89T4A4FQkymJ2Dl2jhIIW/sBcc
         vOotcgL3TDwRPkCN1ti9GPgQuSQ2xypZTmtENqOxWcIHDtCPninSoU3N/aLl4wfA5hHk
         37AQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bTJeaP2A5u6gr52uaeLgFDZk+whIGYuftWaWe2jTjxYB+lYQvAXrrwbmJC6SoHO9BiW8PdgS8ChzSNeCtLsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/BUyjwOHxjprus2mgEP6rdh80xzU+QWzT9+wZCoz2ytWE/fs
	FhOqw1euKjJiz6wKKpl50IkqUJaK7Q1vq5IjE8OFRmeGvW/Tk4PKoMntld0tCJ1kWDhYoWSjlG6
	4x6Gl2uDAiEaymBsPMFrvxQgKKHuugXU=
X-Gm-Gg: Acq92OEqWXI180bmaxiVSVZ13ST5DgkxkwThaE1RDYEwEHRp2i3lfADgTdAH41MtFlx
	geW84/s6MU6KH0rMKKrCQ7ZIHuwgLBS21BkVMWRl5H0VqAYLyu3P2oNX5rzG6/CTN1EPaQ+NUmD
	yhKTh6b1y384NGDvjMA3KtOzyzDVVwpQSzrRl6cQpMDlJttOL7AIMY9r2jbLCUrnIgonYom3dPn
	+oO3pSOpPujyIVyP3GdToLV4s243TvGH4kCVuC/KNX/ct21qtO7k8EO+0ExiQK76KQzyocHJ/z8
	ChT8HuzUydYpj9Cr6CWsno/xTn2G+3Vga2P6gInBn9+20Y5GfizcHZpqTyPHidt31uzl5w==
X-Received: by 2002:a05:690e:a4e:b0:660:5df1:f226 with SMTP id
 956f58d0204a3-662783d5fffmr11844207d50.62.1781532572284; Mon, 15 Jun 2026
 07:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615131131.1459372-1-oss@fourdim.xyz>
In-Reply-To: <20260615131131.1459372-1-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Jun 2026 10:09:21 -0400
X-Gm-Features: AVVi8CeubsG_qPk3-ZqeiQCfPVQsMg8jTUTpGUZRH_ybFz0QlDiYMRXMIjoMGDo
Message-ID: <CABBYNZKRTpmnQ44UWH_0jFwQY9OOP5LAHE2+1ZZn-Ckic4wGZQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Pauli Virtanen <pav@iki.fi>, XIAO WU <xiaowu.417@qq.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Mon, Jun 15, 2026 at 9:12=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
> was pending, but hdev->sent_cmd can be NULL while req_status is still
> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
> protection fault from the hci_rx_work() receive path.
>
> Instead of inspecting hdev->sent_cmd, track the in-flight create
> connection command with a new per-connection HCI_CONN_CREATE flag and
> route all cancellation through hci_cancel_connect_sync(). The create
> command is in exactly one of two states: still queued, or in flight.
> hci_cancel_connect_sync() holds cmd_sync_work_lock across the whole
> decision: the worker takes this lock to dequeue every entry, so while it
> is held a queued command cannot start running and an in-flight command
> cannot complete and let the next command become pending. This keeps the
> flag test and hci_cmd_sync_cancel() atomic with respect to the worker,
> so a queued command is simply dequeued, and an in-flight command owned
> by this connection is cancelled without the risk of cancelling an
> unrelated command that became pending in the meantime. CIS uses the same
> path via the existing HCI_CONN_CREATE_CIS flag.
>
> hci_acl_create_conn_sync() and hci_le_create_conn_sync() clear
> HCI_CONN_CREATE after the create command completes, but the command
> status handler can free conn via hci_conn_del() (for example when the
> controller rejects the connection) while the worker is still blocked on
> the connection complete event. Hold a reference on conn across the
> create command so the flag can be cleared without a use-after-free.
>
> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting =
connections")
> Cc: stable@vger.kernel.org
> Suggested-by: XIAO WU <xiaowu.417@qq.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_conn.c         | 21 +------
>  net/bluetooth/hci_sync.c         | 96 ++++++++++++++++++++++++++++----
>  3 files changed, 88 insertions(+), 30 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index aa600fbf9a53..aa554c34f9ec 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -988,6 +988,7 @@ enum {
>         HCI_CONN_AUTH_FAILURE,
>         HCI_CONN_PER_ADV,
>         HCI_CONN_BIG_CREATED,
> +       HCI_CONN_CREATE,
>         HCI_CONN_CREATE_CIS,
>         HCI_CONN_CREATE_BIG_SYNC,
>         HCI_CONN_BIG_SYNC,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 54eabaa46960..eba4a548bef5 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -3181,26 +3181,11 @@ int hci_abort_conn(struct hci_conn *conn, u8 reas=
on)
>
>         conn->abort_reason =3D reason;
>
> -       /* If the connection is pending check the command opcode since th=
at
> -        * might be blocking on hci_cmd_sync_work while waiting its respe=
ctive
> -        * event so we need to hci_cmd_sync_cancel to cancel it.
> -        *
> -        * hci_connect_le serializes the connection attempts so only one
> -        * connection can be in BT_CONNECT at time.
> +       /* Cancel the connect attempt. A return of 0 means the create com=
mand
> +        * was still queued and got dequeued, so there is nothing to disc=
onnect.
>          */
> -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_status) =
=3D=3D HCI_REQ_PEND) {
> -               switch (hci_skb_event(hdev->sent_cmd)) {
> -               case HCI_EV_CONN_COMPLETE:
> -               case HCI_EV_LE_CONN_COMPLETE:
> -               case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
> -               case HCI_EVT_LE_CIS_ESTABLISHED:
> -                       hci_cmd_sync_cancel(hdev, ECANCELED);
> -                       break;
> -               }
> -       /* Cancel connect attempt if still queued/pending */
> -       } else if (!hci_cancel_connect_sync(hdev, conn)) {
> +       if (!hci_cancel_connect_sync(hdev, conn))
>                 return 0;
> -       }
>
>         /* Run immediately if on cmd_sync_work since this may be called
>          * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index df23245d6ccd..06b87e9cd999 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6611,6 +6611,11 @@ static int hci_le_create_conn_sync(struct hci_dev =
*hdev, void *data)
>
>         bt_dev_dbg(hdev, "conn %p", conn);
>
> +       /* Hold a reference so conn stays valid for the HCI_CONN_CREATE
> +        * clear_bit() at done.
> +        */
> +       hci_conn_get(conn);
> +
>         clear_bit(HCI_CONN_SCANNING, &conn->flags);
>         conn->state =3D BT_CONNECT;
>
> @@ -6623,6 +6628,7 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>                     hdev->le_scan_type =3D=3D LE_SCAN_ACTIVE &&
>                     !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) =
{
>                         hci_conn_del(conn);
> +                       hci_conn_put(conn);
>                         return -EBUSY;
>                 }
>
> @@ -6668,6 +6674,12 @@ static int hci_le_create_conn_sync(struct hci_dev =
*hdev, void *data)
>                                              &own_addr_type);
>         if (err)
>                 goto done;
> +
> +       /* Mark create connection in flight so hci_cancel_connect_sync() =
can
> +        * cancel it while blocking on the connection complete event.
> +        */
> +       set_bit(HCI_CONN_CREATE, &conn->flags);
> +
>         /* Send command LE Extended Create Connection if supported */
>         if (use_ext_conn(hdev)) {
>                 err =3D hci_le_ext_create_conn_sync(hdev, conn, own_addr_=
type);
> @@ -6703,11 +6715,14 @@ static int hci_le_create_conn_sync(struct hci_dev=
 *hdev, void *data)
>                                        conn->conn_timeout, NULL);
>
>  done:
> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
> +
>         if (err =3D=3D -ETIMEDOUT)
>                 hci_le_connect_cancel_sync(hdev, conn, 0x00);
>
>         /* Re-enable advertising after the connection attempt is finished=
. */
>         hci_resume_advertising_sync(hdev);
> +       hci_conn_put(conn);
>         return err;
>  }
>
> @@ -6982,10 +6997,25 @@ static int hci_acl_create_conn_sync(struct hci_de=
v *hdev, void *data)
>         else
>                 cp.role_switch =3D 0x00;
>
> -       return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> -                                       sizeof(cp), &cp,
> -                                       HCI_EV_CONN_COMPLETE,
> -                                       conn->conn_timeout, NULL);
> +       /* Hold a reference so conn stays valid for the HCI_CONN_CREATE
> +        * clear_bit() below.
> +        */
> +       hci_conn_get(conn);
> +
> +       /* Mark create connection in flight so hci_cancel_connect_sync() =
can
> +        * cancel it while blocking on the connection complete event.
> +        */
> +       set_bit(HCI_CONN_CREATE, &conn->flags);
> +
> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> +                                      sizeof(cp), &cp,
> +                                      HCI_EV_CONN_COMPLETE,
> +                                      conn->conn_timeout, NULL);
> +
> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
> +       hci_conn_put(conn);
> +
> +       return err;
>  }
>
>  int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
> @@ -7039,20 +7069,62 @@ int hci_connect_le_sync(struct hci_dev *hdev, str=
uct hci_conn *conn)
>
>  int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
>  {
> -       if (conn->state !=3D BT_OPEN)
> -               return -EINVAL;
> +       struct hci_cmd_sync_work_entry *entry;
> +       hci_cmd_sync_work_func_t func =3D NULL;
> +       hci_cmd_sync_work_destroy_t destroy =3D NULL;
> +       int create_flag =3D -1;
> +       int err =3D -EBUSY;
>
>         switch (conn->type) {
>         case ACL_LINK:
> -               return !hci_cmd_sync_dequeue_once(hdev,
> -                                                 hci_acl_create_conn_syn=
c,
> -                                                 conn, NULL);
> +               func =3D hci_acl_create_conn_sync;
> +               create_flag =3D HCI_CONN_CREATE;
> +               break;
>         case LE_LINK:
> -               return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_con=
n_sync,
> -                                                 conn, create_le_conn_co=
mplete);
> +               func =3D hci_le_create_conn_sync;
> +               destroy =3D create_le_conn_complete;
> +               create_flag =3D HCI_CONN_CREATE;
> +               break;
> +       case CIS_LINK:
> +               /* LE Create CIS is shared by the whole CIG and cannot be
> +                * dequeued per-connection; only cancel it in-flight belo=
w.
> +                */
> +               create_flag =3D HCI_CONN_CREATE_CIS;

Instead of doing everything in the same function, it probably makes
more sense to add dedicated functions for each type, for example,
`hci_acl_cancel_create_conn_sync`, etc.

> +               break;
> +       default:
> +               return -ENOENT;
>         }
>
> -       return -ENOENT;
> +       /* The create command is either still queued or in flight. Hold
> +        * cmd_sync_work_lock across the test and the cancel: the worker =
takes
> +        * this lock to dequeue every entry, so while it is held no other=
 command
> +        * can become pending, which keeps hci_cmd_sync_cancel() from rac=
ing with
> +        * completion and cancelling an unrelated command.
> +        */
> +       mutex_lock(&hdev->cmd_sync_work_lock);
> +
> +       /* The flag is set while the worker blocks on the connection comp=
lete
> +        * event, so if it is set this connection owns the pending reques=
t.
> +        */
> +       if (create_flag >=3D 0 && test_bit(create_flag, &conn->flags)) {
> +               hci_cmd_sync_cancel(hdev, ECANCELED);
> +               goto unlock;
> +       }
> +
> +       /* Otherwise it may still be queued; dequeue it. A successful deq=
ueue
> +        * means it never started, so there is nothing to disconnect.
> +        */
> +       if (func) {
> +               entry =3D _hci_cmd_sync_lookup_entry(hdev, func, conn, de=
stroy);
> +               if (entry) {
> +                       _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELE=
D);
> +                       err =3D 0;
> +               }
> +       }
> +
> +unlock:
> +       mutex_unlock(&hdev->cmd_sync_work_lock);
> +       return err;
>  }
>
>  int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
