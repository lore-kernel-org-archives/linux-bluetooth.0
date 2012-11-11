Return-Path: <cyrus@holtmann.org>
Message-ID: <1352594558.16204.23.camel@aeonflux>
Subject: Re: [RFCv3 2/3] Bluetooth: Add support vendor specific device setup
From: Marcel Holtmann <marcel@holtmann.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org, albert.o.ho@intel.com,
	johan.hedberg@intel.com, tedd.hj.an@gmail.com
Date: Sun, 11 Nov 2012 01:42:38 +0100
In-Reply-To: <1731055.pboutxBfre@tedd-ubuntu>
References: <1731055.pboutxBfre@tedd-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds support vendors to execute their specific device
> setup before the BT stack sends generic BT device initialization.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    2 ++
>  include/net/bluetooth/hci_core.h |    7 +++++++
>  net/bluetooth/hci_core.c         |   27 ++++++++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0f28f70..3e9949b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -117,7 +117,9 @@ enum {
>  	HCI_DISCOVERABLE,
>  	HCI_LINK_SECURITY,
>  	HCI_PENDING_CLASS,
> +
>  	HCI_PERIODIC_INQ,
> +	HCI_VENDOR,		/* for mini-driver vendor specific setup */
>  };
>  
>  /* HCI ioctl defines */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 6a3337e..ad4a099 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -275,6 +275,13 @@ struct hci_dev {
>  	int (*send)(struct sk_buff *skb);
>  	void (*notify)(struct hci_dev *hdev, unsigned int evt);
>  	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
> +
> +/* CHECKME: Added following members for vendor specific setup in order to make
> + * the bluetooth.ko transparent to the interface below.
> + * These members are set/used by the vendor provided mini-driver. */
> +	void			*vendor_data;
> +	int (*vendor_setup)(struct hci_dev *hdev);
> +	void (*vendor_event)(struct hci_dev *hdev, struct sk_buff *skb);
>  };
>  
>  struct hci_conn {
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e407051..09e7fa2 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -685,6 +685,21 @@ int hci_dev_open(__u16 dev)
>  		set_bit(HCI_INIT, &hdev->flags);
>  		hdev->init_last_cmd = 0;
>  
> +/* CHECKME: this is the required spot for executing the vendor setup code.
> + * We need btusb_open() to complete so HCI event can be received and
> + * processed by vendor_event() handler. vendor_setup() must be done first
> + * before hci_init_req.
> + * vendor_setup() runs once only.*/
> +		if (hdev->vendor_setup) {
> +			set_bit(HCI_VENDOR, &hdev->dev_flags);

the HCI_VENDOR is actually not needed since we do already have the
HCI_SETUP stage that is executed exactly one time.

> +			ret = hdev->vendor_setup(hdev);
> +			hdev->vendor_event = NULL;
> +			hdev->vendor_setup = NULL;
> +			clear_bit(HCI_VENDOR, &hdev->dev_flags);
> +			if (ret < 0)
> +				goto done;

This goto is actually wrong. You are not cleaning up the transport
setup. This means you leave a half broken setup around in case it
returns an error.

What I really want is that the hdev->setup() can just abort the setup
and fail gracefully. Reason for this might be simple like the firmware
is not present. The next time you try it should go through and succeed.

> +		}
> +
>  		ret = __hci_request(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
>  
>  		if (lmp_host_le_capable(hdev))
> @@ -2119,6 +2134,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(hci_send_cmd);
>  
>  /* Get data from the previously sent command */
>  void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
> @@ -2800,7 +2816,16 @@ static void hci_rx_work(struct work_struct *work)
>  		switch (bt_cb(skb)->pkt_type) {
>  		case HCI_EVENT_PKT:
>  			BT_DBG("%s Event packet", hdev->name);
> -			hci_event_packet(hdev, skb);
> +/* CHECKME: If we are in vendor mode, all HCI events are handled by
> + * vendor_event() and not handled by normal stack flows. vendor_event() shall
> + * also be responsible for handling flow control.
> + *
> + * Please see the mini-driver sample code. */
> +			if (test_bit(HCI_VENDOR, &hdev->dev_flags)
> +					&& hdev->vendor_event)
> +				hdev->vendor_event(hdev, skb);
> +			else
> +				hci_event_packet(hdev, skb);
>  			break;

Having spent some time with this problem and actually playing with it, I
want to do this two-fold. First get the proper handling of the HCI_SETUP
stage and hdev->setup() integrated. That by itself is already useful for
really simple drivers.

The next is that we need a hci_request equivalent that also returns the
results of a command or maybe simple just its events. I am fine with
them being duplicated actually.

For a first step it might be simple enough to just use hci_request and
allow to provide a event callback when triggering it. The hci_request is
already serialized with a lock. So you will only have one caller at a
time.

In addition this will make the mini-driver a lot simpler. hci_request is
already handling all the waiting for you.

As mentioned, I do have patches for the hdev->setup() stage, but I have
not gotten to the hci_request part (despite a 12 hours flights).

Regards

Marcel


