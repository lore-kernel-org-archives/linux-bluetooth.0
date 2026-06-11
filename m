Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329B438FE6
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192183; cv=pass; b=AkCTFib9EYb9YEjPWL62yLpBQfUStcL/cyVtSXbnfP1VY5MqzYJatkkCw6PEhIJgx8pta9sx8Zt5IE8AZBSykZc+GmrdXPcSde8ZGBRPI4Aw5Y1y13xpYT7o+ZhVcJ6AdG5YRRd0WNFNtIEJ5GWYtcTdBiKssqKeC5wAdpHPUeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192183; c=relaxed/simple;
	bh=BP9IrziDjckqC2djo3JE6JqaQneWUDPdSL6ln252+9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECW1ufndkB7IE05hVNFLyJU4Kj4sWqd9Esw82YEc6ZkinU09Mm2AcnsLspKULqed26IkiB6heXosuIZi8GN7JzMK6mQ5aPkBZBqO0uOtdiS2iECx0wb4GpfL8MXNmOK1PTagnscAlgCnohfcSblmznZnXWh0ewKYC3pjtbo9TB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chVYA2j/; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chVYA2j/"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-660390acd71so931757d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 08:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781192174; cv=none;
        d=google.com; s=arc-20240605;
        b=VsFKqynPi7LjQ4jepubsyb4hZzqas8KkNONIrzhx96HZQqBDYtNO5X+836T4fEFLeT
         ld5kNapVQsiFsbOYN55H4VoKP7CbYGaegHQpG3nEmo97CFFZqh4htsKt4foRWQoHP6B5
         5kCzoOFaMk1W3Qf4hqUNtWs4hgaEtcN/gD0othITvW0xeqZsVUapP/aaXr7OCZfP/LCN
         QJvPDZ2hHU7S9+RvZh55FgP3DTKrlkSm+HtuGjrFNjE2QbZCK8c0rLSUDYZHnaP1sh6B
         Tyi2NDZx9r0E9Leol58UFwpsD2GC6Vvlor+Ukq6QVLXpYsCujdCgwKyQ564ciuV34Dcz
         pKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6uZPdLCW7I+SgGTMpr04HCq57/EqEhMHGvudaJSYmVc=;
        fh=tyIoVIdoo3GG6ZRoi/xsrXAAPlFArnFDetdoYcj+VDI=;
        b=FnhPOQNRO3oGxSSktQou7rW4y9hlLjfK46thmwnFfIbqarI72iGJVD5SkGnW4bNFJb
         5jnssVrNxWK70w8NqKmWj26NE7UFBpk62ARDcoO6zC3HNjtsG+bz7ec3t/+fy8rB1ei2
         eYNLz/Be0qO7Rp5pos22iun+wnt+F5CCckF1CIq2xkNUyL+YbEWVhH0eH84kXwZju2ew
         tYcy0RBttrrAGGxMs5DysR7Gx1/HCAH3PoaKPRF0b1vjNUobRnx8OtAw/9j0wljjjegJ
         iqDXQKGGxYJHfPmp4GtcfnsPx2WLy3Ps7vSAaJdbIx6zUV/Pn00vR4MHPQ4F/2os9NtW
         83ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781192174; x=1781796974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uZPdLCW7I+SgGTMpr04HCq57/EqEhMHGvudaJSYmVc=;
        b=chVYA2j/c8HM45frVq93Cim59BKR2uv5Jofww2lB6kURzLGgvoOaX/93LIS7Su2f2k
         PSOl8ndl4mhTtdXHee6DAuSKRdc32uf1drW5+z8zojxWU0QWzJLoHDr7gOIprPNXsAfm
         f8Y0pGTINWRw3jSgQEl3EKZQ3QZhJBulFjuTGoKe6dPBNooMA2SHqq+N2PalKPD4h9ID
         c+VjTJz3fKPi2q6sqtKNaniorNLRmnwZhKC4hsJ+cClLctYVnDkeyJtNUOJU4fksF0vI
         8Y5wNGCrMhPSiN/jfxuxKanXtcFqb57hm6RDZlW0Oy4huVvaJ39KWvssa+B8b3Xjh2w9
         zPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781192174; x=1781796974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6uZPdLCW7I+SgGTMpr04HCq57/EqEhMHGvudaJSYmVc=;
        b=najouAC31+VkCHfdQcuTQIPdMMTuN6y/e/nABTB+KZW/pwS8ARwzxNu9D0i4fAOX39
         7cL5uWt/j98fYdxiz7fA8IeCAVhe58rm06S/fo6XWhnRB5M3ttsRrbnTAgKBRxjRpFNk
         Yn85KYktHlzAKqKuu0Y7SEKOTFco0pAaFKSqhTAg86yupiNVTVHWxq7+9r9odYJwI8cz
         tV7y3OXDwst6GopGw8iK7JrLgOY9wOB03iJX9TVApkXnI55g1B5xFi4yb9MU/rpUpDCR
         WYIX1/o8biaIZZdebvKnAgYSbEDAKU8JvRcXYOM3NjEpp6osmlhVltsr9n6pqf5ZV+8W
         WwqA==
