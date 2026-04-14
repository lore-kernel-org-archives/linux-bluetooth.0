Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30E318ED6
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198485; cv=pass; b=lh7qRLheEfSyi8mZkUvuo4HfWndAmc4yvAZGoB3Ct7wjeEjTLUcGTPY0bw7JkmnuGo1mSTG8vAxINBQXLNc+dqKf/3pUNZL/3jtSEYsC39TGazNHXM9vuBxGZTlrBzjw2VVRi/wzCNoHVeZhno8pGdtkSiQY8ddH+J4MEJ0v0ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198485; c=relaxed/simple;
	bh=/jgTCTZ3Y6Q6exHssGXP2OKlt8MYJ891LLphLMWIyxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRBJ+Ba/KUKKpN9GFFEEHpIHHgELS8Xc7ouGBlCSEv1Y/ufK1P8LRBY64A/apG/C2fd5sbh0h4VDDh1TliEHJ9KLeZlrqLdFQsCUMIYl4BTS+SCbXxw3Truu+/lT/hDuuCPcLNSw5PpqvfsF9/GV0BDivYO+E2juOzdLYd9cpz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS0KYxGd; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS0KYxGd"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-68a5e7b5b52so2507114eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 13:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776198482; cv=none;
        d=google.com; s=arc-20240605;
        b=PWolxKxlV4AbAi1a7GYPFOk1XTik5xfSE1Tx0ZgX4PVF4WpDOrjg1HDCv/Hw27R/PB
         vt9rZRe2oYfSDnaSmuqJeZfyCqke4yMcfzm6X8cXTcsXfqcJXhpoIfAXxmnms7NVuQ3E
         Svk6AZ1TQKfcrRR2sSuJfE5IFXcrCkXY+RPVkH3LUWeGpsJURxHz53FgZDqGY7rSrGYw
         GCNS407F9Pp4PIXrBnjfu5GMOFTy2p3hnpcIZoBUArx2OF8OKZ4ffELCL9XoSgkPIHEx
         s/HB+KBdeRGf96IsF/JqIy2Rp3+a6w93C/8dSDVn5AYla28n42p/B8jkjBCcB3iGo1Xm
         ZTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RjNUqJWOiNchf1uF/yrT7h11uIVZt99SuWpLk2hgabE=;
        fh=8ib3TyAz0fXgExTQ+re4jrDu0BOWtGH4qvQrPQcWE6E=;
        b=V4dT58pJyA4xhyBalKJV7za19Q/xebGEtZwS/m7jert4WugLxXmjUfzeegSd1laxoo
         3vTROz/mZzBGkZk43ESFuJDBWDF0jSarq2coS9cdFXotFy5ayWmlWqruKcUsvVO9KiDc
         5ItRGlS65/c6Pzvfi3lunA6cl/CS7z9NjH3D3hV155+fb+XMg1454H+BHqg9yri4qHdP
         m66IGtFH78YrPUp4KIDzLJnNLFjapwsFMKEaGoxBlB/ISznbmyW7vezALm6pk2ovdzLy
         1Q7Al+JGmXYKVnflmEGEY/q7A2LF0aJeQUNOk29Qk0lMzxlGTRbEyuDIb44Tvp2Y8Vnd
         GNNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776198482; x=1776803282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjNUqJWOiNchf1uF/yrT7h11uIVZt99SuWpLk2hgabE=;
        b=CS0KYxGdaTNpe0VDzNtPmCjCbalXxPi+kdABPSDWN9maQL6gl1OIVWrRqx85KfsXIr
         QkTwwFdIHvnlRKcw06maQ0lvyvz0KXVzZNsVXR6w/mq0vSzxOdam1Sl5CS95LtzbCgiA
         kY/zgHKhhsY/n0ai7L1yRZnqxMlBQBNqAaH5KO3EzB6pAB/PLyGQRXR6/3xZ35J6L+Gl
         kTn0klVwTMV23N+8EsI7Zatn4ohbf0WLYm3oJUaA6daLJDkxL0/t59GSC4o5MH+zq/t6
         Amuj9URjXEsffJc3ZcVz9X+dRxhrwfPO7Pn2ZMZMOOrwFet6KRzhD2j1ceR2b/q72SXk
         XskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776198482; x=1776803282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RjNUqJWOiNchf1uF/yrT7h11uIVZt99SuWpLk2hgabE=;
        b=tE9kDe6m5maPYuHEI/652NBFYxYRlTJvLoT92oT8RsD0f5CzOcS3hTD4rFoQdJEOCr
         YtXpl+2VOzobE8CTdPm9M4AQD+jgBAuVcwVgZb6FR/Vu77ehN1D0VL+u1nol+x6ppoYD
         FH1KPJVD+KXTwqOcLfaM8tBDefD5VeqCSlx8COq9oXReZN55dqB4VV3qDblGCBgukUqp
         +xa0J/C9Sv8bkWqYzr2xFivawxRe8nkoU3fYZLOsf1OyEW4ARbFhWlReNvrc0Od09EvD
         qGo8eR6PZimslqhUUOPgvKnddKYGRhYWguIqKtJicOA4wFeqd5bTf2GcRu2SgUx+Mw84
         DZdw==
