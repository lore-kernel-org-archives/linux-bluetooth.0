Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7218DF62
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912975; cv=none; b=bdqp/twb0rLRT1Az70tn5Nkn1jfGFoJl2XgeSsyUjGtBtuO1dtnEf71wil/+OYStZoRfFjZgbcRnRj2tHsiZxRRhw51nWDcKJgjG8bgm/fLpFVyYiuyAFBcIROfp06NOeodeECHNQy01c1j2Z6x8791RFYHpP37UDXokhYeEw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912975; c=relaxed/simple;
	bh=DF42UXqdlsYejBcj9OH9196nEZaXi9Ssz8HoK0g2y+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Beb3YTmszEz85rBYr5QANmj2Mz3DVEWkkVE2M54KjqxkR3ljeSUjmcA7fsQVWDIAb2QUhNP7wNGmlPbb22FeSdpd4rvn+gwDPhz1pbJ16OsljtQoxPxKZYk15Po0ijjtNnG/qH4QQkOQ6QGUayDdUukkaTk3a9GGMwkYAlWZg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVEJkstP; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVEJkstP"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32f1763673cso27982851fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751912971; x=1752517771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0enJqYcR2VD/x3PF/GP8oxmq2TC1Q8uZDBdicLVx5o=;
        b=eVEJkstPqoIfOGd2szxgQH7R+LdpKT8Wd2qTsSz84HvgUhXv2Y7UE3z63lwUHO2lXC
         QJsI9aWqyjadlD39l0NAdxdxCxCBquGmPEbV/3ezbF28JJVtyFXyHwsYFPNLqufeeOxQ
         a2rFDMVK5Q60eK+C5q6okKZGkwuf2ucQk/aarWUBj4wXwC6beOQJxs3Yd5iN2sKIX0M8
         e1aPcuJmKRCKz9/a8w0rJjJSzP1cclvJ3CsRnXstMNMg267PkUMgWuQWFulJlAL42jEL
         zajHTN+0ItKcSyQqxeKWgmsJozBRg5r9HySv/41lSXkmJDlx1Kqyur4kbM1ApO0vbR1s
         8cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751912971; x=1752517771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0enJqYcR2VD/x3PF/GP8oxmq2TC1Q8uZDBdicLVx5o=;
        b=TrJM3ZyxAnzi4r1vvgbvZ3vubnty4b8VFXS4Is6Ffe+OjzaofHgwgrvUttKFwhY9Lv
         Os9qCmvv/P6DMoropJYqW1xYJ100l5v7ff3dXvdHcGpVvl0iZ0ZXkyZaaRtYrQ1ZTu9Q
         kynXElEpFN9DXJQC/Ye/G14GI/Bv3AMj6RUAwfXmS/P0XJM2vyLIt8nRurbgRiHm+iI2
         E3EBqHi+HO6PrQaqGEK53v2tvD6486f4rHiwjFZWBWfJ+SMao10xo8IwNfFcYTO564xx
         jG7XW0aqnrZhz+tMiKmvtFxsjXksefVci23Qup260YNGTLQ07iU3jZjVbwt8AuPW1Fla
         OmGQ==
X-Gm-Message-State: AOJu0Yy4lzeSu6yfXiIKryuAE791d08sC7wJwQN3r8q2BY3iyw4b0ez8
	YqhVWMvYXT3sPrjx0Byf456D2juaYd2x6CFkrABHtqKz4i0PXqMyk8prlXJFYSLqHG4pbROxSh8
	PapDDr9kwA+6CMsSQAJa85BnIN5yUMYc=
X-Gm-Gg: ASbGnctO7V0vfsR6Iy2rc9dBL7JJrBuP1z22rN5LX3wsGBxQEgXTwCmM5f4wS36rRAN
	Y/v8mP2umeSSzcTSN+co+81rCsLyin/Myuj29PL45095rnkNx93309qYU4tCPmZWuLdPMdxS/jf
	Nvc0jwxJ36mg1FyL7wNGaWBoJwmztVbHZw2GyqwZXvSQ==
X-Google-Smtp-Source: AGHT+IHY05aBkmmuiLLmooJrsrmRj9QeiwyfT+9/LJ/SGdBcw2qMz+tS4EAdbhNg+VaaHyBqdIaU8gQx9DVZQL6kYSI=
X-Received: by 2002:a05:651c:4114:b0:32b:8778:6f0a with SMTP id
 38308e7fff4ca-32f092e51bcmr25375841fa.27.1751912970828; Mon, 07 Jul 2025
 11:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627030229.1720287-1-quic_shuaz@quicinc.com>
