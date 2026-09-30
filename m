Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B374D9540
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777518; cv=pass; b=s4hCxVRhuX2/DnYKByfibgWJRQawtjq8/e63Zccdu98NSR8w945w5TQjeac1EQPat1Y+WRG8H04rxx+J8nEn6NVYhESGmZtfagTB4SsdYduzyHgLu33ef4I+lZexozuAjCrQOgg3OvF15ZMW6Ckzu6SL5nW31jAwK0raEWaVc8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777518; c=relaxed/simple;
	bh=L9+q+ebFrgwQ8PkkAyJMgL51jSSifwkZ5yrp5hnqi/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjwvAPl5/wuraEAS2q+trtGvyWiYA9vElJ8vTQuXC9lol9PskoJFmoZaYIFUr0hzy9Du+DTKLQ47ggEiv+SN8czCsQmCOJMQ7odGP2BDk+JEBLyg078osTn471a187R3UUcZ79y0dLc11RCwhFKLiKG+LjzQRvKXRMiLDlg4B9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZis88XO; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZis88XO"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f4b7091dso2842768d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790777510; cv=none;
        d=google.com; s=arc-20260327;
        b=b+2wjW2xvX5VRs/L6+gbHHrTx7M+/HDHmhmBdMrR31OVpNUGuqBm5ohL11rIf5usvk
         DxGa5uge6beD/p8h2l2RWTrQ/UhX/JnpwZNVJEiFPAK5yFb76KcZRSyUnTJrHC1+1MMx
         A8hYtr7v/k731QHNm+fxTk7w53GOBREJD0Hb/HbkQKS+vt29o7GiAzFWBlH9NraZtB+8
         ZnYzSH33eKfN1jgBFhs+br8TkAurfpOISFmjio5Blj27MmUQMHlSQMwSriftJjYQaU4R
         IxG/963LfLtdG/7xlY2tYTdNEDHOjdINJOolNZeH1xTevN+ITgUf1wBFsRaEpLobjcD3
         ekEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NWajdM/5y50eHthmOZgCD1ZiQ44IMua5HMRERTCJRWU=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=YpMnDe8u78NnvgD3vSMKM6QN/cbAH0y9wh7dHL6y2Ors5amq8Xwege3krACvG2cDZ2
         gMDXL3+JM5xojvmiOCHttIzmI1822Iy0nuVSdWDYM7p0aHdTwN0ayuQ339JXZ8+C8/jH
         3LaPBSiShflC6xuyw6NP7cOaLe9KPp3ZmIQlZLqNWvlAxPKl3mqplw3z/00Evvkl7cHG
         UrI3ecQEnkgEm9tN3lhfdJh9w3lULnyU/uw4eJnVQvI5h4xPrVczKmKo8pzRyUfDlmnu
         iUqc81x8sYCKNmvHLWuY6cCvfQpx7oiXe+ixB5UlB3N8iSz4L3WSdEG8P586dah8zhF4
         fi1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777510; x=1791382310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NWajdM/5y50eHthmOZgCD1ZiQ44IMua5HMRERTCJRWU=;
        b=JZis88XOBiudKEv9ZTaiDTCL7xCnghyfFK9AyyuBy7XZLbJsJmHWJ1H/L0kwAVu8vS
         +1DJO3V58NQ8b8k/A1koONTBvXJrpYVbGuzU80UhNhk3tJlJRkek8wVRLVvt4YDIphYG
         SiFFDAOz10W0ELW6rULg8/FrQC2QWzQHGLm3M70YhNHXWuksM2Twt+kY73WhpEJyRlKQ
         OxNOkBAsoHY0XbiWmmOsxyjagYkbfzuV2n7jVVg7NXQEJ66kO2VORdRT1+D2ilH5J6Px
         /GhZbg7BaShmKCT+tJbtOVRB9+sHX/RSkz7R9cKXdYp9SPeo2ZbOgOpYfUfDYlZwmpVK
         /lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777510; x=1791382310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWajdM/5y50eHthmOZgCD1ZiQ44IMua5HMRERTCJRWU=;
        b=EStxginACRTGgq47b8nqG3snrue59NJFQAKhCM4XRw2nrHphcEGJhFfkK16+sPtDqL
         ayWt4XbK6qUEdwMV3T8DqO6BfPqW/o85KDlyYg1xVzyeADpkctcvUmVE3oKbd95i7HBW
         M9ZUksjswcw/R6sUOXRdgNx1GzNHCddK+BVXo2QPXicSxIpW7EsVIVwWKjMABMgVYqAP
         3/BAUEBo3UkPLz6YBq/acQemQyNdJV3Euz54t68gGtP/yB7ciGtt0SP9zy9Efpiu+XVm
         GUqBRH8anwSxnhMdZZvlBDvwkOHXy93bH1KE6xujMquEyV8Gr5QhxdE5KqX9gcANHqot
         PS9g==
X-Gm-Message-State: AFq9FYL9PzbDKY5V1fywwIUL7Hc7R9KQdlvHIp/Imh2SYD0pDH25vQvP
	CNaIKuoJUeytTRALC40VSJTU2V6EVK/JYqNqNQfec8SBTtwg2/4mkotWm1RjxnS2wt+goRUSELD
	A7KRQeVkpHFy84DHNJcNx5nqvlRlZ0hJjYSWhTxA=
X-Gm-Gg: AYBFou1QnRu/bMcc0BuhCYpkgltEDy1U7h8h5tNvakSwRp9nAHTcKEzWp8wvz2qxt1l
	65UXGHKN+SYxRgBapIZ7iud2coFMSvBaETJH/iY9D9n0RxxaF7ECAygLANjUyCgbGNsK2TOErJ5
	mpl5Eg8XG9QY47UTXVhrxT6zCAAUwgxvnIRvORxaL2OD4/g0IS1ob5+1Mh3/m23rM9lMY2z/KA1
	GBosNrm5S0o+PtVcgl1D5FiuIdYshbS7UPcUS1J8wz5o5MNPtEB6tunYDgKmSjzbd+3jQU/Ch6O
	SAtu2rDSWgflyhJ521Y97KMxioHgLWHAVbvGPgxKfRqnlsQAuYuDvo7l1zzsdt97bny18PR5i5D
	T28zSJRso0eXQBidMNIXocLIdPXbJ9iuj++q0oLLLKjIhQ0AKeA==
X-Received: by 2002:a05:690c:87:b0:80e:dc2:873b with SMTP id
 00721157ae682-8ac96fdd5d5mr5886207b3.16.1790777509833; Wed, 30 Sep 2026
 07:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930095147.554276-1-frederic.danis@collabora.com>
