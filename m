Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753E1DC075
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755114; cv=none; b=gy+p7WDhs6MX0VSwriWm53Xh55vLTUTq928Sm9OcKrXDM9YItxgxMmT/M49HEutRI515bRHB8ns6sjlV/j+QrAUXCYRzlpSsyt4B0k/u/MElHODyqnm01sUySsEHNNFOPFxIp0GUjtUBeV/ryh/iHSBQqQBZwGDv0vL8fAJXhiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755114; c=relaxed/simple;
	bh=cS2GEG/SEfNDit7E8UmqRLcooLHbri0ul3wH82ja4hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMbeIWixKS6h0MjVhphlyE1ryNomKDTeSAKjIyugxaGQdZSxp0Gf6fqaIZM2iiORKxb9RK2jj5gDfIKXU9KRR8HQbar+8M91nMuqEaRr7DN33h/PEiBJ74Ox7dydOwanOZb7572e8YlNln994DENKJMbbvCe2/owLeSEIO9VEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgafDCXV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgafDCXV"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3292aad800aso8564031fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747755110; x=1748359910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iQQitNpI1d9W11Y+ybk4KncC+8fTtkCJu4tqTZMSmk=;
        b=hgafDCXVa/PixLW4d0eLNUOYwL6qTXoLNzklo516/gCN0iieRc2ehtGTP1aTWOY+bi
         kMrn0vzXfkxa1Tgk5d752ByxvxeGWwQ8gUC+0J8MXX23tBozIBHxNwTH4ZYrttx/MLKh
         Ma3Cmby847sHoQ3+hwqhbpjSoH4DNJJ2+sdizRARjJ7Pj1hV7EAg0ki0oFMWZB4osFk+
         nQroX5+wYhUAB7SFOq1CZ1J2tjQ6W5ueklVdwgRMD2VUBZuzO/HgbkMMPS0kVGjGnFL8
         Z2//kl4C+/2qair+sl9yYGA6KOjv4LGcx1oim9KkmWXsen0aHWKr7uNdLfNzQF7gEULl
         JE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755110; x=1748359910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iQQitNpI1d9W11Y+ybk4KncC+8fTtkCJu4tqTZMSmk=;
        b=wu+H6pwtmEoLEm9BLmhatADaqEtQ6ciLaZlMXLYVSMP0CUZaqBvjgRfG8MngFfA9Pg
         6DBVMDrbpZJUUYdCNtFXFcnrTYDjxgBvuKFuJN7Nzxiz1Z/oaFPaBmStiDeP4I+tVImf
         lGF92hEW0oc2yqMIlYugCQSayztSJHAUULNa1lhZr18T1722rbRP6nNlw1JwjAv347E/
         QOVEy0wh673NE54PGAHuAcAsmtlTwcAPD39qA1Vm3ouf1SFPifn+Yu2LYbxu808VKPTf
         xV2fQhE1kCeTpFbXefK2kp1fzf82N/M+fqg8JiW8xL3o5wzwOrqd2AfnkMWZHllImcFw
         EBig==
X-Forwarded-Encrypted: i=1; AJvYcCUT/3DZB/3J4z5SzN07Uuc+fF95cojM8+OtreBfbATPlLrvxBySCMSKTumJXYrFxqUU0KmP14EODINuKnDJnpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1BgITyrtwBgwn2c5giO17N+7mRaQKFt27VFBG46MKS+p4wk5f
	jBhpPqTOY1791GHxJNwgm0gm4GixLM52z2mxGLuGDEeMQwUT0CoZa4gQSCtS0SWZm0BXk+71dKF
	+4H20LlsjSGpF1LrGJ4jcYY1YoU9vycU=
X-Gm-Gg: ASbGnctEZzhTwFa3D1twCDEGI9G2v01PVb31ciodrfXVu4eUnrPlDBmTPzRzx0xHQ9B
	E8LUoaJOiBnOaAHG8/4ZvNQr+lkJGxg0nJBYluuImV2FKm6v6Z9JCwap2a/yE1zVsupwiBEH+f7
	8X1twPErJn2VZpC1HkOB9ubG/A29yYNwk=
