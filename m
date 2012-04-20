Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334920191-29308-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1334920191-29308-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 20 Apr 2012 11:51:53 -0300
Message-ID: <CAA37ikZqM3Lm_U-5mwCwiDBw-6z+3k517YtbEvbOBnyNBrmT3w@mail.gmail.com>
Subject: Re: [RFCv7 02/23] Bluetooth: A2MP: AMP Manager basic functions
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Apr 20, 2012 at 8:09 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Define AMP Manager and some basic functions.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/a2mp.h     |   30 +++++++++++++++++++++
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/a2mp.c             |   54 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_conn.c         |   15 +++++++++++
>  4 files changed, 100 insertions(+)
>  create mode 100644 include/net/bluetooth/a2mp.h
>
> diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
> new file mode 100644
> index 0000000..0fe8ddd
> --- /dev/null
> +++ b/include/net/bluetooth/a2mp.h
> @@ -0,0 +1,30 @@
> +/*
> +   Copyright (c) 2010,2011 Code Aurora Forum.  All rights reserved.
> +   Copyright (c) 2011,2012 Intel Corp.
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 and
> +   only version 2 as published by the Free Software Foundation.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +*/
> +
> +#ifndef __A2MP_H
> +#define __A2MP_H
> +
> +struct amp_mgr {
> +       struct list_head        list;
> +       struct l2cap_conn       *l2cap_conn;
> +       struct l2cap_chan       *a2mp_chan;
> +       struct kref             kref;
> +       __u8                    ident;
> +       unsigned long           flags;
> +};
> +
> +void amp_mgr_get(struct amp_mgr *mgr);
> +int amp_mgr_put(struct amp_mgr *mgr);
> +
> +#endif /* __A2MP_H */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index ef6e654..16ab35d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -324,6 +324,7 @@ struct hci_conn {
>
>        struct sk_buff_head data_q;
>        struct list_head chan_list;
> +       struct list_head mgr_list;
>
>        struct delayed_work disc_work;
>        struct timer_list idle_timer;
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 1f733b5..85cd29a 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -15,6 +15,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/l2cap.h>
> +#include <net/bluetooth/a2mp.h>
>
>  static struct l2cap_ops a2mp_chan_ops = {
>        .name = "L2CAP A2MP channel",
> @@ -57,3 +58,56 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
>
>        return chan;
>  }
> +
> +/* AMP Manager functions */
> +void amp_mgr_get(struct amp_mgr *mgr)

I'm probably late to say this but maybe amp_mgr_hold() instead of
_get() like we already have in the stack would be better?

Regards,

-- Ulisses

> +{
> +       BT_DBG("mgr %p", mgr);
> +
> +       kref_get(&mgr->kref);
> +}
> +
> +static void amp_mgr_destroy(struct kref *kref)
> +{
> +       struct amp_mgr *mgr = container_of(kref, struct amp_mgr, kref);
> +
> +       BT_DBG("mgr %p", mgr);
> +
> +       kfree(mgr);
> +}
> +
> +int amp_mgr_put(struct amp_mgr *mgr)
> +{
> +       BT_DBG("mgr %p", mgr);
> +
> +       return kref_put(&mgr->kref, &amp_mgr_destroy);
> +}
> +
> +static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
> +{
> +       struct amp_mgr *mgr;
> +       struct l2cap_chan *chan;
> +
> +       mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> +       if (!mgr)
> +               return NULL;
> +
> +       BT_DBG("conn %p mgr %p", conn, mgr);
> +
> +       mgr->l2cap_conn = conn;
> +
> +       chan = a2mp_chan_open(conn);
> +       if (!chan) {
> +               kfree(mgr);
> +               return NULL;
> +       }
> +
> +       mgr->a2mp_chan = chan;
> +       chan->data = mgr;
> +
> +       list_add(&mgr->list, &conn->hcon->mgr_list);
> +
> +       kref_init(&mgr->kref);
> +
> +       return mgr;
> +}
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 947172b..2de2773 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -43,6 +43,7 @@
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/a2mp.h>
>
>  static void hci_le_connect(struct hci_conn *conn)
>  {
> @@ -404,6 +405,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>
>        INIT_LIST_HEAD(&conn->chan_list);
>
> +       INIT_LIST_HEAD(&conn->mgr_list);
> +
>        INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
>        setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
>        setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
> @@ -424,6 +427,16 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>        return conn;
>  }
>
> +static void hci_amp_mgr_list_flush(struct hci_conn *conn)
> +{
> +       struct amp_mgr *mgr, *n;
> +
> +       BT_DBG("conn %p", conn);
> +
> +       list_for_each_entry_safe(mgr, n, &conn->mgr_list, list)
> +               amp_mgr_put(mgr);
> +}
> +
>  int hci_conn_del(struct hci_conn *conn)
>  {
>        struct hci_dev *hdev = conn->hdev;
> @@ -459,6 +472,8 @@ int hci_conn_del(struct hci_conn *conn)
>
>        hci_chan_list_flush(conn);
>
> +       hci_amp_mgr_list_flush(conn);
> +
>        hci_conn_hash_del(hdev, conn);
>        if (hdev->notify)
>                hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
