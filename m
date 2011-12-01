Return-Path: <cyrus@holtmann.org>
Message-ID: <1322745116.26198.33.camel@aeonflux>
Subject: Re: [PATCHv2 7/8] Bluetooth: Use SNIFF mode only for BREDR
 controller
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Dec 2011 14:11:56 +0100
In-Reply-To: <1322743335-8671-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322743335-8671-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>  net/bluetooth/hci_conn.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b328ac6..beb280e 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -749,6 +749,9 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
>  	if (test_bit(HCI_RAW, &hdev->flags))
>  		return;
>  
> +	if (hdev->dev_type != HCI_BREDR)
> +		return;
> +
>  	if (conn->mode != HCI_CM_SNIFF)
>  		goto timer;
>  
> @@ -783,6 +786,9 @@ void hci_conn_enter_sniff_mode(struct hci_conn *conn)
>  	if (conn->mode != HCI_CM_ACTIVE || !(conn->link_policy & HCI_LP_SNIFF))
>  		return;
>  
> +	if (hdev->dev_type != HCI_BREDR)
> +		return;
> +
>  	if (lmp_sniffsubr_capable(hdev) && lmp_sniffsubr_capable(conn)) {
>  		struct hci_cp_sniff_subrate cp;
>  		cp.handle             = cpu_to_le16(conn->handle);

I am really not sure that this is the best solution. It sounds like way
to much overhead. Essentially I read this is being ignorant to what kind
of controller we have and only last last minute we bother checking.

Regards

Marcel


