Return-Path: <cyrus@holtmann.org>
From: Ed Tomlinson <edt@aei.ca>
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix HCI_RESET command syncronization
Date: Wed, 16 Mar 2011 18:33:07 -0400
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, mmvinni@yahoo.com,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
References: <4D7BB10B.3080100@gmail.com> <20110316191540.GC2151@joana> <AANLkTi=NCL2mWhLfnjD85Zp2y9SYFf6Dx5K0A8ckK7CX@mail.gmail.com>
In-Reply-To: <AANLkTi=NCL2mWhLfnjD85Zp2y9SYFf6Dx5K0A8ckK7CX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103161833.08850.edt@aei.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 16 March 2011 16:02:17 Justin Mattock wrote:
> > No, it's based on bluetooth-next (2.6.39). But you can drop the hci_cmd_timer
> > part while testing it. It's not needed unless you have and hci_reset cmd
> > timeout.
> >
> > --
> > Gustavo F. Padovan
> > http://profusion.mobi
> >
> 
> o.k. works over here..
> Tested-by: Justin P. Mattock <justinmattock@gmail.com>

Works here too (Justin's varient on top of .38)
Tested-by: Ed Tomlinson <edt@aei.ca>

Thanks
Ed

> here is an updated patch for the current Mainline if anybody needs it:
> 
> ---
>  include/net/bluetooth/hci.h |    1 +
>  net/bluetooth/hci_core.c    |    1 +
>  net/bluetooth/hci_event.c   |    4 +++-
>  3 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 29a7a8c..c4f4c42 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -76,6 +76,7 @@ enum {
>  	HCI_INQUIRY,
> 
>  	HCI_RAW,
> +	HCI_RESET,
>  };
> 
>  /* HCI ioctl defines */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9c4541b..07a1a4c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -522,6 +522,7 @@ int hci_dev_open(__u16 dev)
>  		atomic_set(&hdev->cmd_cnt, 1);
>  		set_bit(HCI_INIT, &hdev->flags);
> 
> +		set_bit(HCI_RESET, &hdev->flags);	
>  		//__hci_request(hdev, hci_reset_req, 0, HZ);
>  		ret = __hci_request(hdev, hci_init_req, 0,
>  					msecs_to_jiffies(HCI_INIT_TIMEOUT));
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a290854..a63bcf0 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -183,6 +183,8 @@ static void hci_cc_reset(struct hci_dev *hdev,
> struct sk_buff *skb)
> 
>  	BT_DBG("%s status 0x%x", hdev->name, status);
> 
> +	clear_bit(HCI_RESET, &hdev->flags);
> +
>  	hci_req_complete(hdev, HCI_OP_RESET, status);
>  }
> 
> @@ -1464,7 +1466,7 @@ static inline void hci_cmd_status_evt(struct
> hci_dev *hdev, struct sk_buff *skb)
>  		break;
>  	}
> 
> -	if (ev->ncmd) {
> +	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
>  		atomic_set(&hdev->cmd_cnt, 1);
>  		if (!skb_queue_empty(&hdev->cmd_q))
>  			tasklet_schedule(&hdev->cmd_task);
> 