X-Google-Smtp-Source: AGHT+IF6D6ijr5Og/3hKzLkaKvRRn1IeK2yuUjuenmboaFmLdkwUkreith6biTp0fAuli/mlYj5bxnPyB94NvUDyOq4=
X-Received: by 2002:a05:651c:1b12:b0:30c:1aa6:5565 with SMTP id
 38308e7fff4ca-328084c30cdmr49240331fa.20.1747755109818; Tue, 20 May 2025
 08:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLJGwmPSe9Me+OLpr8WLGOenRrwJt_JxVmWfPO_X1YWJg@mail.gmail.com>
 <20250520144935.595774-1-dmantipov@yandex.ru>
In-Reply-To: <20250520144935.595774-1-dmantipov@yandex.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 May 2025 11:31:36 -0400
X-Gm-Features: AX0GCFtQL0gOLUSwdD8nkZFzzQkYb3OnA4Q7GRk-8tFJDdIxHPEdWYrVbtCfWpU
Message-ID: <CABBYNZ+i56pg+Rs=mu8HvJ1LC+aeyDAt7=pYJ3ksNOrehj0ZUQ@mail.gmail.com>
Subject: Re: [PATCH RFC] Bluetooth: use RCU-protected list to process mgmt commands
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, May 20, 2025 at 10:50=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> An overall idea is that 'mgmt_pending' of 'struct hci_dev' may be altered
> only in 'mgmt_pending_add()' under 'mgmt_lock' protection, where processe=
d
> commands are removed each time when the new command is added. All other
> users of 'mgmt_pending' (except 'mgmt_pending_cleanup()' where no
> concurrent accesses are expected) are read-side critical sections running
> under 'rcu_read_lock()'. (I'm also trying to fix socket UAFs observed whe=
n
> running this code, and most likely these fixes should go to the separate
> patch).
>
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  include/net/bluetooth/bluetooth.h |  1 +
>  include/net/bluetooth/hci_core.h  |  1 +
>  net/bluetooth/hci_core.c          |  6 +--
>  net/bluetooth/mgmt.c              | 65 ++++++++++++++++++++++---------
>  net/bluetooth/mgmt_util.c         | 55 ++++++++++++++++++++------
>  net/bluetooth/mgmt_util.h         |  3 ++
>  6 files changed, 96 insertions(+), 35 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index bbefde319f95..cee6be23acc8 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -655,6 +655,7 @@ static inline bool iso_enabled(void)
>  int mgmt_init(void);
>  void mgmt_exit(void);
>  void mgmt_cleanup(struct sock *sk);
> +void mgmt_pending_cleanup(struct hci_dev *hdev);
>
>  void bt_sock_reclassify_lock(struct sock *sk, int proto);
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 54bfeeaa0995..2fb586c6d684 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -546,6 +546,7 @@ struct hci_dev {
>
>         struct list_head        mesh_pending;
>         struct list_head        mgmt_pending;
> +       struct mutex            mgmt_lock;
>         struct list_head        reject_list;
>         struct list_head        accept_list;
>         struct list_head        uuids;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5eb0600bbd03..0172ec45f2df 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2492,6 +2492,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>
>         INIT_LIST_HEAD(&hdev->mesh_pending);
>         INIT_LIST_HEAD(&hdev->mgmt_pending);
> +       mutex_init(&hdev->mgmt_lock);
>         INIT_LIST_HEAD(&hdev->reject_list);
>         INIT_LIST_HEAD(&hdev->accept_list);
>         INIT_LIST_HEAD(&hdev->uuids);
> @@ -2685,10 +2686,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>                 hci_dev_unlock(hdev);
>         }
>
> -       /* mgmt_index_removed should take care of emptying the
> -        * pending list */
> -       BUG_ON(!list_empty(&hdev->mgmt_pending));
> -
> +       mgmt_pending_cleanup(hdev);
>         hci_sock_dev_event(hdev, HCI_DEV_UNREG);
>
>         if (hdev->rfkill) {
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 46b22708dfbd..e2eccc44076d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1444,25 +1444,30 @@ struct cmd_lookup {
>  static void settings_rsp(struct mgmt_pending_cmd *cmd, void *data)
>  {
>         struct cmd_lookup *match =3D data;
> +       struct sock *sk =3D cmd->sk;
>
> -       send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
> -
> -       list_del(&cmd->list);
> +       sock_hold(sk);
>
> -       if (match->sk =3D=3D NULL) {
> -               match->sk =3D cmd->sk;
> -               sock_hold(match->sk);
> -       }
> +       send_settings_rsp(sk, cmd->opcode, match->hdev);
> +       mgmt_pending_remove(cmd);
>
> -       mgmt_pending_free(cmd);
> +       if (match->sk =3D=3D NULL)
> +               match->sk =3D sk;
> +       else
> +               sock_put(sk);
>  }
>
>  static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
>  {
> +       struct sock *sk =3D cmd->sk;
>         u8 *status =3D data;
>
> +       sock_hold(sk);
> +
>         mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, *status);
>         mgmt_pending_remove(cmd);
> +
> +       sock_put(sk);
>  }
>
>  static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
> @@ -2598,18 +2603,25 @@ static int mgmt_hci_cmd_sync(struct sock *sk, str=
uct hci_dev *hdev,
>  static bool pending_eir_or_class(struct hci_dev *hdev)
>  {
>         struct mgmt_pending_cmd *cmd;
> +       bool found =3D false;
> +
> +       rcu_read_lock();
>
> -       list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> +       list_for_each_entry_rcu(cmd, &hdev->mgmt_pending, list) {
> +               if (atomic_read(&cmd->deleted))
> +                   continue;
>                 switch (cmd->opcode) {
>                 case MGMT_OP_ADD_UUID:
>                 case MGMT_OP_REMOVE_UUID:
>                 case MGMT_OP_SET_DEV_CLASS:
>                 case MGMT_OP_SET_POWERED:
> -                       return true;
> +                       found =3D true;
> +                       break;
>                 }
>         }
>
> -       return false;
> +       rcu_read_unlock();
> +       return found;
>  }
>
>  static const u8 bluetooth_base_uuid[] =3D {
> @@ -3401,19 +3413,23 @@ static int set_io_capability(struct sock *sk, str=
uct hci_dev *hdev, void *data,
>  static struct mgmt_pending_cmd *find_pairing(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> -       struct mgmt_pending_cmd *cmd;
> +       struct mgmt_pending_cmd *tmp, *cmd =3D NULL;
>
> -       list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> -               if (cmd->opcode !=3D MGMT_OP_PAIR_DEVICE)
> -                       continue;
> +       rcu_read_lock();
>
> -               if (cmd->user_data !=3D conn)
> +       list_for_each_entry(tmp, &hdev->mgmt_pending, list) {
> +               if (atomic_read(&tmp->deleted))
>                         continue;
> -
> -               return cmd;
> +               if (tmp->opcode !=3D MGMT_OP_PAIR_DEVICE)
> +                       continue;
> +               if (tmp->user_data !=3D conn)
> +                       continue;
> +               cmd =3D tmp;
> +               break;
>         }
>
> -       return NULL;
> +       rcu_read_unlock();
> +       return cmd;
>  }
>
>  static int pairing_complete(struct mgmt_pending_cmd *cmd, u8 status)
> @@ -10476,3 +10492,14 @@ void mgmt_cleanup(struct sock *sk)
>
>         read_unlock(&hci_dev_list_lock);
>  }
> +
> +void mgmt_pending_cleanup(struct hci_dev *hdev)
> +{
> +       struct mgmt_pending_cmd *cmd, *tmp;
> +
> +       list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
> +               BUG_ON(atomic_read(&cmd->deleted) =3D=3D 0);
> +               list_del_rcu(&cmd->list);
> +               mgmt_pending_free(cmd);
> +       }
> +}
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 3713ff490c65..3442bd37fa52 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -217,30 +217,45 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u=
16 cmd, u8 status,
>  struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 o=
pcode,
>                                            struct hci_dev *hdev)
>  {
> -       struct mgmt_pending_cmd *cmd;
> +       struct mgmt_pending_cmd *tmp, *cmd =3D NULL;
> +
> +       rcu_read_lock();
>
> -       list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> -               if (hci_sock_get_channel(cmd->sk) !=3D channel)
> +       list_for_each_entry_rcu(tmp, &hdev->mgmt_pending, list) {
> +               if (atomic_read(&tmp->deleted))
>                         continue;
> -               if (cmd->opcode =3D=3D opcode)
> -                       return cmd;
> +               if (hci_sock_get_channel(tmp->sk) !=3D channel)
> +                       continue;
> +               if (tmp->opcode =3D=3D opcode) {
> +                       cmd =3D tmp;
> +                       break;
> +               }
>         }
>
> -       return NULL;
> +       rcu_read_unlock();
> +       return cmd;
>  }
>
>  void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
>                           void (*cb)(struct mgmt_pending_cmd *cmd, void *=
data),
>                           void *data)
>  {
> -       struct mgmt_pending_cmd *cmd, *tmp;
> +       struct mgmt_pending_cmd *cmd;
>
> -       list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
> +       rcu_read_lock();
> +
> +       list_for_each_entry_rcu(cmd, &hdev->mgmt_pending, list) {
> +               if (atomic_read(&cmd->deleted))
> +                       continue;
>                 if (opcode > 0 && cmd->opcode !=3D opcode)
>                         continue;
>
> +               rcu_read_unlock();
>                 cb(cmd, data);
> +               rcu_read_lock();
>         }
> +
> +       rcu_read_unlock();
>  }
>
>  struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
> @@ -270,17 +285,34 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct so=
ck *sk, u16 opcode,
>         return cmd;
>  }
>
> +static void mgmt_pending_delayed_free(struct rcu_head *rcu)
> +{
> +       struct mgmt_pending_cmd *cmd =3D
> +               container_of(rcu, struct mgmt_pending_cmd, head);
> +       kfree(cmd->param);
> +       kfree(cmd);
> +}
> +
>  struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
>                                           struct hci_dev *hdev,
>                                           void *data, u16 len)
>  {
> -       struct mgmt_pending_cmd *cmd;
> +       struct mgmt_pending_cmd *cmd, *old, *tmp;
>
>         cmd =3D mgmt_pending_new(sk, opcode, hdev, data, len);
>         if (!cmd)
>                 return NULL;
>
> -       list_add_tail(&cmd->list, &hdev->mgmt_pending);
> +       mutex_lock(&hdev->mgmt_lock);
> +       list_for_each_entry_safe(old, tmp, &hdev->mgmt_pending, list)
> +               if (atomic_read(&old->deleted)) {
> +                       list_del_rcu(&old->list);
> +                       sock_put(old->sk);
> +                       call_rcu(&old->head, mgmt_pending_delayed_free);
> +               }
> +
> +       list_add_tail_rcu(&cmd->list, &hdev->mgmt_pending);
> +       mutex_unlock(&hdev->mgmt_lock);
>
>         return cmd;
>  }
> @@ -294,8 +326,7 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
>
>  void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
>  {
> -       list_del(&cmd->list);
> -       mgmt_pending_free(cmd);
> +       atomic_set(&cmd->deleted, 1);

I'm afraid you were not looking into other places of the code
regarding this, what you should have done is:

list_del_rcu
synchronize_rcu
free

synchronize_rcu will wait the threads holding rcu_read_lock so by the
time it returns we can proceed to free because all existing readers
should be done already and if in the meantime another thread attempts
to iterate in the list that shall already been update given that
list_del_rcu has updated the list.

>  }
>
>  void mgmt_mesh_foreach(struct hci_dev *hdev,
> diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> index f2ba994ab1d8..5e681bc74220 100644
> --- a/net/bluetooth/mgmt_util.h
> +++ b/net/bluetooth/mgmt_util.h
> @@ -32,6 +32,8 @@ struct mgmt_mesh_tx {
>
>  struct mgmt_pending_cmd {
>         struct list_head list;
> +       struct rcu_head head;
> +       atomic_t deleted;
>         u16 opcode;
>         int index;
>         void *param;
> @@ -65,6 +67,7 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *=
sk, u16 opcode,
>                                           void *data, u16 len);
>  void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
>  void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
> +void mgmt_pending_cleanup(struct hci_dev *hdev);
>  void mgmt_mesh_foreach(struct hci_dev *hdev,
>                        void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *dat=
a),
>                        void *data, struct sock *sk);
> --
> 2.49.0
>


--=20
Luiz Augusto von Dentz
