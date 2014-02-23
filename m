Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2 01/10] Bluetooth: Set the correct address type in Identity Address Information
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393165438-13610-2-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 23 Feb 2014 06:46:39 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <F148332F-574B-4308-9661-34AF592C84FE@holtmann.org>
References: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com> <1393165438-13610-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The SMP Identity Address Information PDU contains our Identity Address.
> The address type can either be static random or public and it is tracked
> in the hdev->own_address_type variable.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 8ef50c790b96..ce2c461d07e3 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -1196,8 +1196,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
> 
> 		smp_send_cmd(conn, SMP_CMD_IDENT_INFO, sizeof(idinfo), &idinfo);
> 
> -		/* Just public address */
> -		memset(&addrinfo, 0, sizeof(addrinfo));
> +		addrinfo.addr_type = hdev->own_addr_type;
> 		bacpy(&addrinfo.bdaddr, &hcon->src);

why not use hcon->src_type here. Otherwise you have to track the difference between when the public address is used vs the static address and force_static_address debugfs.

Regards

Marcel

