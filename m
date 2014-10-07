Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Oct 2014 11:01:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: Include ADV_IND report in Device Connected
 event
Message-ID: <20141007080154.GA30209@t440s.lan>
References: <1412637149-2966-1-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412637149-2966-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Mon, Oct 06, 2014, Alfonso Acosta wrote:
> @@ -4322,7 +4323,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
>  		 * count consistent once the connection is established.
>  		 */
>  		params->conn = hci_conn_get(conn);
> -		return;
> +		return conn;
>  	}
>  
>  	switch (PTR_ERR(conn)) {
> @@ -4335,7 +4336,10 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
>  		break;
>  	default:
>  		BT_DBG("Failed to connect: err %ld", PTR_ERR(conn));
> +		return NULL;
>  	}
> +
> +	return conn;
>  }

I just realized that in this last part of check_pending_le_conn()
IS_ERR(conn) will true (since the first part that I quoted handles the
!IS_ERR(conn) condition) so you should really be explicitly returning
NULL here instead of the conn pointer. This is particularly important
since you're only checking for non-NULL in the calling code instead of
doing IS_ERR() there.

> -	if (conn->dev_class && memcmp(conn->dev_class, "\0\0\0", 3) != 0)
> -		eir_len = eir_append_data(ev->eir, eir_len,
> -					  EIR_CLASS_OF_DEV, conn->dev_class, 3);
> +		if (conn->dev_class &&
> +		    memcmp(conn->dev_class, "\0\0\0", 3) != 0)
> +			eir_len = eir_append_data(ev->eir, eir_len,
> +						  EIR_CLASS_OF_DEV,
> +						  conn->dev_class, 3);
> +	}

I know this is not your fault but a redundancy in the existing code, but
the check for if (conn->dev_class) is pointless since the variable is
defined as an array, i.e. it will always be non-NULL. To make this fix
clear it's probably better to have it as a separate patch either before
or after your current two patches.

To make it easier to get the right versions of these applied could you
please send the entire set again instead of just this one patch. Thanks.

Johan
