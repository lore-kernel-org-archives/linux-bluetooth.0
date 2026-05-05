Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6CC401A2D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977576; cv=pass; b=SepgMLBsbKokSwJwpV/R2m+RJMY4EUa0At3cBve9TRbFWasR+icG48NdnfM0i8y4yN/W98j1AoaMttBCV+YBoMqIC6Y8zUUARHe5c3s6mWoayJMspQFnYBp7Wp9buMOtJv0TTkaiRqDhjDJalmN4Mr1cpI/TyRiE8+R2vIaGu/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977576; c=relaxed/simple;
	bh=G8/QXNHoOJdhr7iwKgYpOlvk+FU7njdluGCbiN/eFNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERVEBkrY+GuqBfqSqpjt4UvyvwwUen/x76wzUgL2rI0CQA9vXEqspgcy6+Fr68mByNQdOQMAktouo6SsOAhy0IhbMl1Ew1cM2lHGS4rGc8uti7dKu1CCux+YbkyV+xb0eG+xMDUOUAinW07gv23TVxwqWku6lRi8Xluxrq4Qpkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sw6sbaD6; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sw6sbaD6"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcd89701acso4894975a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 03:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777977574; cv=none;
        d=google.com; s=arc-20240605;
        b=aL2rJ/8x672cJ3x4AnmkDUjtNTP8iIXw97UZQiNKGjMaOfK58OrrD4lC830kvVEvBU
         AiAysPyGOu4EcOfyDhxgIxj6qaDzhFHdpKE2NMmzpNs5VQ3GISByc7so/A8BF7pPV68G
         v1D587l9nG2mTdQkNczB+zBD8oFvtOPzQ7EGRft0/XiO00lgxqux93phbdj/Pd44g4DK
         dAIUOmkVn85AXEMxav7SP9HPKrK4GMrxo51iZCWsxeMQ6A4NPAkCSloWaANqe3SYrcKs
         CUdfRJSSSZ+JZlp2bfMXoCc1dvOV9ATxxsWcohyPEKe2iN2GZ996HDIj5FhVEmNrNM2S
         a+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xDzjzL8gZ7X54K8pHi6J8ue7/39rZS9Miu6+5MDCb68=;
        fh=gl5av412S7EMb9+DTz180ZfpeatHOLcsubW5jmViPHA=;
        b=cXXWCuicy9pgKUWzqtLCB6nt+ROaqB9ftJlfDNNtobJBv7zrBiH+ixO4iZBeyOrrbP
         3OfGnl+IQTzAG46XtXEbt9tgtmE1cPzF7fvfJ+qeklQVn4w5clGI/n3cdUNy9GNmKQIe
         wfo1ZO+VEaOnpepKAJ9KEE+va8cmjP/+K0gSNM+zY4gsC4vBWNgSsSvj43JAtm8qzlgh
         xfBSBPNhZ+owO8fYJF+4L6UQHp2gD68opCG46TC5BM7Oe7bu2DYSc9jaU5iNAoDhCOXc
         aOrfQmYd/2vUfLUeLcyHIg1Pn92bjQ/OoP0y61q2ZinFvw2WDJgcP3Si1x8Of921dcve
         8pTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777977574; x=1778582374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDzjzL8gZ7X54K8pHi6J8ue7/39rZS9Miu6+5MDCb68=;
        b=sw6sbaD6F2ljtRnjjNaUg516tzJeljiK4tsUL/O6UDcv7bS3aFTPWCnk0NBFNUstEt
         Atog88DxDDxdS3H8NF8F+IaQFfw5thLNE/fig/EOyffoWUVS8oGICUDPey1y5jMMCjl1
         NskzXb2IzuOlj3gFM0xAN50i/2wV3xAUbWinGI7YiBFTmtItm8IPVFVWrHnC7YXpeInP
         BFxLASdD9lAi7NmCSWVIAsfzlm3OByooRC95tFTZ4FRhP5RFwMcCnPUzwq5wzCKSX5Rh
         COg0W3tgWgry8yEgpa+QTbug19n4sJ4R6wn1pqJuSzbxR2u41ZrqWYGkJKumKfcCMb7N
         HROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977574; x=1778582374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDzjzL8gZ7X54K8pHi6J8ue7/39rZS9Miu6+5MDCb68=;
        b=S9M38nXKRu1b3c1DmjCCl+/NppvQhC7f7cgFpQPuZEXf03OOlb6jNkQHHeKhasU0Pz
         FgbDhW4VesHmaJIblPydUofBy31H8xMRViv6AoT8g7lbahFT3J8R1jm7CojSDn3a1hCR
         Ta0r4MuxCxee3ITYTtot0K18rcCIfCJWlU+AJWv0nQBRXRriVLSb6UQb+7FXB8ueamG0
         ad4kikxLiQyuCu5RURXWGBhf4nKNS8AXeXGqK1uTB114Db7I1TnhuDpjLH0ojFNpk8zj
         Yi6doT6pNnMPv3B7MxTX3rMG5YZawZ3U4Oh0+0Jzr73clmZibjcLsfd0u/q+GoFh8KtN
         TwFA==
