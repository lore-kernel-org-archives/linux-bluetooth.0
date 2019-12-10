Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BB0C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B80D2077B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROSMawzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfLJUBd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:01:33 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:40425 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLJUBd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 15:01:33 -0500
Received: by mail-lf1-f53.google.com with SMTP id i23so2289476lfo.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2019 12:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8YgCMry5pKFoAKkPqsYTeZQRL9SDsAiXrarHQ7z7RsA=;
        b=ROSMawzrYpYzgM6jYQ1PG4UMuBe/kkAcVtMMTjtjb50+AZ3YKAPaLIgwabM2/kHotw
         lRn6UNiaCOv7iGfz/o0h1canGNwkLfcRuLXIj6S/mf9wz+TErs7UPIV49PsUBO0dBPfK
         YuP9aEb1IOg3UFVMuK0Wq7JMVvwJczxtW7G61ifwFqcX1ChvY1uMmo/7vJlF7dNCXZ4d
         YnmbsUxuTQWCxgpRU1uAxf7LloLuc3PuWuh+dEnXsStZJ/J7vM+lxIx67Yi904BpBTsY
         HBIJgS5BoOpy05P2o6ExHDEHi19v4K+MB5Pcg3TPitvKw6wdPcae84jDZAx5GSDB1w0N
         8Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=8YgCMry5pKFoAKkPqsYTeZQRL9SDsAiXrarHQ7z7RsA=;
        b=RoTtugnWEWg7Txd8yAHE58qM5kLLSr9+2P9R9nPGdbmBJYOVOsorekfN+Td0RPQMhS
         bMk0bmK+tnm9GxiEXF7UayMU8A8b+vUlG3SPRbNq5zsVkQjVSXxrgbIGfCPA8zJ8d+Ui
         lxIQubjA03Wte3hC1gSXTdps7uSgmh8DfMjtB4q9j1L9t9p4cMwCgaBpzLxBSlrPry8b
         /igqYCXdUgsUAJLvK0CYGDLim5cUgQVET2DDZgp/Q9U/faDuXgNToqmmd7SidaR19Pyb
         M9hdB8EFOFvOMfEnF3JLPGLGONRE0BX431iEpE8Wh2pHHKLJOnPj6Q3vY+PrgeQDSRJC
         UnPg==
X-Gm-Message-State: APjAAAVmy0jxMkSkdZjf+NDau8+oN0DIrElhEUPBVSVB0p+xfwE5anDq
        k45xBjIAUQhk+c0I2b4raPtDunadGYZ4nbjGDiYkKnkJ
X-Google-Smtp-Source: APXvYqz9SOM/fd/yCwzVCF9NtEGu1obQA66fsAhcIa4XLxmYQv/9aK/lsMg0NUXREmcIZ8Lo0IZS9vMl4EnvLCd4akw=
X-Received: by 2002:a19:114:: with SMTP id 20mr8210454lfb.25.1576008089161;
 Tue, 10 Dec 2019 12:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20191209220551.117763-1-alainm@chromium.org> <EAA33AF4-A522-47BF-9775-7B1811B44973@holtmann.org>
 <CALWDO_W72mFVqMacjLgLGjY+jf4U=4ggQw-YX39dX78ckNDohw@mail.gmail.com>
In-Reply-To: <CALWDO_W72mFVqMacjLgLGjY+jf4U=4ggQw-YX39dX78ckNDohw@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 10 Dec 2019 15:01:17 -0500
Message-ID: <CALWDO_VuctheAP4xVc1rQCgz1rHBdYnGrkY7RzH6rcx_NPhyLA@mail.gmail.com>
Subject: RE: [PATCH] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
To:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Resending in plain text mode, sorry about that.

---------- Forwarded message ---------
From: Alain Michaud <alainmichaud@google.com>
Date: Tue, Dec 10, 2019 at 2:12 PM
Subject: Re: [PATCH] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alain Michaud <alainm@chromium.org>, BlueZ <linux-bluetooth@vger.kernel=
.org>




