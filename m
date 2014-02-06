Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Feb 2014 14:02:09 -0200
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v8 06/10] Bluetooth: Introduce LE auto connection
 infrastructure
Message-ID: <20140206160209.GA26623@molly>
References: <1391639006-26311-1-git-send-email-andre.guedes@openbossa.org>
 <1391639006-26311-6-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391639006-26311-6-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On 19:23 Wed 05 Feb, Andre Guedes wrote:
> This patch introduces the LE auto connection infrastructure which
> will be used to implement the LE auto connection options.
>
> In summary, the auto connection mechanism works as follows: Once the
> first pending LE connection is created, the background scanning is
> started. When the target device is found in range, the kernel
> autonomously starts the connection attempt. If connection is
> established successfully, that pending LE connection is deleted and
> the background is stopped.
>
> To achieve that, this patch introduces the hci_update_background_scan()
> which controls the background scanning state. This function starts or
> stops the background scanning based on the hdev->pend_le_conns list. If
> there is no pending LE connection, the background scanning is stopped.
> Otherwise, we start the background scanning.
>
> Then, every time a pending LE connection is added we call hci_update_
> background_scan() so the background scanning is started (in case it is
> not already running). Likewise, every time a pending LE connection is
> deleted we call hci_update_background_scan() so the background scanning
> is stopped (in case this was the last pending LE connection) or it is
> started again (in case we have more pending LE connections). Finally,
> we also call hci_update_background_scan() in hci_le_conn_failed() so
> the background scan is restarted in case the connection establishment
> fails. This way the background scanning keeps running until all pending
> LE connection are established.
>
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---

[snip]

>  static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	u8 num_reports = skb->data[0];
>  	void *ptr = &skb->data[1];
>  	s8 rssi;
>
> +	hci_dev_lock(hdev);
> +
>  	while (num_reports--) {
>  		struct hci_ev_le_advertising_info *ev = ptr;
>
> +		check_pending_le_conn(hdev, &ev->bdaddr, ev->bdaddr_type);
> +

Shouldn't the event type be checked to see if it is a connectable event?

>  		rssi = ev->data[ev->length];
>  		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
>  				  NULL, rssi, 0, 1, ev->data, ev->length);
>
>  		ptr += sizeof(*ev) + ev->length + 1;
>  	}
> +
> +	hci_dev_unlock(hdev);
>  }
>
>  static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius
