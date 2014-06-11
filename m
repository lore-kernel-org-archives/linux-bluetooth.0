Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix for ACL disconnect when pairing fails
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402478593-19791-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 11 Jun 2014 11:30:26 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6053DFD1-5B79-4EBC-936B-3725E44A9CAA@holtmann.org>
References: <1402478593-19791-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> When pairing fails hci_conn refcnt drops below zero. This cause that
> ACL link is not disconnected when disconnect timeout fires.
> 
> Probably this is because l2cap_conn_del calls l2cap_chan_del for each
> channel, and inside l2cap_chan_del conn is dropped. After that loop
> hci_chan_del is called which also drops conn.

I wonder if we should actually add a WARN_ON when the reference count drops below. At some point we should look into fixing this for real.

> Anyway, as it is desrcibed in hci_core.h, it is known that refcnt
> drops below 0 sometimes and it should be fine. If so, let disconnect
> link when hci_conn_timeout fires and refcnt is 0 or below. This patch
> does it.
> 
> This affects PTS test SM_TC_JW_BV_05_C
> 
> Logs from scenario:

<snip>

> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index ca01d18..10ec9b7 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -292,7 +292,7 @@ static void hci_conn_timeout(struct work_struct *work)
> 
> 	BT_DBG("hcon %p state %s", conn, state_to_string(conn->state));

I would prefer that you add a comment here explaining the details again, why we check for a positive refcount. Since we will forget the reason after a while.

> 
> -	if (atomic_read(&conn->refcnt))
> +	if (atomic_read(&conn->refcnt) > 0)
> 		return;
> 
> 	switch (conn->state) {

Regards

Marcel