In-Reply-To: <20260930095147.554276-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Sep 2026 10:11:37 -0400
X-Gm-Features: AclHuK9F1USPWEuMsQG3Za3t7DHR1YCy6G2VGg_TXBLNzXiK_jeaCp0VLiBiOx4
Message-ID: <CABBYNZKrnOUwKfw31BLLdXP5AWUCYmOx091rS5TfK5xyjFbRCg@mail.gmail.com>
Subject: Re: [PATCH v6] Bluetooth: MGMT: Add management security level changed event
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Sep 30, 2026 at 5:53=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
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
>  - filter on link type to prevent sending the event for child connections
>  - remove premature calls to mgmt_security_level_changed()
>  - send events only on security level changes
> v5->v6: Address Sashiko comments:
>  - avoid a duplicate MGMT event in hci_conn_complete_evt() by not setting
>    encrypt_change when the link-key branch already reports the change via
>    hci_encrypt_cfm()
>  - defer reporting for encrypted ACL links until hci_cc_read_enc_key_size=
()
>    has validated the encryption key size, instead of reporting a transien=
t
>    state that a key-size downgrade could immediately invalidate
>
>  include/net/bluetooth/hci_core.h | 15 +++++++--
>  include/net/bluetooth/mgmt.h     | 14 ++++++++
>  net/bluetooth/hci_conn.c         | 10 ++++++
>  net/bluetooth/hci_event.c        | 58 ++++++++++++++++++++++++++++++--
>  net/bluetooth/mgmt.c             | 49 +++++++++++++++++++++++++++
>  5 files changed, 141 insertions(+), 5 deletions(-)
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
> index 5ac2357e92c9..c576cc808dce 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -762,6 +762,13 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *h=
dev, void *data,
>                         *key_enc_size =3D conn->enc_key_size;
>         }
>
> +       /* Report the final security level here rather than when encrypti=
on
> +        * was first enabled: this is the only place both the success and
> +        * key-size-downgrade outcomes are known, avoiding a transient ev=
ent
> +        * for a state that a downgrade would immediately invalidate.
> +        */
> +       mgmt_security_level_changed(conn);
> +
>         hci_encrypt_cfm(conn, status);
>
>  done:
> @@ -3210,6 +3217,8 @@ static void hci_conn_complete_evt(struct hci_dev *h=
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
> @@ -3232,8 +3241,10 @@ static void hci_conn_complete_evt(struct hci_dev *=
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
> @@ -3244,10 +3255,22 @@ static void hci_conn_complete_evt(struct hci_dev =
*hdev, void *data,
>                         if (key) {
>                                 set_bit(HCI_CONN_ENCRYPT, &conn->flags);
>                                 hci_read_enc_key_size(hdev, conn);
> +                               /* Set sec_level here so hci_encrypt_cfm(=
)'s
> +                                * own change check is a no-op below: the
> +                                * async hci_cc_read_enc_key_size() compl=
etion
> +                                * is the sole point reporting the final
> +                                * security level for this connection, on=
ce
> +                                * the key size has been validated, so
> +                                * encrypt_change is not set here either.
> +                                */
> +                               conn->sec_level =3D conn->pending_sec_lev=
el;
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
> @@ -3514,9 +3537,14 @@ static void hci_auth_complete_evt(struct hci_dev *=
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
> @@ -3632,9 +3660,20 @@ static void hci_encrypt_change_evt(struct hci_dev =
*hdev, void *data,
>                         if ((conn->type =3D=3D ACL_LINK && ev->encrypt =
=3D=3D 0x02) ||
>                             conn->type =3D=3D LE_LINK)
>                                 set_bit(HCI_CONN_AES_CCM, &conn->flags);
> +
> +                       /* For ACL links the encryption key size is still
> +                        * validated below via hci_read_enc_key_size(). I=
ts
> +                        * completion handler, hci_cc_read_enc_key_size()=
,
> +                        * reports the final security level so userspace =
does
> +                        * not see a transient "encrypted" state that a
> +                        * key-size downgrade would immediately invalidat=
e.
> +                        */
> +                       if (conn->type !=3D ACL_LINK)
> +                               mgmt_security_level_changed(conn);
>                 } else {
>                         clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
>                         clear_bit(HCI_CONN_AES_CCM, &conn->flags);
> +                       mgmt_security_level_changed(conn);
>                 }
>         }
>
> @@ -3667,8 +3706,14 @@ static void hci_encrypt_change_evt(struct hci_dev =
*hdev, void *data,
>
>         /* Try reading the encryption key size for encrypted ACL links */
>         if (!ev->status && ev->encrypt && conn->type =3D=3D ACL_LINK) {
> -               if (hci_read_enc_key_size(hdev, conn))
> +               if (hci_read_enc_key_size(hdev, conn)) {
> +                       /* Could not even issue the key-size read: report=
 the
> +                        * security level now since hci_cc_read_enc_key_s=
ize()
> +                        * will not run to do it.
> +                        */
> +                       mgmt_security_level_changed(conn);
>                         goto notify;
> +               }
>
>                 goto unlock;
>         }
> @@ -5228,8 +5273,14 @@ static void hci_key_refresh_complete_evt(struct hc=
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
> @@ -5861,6 +5912,7 @@ static void le_conn_complete_evt(struct hci_dev *hd=
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

More comments to be addressed:

https://sashiko.dev/#/patchset/20260930095147.554276-1-frederic.danis%40col=
labora.com


--=20
Luiz Augusto von Dentz
