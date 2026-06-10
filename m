Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799FE340A76
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109801; cv=pass; b=ex+BxX1HEeyeMGZUkV8XD13401qEXUoIO9jWBHpCPjcs9p5MW/6YHLNuY/oqhrJkzPC+7U2HFQKdotTHP+NABxOdGTVZMCgCpxRbL/SvoQAnZZFUpDDsP/PoMQwiVtdVu2+ZoiW6zC35/yJDEDMafiBrRllu2X3c1RmHDk277O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109801; c=relaxed/simple;
	bh=lTWqzhhpD9lVCVkQe1g4fjw8Lis18OyDInBgJRybCiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSa8qaMbiHXzDh2qmQZPlFlQyCTokUf644iiKTjt5DERorw9u5CkXMMwMkDrDZhuJXRXK8OdBgssJZsJJSufi4bdfSA0h9JVYcaU47m/RaL6othDGWlgBEPZAhlYa3dg3HQGqksQQQe+0965tEDzun3fVDN4uXaB8Vr9WCuEveA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOp8erRX; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOp8erRX"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6603d8697d2so6914540d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 09:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781109799; cv=none;
        d=google.com; s=arc-20240605;
        b=BqnKaGf7cxzygtEVwNwYnNWq8gsZXv6/WjF0PkBEKXVQJd1eycOCDXtdfa6647IeVp
         3UAyWq/i5dRHXabhc2T56+ZueMUWVKs6QlzLay/HyjrUpkzzmm4j7NH55SG0N2p8tfBR
         QuetzM7M+wM+FKKROlB6XREQg00cHUis3dyr9qw2yaU1sjHqlNgv6nhZpSRSWxZqF4h8
         WKXd3JhvTIMJbWQOv7SIamoKwrYvlsvR4fGVTZQ8iYzts8M8KoZBZ+D3QBLJrXOJiEem
         uJ4q4A3RxEyLaEfrCIzZ82aVwmdNEYu62O1uOOTtwLpraFusY+jlN2LOvrPaVUEcMAdo
         416g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oC1zzgO4GWoiOsfosFQG+QKjXmjnSZZbymz8PjKTHgo=;
        fh=tyIoVIdoo3GG6ZRoi/xsrXAAPlFArnFDetdoYcj+VDI=;
        b=fPItTjTBcI95FDggkA29j3OTS25riYXvST7A2FoL7cXRBt7AP6sVL+ZwkXBLYTxEEp
         ASEG8OGBUdWzlImk78CLAiSq87D+LB0Gme5F6HJLFybtysvYIBLWH72Y94xkGGTA5YDP
         /9bX9Y9ioLAEWWESBGD77nYq0MG6Q5zfCDF7V8gRhYDYH3PyWq4xW1pQ7wGAGorZYpGt
         OX5tPf8QZtwcZUHgZpoKKvdxquZb9B+m0t8YKa5LxTiF1Lo8Q2TIuLKkGOf0OGG88oQ/
         I4bAoIYQnx/8WmcHZdNjj8utfH5+Y7oTMeBj1eqpksGFE7Q5zX1QboK2WDT7LHSw6PTT
         lq/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781109799; x=1781714599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC1zzgO4GWoiOsfosFQG+QKjXmjnSZZbymz8PjKTHgo=;
        b=lOp8erRXrlVdJhoUAA8qervaaRTHaFifsk6YB6pC93A5r+l1xmcZde6jiJZ9SdugkW
         A4HOFO/LPggzls9f1YfKOuooM7D6QKh4gmYFR0gO+gZln1vOcKwpK3A60MTNedVZF5y+
         wQ+Jcaxb1oJff/vxLUc+MlCSiPVpr3d8vQQPDDqY4CDYDGIbcs0emyg2egxFt3Kp554+
         NimcBchCI70FZrtrzGlRAAmBf8xHCsGxTogMChVuFl1gElTZyS54JJSwcZI6lNxZ/Va+
         23ZVAIZUuFrx0ojc1g9IpBQf9NICVvKrdxpOFote8UE5b71e7g1k1nAeTHdioyYCxocL
         UJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781109799; x=1781714599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oC1zzgO4GWoiOsfosFQG+QKjXmjnSZZbymz8PjKTHgo=;
        b=NkltXGlPf22Nbi4mHnwZT6LzCgOu+RVDLF0z0KYFYTaywcn2bJvmoI4PUIZ8uHHuDh
         NawYSZV5dp9r3dHH7ctl0C7d2h7cbQNtsWK0Z0KTSMjKKO0m0XPzLTUrpJmjr6xZEYBF
         /w3/FaWSFWs47nQwrJclApbzUIzE/KLaVchaJMwKSGfXtcdgiGWmjVqzD/k+GBnFP45O
         FQlOGBRhZYFOBkzWnwyfal5u60BvMu4c2+s7yiutBALybNWU7b3Izxwbs9p6mufd48VX
         0wGRwgCBRaBr0E894fHcrrVU6Mi4sCQt6cerkEJE6ZCZkpSgM2vcylsu8LCfRblc9S9a
         fW2Q==
