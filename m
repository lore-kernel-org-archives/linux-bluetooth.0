Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jul 2012 14:00:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v2] Bluetooth: mgmt: Add device disconnect reason
Message-ID: <20120730110050.GA13789@x220.ger.corp.intel.com>
References: <1342790298-12193-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342790298-12193-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Jul 20, 2012, Mikel Astiz wrote:
> During the BlueZ meeting in Brazil it was proposed to add two more
> values to this enum: "Connection terminated by local host" and
> "Connection terminated by remote host". However, after some testing,
> it seems the result can be quite misleading. Therefore and given that
> there are no known use-cases that need this information (local vs
> remote disconnection), these two values have been dropped.

I still think that it wouldn't hurt to include which side triggers the
HCI_Disconnect() command. We can always document that this identifies
accurately the ACL disconnection initiator but not necessarily the
higher-level profile(s) disconnection initiator.

>  	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags) &&
>  	    (conn->type == ACL_LINK || conn->type == LE_LINK)) {
> -		if (ev->status != 0)
> +		if (ev->status != 0) {
>  			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>  					       conn->dst_type, ev->status);
> -		else
> +		} else {
> +			u8 reason = 0x00;
> +
> +			if (ev->reason == HCI_ERROR_CONNECTION_TIMEOUT)
> +				reason = 0x01;
> +
>  			mgmt_device_disconnected(hdev, &conn->dst, conn->type,
> -						 conn->dst_type);
> +						 conn->dst_type, reason);
> +		}
>  	}

Instead of using hard-coded 0x00 and 0x01 wouldn't it be better to have
proper MGMT_* defines for these?

Johan
