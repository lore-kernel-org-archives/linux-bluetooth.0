Return-Path: <cyrus@holtmann.org>
Message-ID: <1322222529.29909.20.camel@aeonflux>
Subject: Re: [RFCv1 4/6] Bluetooth: Initialize default flow control mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 25 Nov 2011 13:02:09 +0100
In-Reply-To: <1322139125-22377-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322139125-22377-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>  include/net/bluetooth/hci.h |    4 ++++
>  net/bluetooth/hci_core.c    |    4 ++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ee83c36..67f7028 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -271,6 +271,10 @@ enum {
>  #define HCI_ERROR_LOCAL_HOST_TERM	0x16
>  #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
>  
> +/* Flow control modes */
> +#define HCI_PACKET_BASED_FLOW_CTL_MODE	0x00
> +#define HCI_BLOCK_BASED_FLOW_CTL_MODE	0x01

see my other email. You have the naming backwards here.

> +
>  /* -----  HCI Commands ---- */
>  #define HCI_OP_NOP			0x0000
>  
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a0247d3..2e4211e 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -198,6 +198,8 @@ static void bredr_init(struct hci_dev *hdev)
>  	__le16 param;
>  	__u8 flt_type;
>  
> +	hdev->flow_ctl_mode = HCI_PACKET_BASED_FLOW_CTL_MODE;
> +
>  	/* Mandatory initialization */
>  
>  	/* Reset */
> @@ -244,6 +246,8 @@ static void bredr_init(struct hci_dev *hdev)
>  
>  static void amp_init(struct hci_dev *hdev)
>  {
> +	hdev->flow_ctl_mode = HCI_BLOCK_BASED_FLOW_CTL_MODE;
> +
>  	/* Reset */
>  	hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
>  

Otherwise this is fine.

Regards

Marcel


