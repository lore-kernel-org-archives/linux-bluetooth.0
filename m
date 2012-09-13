Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Sep 2012 08:40:59 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 06/17] Bluetooth: AMP: Physical link struct and
 heplers
In-Reply-To: <1347437192-24694-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1209130835240.19321@mathewm-linux>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux> <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1347437192-24694-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Wed, 12 Sep 2012, Andrei Emeltchenko wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Define physical link structures. Physical links are represented by
> hci_conn structure. For BR/EDR we use type ACL_LINK and for AMP
> we use AMP_LINK.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> include/net/bluetooth/hci.h      |    1 +
> include/net/bluetooth/hci_core.h |   20 ++++++++++++++++++
> include/net/bluetooth/pal.h      |   26 +++++++++++++++++++++++
> net/bluetooth/Makefile           |    2 +-
> net/bluetooth/a2mp.c             |    1 +
> net/bluetooth/pal.c              |   42 ++++++++++++++++++++++++++++++++++++++
> 6 files changed, 91 insertions(+), 1 deletion(-)
> create mode 100644 include/net/bluetooth/pal.h
> create mode 100644 net/bluetooth/pal.c
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1cb8b55..4c41b8c 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -207,6 +207,7 @@ enum {
> #define ESCO_LINK	0x02
> /* Low Energy links do not have defined link type. Use invented one */
> #define LE_LINK		0x80
> +#define AMP_LINK	0x81
>
> /* LMP features */
> #define LMP_3SLOT	0x01
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 1174218..4ae5293 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -316,6 +316,7 @@ struct hci_conn {
>
> 	__u8		remote_cap;
> 	__u8		remote_auth;
> +	__u8		remote_id;
> 	bool		flush_key;
>
> 	unsigned int	sent;
> @@ -510,6 +511,25 @@ static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
> 	return NULL;
> }
>
> +static inline struct hci_conn *hci_conn_hash_lookup_id(struct hci_dev *hdev,
> +						       __u8 remote_id)
> +{
> +	struct hci_conn_hash *h = &hdev->conn_hash;
> +	struct hci_conn  *c;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(c, &h->list, list) {
> +		if (c->remote_id == remote_id) {
> +			rcu_read_unlock();
> +			return c;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return NULL;
> +}
> +

If there are multiple AMP physical links to different devices, the 
remote_id probably isn't enough information to look up a physical 
link.  Most of the time the remote_id will be "1", so there will 
probably be multiple hci_conns with the same remote_id.

l2cap_conn + remote_id should be unique, though.

> static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
> 							__u8 type, bdaddr_t *ba)
> {
> diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
> new file mode 100644
> index 0000000..a0f441b
> --- /dev/null
> +++ b/include/net/bluetooth/pal.h
> @@ -0,0 +1,26 @@
> +/*
> +   Copyright (c) 2011,2012 Intel Corp.
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 and
> +   only version 2 as published by the Free Software Foundation.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +*/
> +
> +#ifndef __PAL_H
> +#define __PAL_H
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/l2cap.h>
> +#include <net/bluetooth/a2mp.h>
> +#include <net/bluetooth/amp.h>
> +
> +struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
> +			     u8 remote_id);
> +
> +#endif /* __PAL_H */
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index dea6a28..3f76fc2 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -10,4 +10,4 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
>
> bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
> 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
> -	a2mp.o amp.o
> +	a2mp.o amp.o pal.o
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index c876997..8f236db 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -17,6 +17,7 @@
> #include <net/bluetooth/l2cap.h>
> #include <net/bluetooth/a2mp.h>
> #include <net/bluetooth/amp.h>
> +#include <net/bluetooth/pal.h>
>
> /* Global AMP Manager list */
> LIST_HEAD(amp_mgr_list);
> diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
> new file mode 100644
> index 0000000..3377ad1
> --- /dev/null
> +++ b/net/bluetooth/pal.c
> @@ -0,0 +1,42 @@
> +/*
> +   Copyright (c) 2011,2012 Intel Corp.
> +
> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License version 2 and
> +   only version 2 as published by the Free Software Foundation.
> +
> +   This program is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +   GNU General Public License for more details.
> +*/
> +
> +#include <net/bluetooth/pal.h>
> +
> +/* Physical Link interface */
> +static u8 __next_handle(struct amp_mgr *mgr)
> +{
> +	if (++mgr->handle == 0)
> +		mgr->handle = 1;
> +
> +	return mgr->handle;
> +}
> +
> +struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
> +			     u8 remote_id)
> +{
> +	struct hci_conn *hcon;
> +
> +	hcon = hci_conn_add(hdev, AMP_LINK, BDADDR_ANY);
> +	if (!hcon)
> +		return NULL;
> +
> +	hcon->state = BT_CONNECT;
> +	hcon->out = true;
> +	hcon->attempt++;
> +	hcon->handle = __next_handle(mgr);
> +	hcon->remote_id = remote_id;
> +	hcon->amp_mgr = mgr;
> +
> +	return hcon;
> +}
> -- 
> 1.7.9.5

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation


