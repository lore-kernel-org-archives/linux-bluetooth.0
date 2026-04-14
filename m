Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8EF9E8
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177988; cv=pass; b=knQ6vBtPSu1ZHElXtCmS4Y+QRSjSjd2xyqOExTFyxfaQmLFtY2JPFCfOSUr2k4vfBvDnOFSSfkwsfE5BMtmFQ6JSmlU/AKJJbZDWMNC4sTfrFLg62N876hYwPUKUz1FrndxgQ8ZGYFxRHZW75Igjkc22OahElAPnC/Hn30ZF+XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177988; c=relaxed/simple;
	bh=Uhd4G9nr40PdZ+KmL9bs1GdhSBdggxDgY5JkWMBcg/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXr1ba8R/CaJ3GFHxJvPNgPFo3K6QI8stCHli61/Hm1j6L+tbWtf+ssX0h4zetUbvsnBNoEnaAyJRf5IdNW984VaNAuRD023/OVrY7Dkit5kIVrHA1hSmi79bKMBYyO79QBbwh5OK8SmdwU/9VyHPZ+8pH7JFMgqUJiEESn1H9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SasNvTPo; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SasNvTPo"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-66f747175d8so2593773eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 07:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776177985; cv=none;
        d=google.com; s=arc-20240605;
        b=iQAgYM4+a/zprTmkQGYQhyY/DQogd5By2Mu2klUxoSb3+/chensh1lMyTl38uxpItV
         9YkKYpqTw3hGNU+nd5vK0J4Mr09baLIBvTWLrXzScjgGGZJTAQbjkm7Dtlskpk3FKir6
         R6SMUL1gQKQllQl2MK9njul/3DpjytabBp/KS0+XPm2Snu9ZghLPlg2iPi4X7BTYiHoF
         KZ39IPIBRVlju3cmr3stLeWABLA/fWnCsOR759V0Q64FGkU0yd4ZSvkI4oQFc8DgI+6q
         iLfLcpuUZit9FJ/usei3gOccLDPBVadTIPzvoocU7INex/AJ7vmxKVHOeLBAJPYOME1X
         vgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OwvI/v3l4Aq785Z+dVIIUWEj1KkRE+iFCTHT+IK3ijo=;
        fh=zz2GTi7rfGH29vSESvgWjxuDjrql3HtWJxr0zmOyIc8=;
        b=C7yRyHvgyGOT49rIDQtCjC4wlYglrlYJgIFybcIr9PDiBDZpjqDk+oQNg64fEqbj7d
         GOXiKE8rNgIRQh5y5XeDvjmwcxBiGYPqCMzb0QKDXtUP2wIS6X54p5UUUq/ZHo3/k9JM
         wD9zvnF/rNa9i5Xx6N7S1Jod4kKRmaKcDE/QpbIxUi9Dm5zodTssGXa8YnPWruyodX/2
         sADXO23/4mU9emZcTB0fj3eWX8WrZ9oSq4vJwXyOw6KQEvHiYFWUCNN0mIVD3tz9mq0T
         SWzQoDMeYcdob8+BqMk6yyKM9ULyVtmG0I1vtmNPtQr+FzTk71EbwWFOc88bDMTKUMft
         rnlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177985; x=1776782785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwvI/v3l4Aq785Z+dVIIUWEj1KkRE+iFCTHT+IK3ijo=;
        b=SasNvTPo2xn63cMkkJKGPYZPAKLRuvkjAgqkQPu8NIbGyv4LFAi3JhVNasqFc/YUGB
         EQNDw86mQ1hnC7o4A2tOsFFTOM7k4ZvFEPko7OVufa/l5fIc9+/NL8tsXxqsaeBP97/P
         XET0XxDCPAiDOxsYufJK3WBEWw93qBYrdJMh3FcnATAJMivWV6a/cdc6DKNLkh3a5o/D
         XSRRxLJg0iGPTXYYQ+tXE2pUFWv7Gn2J5WREoBghK6HCIctUWd6p8bTZx7+gZjoHW5sy
         mmh4QEVjckZr5/PnvxjSuTayhG96CKOigwA2UkuPzLen+KOFyan3/U7uRYWKQGXmBQ95
         Hbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177985; x=1776782785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OwvI/v3l4Aq785Z+dVIIUWEj1KkRE+iFCTHT+IK3ijo=;
        b=dxtthcFLZ6pUBYM6F0Kt9kevhbFEIC5FKDC0GgpNLkTZCMVhSMcD0cH3pO7QFrgkQf
         FdrbEGlcEBL6Zyni3f0vDd2I07SS16NWrLK3YFuMF6DVBrUG0OTzqQQgDvyEkySZGU7t
         GrBc52IeULf+OCPHJls7leCwOq2R6c0G4pB91+w1ez45loQhEyz/4awaoEEJrNACDW3f
         zF9fih2br2RuwfYQETgypP7Z55ftLRlkkph+/tt7p6Bt7Y+z3mQK/tBPGPW9RXpXRXlI
         scREqwfLWHdA4t8rUSMh1N/j9pFrtavu+zfw7eGpXEUweG+6JcTv+q+Obgux7dol371z
         Cbgg==
