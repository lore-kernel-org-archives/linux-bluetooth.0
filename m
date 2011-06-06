Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jun 2011 15:43:41 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth-next v2 10/16] Bluetooth: Add support for resuming
 socket when SMP is finished
Message-ID: <20110606064341.GA1905@dell>
References: <1307046738-19588-1-git-send-email-vinicius.gomes@openbossa.org>
 <1307046738-19588-11-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307046738-19588-11-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Jun 02, 2011, Vinicius Costa Gomes wrote:
> @@ -357,21 +375,16 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
>  	if (IS_ERR(hcon->hdev->tfm))
>  		return 1;
>  
> -	switch (sec_level) {
> -	case BT_SECURITY_MEDIUM:
> -		/* Encrypted, no MITM protection */
> -		authreq = HCI_AT_NO_BONDING_MITM;
> -		break;
> +	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
> +		return -EINPROGRESS;

This doesn't look right to me. Like hci_conn_security, smp_conn_security
is supposed to be a boolean function by only returning 0 or 1. That's
also how all places use it: "if (smp_conn_security(...))". So returning
a negative error like this looks wrong.

Johan
