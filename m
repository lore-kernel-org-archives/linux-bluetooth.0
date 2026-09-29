Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747A5349A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694956; cv=pass; b=AV5waKzRGDpk1AFyjNSC2M3n//OV6t0pMso69uHVWG8w/BLBY00SuZdbrdC16Jfw6PiK3h9KdGmzPhNSITSlBzmw+pi7KTV1LMb17w7jCy6+dF6jUK0ZbgfdmCF/0NGqce4FU+SMOWeplUgkGCdPrDongkLU13517XAgYHPDdKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694956; c=relaxed/simple;
	bh=0KozPkvCh1JTbs90n58688eAJIQSodlrKiUzXxVLlo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6XYD1gL86uTvXcPBFbMikFPlE2mp01VQCbkxTOxJhiB8XMfpkYm5j6wnPznb5Iy02qgcp8hVkxsd3TSC8ClV2p0pb9qs4luxLAoOMjNwnWGfVGF/6nU/fEdfCPdEuXkmUr5oL/lsJ7U/zNqXiqPI2FfC920rpparf6JSB3v8Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfpTcNUe; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfpTcNUe"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab46253999so7039637b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 08:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790694935; cv=none;
        d=google.com; s=arc-20260327;
        b=PrOl4ozMOElEIeHt5qQRrXCe42EzEyzQ7jFMNtpHYIgNKXodgs4kJyiq9N+zo1XdxQ
         U1Nj6XLuy4Cpw9Hwe7GeoyxoN77sAXmcAfdNdKgCyBo6zzFThHVLNk0gXkK/W+wIQ3qi
         RoPtPNWOV09VkRFTdMhuDfe0L7KAMzaH19LEEy8TeaxMaLioD3FZTPqkAu69/8dmyHlS
         ckgrT0xIAqstqlmrGnM7L76ZhxY4atr8FWzyGISbYVJM9ZVrAoOJ6DWkxFw7kN92WBgE
         L8EYfoXlUWtAypN0qHLM/QdPyTXEorJs02t72hhifDjEJQTFhwHE6d3lVBGVSzgHRfBH
         zBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXhi0qLbS1SThqyboYHBBDko7VFR48O2+Mm4RmwLQmE=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=d6xWF2dfBjWf136Ob2v7Yga9xnMM15EYGnf1hOYfUGoHqIX9uz+nxyJruiD4Azs2tS
         Z6Ty5TraP2m9yTbHOjZXGdRro/MXnStE0LdtzanfcEyErmgFSBrDlu577A8H77NZEVjC
         +lsODU0fDyptmnWBNw+GaYkoc08C5Av9tZnwxrQEWmBIcLcDm5uWNTjN2h6a+QVoqi+j
         4gTUkBjV23mLNXp5F2fGb9SSZyuiKo5pHNvGBAiDlR2ssI0kmPsXpAkEsoQ7GSXuKwSw
         zvSWKjgZ7ZNPLmw+1rgjxu5LY6Ci2cbjGsSXk+Qk2jYPbe/5vLW2xZ8vayL+BP83t2HQ
         WFeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790694935; x=1791299735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BXhi0qLbS1SThqyboYHBBDko7VFR48O2+Mm4RmwLQmE=;
        b=dfpTcNUemM8WfYcHIbe594DflE6ulkWSpECXi39g3flKvgQ0vGydRaPcFsc21whqV9
         19hr8qTIfn3jwDCgpXWVrXNcjEihIZu/YzlCh5DSCWC+wTnML4zxuUNnkXeZLLBaIAdv
         kVCVkWPfDGeQW7cdPbE7LJiKb4qVrvavVxauqWO1nuiap5Z6NjUQKHc9Vgs/xT0oHaGe
         Tu6uVLI6JZ5aCJ1bINwfo81b2fENn1wttHLnxUl8NrVkSX5hwZTeX/l1Y6rhDI/41nke
         8ljaaxHyFBTK6FjeWk2ksBRcoX6hviUshyb2pP55dvvUoIIZEc3dY3oWscNfH/V1zED0
         s2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790694935; x=1791299735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BXhi0qLbS1SThqyboYHBBDko7VFR48O2+Mm4RmwLQmE=;
        b=oyYToEqAy3UJHnHb1zl/b1p0PLXZ3JspwPJ+aFki7qc1PnLhqHWLhz6RUFvWsiR7RM
         TAoYfR3ar9DMQyOKg4+Trm3/OvvTENivakdx1eO+R/3UT+BBiQA82rNK19mVpxxIi5EJ
         ODSwy3L7v77xVurH5u2vMHwMFizjII3MLxFrDVp7vA5WdACv7GTz3A9hGXMdvvVMBb2T
         MXqhGi0eBXGvfvCuvfmiE5XoaTX15UbJcQBtv0tboa/B36grAAEl26h7hebUlcyTlLZR
         kwMNcNIGChxyrPsj7qJ5XM+uNtgP3hYcuwqTmrh6B/b1wc6/KOBqeFZF+L9Z0SMHda88
         koMQ==
