Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A23A4F5A
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109529; cv=pass; b=g9jCgZPN/WzDQdNLmF2t+xMTcCGnfdpG5OdF+IMy693DO58bEbxm0GNxjbb1raa08kCh0f7TYW9JpYh6N0rgeQsjNgHMhX+/KUFvuNvas9oKhhgbfQ2fQccGB4lUVWP9IJix5ogxI62lxGlpCypXNGaRNOY3dobJYr+FLr4bj0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109529; c=relaxed/simple;
	bh=mwV+eTacJkfjnXSjKbsKEWfvVmAtmHBAId2NAHSnOeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta1womZgxJU2zQlbmAVkJ7rJA3FXMJhEXO4WJuxwJyKZoPrI+S/INpgze6Of6WQ+vDUZgj/6G9pifB1OOxK3PFKwOmEgGYqd3ymbTsggLTw4BNK15QJ2046YyzGzWnST160I/93UJX9Kk3vtwA4j8gt0b4Q8VKXlM9uaJ9excv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9otD/o/; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9otD/o/"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651ce2484d5so1428506d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 12:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776109527; cv=none;
        d=google.com; s=arc-20240605;
        b=KksycLX4M2E2dwYvCE2C7PT2MmGWo8lmHCd7yWIIwWmm1tyD+ijf1tHcL0c4Wv3Qv/
         aVLCVv3xrnEE5LhH/AIOy9h1oTRuM75a52PB3622fojMQW0ziZdh9M7SjDTTspyZG1qW
         F2AbUU0HGpfeCM8DhDWk4kaduP/lN3sNt6tSkrTjWV1Fkuit23D2FtmSmJghb+4kphvg
         K6qGY8mRA/n3PIW3fu/lDLLetXhl+W94x7jaeREt2TPDmxOp4est4IL63KgoykO4RWo1
         cMobJkUMEECJkRtK51/BGyAPu7QXhdJg906+NL9wmizs2tjBvAcpuInp+h6V8yQBp3uz
         zTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cgJ+tSGhsDzDvjTmk+LFkKu/pfZJO/ZRGR9MaVyk+/M=;
        fh=8rK2+Ey6Ge7faVNQPlrU/OPEmc4YrIp/EuVaju0iruw=;
        b=hq0GBA0tLquIPj5FPYWM+XSOHTyVyeH52GiVgt7dqRvU/tQuxsA9SNsSa7qdunLaod
         GmNy385i6KzVXiJH1KXtSA/6WEtVnOYquWvK7843N36B5UpIrJ/muR3Uul9qf1RhmPXo
         Lcp8jQguSAdSBCdJSYB3ew144GfLTzpRjRyVwtEIkYZcs8qsZpxXDkkayRwCDqYYFot+
         PzEXV1TD0yc/+NNzeabNbyet3CiVh9EtDjmxDL6c+pGWkJpVA2CHj4StowPSJCh1+Dxq
         DA5Lu1bmg6HdWvOu99Z01CU20DBRmHb8nSPVsvW8suBite9ojuxZSZmYua1zAaCKnqHz
         X+jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776109527; x=1776714327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgJ+tSGhsDzDvjTmk+LFkKu/pfZJO/ZRGR9MaVyk+/M=;
        b=p9otD/o/fIpRFEEEOy5B+ph1RSMQcJSfaCa8MsoWBD8MZRpzPlYjMSusmXMOriVVnw
         vhQvNnfAfeqOJpSOw/fogDPHFf8Qbuf1BG3VsiWb2TKnU+ZvgSDDglfDFJHKlg036Dhb
         wA6iVPoBgG8ZoVBW/MSAMCg4wmsNtc5CFDT82AwvynF4qPPMkoiKxCy/m6vgHP173Mdd
         mba3K3PEbVZFnfyBv3uT06aj0JernZx07MUCOoqgsX5G3LeFAz/r4M1JTWuY2/ZyV33K
         b2JnW5c3DINp6D7Yw1kojNWTweY1dRKWQYp4rBouxVqmEG+Z/ClfMzijAYed2L+jZbsy
         uoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109527; x=1776714327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgJ+tSGhsDzDvjTmk+LFkKu/pfZJO/ZRGR9MaVyk+/M=;
        b=BjOVLJHEaykw3gkxR3K2ioRUXBYd5U7PwAGIq9rjKFD3AaZnTtMTem8hZIbxzLhz/x
         6FTp3cH1BHgWO1kdZzDyE5T+JyG0h2RDmCccO41keldrXzme/mayfCTvifnmlwXi4rg/
         KMM8StjHmhex59gtUnCBzuJpj3MQSX2yCZV5LwhEB0Ec2CqKD/edai+yaSTkyXsL0U1m
         C7vyhYWEj1emR5rLzoen5Bga0L+DuQWMP+Hqrf56XiGcgH/YNnbkf0fL3nDK1AmQbHyT
         PmcTDUQhttzITHKJUgFNjZb4NMhDMuUfMvkobgjRkvYMyVBobpKhionRgabW83T46jjC
         6zjA==
