Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41925334C
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204271; cv=none; b=lTLup7j0xYHRWw4Hf2iQmFHQQKwm6ia7ZVa95zhKX6bspHoU8bRjNqxlprXUNXR5KLoV/A96EiQSJ10oQVP2+5MUgDJ2HYjd6feYGuZ9PvmKPUF2AMcBroKq9i8z+22zhjJkP1DNm9jBmwBYaFiBWIRMHJzntzIiVUiIuegyz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204271; c=relaxed/simple;
	bh=PCYKSClSj+NYdeVkpKvUdj/f9pnXzEW8/lvd8c+M7GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VI2tsZ/X7VpSp4UPJqDLOJZtkmK4ZPMA3BzDnGGMvxUNfb5r4l5mb38LLzdKC0/w58mwPmPDaZYkW9szKyexNyFp/fsc3rby8c8OVSlGQXVOiNPa8lhxsi/1jpPi6q1O03yRUndT4qHh/gspj0W8XqrBdRcNqNDUai0NEZtS7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1hcStcm; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1hcStcm"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bb75492e4so37640411fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Mar 2025 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204267; x=1741809067; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvya5yPFP+EsZsRcC6C30EzhRNvds7AemvAA9d8w/vQ=;
        b=f1hcStcmVeJ29Nw6OG6fAxW9+hgMu1Yu1lexDw38B/U+qi1biyK17AETLq6z+PB6c1
         d32m3Ofn/G7HEnGiwwDwCd/Eu/PbJY12568e/rZWrFDn+gBFYbtshSRrzgTW5Q3JIeip
         4VdNFBDPnTicyPe5rYKnKwu1G3qRxbZxmTr5MqS/KGpzSvwc6qytxfXXNGsc9IGH/Q7m
         jFqy9/3MbZ9Yfck31fQQB5f73AMf/071RE/BAYkWrmo8haGOwcPZ0CzgBlweM6W/kthq
         OET01goufT1vCm/mppXo5MM+SBaZt/dl2IUk0y8g4kBwaarFkRgU+YjTD6U0dpLz/IcS
         xfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204267; x=1741809067;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvya5yPFP+EsZsRcC6C30EzhRNvds7AemvAA9d8w/vQ=;
        b=PZE32g9VwDI+oX25NaqdFdKBHafy0tBqey/8gKi3ijcBMrsaTc9YuqaekLSpUbbIcD
         ehPDmx8WFCYhlI3I6xhjZtjPIaMAtbcaewvJJY4juY8l30+iEk1fWtvLU7uviTC2g7C9
         FZ/BFu8ExPAHtj1JtMX47Crziu7eJXOLOEmU4vwVdsvE2aiC8s8hkxEoB/XHsFUvm7dq
         WAxT5zwPey0HIPfZv0/3pYp4X00p6GMMm0D4cZWEsNA9HCO1ca6nRHrYS5o7o7D6ZrGk
         miSChu2Z1H6HP4It/FAWUINCKv9wBltZjDZar0xYvNUDtoGOonvzajg9GENZNqGNz0N3
         nZAg==
X-Gm-Message-State: AOJu0Ywnar73geyz0qBJio79WK6C8AEVG5REn1jb86Ivjq3tA+EUm9Ip
	R4TDMzve+iqu2ckRf14SMig4Od3zXbPbxWgMrvDpnBT2Fu26VTbxyLR1MMbiIr1IiQmO1gX6YGq
	jwOw3xQIGRVV5vVa16Zb0hHpIcoIVxA==
X-Gm-Gg: ASbGnctMx7a7/3vAMMGbkraeX+hmp7DLxuHE0f0t2YofyVx5M6tS+JTFjEpJEUYLHIb
	68GrYOMOUPBt6CiXadR9abWkYfGSXU2e8AKiH1Ext2PNlrg/G2VYt5uQwLRA6QVGhI9jvxA2HuV
	cVIinU1JmFgxXQNfRSEJtV5Lle
X-Google-Smtp-Source: AGHT+IHjSeNQ8fZZ7+d5giIqSE+aKdD7fV1B1Qsxj/+Zt1afPgEwNPcy9osXgWSo9ka1boGdJmIOAao88+FfrV5wx7Y=
X-Received: by 2002:a2e:bc06:0:b0:30b:cc6a:ffd9 with SMTP id
 38308e7fff4ca-30bd789238amr18747881fa.0.1741204266523; Wed, 05 Mar 2025
 11:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304153934.112156-1-luiz.dentz@gmail.com>
In-Reply-To: <20250304153934.112156-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Mar 2025 14:50:54 -0500
X-Gm-Features: AQ5f1Jpssx16noiwfIXvEZAv71ZkMNJHYFJuMBEVuU6KwJ-xl_dSo1--OBqYImQ
Message-ID: <CABBYNZLYp9MT1hNsvRBLdstGaXj54N5MVrdBU5L943vjLuqH2g@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "Bluetooth: hci_core: Fix sleeping function
 called from invalid context"
