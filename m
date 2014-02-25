Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Feb 2014 06:23:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v11 06/15] Bluetooth: Introduce LE auto connection
 infrastructure
Message-ID: <20140225042337.GA27803@localhost.P-661HNU-F1>
References: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
 <1393281061-14320-7-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393281061-14320-7-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Feb 24, 2014, Andre Guedes wrote:
> +		if (hci_update_random_address(&req, false, &own_addr_type))
> +			return;

Don't we want require_privacy = true here?

> +	if (addr_type == ADDR_LE_DEV_PUBLIC)
> +		bdaddr_type = BDADDR_LE_PUBLIC;
> +	else
> +		bdaddr_type = BDADDR_LE_RANDOM;
> +
> +	conn = hci_connect(hdev, LE_LINK, addr, bdaddr_type, BT_SECURITY_LOW,
> +			   HCI_AT_NO_BONDING);

All hci_connect is is a very short wrapper to hci_connect_acl/le. The
hci_connect_le function in turn does the following:

        /* Convert from L2CAP channel address type to HCI address type */
        if (dst_type == BDADDR_LE_PUBLIC)
                dst_type = ADDR_LE_DEV_PUBLIC;
        else
                dst_type = ADDR_LE_DEV_RANDOM;

So it seems a bit silly to do this kind of back and forth conversions.
Instead, I think the hci_connect API should take the address type that's
used for struct hci_conn, i.e. the HCI one (not the L2CAP/mgmt one).

Also, since pretty much all places that are calling hci_connect pass an
explicit value as the link type I think the most sensible thing to do
would be to completely remove this function and export hci_connect_le &
hci_connect_acl from hci_conn.c.

Johan