X-Forwarded-Encrypted: i=1; AFNElJ8AuHEsb7SAsG4Fun/vGWiOhFcteOQxSV/TSvSc6CEO+RQE8DYzDzsprd2oso9fFnR2ZCotDnfHNOCphSefaSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXlEcL7RkGHLU5eaW3MkLUQHsWhZC4FD6vTpdaz4V/VWIrcpJ
	I2aplxDYpagoKkk23AMHlx++YT8ljZo9GV/yzm+OYzli2bnbITKQD6HnA6MUkkIg0dbXRBCkS8D
	GrCSRgILNJdua9t7ffVjqyQQ9TPOiFrzORyqwELQ=
X-Gm-Gg: AeBDieuKQZvXF/I9HtEpLcOEZwUOxp2a2Yrd7F9asILVOQazFxlBnnrI2SBxFFoZ66n
	po0ZgPSN4RNu+411MPK6nv7ZUjHx3Wk3QlLd+yevdNZ0vv0+Ub1EpjzoGiigMhSqqD1IeIl1E5E
	o9z0DCjazqWliU5g2ZpqnFWga26XOn9Ce9Ik0gCoFYYJF+Rz6iVaL4MfE7DeWagMf065GCkozbh
	rxuH2inyTlWgK/I3xilGqdje/3V6oxN/8HlHXVtuSKh9TIdPmEfM6foJ2xaAtLJmMKqUAnf2TQR
	mgdrAeWO2o52QJ+swDNnKKSWt2AKWQSnN4F/of5jsoifiCJSnLltRQGiz4PSyPYde6CPCQ==
X-Received: by 2002:a05:690e:1247:b0:651:bd06:e4bf with SMTP id
 956f58d0204a3-651bd06e89emr7544772d50.68.1776109526477; Mon, 13 Apr 2026
 12:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410063001.94728-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260410063001.94728-1-mikhail.v.gavrilov@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 15:45:13 -0400
X-Gm-Features: AQROBzDhTeFfES82O_C3yKDLNagGbyHGV8dATwqcHZi5R1wo6myPX7vJcv11Eb4
Message-ID: <CABBYNZLhjhLCWpO9eyeiCMzNkOt+f7UZw6DssfJ-ADrKV4d-Zg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: marcel@holtmann.org, pmenzel@molgen.mpg.de, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On Fri, Apr 10, 2026 at 2:30=E2=80=AFAM Mikhail Gavrilov
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
> Fix this by introducing l2cap_conn_param_update_sync() which is scheduled
> via hci_cmd_sync_queue() to run on the hci_cmd_sync workqueue, outside
> any of the involved locks.  The necessary connection parameters are
> captured into a heap-allocated struct conn_param_update_data and the
> sync callback performs the hci_conn_params update, sends the HCI LE
> Connection Update command, and notifies mgmt of the new parameters.
>
> To guard against a theoretical handle-reuse race (the connection could
> drop and its handle be reassigned between queuing and execution), the
> sync callback verifies the connection still exists and its destination
> address matches the original request before proceeding.
>
> The allocation is performed before sending the L2CAP_CONN_PARAM_ACCEPTED
> response so that on OOM the peer receives a REJECTED response instead of
> an inconsistent state where the peer applies new parameters but the local
> controller does not.
>
> Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in=
 connection params")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>
