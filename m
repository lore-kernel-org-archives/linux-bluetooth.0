Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 13:19:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Temporary keys should be retained during
 connection
Message-ID: <20120405101957.GB32212@x220>
References: <1333546839-28218-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333546839-28218-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Wed, Apr 04, 2012, Vishal Agarwal wrote:
> @@ -1330,10 +1330,10 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>  
>  	mgmt_new_link_key(hdev, key, persistent);
>  
> -	if (!persistent) {
> -		list_del(&key->list);
> -		kfree(key);
> -	}
> +	if (persistent)
> +		conn->temp_link_key = false;
> +	else
> +		conn->temp_link_key = true;

The hci_add_link_key function can be called with conn == NULL so you
need to take this into account before dereferencing it.

Johan
