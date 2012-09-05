Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Sep 2012 12:25:43 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mgmt: Implement support for passkey
 notification
Message-ID: <20120905092536.GA28333@aemeltch-MOBL1>
References: <1346832850-25061-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346832850-25061-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

nitpicks

On Wed, Sep 05, 2012 at 11:14:10AM +0300, Johan Hedberg wrote:
...
> +	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
> +	if (!conn)
> +		return;
> +
> +	switch (ev->type) {
> +	case HCI_KEYPRESS_STARTED:
> +		conn->passkey_entered = 0;
> +		return;
> +	case HCI_KEYPRESS_ENTERED:
> +		conn->passkey_entered++;
> +		break;
> +	case HCI_KEYPRESS_ERASED:
> +		conn->passkey_entered--;
> +		break;
> +	case HCI_KEYPRESS_CLEARED:
> +		conn->passkey_entered = 0;
> +		break;

Can we use the same style for switch like below:

...
> +	case HCI_EV_USER_PASSKEY_NOTIFY:
> +		hci_user_passkey_notify_evt(hdev, skb);
> +		break;
> +
> +	case HCI_EV_KEYPRESS_NOTIFY:
> +		hci_keypress_notify_evt(hdev, skb);
> +		break;
> +
>  	case HCI_EV_SIMPLE_PAIR_COMPLETE:
>  		hci_simple_pair_complete_evt(hdev, skb);
>  		break;

Best regards 
Andrei Emeltchenko 
