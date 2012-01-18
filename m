Return-Path: <cyrus@holtmann.org>
Message-ID: <1326914043.6454.406.camel@aeonflux>
Subject: Re: [PATCH 10/15] Bluetooth: Add a convenience function to check
 for SSP enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:14:03 +0100
In-Reply-To: <1326912717-6347-11-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-11-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It's a very common test to see if both the local and the remote device
> have SSP enabled. By creating a simple function to test this we can
> shorten many if-statements in the code.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    7 +++++++
>  net/bluetooth/hci_conn.c         |    8 ++------
>  net/bluetooth/hci_event.c        |    9 +++------
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5f6cb35..f2ccdae 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -411,6 +411,13 @@ enum {
>  	HCI_CONN_REMOTE_OOB,
>  };
>  
> +static inline bool hci_conn_ssp_support(struct hci_conn *conn)
> +{
> +	struct hci_dev *hdev = conn->hdev;
> +	return (hdev->ssp_mode > 0 &&
> +				test_bit(HCI_CONN_SSP_SUPPORT, &conn->flags));
> +}

why is hdev->ssp_mode not converted into a flag first?

Regards

Marcel