X-Forwarded-Encrypted: i=1; AFNElJ+PHw/Ges9KOuLF62HjiSMy1+PIRvv2W20HzO3CiKlJQzhxf/GZjrozRgcF/B1CAxOLT36YjEquO+k7vKRtutw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQw6ftyEvS5w6sguBawznPltN/x9TYNOLPjfU/KizGxOAJ2Nt
	snUIAixK456Qpk67khgPghSc3PdwDshMBJEOMN/tcv8SjEzciURc8jnDXvLUsxotpxbIq5pL5qI
	GHAnXpFxLp66EW8R+b9yzHZwpuv1/OwY=
X-Gm-Gg: AeBDiev7i3kI3f3DDjK6Ir02Uh3L1+SG/kjmrQmMwuHQulug1QkYKMMLOAkkLvnicot
	LFBncv91Wbsmpk/VdTXJsEH6DooQCkefV6kapbR2CbSNFOiDrjfwsqmYctJljHenFcO8uhZg9F5
	NJCQz407fTd51mT7C0U/5F82yIv6dhZE/gvfdyXYmGpBLM9NdJNnlJmrF9tNJnyxQhgw1LhRfBc
	K1tXKompn7h1Oh6AORwIVsgiLFJ8YlvFVn34vAbIpw7LXd2U6rwv/Z487GO4FQbJjDLuDpCFyy2
	njNnTD96WzLgyeBIw1pJBJ787lstwYw6Lu36myMYJcUw4OTbhvaqXFSzu7mukMPnAUsnZg==
X-Received: by 2002:a05:6820:298f:b0:67d:e619:5c5a with SMTP id
 006d021491bc7-68be5f4dd9amr10194856eaf.16.1776177984594; Tue, 14 Apr 2026
 07:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413230813.21393-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260413230813.21393-1-mikhail.v.gavrilov@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Apr 2026 10:46:12 -0400
