Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jan 2012 11:30:23 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/15] Bluetooth: Add a convenience function to check for
 SSP enabled
Message-ID: <20120119093021.GC20598@aemeltch-MOBL1>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
 <1326912717-6347-11-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326912717-6347-11-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jan 18, 2012 at 08:51:52PM +0200, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
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

Maybe matter of taste but cold this be named hci_conn_ssp_supported ?
Then in if condition below it would be seen more natural and similar to
other "-ed" functions.

Best regards 
Andrei Emeltchenko 

> +	if (hci_conn_ssp_support(conn) && !(conn->link_mode & HCI_LM_ENCRYPT))
>  		return 0;