On Tue, Dec 10, 2019 at 3:20 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> > MGMT command is added to receive the list of blocked keys from user-spa=
ce.
> > The list is used to:
> > 1) Block keys from being distributed by the device during the key
> > distribution phase of SMP.
> > 2) Filter out any keys that were previously saved so they are no longer
> > used.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > include/net/bluetooth/bluetooth.h |  4 +++
> > include/net/bluetooth/hci_core.h  |  9 +++++
> > include/net/bluetooth/mgmt.h      | 17 +++++++++
> > net/bluetooth/hci_core.c          | 57 +++++++++++++++++++++++++++++++
> > net/bluetooth/lib.c               | 16 +++++++++
> > net/bluetooth/mgmt.c              | 48 ++++++++++++++++++++++++++
> > net/bluetooth/smp.c               | 11 ++++++
> > 7 files changed, 162 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index fabee6db0abb..92b0e6889f8c 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -127,12 +127,16 @@ void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > void bt_warn(const char *fmt, ...);
> > __printf(1, 2)
> > +void bt_warn_ratelimited(const char *fmt, ...);
> > +__printf(1, 2)
> > void bt_err(const char *fmt, ...);
> > __printf(1, 2)
> > void bt_err_ratelimited(const char *fmt, ...);
> >
> > #define BT_INFO(fmt, ...)     bt_info(fmt "\n", ##__VA_ARGS__)
> > #define BT_WARN(fmt, ...)     bt_warn(fmt "\n", ##__VA_ARGS__)
> > +#define BT_WARN_RATELIMITED(fmt, ...)                \
> > +     bt_warn_ratelimited(fmt "\n", ##__VA_ARGS__)
>
> lets move this one to the BT_ERR_RATELIMITED to keep that set of error fu=
nction together. And I prefer to have this as a separate patch.
>
>
> > #define BT_ERR(fmt, ...)      bt_err(fmt "\n", ##__VA_ARGS__)
> > #define BT_DBG(fmt, ...)      pr_debug(fmt "\n", ##__VA_ARGS__)
>
> Now I started to look at BT_ERR_RATELIMITED and I realized that we should=
 have fixed one thing a long time ago. Some functions have been moved over =
to bt_dev_err_ratelimited. And that is what I should have told you to intro=
duce a bt_dev_warn_ratelimited function so that the hdev is always listed a=
s well and we know which controller caused this.
>
> The BT_ERR_RATELIMITED should have been eradicated from the source code s=
ince it is rather useless not providing proper context of the error.
>
> Whenever possible, we should have used bt_dev_* functions. Do you want to=
 send preparation patches to rectify this issue or should I do it?

[alain] Happy to look at this separately.  Perhaps by introducing
bt_dev_warn_ratelimited then parenting the other patch on top of that
one.  I'll wait for your confirmation before proceeding in this
direction.
>
>
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index b689aceb636b..e9a789e11493 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -118,6 +118,13 @@ struct bt_uuid {
> >       u8 svc_hint;
> > };
> >
> > +struct blocked_key {
> > +     struct list_head list;
> > +     struct rcu_head rcu;
> > +     u8 type;
> > +     u8 val[16];
> > +};
> > +
> > struct smp_csrk {
> >       bdaddr_t bdaddr;
> >       u8 bdaddr_type;
> > @@ -397,6 +404,7 @@ struct hci_dev {
> >       struct list_head        le_conn_params;
> >       struct list_head        pend_le_conns;
> >       struct list_head        pend_le_reports;
> > +     struct list_head        blocked_keys;
> >
> >       struct hci_dev_stats    stat;
> >
> > @@ -1121,6 +1129,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_d=
ev *hdev, bdaddr_t *bdaddr,
> > struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
> >                           u8 addr_type, u8 val[16], bdaddr_t *rpa);
> > void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_typ=
e);
> > +bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
> > void hci_smp_irks_clear(struct hci_dev *hdev);
> >
> > bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 ty=
pe);
> > diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.=
h
> > index 9cee7ddc6741..c9b1d39d6d6c 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -654,6 +654,23 @@ struct mgmt_cp_set_phy_confguration {
> > } __packed;
> > #define MGMT_SET_PHY_CONFIGURATION_SIZE       4
> >
> > +#define MGMT_OP_SET_BLOCKED_KEYS     0x0046
> > +
> > +#define HCI_BLOCKED_KEY_TYPE_LINKKEY 0x00
> > +#define HCI_BLOCKED_KEY_TYPE_LTK             0x01
> > +#define HCI_BLOCKED_KEY_TYPE_IRK             0x02
> > +
> > +struct mgmt_blocked_key_info {
> > +     __u8 type;
> > +     __u8 val[16];
> > +} __packed;
> > +
> > +struct mgmt_cp_set_blocked_keys {
> > +     __le16 key_count;
> > +     struct mgmt_blocked_key_info keys[0];
> > +} __packed;
> > +#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0
> > +
> > #define MGMT_EV_CMD_COMPLETE          0x0001
> > struct mgmt_ev_cmd_complete {
> >       __le16  opcode;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 9e19d5a3aac8..d6fab1e5d879 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2311,6 +2311,33 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
> >       }
> > }
> >
> > +static void hci_blocked_keys_clear(struct hci_dev *hdev)
> > +{
> > +     struct blocked_key *b;
> > +
> > +     list_for_each_entry_rcu(b, &hdev->blocked_keys, list) {
> > +             list_del_rcu(&b->list);
> > +             kfree_rcu(b, rcu);
> > +     }
> > +}
> > +
> > +bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16])
> > +{
> > +     bool blocked =3D false;
> > +     struct blocked_key *b;
> > +
> > +     rcu_read_lock();
> > +     list_for_each_entry(b, &hdev->blocked_keys, list) {
> > +             if (b->type =3D=3D type && !memcmp(b->val, val, sizeof(b-=
>val))) {
> > +                     blocked =3D true;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     rcu_read_unlock();
> > +     return blocked;
> > +}
> > +
> > struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdad=
dr)
> > {
> >       struct link_key *k;
> > @@ -2319,6 +2346,14 @@ struct link_key *hci_find_link_key(struct hci_de=
v *hdev, bdaddr_t *bdaddr)
> >       list_for_each_entry_rcu(k, &hdev->link_keys, list) {
> >               if (bacmp(bdaddr, &k->bdaddr) =3D=3D 0) {
> >                       rcu_read_unlock();
> > +
> > +                     if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE=
_LINKKEY,
> > +                                                                     k=
->val)) {
>
> So the netdev indentation style is different. Checkpatch needs to use --s=
trict to use these.
>
>                 if (hci_is_blocked_key(hdev, ..
>                                        k->val)) {
>
>
> > +                             BT_WARN_RATELIMITED("Key blocked for %pMR=
", &k->bdaddr);
> > +
>
> This empty line should not be here. And I would Use =E2=80=9CLink key blo=
cked..=E2=80=9D here.
>
> > +                             return NULL;
> > +                     }
> > +
> >                       return k;
> >               }
> >       }
> > @@ -2387,6 +2422,12 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hde=
v, bdaddr_t *bdaddr,
> >
> >               if (smp_ltk_is_sc(k) || ltk_role(k->type) =3D=3D role) {
> >                       rcu_read_unlock();
> > +
> > +                     if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE=
_LTK, k->val)) {
> > +                             BT_WARN_RATELIMITED("Key blocked for %pMR=
", &k->bdaddr);
>
> Here I would write =E2=80=9CLong term key blocked..=E2=80=9D
>
> > +                             return NULL;
> > +                     }
> > +
> >                       return k;
> >               }
> >       }
> > @@ -2401,6 +2442,11 @@ struct smp_irk *hci_find_irk_by_rpa(struct hci_d=
ev *hdev, bdaddr_t *rpa)
> >
> >       rcu_read_lock();
> >       list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list=
) {
> > +             if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK, ir=
k->val)) {
> > +                     BT_WARN_RATELIMITED("Key blocked for %pMR", &irk-=
>bdaddr);
>
> Here I would do =E2=80=9CIdentity resolving key blocked..=E2=80=9D.
>
> > +                     continue;
> > +             }
> > +
> >               if (!bacmp(&irk->rpa, rpa)) {
> >                       rcu_read_unlock();
> >                       return irk;
> > @@ -2408,6 +2454,11 @@ struct smp_irk *hci_find_irk_by_rpa(struct hci_d=
ev *hdev, bdaddr_t *rpa)
> >       }
> >
> >       list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list=
) {
> > +             if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK, ir=
k->val)) {
> > +                     BT_WARN_RATELIMITED("Key blocked for %pMR", &irk-=
>bdaddr);
> > +                     continue;
> > +             }
> > +
>
> Do we have to run through the list here again. I think we rather instead =
of return irk, we use a goto+label and do the check for the vulnerable IRK =
at the end of the function.