X-Gm-Features: AQROBzCIvvqkl86OojOB_hPBrMpthw8W-a2ScXei7vQ8Bm-mcB7NEkmgSRPDQCA
Message-ID: <CABBYNZKurBHkerQ4NJS1okA2hn=D5ty4tJx5PWphM3DASvfs8Q@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: marcel@holtmann.org, pmenzel@molgen.mpg.de, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On Mon, Apr 13, 2026 at 7:08=E2=80=AFPM Mikhail Gavrilov
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
> caller context.
>
> The connection parameter storage (hci_conn_params update) and userspace
> notification (mgmt_new_conn_param) are moved into
> hci_le_conn_update_complete_evt() where they are handled when the
> controller confirms the update, using hci_sent_cmd_data() to retrieve
> the originally requested min/max interval values.
>
> Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in=
 connection params")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
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
>  net/bluetooth/hci_conn.c         | 66 ++++++++++++++++++++++----------
>  net/bluetooth/hci_event.c        | 33 ++++++++++++++++
>  net/bluetooth/l2cap_core.c       | 12 +-----
>  4 files changed, 81 insertions(+), 32 deletions(-)
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
> index 11d3ad8d2551..207221560a02 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -480,40 +480,64 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 ha=
ndle)
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
> -       struct hci_conn_params *params;
> +       struct le_conn_update_data *d =3D data;
> +       struct hci_conn *conn;
>         struct hci_cp_le_conn_update cp;
>
>         hci_dev_lock(hdev);
> -
> -       params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_typ=
e);
> -       if (params) {
> -               params->conn_min_interval =3D min;
> -               params->conn_max_interval =3D max;
> -               params->conn_latency =3D latency;
> -               params->supervision_timeout =3D to_multiplier;
> -       }
> -
> +       /* Verify connection is still alive. */
> +       conn =3D hci_conn_valid(hdev, d->conn) ? d->conn : NULL;
>         hci_dev_unlock(hdev);
> +       if (!conn)
> +               return -ECANCELED;
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
> +       return __hci_cmd_sync_status(hdev, HCI_OP_LE_CONN_UPDATE,
> +                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
> +static void le_conn_update_complete(struct hci_dev *hdev, void *data,
> +                                       int err)
> +{
> +       kfree(data);
> +}
>
> -       if (params)
> -               return 0x01;
> +void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 lat=
ency,
> +                       u16 to_multiplier)
> +{
> +       struct le_conn_update_data *d;
>
> -       return 0x00;
> +       d =3D kmalloc(sizeof(*d), GFP_KERNEL);
> +       if (!d)
> +               return;
> +
> +       d->conn =3D conn;
> +       d->min =3D min;
> +       d->max =3D max;
> +       d->latency =3D latency;
> +       d->to_multiplier =3D to_multiplier;
> +
> +       if (hci_cmd_sync_queue(conn->hdev, le_conn_update_sync, d,
> +                              le_conn_update_complete) < 0)
> +               kfree(d);
>  }
>
>  void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 3ebc5e6d45d9..9df8fc762a84 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6065,6 +6065,8 @@ static void hci_le_conn_update_complete_evt(struct =
hci_dev *hdev, void *data,
>                                             struct sk_buff *skb)
>  {
>         struct hci_ev_le_conn_update_complete *ev =3D data;
> +       struct hci_cp_le_conn_update *sent;
> +       struct hci_conn_params *params;
>         struct hci_conn *conn;
>
>         bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> @@ -6079,6 +6081,37 @@ static void hci_le_conn_update_complete_evt(struct=
 hci_dev *hdev, void *data,
>                 conn->le_conn_interval =3D le16_to_cpu(ev->interval);
>                 conn->le_conn_latency =3D le16_to_cpu(ev->latency);
>                 conn->le_supv_timeout =3D le16_to_cpu(ev->supervision_tim=
eout);
> +
> +               /* Update stored connection parameters and notify userspa=
ce
> +                * using the parameters from the original HCI command.
> +                */
> +               sent =3D hci_sent_cmd_data(hdev, HCI_OP_LE_CONN_UPDATE);
> +               if (sent) {
> +                       u8 store_hint;
> +
> +                       params =3D hci_conn_params_lookup(hdev, &conn->ds=
t,
> +                                                       conn->dst_type);
> +                       if (params) {
> +                               params->conn_min_interval =3D
> +                                       le16_to_cpu(sent->conn_interval_m=
in);
> +                               params->conn_max_interval =3D
> +                                       le16_to_cpu(sent->conn_interval_m=
ax);
> +                               params->conn_latency =3D
> +                                       le16_to_cpu(sent->conn_latency);
> +                               params->supervision_timeout =3D
> +                                       le16_to_cpu(sent->supervision_tim=
eout);
> +                               store_hint =3D 0x01;
> +                       } else {
> +                               store_hint =3D 0x00;
> +                       }
> +
> +                       mgmt_new_conn_param(hdev, &conn->dst, conn->dst_t=
ype,
> +                                           store_hint,
> +                                           le16_to_cpu(sent->conn_interv=
al_min),
> +                                           le16_to_cpu(sent->conn_interv=
al_max),
> +                                           le16_to_cpu(sent->conn_latenc=
y),
> +                                           le16_to_cpu(sent->supervision=
_timeout));
> +               }
>         }
>
>         hci_dev_unlock(hdev);
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

https://sashiko.dev/#/patchset/20260413230813.21393-1-mikhail.v.gavrilov%40=
gmail.com

Most comments seem valid. Regarding the last 2 we might need to wait
for HCI_EV_LE_CONN_UPDATE_COMPLETE by passing it to
__hci_cmd_sync_status_sk.

For the first comment I guess we will need to use hci_conn_get to
prevent the hci_conn from being freed. It can still be removed so the
usage of hci_conn_valid remains valid, but we will need to call
hci_conn_put even if hci_conn is already removed.

--=20
Luiz Augusto von Dentz