X-Forwarded-Encrypted: i=1; AFNElJ8WHSgNfDgYeL/Ra/mPUw/WaueYdpY/AURdgfQOH4HPReB5zPPC1OPiD432MuQKRCnGmprqirnWdoRTIq42nGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5MvKepvzr6dsg/tZyzxmQ1VA8V6FhtAvqfGnnJjj6ZPfL13/
	vfHOSiX6du6G747/fywU8SOTKQxK+Jn3SzW3cAZTLiksWwqj5DSmjwIWVdi1TOTTUBfPoBSk8r5
	owzSILeKak0LLugbf6uyo90OMeiWWj1Y=
X-Gm-Gg: AeBDievCHXExYyKu9NF58GCCNJqL6Pw9fzsrzj4ADHEkfTmkIgh1NgLdeVUse3Y1H3u
	0ossWw6vDSN2t+xOVr2FyY8L4Bg4bU99yVc4osNgCuJo8tikYPj+zjHaaNWqGS4WUxFhTgEWQuE
	qZ57A+6IbBO7gMohiUmk6/zihj7/x2XWNQLk5Vwxj1DqgbchD9IK2eHslWz5fVc9yBVfob8fA77
	GOKuRgR6anlwvmr58FB1LQ7rmvliRl02Cl/xdly7nyc9eZthQGLItZB8iCTqPM9WadVLwODMjEh
	tydNMihozevtiV+JdDaUx2NcY+4aq04=
X-Received: by 2002:a05:6830:3817:b0:7dc:db04:d316 with SMTP id
 46e09a7af769-7dee1290592mr7625092a34.8.1777977573855; Tue, 05 May 2026
 03:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414215237.17791-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260414215237.17791-1-mikhail.v.gavrilov@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 5 May 2026 15:39:22 +0500
X-Gm-Features: AVHnY4KPyS0YEZXg3cyLHxvSMsJkmwJec4eTCmul400NUSUo-P0cj2PVpMEohL0
Message-ID: <CABXGCsOnsqL6-6boHSkaXdjAnpwfyhK7d_poNRFftTnH43Dhdg@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
To: luiz.dentz@gmail.com, marcel@holtmann.org
Cc: pav@iki.fi, pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 2:53=E2=80=AFAM Mikhail Gavrilov
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
> removed while the work was pending.  The hci_dev_lock is held across
> hci_conn_valid() and all conn field accesses to prevent a concurrent
> disconnect from invalidating the connection mid-use.
>
> Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in=
 connection params")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>
> Changes in v5 (Pauli Virtanen, Luiz Augusto von Dentz):
> - Keep hci_dev_lock held across hci_conn_valid() and all conn field reads
>   (including conn->handle) to close the race window noted by Pauli
> - Use conn->conn_timeout instead of HCI_CMD_TIMEOUT for the sync wait,
>   matching hci_le_create_conn_sync() pattern
>
> Changes in v4 (Luiz Augusto von Dentz, Sashiko/Gemini AI review):
> - Use hci_conn_get()/hci_conn_put() to hold a reference while work is que=
ued
> - Use __hci_cmd_sync_status_sk() to wait for HCI_EV_LE_CONN_UPDATE_COMPLE=
TE,
>   then do params update + mgmt notification in the sync callback
> - Use kzalloc_obj() per checkpatch recommendation
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
>  include/net/bluetooth/hci_core.h |   2 +-
>  net/bluetooth/hci_conn.c         | 105 +++++++++++++++++++++++++------
>  net/bluetooth/l2cap_core.c       |  12 +---
>  3 files changed, 89 insertions(+), 30 deletions(-)
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
> index 11d3ad8d2551..fea0764b8ba3 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -480,40 +480,107 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 h=
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
> +       u16 timeout;
> +       u8 store_hint;
> +       int err;
>
> +       /* Verify connection is still alive and read conn fields under
> +        * the same lock to prevent a concurrent disconnect from freeing
> +        * or reusing the connection while we build the HCI command.
> +        */
>         hci_dev_lock(hdev);
>
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
>
> -       hci_dev_unlock(hdev);
> -
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
> +       timeout                 =3D conn->conn_timeout;
> +
> +       hci_dev_unlock(hdev);
> +
> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CONN_UPDATE,
> +                                      sizeof(cp), &cp,
> +                                      HCI_EV_LE_CONN_UPDATE_COMPLETE,
> +                                      timeout, NULL);
> +       if (err)
> +               return err;
> +
> +       /* Update stored connection parameters after the controller has
> +        * confirmed the update via the LE Connection Update Complete eve=
nt.
> +        */
> +       hci_dev_lock(hdev);
> +
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
> -       hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
> +       hci_dev_unlock(hdev);
>
> -       if (params)
> -               return 0x01;
> +       mgmt_new_conn_param(hdev, &conn->dst, conn->dst_type, store_hint,
> +                           d->min, d->max, d->latency, d->to_multiplier)=
;
>
> -       return 0x00;
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
>

Hi Luiz,

Gentle ping on this patch.  The v5 addresses the review comments from
you and Pauli (extended lock scope around hci_conn_valid + conn field
reads, conn->conn_timeout for the sync wait).  CI is clean aside from
the usual pre-existing failures.

Is there anything else that needs to be changed?

--=20
Thanks,
Mikhail
