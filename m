Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Jul 2015 11:17:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Bluetooth: Enable new connection establishment
 procedure.
Message-ID: <20150723081750.GA7358@t440s.lan>
References: <1437564577-4207-1-git-send-email-jpawlowski@google.com>
 <1437564577-4207-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437564577-4207-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Jul 22, 2015, Jakub Pawlowski wrote:
> @@ -3564,9 +3564,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>  		 */
>  		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
>  
> -		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
> -				      sec_level, HCI_LE_CONN_TIMEOUT,
> -				      HCI_ROLE_MASTER);
> +		conn = hci_add_to_sock_conn_whitelist(hdev, &cp->addr.bdaddr,
> +						      addr_type, sec_level,
> +						      HCI_LE_CONN_TIMEOUT,
> +						      HCI_ROLE_MASTER);

The purpose we're introducing this passive scanning functionality is so
that we have a fresh RPA for the remote device. The way we know that a
new RPA matches the remote device is by checking against an IRK. If the
user is calling pair_device it means we don't have an IRK, so in this
case it seems pointless to me to start passive scanning (not to mention
that typically paired device is called straight after stopping an active
scan).

Johan