X-Gm-Message-State: AFq9FYJTLx0e5lWhgtTg5aYOgdmHC/QjSeG7HfXPyy1KQAfh94j31C+N
	ea3O9Swgi6+fbfRqvydVBLAKlb82ddYFPNRE3SuRMEm9CyUDgUt/YVf6X14c0A7kqWmeitUPLK6
	6Gm7CenY6NV6oMT3ZRoZHJbkMzrpj2/yiiyokpSU=
X-Gm-Gg: AYBFou02pz20wOHtttcM6ldI4d66d5duoxxUnv5p2qkqnP3cmjIh97PyaygFinslP63
	C3GoXtuz31YLhdwZPLKCFhexE+Wgrr6MORbcgZsD29VCetvamA5x2ZsEly/eJ5pAy+fWFY2HSfn
	CblEUp/Ohd3dBV+ubFweyA8/692gt1/oC7eRWhuOx7czQUj10jWaVEjOG8HKdNlY1UfnQvMP7sp
	4EXioGHH6UREatEZ4Dt99I+8gn37f00KV8CMxLgnqA6ZRox17JQVIxTkSryO774rdAncWuiKBCG
	nsR4VVSx4B56hDW/Y8MLrOguSNDhDQKPNyvDsrWs7ZCj0A/Ge2Pgij/UiO18CR3eRkoW0JnS8iv
	9ptvXQSh4Kmn00KXBUKk6Ue3J4mdnqO4VebfeiS6vLg==
X-Received: by 2002:a05:690c:d86:b0:89b:6ecb:c33a with SMTP id
 00721157ae682-8a64a774d6cmr79969777b3.60.1790694935140; Tue, 29 Sep 2026
 08:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929100923.252597-1-frederic.danis@collabora.com>