To: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>, 
	Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli, Takashi,

On Tue, Mar 4, 2025 at 10:39=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This reverts commit 4d94f05558271654670d18c26c912da0c1c15549 which has
> problems (see [1]) and is no longer needed since 581dd2dc168f
> ("Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating")
> has reworked the code where the original bug has been found.
>
> [1] Link: https://lore.kernel.org/linux-bluetooth/877c55ci1r.wl-tiwai@sus=
e.de/T/#t
> Fixes: 4d94f0555827 ("Bluetooth: hci_core: Fix sleeping function called f=
rom invalid context")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h | 108 +++++++++++--------------------
>  net/bluetooth/hci_core.c         |  10 ++-
>  net/bluetooth/iso.c              |   6 --
>  net/bluetooth/l2cap_core.c       |  12 ++--
>  net/bluetooth/rfcomm/core.c      |   6 --
>  net/bluetooth/sco.c              |  12 ++--
>  6 files changed, 57 insertions(+), 97 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 2f320eeddfec..7966db4038cc 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -804,6 +804,7 @@ struct hci_conn_params {
>  extern struct list_head hci_dev_list;
>  extern struct list_head hci_cb_list;
>  extern rwlock_t hci_dev_list_lock;
> +extern struct mutex hci_cb_list_lock;
>
>  #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev=
_flags)
>  #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->d=
ev_flags)
> @@ -2014,47 +2015,24 @@ struct hci_cb {
>
>         char *name;
>
> -       bool (*match)           (struct hci_conn *conn);
>         void (*connect_cfm)     (struct hci_conn *conn, __u8 status);
>         void (*disconn_cfm)     (struct hci_conn *conn, __u8 status);
>         void (*security_cfm)    (struct hci_conn *conn, __u8 status,
> -                                __u8 encrypt);
> +                                                               __u8 encr=
ypt);
>         void (*key_change_cfm)  (struct hci_conn *conn, __u8 status);
>         void (*role_switch_cfm) (struct hci_conn *conn, __u8 status, __u8=
 role);
>  };
>
> -static inline void hci_cb_lookup(struct hci_conn *conn, struct list_head=
 *list)