X-Forwarded-Encrypted: i=1; AFNElJ/N/cF9JS51md3FSEOlkAzDXj0zi/Xpv25rFrPO4SK+fVcwUQ/WNrbADNhU02lbjI6is7pilxSLa1LUon5GEM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6rNRhYbC8LAi+Tv2++fJlCQHMZf5D8gKlj3ULj/FUTXfMGY8
	bfuaDHc9fStArT/YzBBm+83ol0EHCjkVEWYWiHces0agUGRwA3wWIAUPKtGn7hVLak4ee1slkgT
	kZt32lnlkt4oy8bNx8g0nHSfr217Vx/g=
X-Gm-Gg: AeBDievd9kMqEUimI9qrIYmyO+3CfSoWQYuYctUc4pK7jT1D6t/PiteTAgsza9MmN3v
	t/6IsAZMsD+984OwYqMRn3qOCy4rmpI7Jfs+E9R3eszbmihpdeViBFSphtxs/yaGo7jAkjTQxyH
	jQ8qj8MRr9LpF8Uqzfjbd+459xAY3pUGEjcKHpfLkDi30z17r7MsKgBUvxkCLXIVR3UGJnE0h5q
	ooYZxR7gDywgU9CNJOlv54sWQOH/zIOPH44e3xYNcF0AOpVWMlLsRMSU/lM9lYEOc5nscckJfw0
	uSAcnc/jp0hqW7Al1wtXkfOxhDv5+MpCYSov0K8rOIYNr9/GQK5xumU2SepDzVY6unCcFYfFq0f
	I3w==
X-Received: by 2002:a05:6820:c091:b0:688:29ff:2ddc with SMTP id
 006d021491bc7-68a6b265d74mr8476443eaf.38.1776198482516; Tue, 14 Apr 2026
 13:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414184415.17114-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260414184415.17114-1-mikhail.v.gavrilov@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Apr 2026 16:27:50 -0400
X-Gm-Features: AQROBzAcc-U_-PMtrzOcIXseHypcMsJSxrI5JcZFjdTHNltydWWQ5HPDBMBM1wA
Message-ID: <CABBYNZJpJC4hUpQS-JNAXTG0OvpMeuFZ8n8kREuNf_DdLi-qEw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: marcel@holtmann.org, pmenzel@molgen.mpg.de, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On Tue, Apr 14, 2026 at 2:44=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> When a BLE peripheral sends an L2CAP Connection Parameter Update Request
> the processing path is:
>
>   process_pending_rx()          [takes conn->lock]
>     l2cap_le_sig_channel()
>       l2cap_conn_param_update_req()
>         hci_le_conn_update()    [takes hdev->lock]
>
> Meanwhile other code paths take the locks in the opposite order:
>
>   l2cap_chan_connect()          [takes hdev->lock]
>     ...
>       mutex_lock(&conn->lock)
>
>   l2cap_conn_ready()            [hdev->lock via hci_cb_list_lock]
>     ...
>       mutex_lock(&conn->lock)
>
> This is a classic AB/BA deadlock which lockdep reports as a circular
> locking dependency when connecting a BLE MIDI keyboard (Carry-On FC-49).
>
> Fix this by making hci_le_conn_update() defer the HCI command through
> hci_cmd_sync_queue() so it no longer needs to take hdev->lock in the
> caller context.  The sync callback uses __hci_cmd_sync_status_sk() to
> wait for the HCI_EV_LE_CONN_UPDATE_COMPLETE event, then updates the
> stored connection parameters (hci_conn_params) and notifies userspace
> (mgmt_new_conn_param) only after the controller has confirmed the update.
>
> A reference on hci_conn is held via hci_conn_get()/hci_conn_put() for
> the lifetime of the queued work to prevent use-after-free, and
> hci_conn_valid() is checked before proceeding in case the connection was
> removed while the work was pending.
>
> Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in=
 connection params")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>