In-Reply-To: <20260929100923.252597-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Sep 2026 11:15:24 -0400
X-Gm-Features: AclHuK-R69ejWMeGOg2iiwrpcMG5VpRBx2ltCIh1j6HE8Tr1K0YboDKQyrgf2z0
Message-ID: <CABBYNZ+UrOCPZjy9LvGeeMDXmj7yT+MM5aW+DumvwQrd+Q1jkQ@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: MGMT: Add management security level changed event
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Sep 29, 2026 at 6:09=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Add an event on device security level or encryption type change to
> let user space know which level is currently in use.
> Reset security level to 0 on disconnection so further connections
> will correctly report security level changes.
>
> This will be used for BlueZ qualification automation.
>
> Assisted-by: GPT:GPT-5.3-Codex
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
> v1->v2:
>  - Add encryption type to the mgmt event
>  - Send event on security level or encryption type change
> v2->v3:
>  - Replace fixed security level and ancryption type parameters by TLV arr=
ay
>    to allow later enhancement.
> v3->v4:
>  - Change MGMT_EV_SECURITY_LEVEL_CHANGED to 0x0034
>  - Add __counted_by for the tlv_data
>  - dynamically allow the mgmt_ev_security_level_changed structure
> v4->v5: Address Sashiko comments:
>  - stop overwriting tlv_count and replace it by tlv_length as kzalloc_fle=
x()
>    should already set it to the byte length. This depends on compiler
>    supporting __builtin_counted_by_ref(), so explicitly set it too.
>  - filter on link type to prevent to send event for child connection
>  - remove premature calls to mgmt_security_level_changed()
>  - send events only on security level changes
>
>  include/net/bluetooth/hci_core.h | 15 ++++++++--
>  include/net/bluetooth/mgmt.h     | 14 +++++++++
>  net/bluetooth/hci_conn.c         | 10 +++++++
>  net/bluetooth/hci_event.c        | 28 ++++++++++++++++--
>  net/bluetooth/mgmt.c             | 49 ++++++++++++++++++++++++++++++++
>  5 files changed, 112 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index fb85a0ccb250..0f4a345f492c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2255,6 +2255,8 @@ static inline void hci_auth_cfm(struct hci_conn *co=
nn, __u8 status)
>                 conn->security_cfm_cb(conn, status);
>  }
>
> +void mgmt_security_level_changed(struct hci_conn *conn);
> +
>  static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
>  {
>         struct hci_cb *cb;
> @@ -2277,11 +2279,20 @@ static inline void hci_encrypt_cfm(struct hci_con=
n *conn, __u8 status)
>                 encrypt =3D 0x01;
>
>         if (!status) {
> -               if (conn->sec_level =3D=3D BT_SECURITY_SDP)
> +               bool sec_level_changed  =3D false;
> +
> +               if (conn->sec_level =3D=3D BT_SECURITY_SDP) {
>                         conn->sec_level =3D BT_SECURITY_LOW;
> +                       sec_level_changed =3D true;
> +               }
>
> -               if (conn->pending_sec_level > conn->sec_level)
> +               if (conn->pending_sec_level > conn->sec_level) {
>                         conn->sec_level =3D conn->pending_sec_level;
> +                       sec_level_changed =3D true;
> +               }
> +
> +               if (sec_level_changed)
> +                       mgmt_security_level_changed(conn);
>         }
>
>         mutex_lock(&hci_cb_list_lock);
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 1e22eab1081c..b02e915bb44c 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -1221,3 +1221,17 @@ struct mgmt_ev_conn_subrate {
>         __le16  cont_num;
>         __le16  supv_timeout;
>  } __packed;
> +
> +#define MGMT_CONN_SEC_ENCRYPT_NONE             0x00
> +#define MGMT_CONN_SEC_ENCRYPT_E0               0x01
> +#define MGMT_CONN_SEC_ENCRYPT_AES_CCM          0x02
> +
> +#define MGMT_SEC_LEVEL_CHANGED_PARAM_LEVEL     0x0000
> +#define MGMT_SEC_LEVEL_CHANGED_PARAM_ENC_TYPE  0x0001
> +
> +#define MGMT_EV_SECURITY_LEVEL_CHANGED         0x0034
> +struct mgmt_ev_security_level_changed {
> +       struct mgmt_addr_info addr;
> +       __u8    tlv_length;
> +       __u8    tlv_data[] __counted_by(tlv_length);
> +} __packed;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index cf44452e0766..5191fd72ac9e 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1233,6 +1233,11 @@ static void hci_conn_unlink(struct hci_conn *conn)
>         if (!conn->parent) {
>                 struct hci_link *link, *t;
>
> +               conn->sec_level =3D BT_SECURITY_SDP;
> +               clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
> +               clear_bit(HCI_CONN_AES_CCM, &conn->flags);
> +               mgmt_security_level_changed(conn);
> +
>                 list_for_each_entry_safe(link, t, &conn->link_list, list)=
 {
>                         struct hci_conn *child =3D link->conn;
>
> @@ -1543,6 +1548,11 @@ struct hci_conn *hci_connect_le(struct hci_dev *hd=
ev, bdaddr_t *dst,
>                 conn->pending_sec_level =3D sec_level;
>         }
>
> +       /* Do not report the security level here: conn->dst may still hol=
d
> +        * the peer's RPA instead of its identity address, and the connec=
tion
> +        * is not established yet. le_conn_complete_evt() reports it once=
 the
> +        * connection completes and the identity address has been resolve=
d.
> +        */
>         conn->sec_level =3D BT_SECURITY_LOW;
>         conn->conn_timeout =3D conn_timeout;
>         conn->le_adv_phy =3D phy;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 5ac2357e92c9..e2961e1837aa 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -755,6 +755,7 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hd=
ev, void *data,
>                         status =3D HCI_ERROR_AUTH_FAILURE;
>                         clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
>                         clear_bit(HCI_CONN_AES_CCM, &conn->flags);
> +                       mgmt_security_level_changed(conn);
>                 }
>
>                 /* Update the key encryption size with the connection one=
 */
> @@ -3210,6 +3211,8 @@ static void hci_conn_complete_evt(struct hci_dev *h=
dev, void *data,
>         }
>
>         if (!status) {
> +               bool encrypt_change =3D false;
> +
>                 status =3D hci_conn_set_handle(conn, __le16_to_cpu(ev->ha=
ndle));
>                 if (status)
>                         goto done;
> @@ -3232,8 +3235,10 @@ static void hci_conn_complete_evt(struct hci_dev *=
hdev, void *data,
>                 if (test_bit(HCI_AUTH, &hdev->flags))
>                         set_bit(HCI_CONN_AUTH, &conn->flags);
>
> -               if (test_bit(HCI_ENCRYPT, &hdev->flags))
> +               if (test_bit(HCI_ENCRYPT, &hdev->flags)) {
>                         set_bit(HCI_CONN_ENCRYPT, &conn->flags);
> +                       encrypt_change =3D true;
> +               }
>
>                 /* "Link key request" completed ahead of "connect request=
" completes */
>                 if (ev->encr_mode =3D=3D 1 && !test_bit(HCI_CONN_ENCRYPT,=
 &conn->flags) &&
> @@ -3243,11 +3248,15 @@ static void hci_conn_complete_evt(struct hci_dev =
*hdev, void *data,
>                         key =3D hci_find_link_key(hdev, &ev->bdaddr);
>                         if (key) {
>                                 set_bit(HCI_CONN_ENCRYPT, &conn->flags);
> +                               encrypt_change =3D true;
>                                 hci_read_enc_key_size(hdev, conn);
>                                 hci_encrypt_cfm(conn, ev->status);
>                         }
>                 }
>
> +               if (encrypt_change)
> +                       mgmt_security_level_changed(conn);
> +
>                 /* Get remote features */
>                 if (conn->type =3D=3D ACL_LINK) {
>                         struct hci_cp_read_remote_features cp;
> @@ -3514,9 +3523,14 @@ static void hci_auth_complete_evt(struct hci_dev *=
hdev, void *data,
>                 goto unlock;
>
>         if (!ev->status) {
> +               bool sec_level_changed =3D
> +                               conn->sec_level !=3D conn->pending_sec_le=
vel;
> +
>                 clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
>                 set_bit(HCI_CONN_AUTH, &conn->flags);
>                 conn->sec_level =3D conn->pending_sec_level;
> +               if (sec_level_changed)
> +                       mgmt_security_level_changed(conn);
>         } else {
>                 if (ev->status =3D=3D HCI_ERROR_PIN_OR_KEY_MISSING)
>                         set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
> @@ -3632,9 +3646,12 @@ static void hci_encrypt_change_evt(struct hci_dev =
*hdev, void *data,
>                         if ((conn->type =3D=3D ACL_LINK && ev->encrypt =
=3D=3D 0x02) ||
>                             conn->type =3D=3D LE_LINK)
>                                 set_bit(HCI_CONN_AES_CCM, &conn->flags);
> +
> +                       mgmt_security_level_changed(conn);
>                 } else {
>                         clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
>                         clear_bit(HCI_CONN_AES_CCM, &conn->flags);
> +                       mgmt_security_level_changed(conn);
>                 }
>         }
>
> @@ -5228,8 +5245,14 @@ static void hci_key_refresh_complete_evt(struct hc=
i_dev *hdev, void *data,
>         if (conn->type !=3D LE_LINK)
>                 goto unlock;
>
> -       if (!ev->status)
> +       if (!ev->status) {
> +               bool sec_level_changed =3D
> +                               conn->sec_level !=3D conn->pending_sec_le=
vel;
> +
>                 conn->sec_level =3D conn->pending_sec_level;
> +               if (sec_level_changed)
> +                       mgmt_security_level_changed(conn);
> +       }
>
>         clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
>
> @@ -5861,6 +5884,7 @@ static void le_conn_complete_evt(struct hci_dev *hd=
ev, u8 status,
>         mgmt_device_connected(hdev, conn, NULL, 0);
>
>         conn->sec_level =3D BT_SECURITY_LOW;
> +       mgmt_security_level_changed(conn);
>         conn->state =3D BT_CONFIG;
>
>         /* Store current advertising instance as connection advertising i=
nstance
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 9d3de5a0b8ee..77c958322496 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -177,6 +177,7 @@ static const u16 mgmt_events[] =3D {
>         MGMT_EV_CONTROLLER_RESUME,
>         MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
>         MGMT_EV_ADV_MONITOR_DEVICE_LOST,
> +       MGMT_EV_SECURITY_LEVEL_CHANGED,
>  };
>
>  static const u16 mgmt_untrusted_commands[] =3D {
> @@ -10822,6 +10823,54 @@ void mgmt_device_found(struct hci_dev *hdev, bda=
ddr_t *bdaddr, u8 link_type,
>         mgmt_adv_monitor_device_found(hdev, bdaddr, report_device, skb, N=
ULL);
>  }
>
> +void mgmt_security_level_changed(struct hci_conn *conn)
> +{
> +       struct mgmt_ev_security_level_changed *ev;
> +       struct mgmt_tlv *tlv;
> +       u8 *tlv_data;
> +       u8 tlv_len;
> +
> +       /* Only ACL, LE and BIS links are tracked as mgmt connections, so
> +        * restrict the event to those link types. Other transports (SCO,
> +        * CIS, PA sync, ...) share the parent's address and would otherw=
ise
> +        * report a spurious security level change for it.
> +        */
> +       if (conn->type !=3D ACL_LINK && conn->type !=3D LE_LINK &&
> +           conn->type !=3D BIS_LINK)
> +               return;
> +
> +       tlv_len =3D 2 * (sizeof(*tlv) + sizeof(__u8));
> +       ev =3D kzalloc_flex(*ev, tlv_data, tlv_len, GFP_KERNEL);
> +       if (!ev)
> +               return;
> +
> +       bacpy(&ev->addr.bdaddr, &conn->dst);
> +       ev->addr.type =3D link_to_bdaddr(conn->type, conn->dst_type);
> +       ev->tlv_length =3D tlv_len;
> +
> +       tlv_data =3D ev->tlv_data;
> +       tlv =3D (void *)tlv_data;
> +       tlv->type =3D cpu_to_le16(MGMT_SEC_LEVEL_CHANGED_PARAM_LEVEL);
> +       tlv->length =3D sizeof(__u8);
> +       tlv->value[0] =3D conn->sec_level;
> +
> +       tlv_data +=3D sizeof(*tlv) + sizeof(__u8);
> +       tlv =3D (void *)tlv_data;
> +       tlv->type =3D cpu_to_le16(MGMT_SEC_LEVEL_CHANGED_PARAM_ENC_TYPE);
> +       tlv->length =3D sizeof(__u8);
> +       if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
> +               tlv->value[0] =3D MGMT_CONN_SEC_ENCRYPT_NONE;
> +       else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
> +               tlv->value[0] =3D MGMT_CONN_SEC_ENCRYPT_AES_CCM;
> +       else
> +               tlv->value[0] =3D MGMT_CONN_SEC_ENCRYPT_E0;
> +
> +       mgmt_event(MGMT_EV_SECURITY_LEVEL_CHANGED, conn->hdev, ev,
> +                  struct_size(ev, tlv_data, tlv_len), NULL);
> +
> +       kfree(ev);
> +}
> +
>  void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_ty=
pe,
>                       u8 addr_type, s8 rssi, u8 *name, u8 name_len)
>  {
> --
> 2.43.0
>

There are some new findings by sashiko:

https://sashiko.dev/#/patchset/20260929100923.252597-1-frederic.danis%40col=
labora.com


--=20
Luiz Augusto von Dentz