> -{
> -       struct hci_cb *cb, *cpy;
> -
> -       rcu_read_lock();
> -       list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> -               if (cb->match && cb->match(conn)) {
> -                       cpy =3D kmalloc(sizeof(*cpy), GFP_ATOMIC);
> -                       if (!cpy)
> -                               break;
> -
> -                       *cpy =3D *cb;
> -                       INIT_LIST_HEAD(&cpy->list);
> -                       list_add_rcu(&cpy->list, list);
> -               }
> -       }
> -       rcu_read_unlock();
> -}
> -
>  static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
>  {
> -       struct list_head list;
> -       struct hci_cb *cb, *tmp;
> +       struct hci_cb *cb;
>
> -       INIT_LIST_HEAD(&list);
> -       hci_cb_lookup(conn, &list);
> -
> -       list_for_each_entry_safe(cb, tmp, &list, list) {
> +       mutex_lock(&hci_cb_list_lock);
> +       list_for_each_entry(cb, &hci_cb_list, list) {
>                 if (cb->connect_cfm)
>                         cb->connect_cfm(conn, status);
> -               kfree(cb);
>         }
> +       mutex_unlock(&hci_cb_list_lock);
>
>         if (conn->connect_cfm_cb)
>                 conn->connect_cfm_cb(conn, status);
> @@ -2062,43 +2040,22 @@ static inline void hci_connect_cfm(struct hci_con=
n *conn, __u8 status)
>
>  static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
>  {
> -       struct list_head list;
> -       struct hci_cb *cb, *tmp;
> +       struct hci_cb *cb;
>
> -       INIT_LIST_HEAD(&list);
> -       hci_cb_lookup(conn, &list);
> -
> -       list_for_each_entry_safe(cb, tmp, &list, list) {
> +       mutex_lock(&hci_cb_list_lock);
> +       list_for_each_entry(cb, &hci_cb_list, list) {
>                 if (cb->disconn_cfm)
>                         cb->disconn_cfm(conn, reason);
> -               kfree(cb);
>         }
> +       mutex_unlock(&hci_cb_list_lock);
>
>         if (conn->disconn_cfm_cb)
>                 conn->disconn_cfm_cb(conn, reason);
>  }
>
> -static inline void hci_security_cfm(struct hci_conn *conn, __u8 status,
> -                                   __u8 encrypt)
> -{
> -       struct list_head list;
> -       struct hci_cb *cb, *tmp;
> -
> -       INIT_LIST_HEAD(&list);
> -       hci_cb_lookup(conn, &list);
> -
> -       list_for_each_entry_safe(cb, tmp, &list, list) {
> -               if (cb->security_cfm)
> -                       cb->security_cfm(conn, status, encrypt);
> -               kfree(cb);
> -       }
> -
> -       if (conn->security_cfm_cb)
> -               conn->security_cfm_cb(conn, status);
> -}
> -
>  static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
>  {
> +       struct hci_cb *cb;
>         __u8 encrypt;
>
>         if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
> @@ -2106,11 +2063,20 @@ static inline void hci_auth_cfm(struct hci_conn *=
conn, __u8 status)
>
>         encrypt =3D test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x0=
0;
>
> -       hci_security_cfm(conn, status, encrypt);
> +       mutex_lock(&hci_cb_list_lock);
> +       list_for_each_entry(cb, &hci_cb_list, list) {
> +               if (cb->security_cfm)
> +                       cb->security_cfm(conn, status, encrypt);
> +       }
> +       mutex_unlock(&hci_cb_list_lock);
> +
> +       if (conn->security_cfm_cb)
> +               conn->security_cfm_cb(conn, status);
>  }
>
>  static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
>  {
> +       struct hci_cb *cb;
>         __u8 encrypt;
>
>         if (conn->state =3D=3D BT_CONFIG) {
> @@ -2137,38 +2103,40 @@ static inline void hci_encrypt_cfm(struct hci_con=
n *conn, __u8 status)
>                         conn->sec_level =3D conn->pending_sec_level;
>         }
>
> -       hci_security_cfm(conn, status, encrypt);
> +       mutex_lock(&hci_cb_list_lock);
> +       list_for_each_entry(cb, &hci_cb_list, list) {
> +               if (cb->security_cfm)
> +                       cb->security_cfm(conn, status, encrypt);
> +       }
> +       mutex_unlock(&hci_cb_list_lock);
> +
> +       if (conn->security_cfm_cb)
> +               conn->security_cfm_cb(conn, status);
>  }
>
>  static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status=
)
>  {
> -       struct list_head list;
> -       struct hci_cb *cb, *tmp;
> +       struct hci_cb *cb;
>
> -       INIT_LIST_HEAD(&list);
> -       hci_cb_lookup(conn, &list);
> -
> -       list_for_each_entry_safe(cb, tmp, &list, list) {
> +       mutex_lock(&hci_cb_list_lock);
> +       list_for_each_entry(cb, &hci_cb_list, list) {
>                 if (cb->key_change_cfm)
>                         cb->key_change_cfm(conn, status);
> -               kfree(cb);
>         }
> +       mutex_unlock(&hci_cb_list_lock);
>  }
>
>  static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 statu=
s,
>                                                                 __u8 role=
)
>  {
> -       struct list_head list;
> -       struct hci_cb *cb, *tmp;
> +       struct hci_cb *cb;
>
> -       INIT_LIST_HEAD(&list);
> -       hci_cb_lookup(conn, &list);
> -
> -       list_for_each_entry_safe(cb, tmp, &list, list) {
> +       mutex_lock(&hci_cb_list_lock);
> +       list_for_each_entry(cb, &hci_cb_list, list) {
>                 if (cb->role_switch_cfm)
>                         cb->role_switch_cfm(conn, status, role);
> -               kfree(cb);
>         }
> +       mutex_unlock(&hci_cb_list_lock);
>  }
>
>  static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e7ec12437c8b..012fc107901a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -57,6 +57,7 @@ DEFINE_RWLOCK(hci_dev_list_lock);
>
>  /* HCI callback list */
>  LIST_HEAD(hci_cb_list);
> +DEFINE_MUTEX(hci_cb_list_lock);
>
>  /* HCI ID Numbering */
>  static DEFINE_IDA(hci_index_ida);
> @@ -2972,7 +2973,9 @@ int hci_register_cb(struct hci_cb *cb)
>  {
>         BT_DBG("%p name %s", cb, cb->name);
>
> -       list_add_tail_rcu(&cb->list, &hci_cb_list);
> +       mutex_lock(&hci_cb_list_lock);
> +       list_add_tail(&cb->list, &hci_cb_list);
> +       mutex_unlock(&hci_cb_list_lock);
>
>         return 0;
>  }
> @@ -2982,8 +2985,9 @@ int hci_unregister_cb(struct hci_cb *cb)
>  {
>         BT_DBG("%p name %s", cb, cb->name);
>
> -       list_del_rcu(&cb->list);
> -       synchronize_rcu();
> +       mutex_lock(&hci_cb_list_lock);
> +       list_del(&cb->list);
> +       mutex_unlock(&hci_cb_list_lock);
>
>         return 0;
>  }
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 44acddf58a0c..0cb52a3308ba 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2187,11 +2187,6 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t=
 *bdaddr, __u8 *flags)
>         return HCI_LM_ACCEPT;
>  }
>
> -static bool iso_match(struct hci_conn *hcon)
> -{
> -       return hcon->type =3D=3D ISO_LINK || hcon->type =3D=3D LE_LINK;
> -}
> -
>  static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
>  {
>         if (hcon->type !=3D ISO_LINK) {
> @@ -2373,7 +2368,6 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff=
 *skb, u16 flags)
>
>  static struct hci_cb iso_cb =3D {
>         .name           =3D "ISO",
> -       .match          =3D iso_match,
>         .connect_cfm    =3D iso_connect_cfm,
>         .disconn_cfm    =3D iso_disconn_cfm,
>  };
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d21267261a5e..7b4adab353cf 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7182,11 +7182,6 @@ static struct l2cap_chan *l2cap_global_fixed_chan(=
struct l2cap_chan *c,
>         return NULL;
>  }
>
> -static bool l2cap_match(struct hci_conn *hcon)
> -{
> -       return hcon->type =3D=3D ACL_LINK || hcon->type =3D=3D LE_LINK;
> -}
> -
>  static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
>  {
>         struct hci_dev *hdev =3D hcon->hdev;
> @@ -7194,6 +7189,9 @@ static void l2cap_connect_cfm(struct hci_conn *hcon=
, u8 status)
>         struct l2cap_chan *pchan;
>         u8 dst_type;
>
> +       if (hcon->type !=3D ACL_LINK && hcon->type !=3D LE_LINK)
> +               return;
> +
>         BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status)=
;
>
>         if (status) {
> @@ -7258,6 +7256,9 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
>
>  static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
>  {
> +       if (hcon->type !=3D ACL_LINK && hcon->type !=3D LE_LINK)
> +               return;
> +
>         BT_DBG("hcon %p reason %d", hcon, reason);
>
>         l2cap_conn_del(hcon, bt_to_errno(reason));
> @@ -7565,7 +7566,6 @@ void l2cap_recv_acldata(struct hci_conn *hcon, stru=
ct sk_buff *skb, u16 flags)
>
>  static struct hci_cb l2cap_cb =3D {
>         .name           =3D "L2CAP",
> -       .match          =3D l2cap_match,
>         .connect_cfm    =3D l2cap_connect_cfm,
>         .disconn_cfm    =3D l2cap_disconn_cfm,
>         .security_cfm   =3D l2cap_security_cfm,
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 4c56ca5a216c..ad5177e3a69b 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -2134,11 +2134,6 @@ static int rfcomm_run(void *unused)
>         return 0;
>  }
>
> -static bool rfcomm_match(struct hci_conn *hcon)
> -{
> -       return hcon->type =3D=3D ACL_LINK;
> -}
> -
>  static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 enc=
rypt)
>  {
>         struct rfcomm_session *s;
> @@ -2185,7 +2180,6 @@ static void rfcomm_security_cfm(struct hci_conn *co=
nn, u8 status, u8 encrypt)
>
>  static struct hci_cb rfcomm_cb =3D {
>         .name           =3D "RFCOMM",
> -       .match          =3D rfcomm_match,
>         .security_cfm   =3D rfcomm_security_cfm
>  };
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index ed6846864ea9..5d1bc0d6aee0 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1407,13 +1407,11 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_=
t *bdaddr, __u8 *flags)
>         return lm;
>  }
>
> -static bool sco_match(struct hci_conn *hcon)
> -{
> -       return hcon->type =3D=3D SCO_LINK || hcon->type =3D=3D ESCO_LINK;
> -}
> -
>  static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
>  {
> +       if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)
> +               return;
> +
>         BT_DBG("hcon %p bdaddr %pMR status %u", hcon, &hcon->dst, status)=
;
>
>         if (!status) {
> @@ -1430,6 +1428,9 @@ static void sco_connect_cfm(struct hci_conn *hcon, =
__u8 status)
>
>  static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>  {
> +       if (hcon->type !=3D SCO_LINK && hcon->type !=3D ESCO_LINK)
> +               return;
> +
>         BT_DBG("hcon %p reason %d", hcon, reason);
>
>         sco_conn_del(hcon, bt_to_errno(reason));
> @@ -1455,7 +1456,6 @@ void sco_recv_scodata(struct hci_conn *hcon, struct=
 sk_buff *skb)
>
>  static struct hci_cb sco_cb =3D {
>         .name           =3D "SCO",
> -       .match          =3D sco_match,
>         .connect_cfm    =3D sco_connect_cfm,
>         .disconn_cfm    =3D sco_disconn_cfm,
>  };
> --
> 2.48.1
>

Are you guys ok if I push this?


--=20
Luiz Augusto von Dentz
