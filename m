Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 13 Jun 2011 14:24:18 +0200
Subject: RE: [PATCH] Bluetooth: Fix L2CAP security check
Message-ID: <AC090B9732AB2B4DB7FF476E907FE6600131357AAA@dnce02.ent.ti.com>
References: <1307688624-5519-1-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1307688624-5519-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Friday, June 10, 2011 9:50 AM
> To: linux-bluetooth@vger.kernel.org
> Subject: [PATCH] Bluetooth: Fix L2CAP security check
> 
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> With older userspace versions (using hciops) it might not have the
> key type to check if the key has sufficient security for any security
> level so it is necessary to check the return of hci_conn_auth to make
> sure the connection is authenticated
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_conn.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 3163330..efda44c 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -611,8 +611,8 @@ auth:
>  	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
>  		return 0;
> 
> -	hci_conn_auth(conn, sec_level, auth_type);
> -	return 0;
> +	if (!(hci_conn_auth(conn, sec_level, auth_type)))
> +		return 0;
> 
>  encrypt:
>  	if (conn->link_mode & HCI_LM_ENCRYPT)
> --
> 1.7.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I have also come upon this bug - the unconditional "return 0"
broke connection establishment of A2DP streams both in android 
and PTS tests. I think it is better to apply it ASAP.
Regards.


Ilia Kolominsky
iliak@ti.com
Direct:  +972(9)7906231
Mobile: +972(54)909009
