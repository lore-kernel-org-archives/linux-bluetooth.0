Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v7 4/8] Bluetooth: Constants and macro declaration for SCO airmode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1368725646-4593-5-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 17 May 2013 10:49:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3FC9A611-FA7B-4C55-9D8F-23D492975DD5@holtmann.org>
References: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com> <1368725646-4593-5-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On May 16, 2013, at 7:34 PM, Frédéric Dalleau <frederic.dalleau@linux.intel.com> wrote:

> This patchs define constants and macro for extracting SCO airmode from SCO
> voice setting. It refers to Bluetooth Core V4.0 specification, Part E, Chap
> 6.12 which describe SCO voice setting format.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/hci_core.h |    5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e9cf9fa..a6fd544 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1214,4 +1214,9 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> 
> u8 bdaddr_to_le(u8 bdaddr_type);
> 
> +#define SCO_AIRMODE_MASK       0x0003
> +#define SCO_AIRMODE_CVSD       0x0000
> +#define SCO_AIRMODE_TRANSP     0x0003
> +#define hci_sco_airmode(setting) ((setting) & SCO_AIRMODE_MASK)

the constants are fine, but I would not bother with the macro. Just use SCO_AIRMODE_MASK directly.

Regards

Marcel

