Return-Path: <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Bluetooth kernel patch for 2.6.1
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1074193649.2629.23.camel@pegasus>
References: <1074193649.2629.23.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074196988.2559.270.camel@localhost>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 12:03:08 -0800
List-ID: <bluez-devel.lists.sourceforge.net>

Some more comments about the patch.

- BCM203x loader
Should mention (at the top) that it's based on the user-space BCM loader
Copyright (C) such and such (eg me ;-))

- RFCOMM disable CFC by default
Comment should mention that it's a forward port of 2.4 patch by maxk.

- This
> static inline void hci_conn_put(struct hci_conn *conn) 
>  {
>  	if (atomic_dec_and_test(&conn->refcnt)) {
> -		if (conn->type == SCO_LINK)
> +		if (conn->type == ACL_LINK) {
> +			unsigned long timeo = (conn->out) ?
> +				HCI_DISCONN_TIMEOUT : HCI_DISCONN_TIMEOUT * 2;
> +			hci_conn_set_timer(conn, timeo);
> +		} else
>  			hci_conn_set_timer(conn, HZ / 100);
> -		else if (conn->out)
> -			hci_conn_set_timer(conn, HCI_DISCONN_TIMEOUT);
>  	}
>  }

will kill _incoming_ connection when last local socket is closed. I used
to have HCI_CONNIDLE_TIMEOUT for that. But I got rid of it because I
think it's wrong. We should not kill incoming ACL connection. It should
be killed by the initiator.

Max
