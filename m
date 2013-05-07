Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 May 2013 14:41:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Use HCI_MGMT instead of HCI_LINK_KEYS flag
Message-ID: <20130507114116.GA11873@x220>
References: <20130507111436.GA11154@x220>
 <1367926547-8279-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1367926547-8279-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367926547-8279-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, May 07, 2013, Andrei Emeltchenko wrote:
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2687,7 +2687,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  		hci_conn_drop(conn);
>  	}
>  
> -	if (test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
> +	if (test_bit(HCI_MGMT, &hdev->dev_flags))
>  		hci_add_link_key(hdev, conn, 1, &ev->bdaddr, ev->link_key,
>  				 ev->key_type, pin_len);
>  

It seems to me that this chunk would be more appropriately merged to the
first patch.

Johan