> Changes in v4 (Luiz Augusto von Dentz, Sashiko/Gemini AI review):
> - Use hci_conn_get()/hci_conn_put() to hold a reference while work is que=
ued
> - Use __hci_cmd_sync_status_sk() to wait for HCI_EV_LE_CONN_UPDATE_COMPLE=
TE,
>   then do params update + mgmt notification in the sync callback =E2=80=
=94 removes the
>   need for hci_event.c changes and hci_sent_cmd_data()
> - Use kzalloc_obj() per checkpatch recommendation
> - Fix checkpatch alignment issues
>
> Changes in v3 (Luiz Augusto von Dentz):
> - Move hci_cmd_sync_queue into hci_le_conn_update itself instead of open-=
coding
>   the deferral in l2cap_core.c
> - Move conn_params update and mgmt_new_conn_param into
>   hci_le_conn_update_complete_evt, using hci_sent_cmd_data to retrieve
>   the originally requested parameters
>
> Changes in v2 (Paul Menzel, Sashiko/Gemini AI review):
> - Allocate before sending ACCEPTED response to avoid state mismatch on OO=
M
> - Verify connection handle and address in sync callback against reuse rac=
e
> - Expand commit message with implementation details
>
>  include/net/bluetooth/hci_core.h |  2 +-
>  net/bluetooth/hci_conn.c         | 98 +++++++++++++++++++++++++-------
>  net/bluetooth/l2cap_core.c       | 12 +---
>  3 files changed, 82 insertions(+), 30 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index a7bffb908c1e..aa600fbf9a53 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2495,7 +2495,7 @@ void mgmt_adv_monitor_device_lost(struct hci_dev *h=
dev, u16 handle,
>                                   bdaddr_t *bdaddr, u8 addr_type);
>
>  int hci_abort_conn(struct hci_conn *conn, u8 reason);
> -u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 laten=
cy,
> +void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 lat=
ency,
>                       u16 to_multiplier);
>  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
>                       __u8 ltk[16], __u8 key_size);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 11d3ad8d2551..c9cc18fab1f2 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -480,40 +480,100 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 h=
andle)
>         return hci_setup_sync_conn(conn, handle);
>  }
>
> -u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 laten=
cy,
> -                     u16 to_multiplier)
> +struct le_conn_update_data {
> +       struct hci_conn *conn;
> +       u16     min;
> +       u16     max;
> +       u16     latency;
> +       u16     to_multiplier;
> +};
> +
> +static int le_conn_update_sync(struct hci_dev *hdev, void *data)
>  {
> -       struct hci_dev *hdev =3D conn->hdev;
> +       struct le_conn_update_data *d =3D data;
> +       struct hci_conn *conn =3D d->conn;
>         struct hci_conn_params *params;
>         struct hci_cp_le_conn_update cp;
> +       u8 store_hint;
> +       int err;
>
> +       /* Verify connection is still alive. */
>         hci_dev_lock(hdev);
> -
> -       params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_typ=
e);
> -       if (params) {
> -               params->conn_min_interval =3D min;
> -               params->conn_max_interval =3D max;
> -               params->conn_latency =3D latency;
> -               params->supervision_timeout =3D to_multiplier;
> +       if (!hci_conn_valid(hdev, conn)) {
> +               hci_dev_unlock(hdev);
> +               return -ECANCELED;
>         }
> -
>         hci_dev_unlock(hdev);
>
>         memset(&cp, 0, sizeof(cp));
>         cp.handle               =3D cpu_to_le16(conn->handle);
> -       cp.conn_interval_min    =3D cpu_to_le16(min);
> -       cp.conn_interval_max    =3D cpu_to_le16(max);
> -       cp.conn_latency         =3D cpu_to_le16(latency);
> -       cp.supervision_timeout  =3D cpu_to_le16(to_multiplier);
> +       cp.conn_interval_min    =3D cpu_to_le16(d->min);
> +       cp.conn_interval_max    =3D cpu_to_le16(d->max);
> +       cp.conn_latency         =3D cpu_to_le16(d->latency);
> +       cp.supervision_timeout  =3D cpu_to_le16(d->to_multiplier);
>         cp.min_ce_len           =3D cpu_to_le16(0x0000);
>         cp.max_ce_len           =3D cpu_to_le16(0x0000);
>
> -       hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CONN_UPDATE,
> +                                      sizeof(cp), &cp,
> +                                      HCI_EV_LE_CONN_UPDATE_COMPLETE,
> +                                      HCI_CMD_TIMEOUT, NULL);
> +       if (err)
> +               return err;
> +
> +       /* Update stored connection parameters after the controller has
> +        * confirmed the update via the LE Connection Update Complete eve=
nt.
> +        */
> +       hci_dev_lock(hdev);
>
> -       if (params)
> -               return 0x01;
> +       params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_typ=
e);
> +       if (params) {
> +               params->conn_min_interval =3D d->min;
> +               params->conn_max_interval =3D d->max;
> +               params->conn_latency =3D d->latency;
> +               params->supervision_timeout =3D d->to_multiplier;
> +               store_hint =3D 0x01;
> +       } else {
> +               store_hint =3D 0x00;
> +       }
>
> -       return 0x00;
> +       hci_dev_unlock(hdev);
> +
> +       mgmt_new_conn_param(hdev, &conn->dst, conn->dst_type, store_hint,
> +                           d->min, d->max, d->latency, d->to_multiplier)=
;
> +
> +       return 0;
> +}
> +
> +static void le_conn_update_complete(struct hci_dev *hdev, void *data, in=
t err)
> +{
> +       struct le_conn_update_data *d =3D data;
> +
> +       hci_conn_put(d->conn);
> +       kfree(d);
> +}
> +
> +void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 lat=
ency,
> +                       u16 to_multiplier)
> +{
> +       struct le_conn_update_data *d;
> +
> +       d =3D kzalloc_obj(*d);
> +       if (!d)
> +               return;
> +
> +       hci_conn_get(conn);
> +       d->conn =3D conn;
> +       d->min =3D min;
> +       d->max =3D max;
> +       d->latency =3D latency;
> +       d->to_multiplier =3D to_multiplier;
> +
> +       if (hci_cmd_sync_queue(conn->hdev, le_conn_update_sync, d,
> +                              le_conn_update_complete) < 0) {
> +               hci_conn_put(conn);
> +               kfree(d);
> +       }
>  }
>
>  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..aac2db1d6fbb 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4706,16 +4706,8 @@ static inline int l2cap_conn_param_update_req(stru=
ct l2cap_conn *conn,
>         l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
>                        sizeof(rsp), &rsp);
>
> -       if (!err) {
> -               u8 store_hint;
> -
> -               store_hint =3D hci_le_conn_update(hcon, min, max, latency=
,
> -                                               to_multiplier);
> -               mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_typ=
e,
> -                                   store_hint, min, max, latency,
> -                                   to_multiplier);
> -
> -       }
> +       if (!err)
> +               hci_le_conn_update(hcon, min, max, latency, to_multiplier=
);
>
>         return 0;
>  }
> --
> 2.53.0

https://sashiko.dev/#/patchset/20260414184415.17114-1-mikhail.v.gavrilov%40=
gmail.com

1. I don't think it really matters because connection intervals are
typically 60ms at most, so 6*60 =3D 360ms. That said, perhaps we should
use 6 * max_interval as the timeout since that is how long the
controller has to update the connection interval, well if the 6
consecutive intervals are actually a thing since I don't recall
anything like that being mentioned in the command, but perhaps it is
in the link layer. But if it times out I don't think there is a way to
cancel the change either, so I'm not sure how we'll be able to
synchronize if the controller misbehaves.
2. Well I guess that is would need to defer the response and wait the
HCI proceedure to complete to really respond properly, but that would
mean the remote could get a LL procedure to change the connection
interval before the L2CAP response, so I can see this going wrong
either way.


--=20
Luiz Augusto von Dentz