In-Reply-To: <20250627030229.1720287-1-quic_shuaz@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Jul 2025 14:29:18 -0400
X-Gm-Features: Ac12FXyf1XY4X5aDSUCX2bnARnxJbzm_o0mSA61I5Zo9X5PHK19JWkIjofyhoyk
Message-ID: <CABBYNZK2GqH0__beG1D6PemARXmsMpYxjkJrJLktqP4Keix31w@mail.gmail.com>
Subject: Re: [PATCH v1] net: bluetooth: add callback to exe l2cap when
 read_security uncompleted
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_bt@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Thu, Jun 26, 2025 at 11:04=E2=80=AFPM Shuai Zhang <quic_shuaz@quicinc.co=
m> wrote:
>
> When the DUT receives a remote L2CAP Connection Request during the Read
> Encryption Key Size procedure, if it fails to complete reading the
> Encryption Key Size while processing the request, it will respond with
> a Connection Response =E2=80=93 Refused (security block), resulting in th=
e
> disconnection of the remote device.
>
> Use HCI_CONN_ENC_KEY_READY to determine whether
> l2cap_connect_request is pending.
>
> When l2cap_connect occurs before the read_enc_key_size event, it will
> be pending because HCI_CONN_ENC_KEY_READY has not yet been set.
> The connection request will be processed once the read_enc_key_size
> event completes.
>
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  include/net/bluetooth/hci_core.h |  3 +++
>  include/net/bluetooth/l2cap.h    | 10 +++++++++-
>  net/bluetooth/hci_event.c        | 16 ++++++++++++++++
>  net/bluetooth/l2cap_core.c       | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index b47c74080..db329abbf 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -767,6 +767,8 @@ struct hci_conn {
>
>         struct bt_codec codec;
>
> +       struct l2cap_pending_connect *pending_connect;

We have rx_queue for deferring packets, we may need to extend that to
store requests to channels that require encryption.

>         void (*connect_cfm_cb)  (struct hci_conn *conn, u8 status);
>         void (*security_cfm_cb) (struct hci_conn *conn, u8 status);
>         void (*disconn_cfm_cb)  (struct hci_conn *conn, u8 reason);
> @@ -970,6 +972,7 @@ enum {
>         HCI_CONN_CREATE_PA_SYNC,
>         HCI_CONN_PA_SYNC,
>         HCI_CONN_PA_SYNC_FAILED,
> +       HCI_CONN_ENC_KEY_READY,
>  };
>
>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 4bb0eaedd..b1ccd56bd 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -679,6 +679,13 @@ struct l2cap_user {
>         void (*remove) (struct l2cap_conn *conn, struct l2cap_user *user)=
;
>  };
>
> +struct l2cap_pending_connect {
> +       struct l2cap_conn *conn;
> +       struct l2cap_cmd_hdr cmd;
> +       u8 data[sizeof(struct l2cap_conn_req)];
> +       u8 rsp_code;
> +};
> +
>  #define L2CAP_INFO_CL_MTU_REQ_SENT     0x01
>  #define L2CAP_INFO_FEAT_MASK_REQ_SENT  0x04
>  #define L2CAP_INFO_FEAT_MASK_REQ_DONE  0x08
> @@ -976,5 +983,6 @@ void l2cap_conn_put(struct l2cap_conn *conn);
>
>  int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user=
);
>  void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *u=
ser);
> -
> +void l2cap_process_pending_connect(struct l2cap_conn *conn,
> +                                  struct l2cap_cmd_hdr *cmd, u8 *data, u=
8 rsp_code);
>  #endif /* __L2CAP_H */
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c4b87bfb4..6c992f83e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -32,6 +32,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/mgmt.h>
> +#include <net/bluetooth/l2cap.h>
>
>  #include "hci_debugfs.h"
>  #include "hci_codec.h"
> @@ -766,10 +767,23 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *=
hdev, void *data,
>                 /* Update the key encryption size with the connection one=
 */
