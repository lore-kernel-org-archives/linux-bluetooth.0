Return-Path: <cyrus@holtmann.org>
Message-ID: <4C45299D.9060504@codeaurora.org>
Date: Mon, 19 Jul 2010 23:44:13 -0500
From: Ron Shaffer <rshaffer@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Defer SCO setup if mode change is pending
References: <1279562776-12901-1-git-send-email-marcel@holtmann.org>
In-Reply-To: <1279562776-12901-1-git-send-email-marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel:

On 7/19/2010 1:06 PM, Marcel Holtmann wrote:
> @@ -385,10 +406,13 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>  		acl->power_save = 1;
>  		hci_conn_enter_active_mode(acl);
>  
> -		if (lmp_esco_capable(hdev))
> -			hci_setup_sync(sco, acl->handle);
> -		else
> -			hci_add_sco(sco, acl->handle);
> +		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
> +			/* defer SCO setup until mode change completed */
> +			set_bit(HCI_CONN_SCO_SETUP_PEND, &acl->pend);
> +			return sco;
> +		}
> +
> +		hci_sco_setup(acl, 0x00);
>  	}

Not in love with the "fake" status passed here, but the overall change
to centralize this functionality provides a nice cleanup from the
original patch and makes the code more readable and maintainable.

>  
>  	return sco;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 2069c3b..461413c 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -775,9 +775,6 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
>  
>  	BT_DBG("%s status 0x%x", hdev->name, status);
>  
> -	if (!status)
> -		return;
> -
>  	cp = hci_sent_cmd_data(hdev, HCI_OP_SNIFF_MODE);
>  	if (!cp)
>  		return;
> @@ -785,8 +782,13 @@ static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
>  	hci_dev_lock(hdev);
>  
>  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
> -	if (conn)
> -		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
> +	if (conn) {
> +		if (status)
> +			clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
> +
> +		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->pend))
> +			hci_sco_setup(conn, status);

Probably the subject for another patch, but has there been any reported
issue where idle_timeout is set short enough that the timer expires
after exit sniff mode has been requested but before the mode change
event has been received?

Got back from other duties late tonight, so I didn't get testing fully
finished. In particular, I need to see what happens when idle_timeout is
set very low ex < 10. I'll let you know the results first thing in the
morning. If everything is good, I'll regenerate the patch with original
hcidump log included
-- 
Ron Shaffer
Employee of the Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
