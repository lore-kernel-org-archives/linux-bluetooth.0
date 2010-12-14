Return-Path: <cyrus@holtmann.org>
Message-ID: <4D070FE2.6000404@Atheros.com>
Date: Tue, 14 Dec 2010 12:04:10 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Bluetooth: Use non-flushable pb flag by default for ACL
 data on capable chipsets.
References: <1292251105-31130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1292251105-31130-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1292251105-31130-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 12/13/2010 8:08 PM, Emeltchenko Andrei wrote:
>   static inline void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
>   {
>   	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
> +	u8 flags;
>
>   	BT_DBG("code 0x%2.2x", code);
>
>   	if (!skb)
>   		return;
>
> -	hci_send_acl(conn->hcon, skb, 0);
> +	if (lmp_no_flush_capable(conn->hcon->hdev))
> +		flags = ACL_START_NO_FLUSH;
> +	else
> +		flags = ACL_START;
> +
> +	hci_send_acl(conn->hcon, skb, flags);
>   }
>
Should we send L2CAP command packets also as flushable packets? Should 
it be non-flushable?
I thought only L2CAP data frames should be sent as flushable.

Regards
Suraj