>                 if (key_enc_size && *key_enc_size !=3D conn->enc_key_size=
)
>                         *key_enc_size =3D conn->enc_key_size;
> +               set_bit(HCI_CONN_ENC_KEY_READY, &conn->flags);
>         }
>
>         hci_encrypt_cfm(conn, status);
>
> +       /*Defer l2cap_connect here if it's triggered before key size is r=
ead.*/
> +       if (conn->pending_connect) {
> +               struct l2cap_pending_connect *pc =3D conn->pending_connec=
t;
> +
> +               conn->pending_connect =3D NULL;
> +
> +               bt_dev_dbg(hdev, "Defer l2cap_connect");
> +               l2cap_process_pending_connect(pc->conn, &pc->cmd, pc->dat=
a, pc->rsp_code);
> +
> +               kfree(pc);
> +       }
> +
>  done:
>         hci_dev_unlock(hdev);
>
> @@ -3396,6 +3410,8 @@ static void hci_disconn_complete_evt(struct hci_dev=
 *hdev, void *data,
>         if (!conn)
>                 goto unlock;
>
> +       clear_bit(HCI_CONN_ENC_KEY_READY, &conn->flags);
> +
>         if (ev->status) {
>                 mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>                                        conn->dst_type, ev->status);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 40daa3827..c4cb60e65 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3982,6 +3982,30 @@ static void l2cap_connect(struct l2cap_conn *conn,=
 struct l2cap_cmd_hdr *cmd,
>         struct l2cap_chan *chan =3D NULL, *pchan =3D NULL;
>         int result, status =3D L2CAP_CS_NO_INFO;
>
> +       /* If encryption is requested, but the key size is not ready yet,
> +        * we need to wait for the key size to be ready before we can
> +        * proceed with the connection. We do this by deferring the
> +        * connection request until the key size is ready. This is done
> +        * by storing the connection request in the hcon->pending_connect
> +        * field. The connection request will be retried when the key siz=
e
> +        * is ready.
> +        */

This should have been resolved by
https://github.com/bluez/bluetooth-next/commit/c82b6357a5465a3222780ac5d3ed=
cdfb02208cc3:

    /* If the key enc_size is already known, use it as conn->enc_key_size,
     * otherwise use hdev->min_enc_key_size so the likes of
     * l2cap_check_enc_key_size don't fail while waiting for
     * HCI_OP_READ_ENC_KEY_SIZE response.
     */
    if (key_enc_size && *key_enc_size)
        conn->enc_key_size =3D *key_enc_size;
    else
        conn->enc_key_size =3D hdev->min_enc_key_size;

This will use the hci_conn_key_enc_size, then on the command reply we do:

        /* Attempt to check if the key size is too small or if it has
         * been downgraded from the last time it was stored as part of
         * the link_key.
         */
        if (conn->enc_key_size < hdev->min_enc_key_size ||
            (key_enc_size && conn->enc_key_size < *key_enc_size)) {
            /* As slave role, the conn->state has been set to
             * BT_CONNECTED and l2cap conn req might not be received
             * yet, at this moment the l2cap layer almost does
             * nothing with the non-zero status.
             * So we also clear encrypt related bits, and then the
             * handler of l2cap conn req will get the right secure
             * state at a later time.
             */
            status =3D HCI_ERROR_AUTH_FAILURE;
            clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
            clear_bit(HCI_CONN_AES_CCM, &conn->flags);
        }

> +       if (test_bit(HCI_CONN_ENCRYPT, &conn->hcon->flags) &&
> +           !test_bit(HCI_CONN_ENC_KEY_READY, &conn->hcon->flags)) {
> +               struct l2cap_pending_connect *pc;
> +
> +               pc =3D kzalloc(sizeof(*pc), GFP_KERNEL);
> +               if (!pc)
> +                       return;
> +               pc->conn =3D conn;
> +               memcpy(&pc->cmd, cmd, sizeof(*cmd));
> +               memcpy(pc->data, data, sizeof(struct l2cap_conn_req));
> +               pc->rsp_code =3D rsp_code;
> +               BT_DBG("store request and retried when keysize is ready")=
;
> +               conn->hcon->pending_connect =3D pc;
> +               return;
> +       }
> +
>         u16 dcid =3D 0, scid =3D __le16_to_cpu(req->scid);
>         __le16 psm =3D req->psm;
>
> @@ -4105,6 +4129,12 @@ static void l2cap_connect(struct l2cap_conn *conn,=
 struct l2cap_cmd_hdr *cmd,
>         l2cap_chan_put(pchan);
>  }
>
> +void l2cap_process_pending_connect(struct l2cap_conn *conn, struct l2cap=
_cmd_hdr *cmd,
> +                                  u8 *data, u8 rsp_code)
> +{
> +       l2cap_connect(conn, cmd, data, rsp_code);
> +}
> +
>  static int l2cap_connect_req(struct l2cap_conn *conn,
>                              struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *=
data)
>  {
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