> Changes in v2 (Paul Menzel, Sashiko/Gemini AI review):
> - Allocate before sending ACCEPTED response to avoid state mismatch on OO=
M
> - Verify connection handle and address in sync callback against reuse rac=
e
> - Expand commit message with implementation details
>
>  net/bluetooth/l2cap_core.c | 93 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 85 insertions(+), 8 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..94dfef9df498 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4670,6 +4670,70 @@ static inline int l2cap_information_rsp(struct l2c=
ap_conn *conn,
>         return 0;
>  }
>
> +struct conn_param_update_data {
> +       u16     handle;
> +       bdaddr_t dst;
> +       u8      dst_type;
> +       u16     min;
> +       u16     max;
> +       u16     latency;
> +       u16     to_multiplier;
> +};
> +
> +static int l2cap_conn_param_update_sync(struct hci_dev *hdev, void *data=
)
> +{
> +       struct conn_param_update_data *d =3D data;
> +       struct hci_conn *conn;
> +       struct hci_conn_params *params;
> +       struct hci_cp_le_conn_update cp;
> +       u8 store_hint =3D 0x00;
> +
> +       /* Verify the connection is still alive and matches the original
> +        * request, since the handle could theoretically be reused after
> +        * a disconnect/reconnect cycle.
> +        */
> +       hci_dev_lock(hdev);
> +
> +       conn =3D hci_conn_hash_lookup_handle(hdev, d->handle);
> +       if (!conn || bacmp(&conn->dst, &d->dst)) {
> +               hci_dev_unlock(hdev);
> +               return 0;
> +       }
> +
> +       params =3D hci_conn_params_lookup(hdev, &d->dst, d->dst_type);
> +       if (params) {
> +               params->conn_min_interval =3D d->min;
> +               params->conn_max_interval =3D d->max;
> +               params->conn_latency =3D d->latency;
> +               params->supervision_timeout =3D d->to_multiplier;
> +               store_hint =3D 0x01;
> +       }
> +
> +       hci_dev_unlock(hdev);
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.handle               =3D cpu_to_le16(d->handle);
> +       cp.conn_interval_min    =3D cpu_to_le16(d->min);
> +       cp.conn_interval_max    =3D cpu_to_le16(d->max);
> +       cp.conn_latency         =3D cpu_to_le16(d->latency);
> +       cp.supervision_timeout  =3D cpu_to_le16(d->to_multiplier);
> +       cp.min_ce_len           =3D cpu_to_le16(0x0000);
> +       cp.max_ce_len           =3D cpu_to_le16(0x0000);
> +
> +       hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
> +
> +       mgmt_new_conn_param(hdev, &d->dst, d->dst_type, store_hint,
> +                           d->min, d->max, d->latency, d->to_multiplier)=
;

Actually most of this can be defered directly to
hci_event.c:hci_le_conn_update_complete_evt, then use
hci_sent_cmd_data(hdev, HCI_OP_LE_CONN_UPDATE) to fetch the command
parameters.

> +
> +       return 0;
> +}
> +
> +static void l2cap_conn_param_update_destroy(struct hci_dev *hdev, void *=
data,
> +                                           int err)
> +{
> +       kfree(data);
> +}
> +
>  static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
>                                               struct l2cap_cmd_hdr *cmd,
>                                               u16 cmd_len, u8 *data)
> @@ -4677,6 +4741,7 @@ static inline int l2cap_conn_param_update_req(struc=
t l2cap_conn *conn,
>         struct hci_conn *hcon =3D conn->hcon;
>         struct l2cap_conn_param_update_req *req;
>         struct l2cap_conn_param_update_rsp rsp;
> +       struct conn_param_update_data *d;
>         u16 min, max, latency, to_multiplier;
>         int err;
>
> @@ -4703,18 +4768,30 @@ static inline int l2cap_conn_param_update_req(str=
uct l2cap_conn *conn,
>         else
>                 rsp.result =3D cpu_to_le16(L2CAP_CONN_PARAM_ACCEPTED);
>
> +       if (!err) {
> +               d =3D kmalloc(sizeof(*d), GFP_KERNEL);
> +               if (!d) {
> +                       rsp.result =3D cpu_to_le16(L2CAP_CONN_PARAM_REJEC=
TED);
> +                       err =3D -ENOMEM;
> +               }
> +       }
> +
>         l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
>                        sizeof(rsp), &rsp);
>
>         if (!err) {
> -               u8 store_hint;
> -
> -               store_hint =3D hci_le_conn_update(hcon, min, max, latency=
,
> -                                               to_multiplier);
> -               mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_typ=
e,
> -                                   store_hint, min, max, latency,
> -                                   to_multiplier);

Just make hci_le_conn_update internally use hci_cmd_sync_queue and
then handle the update values at hci_le_conn_update_complete_evt.

> -
> +               d->handle =3D hcon->handle;
> +               bacpy(&d->dst, &hcon->dst);
> +               d->dst_type =3D hcon->dst_type;
> +               d->min =3D min;
> +               d->max =3D max;
> +               d->latency =3D latency;
> +               d->to_multiplier =3D to_multiplier;
> +
> +               if (hci_cmd_sync_queue(hcon->hdev,
> +                                      l2cap_conn_param_update_sync, d,
> +                                      l2cap_conn_param_update_destroy) <=
 0)
> +                       kfree(d);
>         }
>
>         return 0;
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
