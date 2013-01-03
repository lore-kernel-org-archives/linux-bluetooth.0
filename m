Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jan 2013 15:51:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Move hci_outgoing_auth_needed() to
 hci_conn.c
Message-ID: <20130103135145.GA18154@x220.ger.corp.intel.com>
References: <1357218329-21399-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357218329-21399-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Jan 03, 2013, Jaganath Kanakkassery wrote:
> This is done so that other files can use this function
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_conn.c         |   17 +++++++++++++++++
>  net/bluetooth/hci_event.c        |   18 ------------------
>  3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 014a2ea..2e1897c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -706,6 +706,7 @@ int hci_get_dev_info(void __user *arg);
>  int hci_get_conn_list(void __user *arg);
>  int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
>  int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
> +int hci_outgoing_auth_needed(struct hci_dev *hdev, struct hci_conn *conn);
>  int hci_inquiry(void __user *arg);
>  
>  struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 25bfce0..7fbabae 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1027,3 +1027,20 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
>  
>  	return hchan;
>  }
> +
> +int hci_outgoing_auth_needed(struct hci_dev *hdev, struct hci_conn *conn)
> +{
> +	if (conn->state != BT_CONFIG || !conn->out)
> +		return 0;
> +
> +	if (conn->pending_sec_level == BT_SECURITY_SDP)
> +		return 0;
> +
> +	/* Only request authentication for SSP connections or non-SSP
> +	 * devices with sec_level HIGH or if MITM protection is requested */
> +	if (!hci_conn_ssp_enabled(conn) && !(conn->auth_type & 0x01) &&
> +	    conn->pending_sec_level != BT_SECURITY_HIGH)
> +		return 0;
> +
> +	return 1;
> +}

Since you're moving this to hci_conn.c I'd prefix the function with
hci_conn_*. You should also remove the hdev parameter since it's not
used in the function (I believe the only reason it was there was for
consistency in hci_core.c).

Johan