X-Gm-Message-State: AOJu0Yy/wQBdQcKUsFqde/teBniutQKFjFMzkCJ5T9ZtQQsLZPZQyj4T
	W54x0cEwwzJjzU6wC1quZKR+es9T7kmUyTBABVIl+DVvcdwjniVnl4AwHokU6YoAtnLsZ+r8CUT
	P8DZmQ56ncSHVLqLvCmfcAWXtscVkWgdvtHXHNQI=
X-Gm-Gg: Acq92OGIndUQU+O1FAjrn6UvHr8bjW9bMKLyA4xIPHWgIknO+L8M/2yiakXQD57dSa1
	OcPaFyHyoD8QlLRbNgdDnnsFHP45yZ1A3pqtn+txqa2KkZuFz+SEA0l/M/xjxVcAYmlzHlngkic
	Cmf+OL4OpXsOx4bu3DVv9ZynJ21dZxk+6nSSON68hDOSY4u4ItB9gROlbsSw4X4oYzSgtoqGT/H
	UnpXw8UHKthW/sKLmSxsxb+5vJmm19A1J0OcXa+Wt58J1WuGHsH7Ts7XfFS97LV0o3yIdwznX3z
	LCWJrFPKDkTPNZEP2Cm3wy/plijkIKCLgOK1Owf3ZdyU1op2sPnB5og5X/V3W/MicrAflaqpu+G
	Hdw==
X-Received: by 2002:a05:690e:4383:b0:651:bd7e:c04c with SMTP id
 956f58d0204a3-662695e6213mr1577060d50.21.1781192173606; Thu, 11 Jun 2026
 08:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611152039.2176565-1-oss@fourdim.xyz>
In-Reply-To: <20260611152039.2176565-1-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Jun 2026 11:36:02 -0400
X-Gm-Features: AVVi8Cewvg7k66AJ2cKfB3RKgmFC8aHOgHnw_1HQD7p0701fG_sGN6MV57zSpm4
Message-ID: <CABBYNZJf5fVxkLVWKwXWOdhyrxANBLfF9Rc_1oka-RgW-mx+Ow@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Thu, Jun 11, 2026 at 11:20=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrot=
e:
>
> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
> was pending, but hdev->sent_cmd can be NULL while req_status is still
> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
> protection fault from the hci_rx_work() receive path.
>
> Instead of inspecting hdev->sent_cmd, track the in-flight create
> connection command with a new per-connection HCI_CONN_CREATE flag and
> route all cancellation through hci_cancel_connect_sync(), which dequeues
> the command if still queued, or cancels the pending request if this
> connection owns the in-flight create command. CIS uses the same path
> via the existing HCI_CONN_CREATE_CIS flag.
>
> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting =
connections")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_conn.c         | 21 ++--------
>  net/bluetooth/hci_sync.c         | 66 ++++++++++++++++++++++++++------
>  3 files changed, 58 insertions(+), 30 deletions(-)
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
> index df23245d6ccd..1fe19ddbbc2c 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6668,6 +6668,12 @@ static int hci_le_create_conn_sync(struct hci_dev =
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
> @@ -6703,6 +6709,8 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>                                        conn->conn_timeout, NULL);
>
>  done:
> +       clear_bit(HCI_CONN_CREATE, &conn->flags);
> +
>         if (err =3D=3D -ETIMEDOUT)
>                 hci_le_connect_cancel_sync(hdev, conn, 0x00);
>
> @@ -6982,10 +6990,19 @@ static int hci_acl_create_conn_sync(struct hci_de=
v *hdev, void *data)
>         else
>                 cp.role_switch =3D 0x00;
>
> -       return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> -                                       sizeof(cp), &cp,
> -                                       HCI_EV_CONN_COMPLETE,
> -                                       conn->conn_timeout, NULL);
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
> +
> +       return err;
>  }
>
>  int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
> @@ -7039,20 +7056,45 @@ int hci_connect_le_sync(struct hci_dev *hdev, str=
uct hci_conn *conn)
>
>  int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
>  {
> -       if (conn->state !=3D BT_OPEN)
> -               return -EINVAL;
> +       hci_cmd_sync_work_func_t func =3D NULL;
> +       hci_cmd_sync_work_destroy_t destroy =3D NULL;
> +       int create_flag =3D -1;
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
> +               break;
> +       default:
> +               return -ENOENT;
>         }
>
> -       return -ENOENT;
> +       /* The create command is in exactly one of two states: still queu=
ed, or
> +        * in flight. The create flag is only set once the worker has deq=
ueued
> +        * the entry and started running it, so the two states are mutual=
ly
> +        * exclusive. Try to dequeue first: if it succeeds the command ha=
d not
> +        * started yet and we are done. Otherwise the worker already pull=
ed it
> +        * off the queue (the dequeue is a no-op here),

This is where I disagree, `dequeue` is not a no-op. It must traverse
the list of entries in cmd_sync_work_list, so it is cheaper to check
the flag first and then attempt to dequeue.

> +        * owns the in-flight create command, cancel the pending request.
> +        */
> +       if (func && hci_cmd_sync_dequeue_once(hdev, func, conn, destroy))
> +               return 0;
> +
> +       if (create_flag >=3D 0 && test_bit(create_flag, &conn->flags))
> +               hci_cmd_sync_cancel(hdev, ECANCELED);
> +
> +       return -EBUSY;
>  }
>
>  int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