[alain] That's definitely another way and may be more efficient.  I'll
make the change.
>
>
>  struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
>  {
> -       struct smp_irk *irk;
> +       struct smp_irk *irk =3D NULL;
>
>         rcu_read_lock();
>         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list=
) {
> -               if (!bacmp(&irk->rpa, rpa)) {
> -                       rcu_read_unlock();
> -                       return irk;
> -               }
> +               if (!bacmp(&irk->rpa, rpa))
> +                       goto done;
>         }
>
>         list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list=
) {
>                 if (smp_irk_matches(hdev, irk->val, rpa)) {
>                         bacpy(&irk->rpa, rpa);
> -                       rcu_read_unlock();
> -                       return irk;
> +                       goto done;
>                 }
>         }
>         rcu_read_unlock();
>
> -       return NULL;
> +done:
> +       if (irk && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
> +                                     irk->val)) {
> +               bt_dev_warn_ratelimited("Identity resolving key blocked f=
or %pMR",
> +                                       &irk->bdaddr);
> +               irk =3D NULL;
> +       }
> +
> +       return irk;
>  }
>
>
> >               if (smp_irk_matches(hdev, irk->val, rpa)) {
> >                       bacpy(&irk->rpa, rpa);
> >                       rcu_read_unlock();
> > @@ -2430,6 +2481,10 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_=
dev *hdev, bdaddr_t *bdaddr,
> >
> >       rcu_read_lock();
> >       list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list=
) {
> > +             if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
> > +                                                             irk->val)=
)
> > +                     continue;
> > +
> >               if (addr_type =3D=3D irk->addr_type &&
> >                   bacmp(bdaddr, &irk->bdaddr) =3D=3D 0) {
> >                       rcu_read_unlock();
>
> Same here. Lets find the IRK first and then check agains the blocked key =
list.

[alain] Changed.
>
>
> > @@ -3244,6 +3299,7 @@ struct hci_dev *hci_alloc_dev(void)
> >       INIT_LIST_HEAD(&hdev->pend_le_reports);
> >       INIT_LIST_HEAD(&hdev->conn_hash.list);
> >       INIT_LIST_HEAD(&hdev->adv_instances);
> > +     INIT_LIST_HEAD(&hdev->blocked_keys);
> >
> >       INIT_WORK(&hdev->rx_work, hci_rx_work);
> >       INIT_WORK(&hdev->cmd_work, hci_cmd_work);
> > @@ -3443,6 +3499,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
> >       hci_bdaddr_list_clear(&hdev->le_resolv_list);
> >       hci_conn_params_clear_all(hdev);
> >       hci_discovery_filter_clear(hdev);
> > +     hci_blocked_keys_clear(hdev);
> >       hci_dev_unlock(hdev);
> >
> >       hci_dev_put(hdev);
> > diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> > index 63e65d9b4b24..755bc7c12e2d 100644
> > --- a/net/bluetooth/lib.c
> > +++ b/net/bluetooth/lib.c
> > @@ -167,6 +167,22 @@ void bt_warn(const char *format, ...)
> > }
> > EXPORT_SYMBOL(bt_warn);
> >
> > +void bt_warn_ratelimited(const char *format, ...)
> > +{
> > +     struct va_format vaf;
> > +     va_list args;
> > +
> > +     va_start(args, format);
> > +
> > +     vaf.fmt =3D format;
> > +     vaf.va =3D &args;
> > +
> > +     pr_warn_ratelimited("%pV", &vaf);
> > +
> > +     va_end(args);
> > +}
> > +EXPORT_SYMBOL(bt_warn_ratelimited);
> > +
> > void bt_err(const char *format, ...)
> > {
> >       struct va_format vaf;
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index acb7c6d5643f..a29e92a575e8 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -106,6 +106,7 @@ static const u16 mgmt_commands[] =3D {
> >       MGMT_OP_START_LIMITED_DISCOVERY,
> >       MGMT_OP_READ_EXT_INFO,
> >       MGMT_OP_SET_APPEARANCE,
> > +     MGMT_OP_SET_BLOCKED_KEYS,
> > };
> >
> > static const u16 mgmt_events[] =3D {
> > @@ -3531,6 +3532,52 @@ static int set_phy_configuration(struct sock *sk=
, struct hci_dev *hdev,
> >       return err;
> > }
> >
> > +static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, voi=
d *data,
> > +                                                     u16 len)
> > +{
> > +     int err =3D MGMT_STATUS_SUCCESS;
> > +     struct mgmt_cp_set_blocked_keys *keys =3D data;
> > +     int i;
> > +
> > +     if (len < sizeof(struct mgmt_cp_set_blocked_keys) ||
> > +         ((len - offsetof(struct mgmt_cp_set_blocked_keys, keys)) %
> > +                     sizeof(struct mgmt_blocked_key_info))) {
>
> Any chance you can introduce a marco for this check?

[alain] Unless it is needed elsewhere, my preference would be to delay
creating a macro to when it's actually needed.  Let me know if this
isn't a good approach.
>
>
> > +             return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKE=
D_KEYS,
> > +                             MGMT_STATUS_INVALID_PARAMS, NULL, 0);
> > +     }
> > +
>
> I would also add some size checks here, like we do for IRKs etc.

[alain] ACK, indeed, there was a missing check around the number of
keys.  Will add that next.
>
>
> > +     hci_dev_lock(hdev);
>
> And one thing I realized now, you need to clear the list here. We had the=
 rule that loading an empty list allows you to clear this list from previou=
s calls of the command. This is needed to be able to reset the lists.

[alain]  This wasn't documented in the docs so this seems like a
different contract.  This is in part the motivation to deal with
duplicates.  It seems sub optimal to me to overload this interface to
remove things from the list.  If that is required functionality, I'd
argue we should probably add a separate interface so we don't
introduce a race condition where all keys are unblocked for a few
instants just to remove one entry.
>
>
> > +     for (i =3D 0; i < keys->key_count; ++i) {
> > +             bool already_blocked =3D false;
> > +             struct blocked_key *b;
> > +
> > +             list_for_each_entry(b, &hdev->blocked_keys, list) {
> > +                     if (keys->keys[i].type =3D=3D b->type &&
> > +                             !memcmp(keys->keys[i].val, b->val, sizeof=
(keys->keys[i].val))) {
>
> You need to indent it differently.

[alain] I'm not sure I understand.  Do you mean use 4 spaces instead
of a tab?  checkpatch doesn't seem to like that...
>
>
>
>
>                 if (keys->..
>                     !memcmp..
>
> > +                             already_blocked =3D true;
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             if (already_blocked)
> > +                     continue;
> > +
> > +             b =3D kzalloc(sizeof(*b), GFP_KERNEL);
> > +             if (!b) {
> > +                     err =3D MGMT_STATUS_NO_RESOURCES;
> > +                     break;
> > +             }
> > +
> > +             b->type =3D keys->keys[i].type;
> > +             memcpy(b->val, keys->keys[i].val, sizeof(b->val));
> > +             list_add_rcu(&b->list, &hdev->blocked_keys);
> > +     }
> > +     hci_dev_unlock(hdev);
> > +
> > +     return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
> > +                             err, NULL, 0);
> > +}
> > +
> > static void read_local_oob_data_complete(struct hci_dev *hdev, u8 statu=
s,
> >                                        u16 opcode, struct sk_buff *skb)
> > {
> > @@ -6914,6 +6961,7 @@ static const struct hci_mgmt_handler mgmt_handler=
s[] =3D {
> >       { set_appearance,          MGMT_SET_APPEARANCE_SIZE },
> >       { get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
> >       { set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
> > +     { set_blocked_keys,        MGMT_OP_SET_BLOCKED_KEYS_SIZE },
> > };
> >
> > void mgmt_index_added(struct hci_dev *hdev)
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index 6b42be4b5861..8bc4d1586d4b 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -2453,6 +2453,10 @@ static int smp_cmd_encrypt_info(struct l2cap_con=
n *conn, struct sk_buff *skb)
> >       if (skb->len < sizeof(*rp))
> >               return SMP_INVALID_PARAMS;
> >
> > +     if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_LTK=
,
> > +                                                     rp->ltk))
>
> Indentation fix here as well please.

[alain] . See question above, I admit I don't think I figured out how
tabs versus spaces are expected to work yet :) Can you confirm it's
tabsize =3D 8 then align with at most 7 spaces?
>
>
> > +             return SMP_INVALID_PARAMS;
> > +
>
> And lets add a comment above that describes that we just abort any kind o=
f SMP pairing if blocked keys are used. In addition I would also add a bt_d=
ev_warn_ratelimited here.

[alain] Ok.
>
>
> >       SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
> >
> >       skb_pull(skb, sizeof(*rp));
> > @@ -2509,6 +2513,13 @@ static int smp_cmd_ident_info(struct l2cap_conn =
*conn, struct sk_buff *skb)
> >       if (skb->len < sizeof(*info))
> >               return SMP_INVALID_PARAMS;
> >
> > +     if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_IRK=
,
> > +                                                     info->irk)) {
> > +             BT_WARN_RATELIMITED("Irk key blocked for %pMR", &conn->hc=
on->dst);
> > +
> > +             return SMP_INVALID_PARAMS;
> > +     }
> > +
>
> Same as above.

[alain] Ok.
>
>
> >       SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
> >
> >       skb_pull(skb, sizeof(*info));
> > --
>
> One thing I did forget is that you should also add a debugfs entry for th=
e list of blocked keys so that debugging proposes you can read it out in /s=
ys/kernel/debug/bluetooth/hci0/blocked_keys.

[alain] I'm assuming you'd want this in a separate patch?
>
>
> Regards
>
> Marcel
>
>