X-Gm-Message-State: AOJu0Yx7SKfzV34KpMahpsmQSSNMn4DcR9T10aytUiqWRx8uuAKhTCtO
	3+ECyObrw+yxFZ/KbSCv/6O9mwHkfFJFL+WPu7cj9Co5DzHs+fb3X5Qeb3PwqUjy8Xmp1GJ1BN2
	fElBmuzZv9Rm+bNOTP1RERF2tKxeTzVIjusQ9Cnc=
X-Gm-Gg: Acq92OHjL3eqeylJTX5rdBwaYLN7gVEzQ9ueuysl4m4nseBUIK6EJcd5wiSszuIZya4
	46OqdHWXQ6CUpCYMGud3D7VWd7QqhHX0u/Me6nbLd71vaaNzIPYQtDV1Qizw8JVwo0HiyLwXB2f
	9EiLIn1gE8BIeSiIRuq8ocxvOKLThfpDuVeY5Izvuf7ySy4CC7fvo3tKO/d3Uys6ZLKbugbiU4z
	UFjmeUgeS5L+j6192HsVnyPYkVBDMdKFwn2Wb8Y9igXHVpQBCuG++oh/idaZB3dJXlr9EScN0Br
	cHKgLod72kypgpM9SaykZfc9WR1txTHuaGadAvxszU2FRjuIZ5/CKOd0sgqsrifHKd+9MZPszjd
	TDYMN
X-Received: by 2002:a05:690e:4382:b0:662:5ec2:8e3c with SMTP id
 956f58d0204a3-6625ec29945mr1780335d50.4.1781109799387; Wed, 10 Jun 2026
 09:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610150704.1234558-1-oss@fourdim.xyz>
In-Reply-To: <20260610150704.1234558-1-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 12:43:07 -0400
X-Gm-Features: AVVi8CdsbTaZnyhcwO2bb7nwNBCLVnyynOhBdaHKuEHKNATq01-nNYuSOUytnk4
Message-ID: <CABBYNZJszP1AV+wnLYYsQM5Wr+fxx_8WXa7bySFS9nGwUTBjHA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, Jun 10, 2026 at 11:07=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrot=
e:
>
> hci_abort_conn() read hci_skb_event(hdev->sent_cmd) when a connection
> was pending, but hdev->sent_cmd can be NULL while req_status is still
> HCI_REQ_PEND, leading to a NULL pointer dereference and a general
> protection fault from the hci_rx_work() receive path.
>
> Instead of inspecting hdev->sent_cmd, track the in-flight create
> connection command with a new per-connection HCI_CONN_CREATE_CONN flag
> and route all cancellation through hci_cancel_connect_sync(), which
> dequeues the command if still queued, or cancels the pending request if
> this connection owns the in-flight create command. CIS uses the same
> path via the existing HCI_CONN_CREATE_CIS flag.
>
> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting =
connections")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_conn.c         | 21 ++----------
>  net/bluetooth/hci_sync.c         | 58 +++++++++++++++++++++++++-------
>  3 files changed, 50 insertions(+), 30 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index aa600fbf9a53..c90ca6173680 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -988,6 +988,7 @@ enum {
>         HCI_CONN_AUTH_FAILURE,
>         HCI_CONN_PER_ADV,
>         HCI_CONN_BIG_CREATED,
> +       HCI_CONN_CREATE_CONN,

Use just HCI_CONN_CREATE

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
> index df23245d6ccd..08917b8167de 100644
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
> +       set_bit(HCI_CONN_CREATE_CONN, &conn->flags);
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
> +       clear_bit(HCI_CONN_CREATE_CONN, &conn->flags);
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
> +       set_bit(HCI_CONN_CREATE_CONN, &conn->flags);
> +
> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> +                                      sizeof(cp), &cp,
> +                                      HCI_EV_CONN_COMPLETE,
> +                                      conn->conn_timeout, NULL);
> +
> +       clear_bit(HCI_CONN_CREATE_CONN, &conn->flags);
> +
> +       return err;
>  }
>
>  int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
> @@ -7039,20 +7056,37 @@ int hci_connect_le_sync(struct hci_dev *hdev, str=
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
> +               create_flag =3D HCI_CONN_CREATE_CONN;
> +               break;
>         case LE_LINK:
> -               return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_con=
n_sync,
> -                                                 conn, create_le_conn_co=
mplete);
> +               func =3D hci_le_create_conn_sync;
> +               destroy =3D create_le_conn_complete;
> +               create_flag =3D HCI_CONN_CREATE_CONN;
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
> +       if (func && hci_cmd_sync_dequeue_once(hdev, func, conn, destroy))
> +               return 0;
> +
> +       if (create_flag >=3D 0 && test_bit(create_flag, &conn->flags))
> +               hci_cmd_sync_cancel(hdev, ECANCELED);

Hmm, I'm not sure I like how this is done here, it seems to always
attempt to dequeue even if the flag indicates it is pending. If that
is intentional, you should add a comment.

> +       return -EBUSY;
>  }
>
>  int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
