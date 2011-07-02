Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 1/1] Bluetooth: l2cap: fix NULL ACL packet handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 02 Jul 2011 15:11:51 -0700
In-Reply-To: <1309628689.22449.12.camel@THOR>
References: <1309628689.22449.12.camel@THOR>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309644714.21109.7.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> A 0-length ACL continuation-fragment is a valid NULL packet. Remote
> devices can use the FLOW indicator in the ACL packet header to
> flow-control ACL packets without sending a payload.
> 
> Track as a device stat instead of logging.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  include/net/bluetooth/hci.h |    1 +
>  net/bluetooth/l2cap_core.c  |    8 ++++++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0c20227..de7ed81 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1142,6 +1142,7 @@ struct hci_ufilter {
>  
>  /* ---- HCI Ioctl requests structures ---- */
>  struct hci_dev_stats {
> +	__u32 null_rx;		/* # NULL pkts recvd */
>  	__u32 err_rx;
>  	__u32 err_tx;
>  	__u32 cmd_tx;

you can not do it like this. This will break userspace API/ABI.

Regards

Marcel


