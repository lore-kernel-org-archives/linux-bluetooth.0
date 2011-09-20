Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 05/14] Bluetooth: Create hci_do_inquiry()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Sep 2011 14:31:06 +0200
In-Reply-To: <1316468136-12472-6-git-send-email-andre.guedes@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
	 <1316468136-12472-6-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316521868.1937.76.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds a function to hci_core to carry out inquiry.
> 
> All inquiry code from start_discovery() were replaced by a
> hci_do_inquiry() call.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_core.c         |   17 +++++++++++++++++
>  net/bluetooth/mgmt.c             |    9 +--------
>  3 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index df6fa85..b7c070b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -914,4 +914,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
>  void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
>  void hci_le_ltk_neg_reply(struct hci_conn *conn);
>  
> +int hci_do_inquiry(struct hci_dev *hdev, u8 length);
> +
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 04bc31d..ebfd963 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2405,3 +2405,20 @@ static void hci_cmd_task(unsigned long arg)
>  		}
>  	}
>  }
> +
> +int hci_do_inquiry(struct hci_dev *hdev, u8 length)
> +{
> +	u8 lap[3] = {0x33, 0x8b, 0x9e};

{ 0x33, ... 0x9e } with proper space please. Otherwise.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


