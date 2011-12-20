Return-Path: <cyrus@holtmann.org>
Message-ID: <1324414682.1965.130.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove global mutex hci_task_lock
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Tue, 20 Dec 2011 12:58:02 -0800
In-Reply-To: <1324408251-8116-1-git-send-email-ulisses@profusion.mobi>
References: <1324408251-8116-1-git-send-email-ulisses@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> The hci_task_lock mutex (previously a lock) was supposed to protect the
> register/unregister of HCI protocols against RX/TX tasks. This will not
> be needed anymore because SCO and L2CAP will always be compiled.
> 
> Moreover, with the recent move of RX/TX to workqueues per device the
> global hci_task_lock was causing starvation between different HCI
> devices.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  net/bluetooth/hci_core.c |   21 +--------------------
>  1 files changed, 1 insertions(+), 20 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d6382db..b45b745 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -61,8 +61,6 @@ static void hci_rx_work(struct work_struct *work);
>  static void hci_cmd_work(struct work_struct *work);
>  static void hci_tx_work(struct work_struct *work);
>  
> -static DEFINE_MUTEX(hci_task_lock);
> -
>  /* HCI device list */
>  LIST_HEAD(hci_dev_list);
>  DEFINE_RWLOCK(hci_dev_list_lock);
> @@ -1800,8 +1798,7 @@ EXPORT_SYMBOL(hci_recv_stream_fragment);
>  
>  /* ---- Interface to upper protocols ---- */
>  
> -/* Register/Unregister protocols.
> - * hci_task_lock is used to ensure that no tasks are running. */
> +/* Register/Unregister protocols. */
>  int hci_register_proto(struct hci_proto *hp)
>  {
>  	int err = 0;
> @@ -1811,15 +1808,11 @@ int hci_register_proto(struct hci_proto *hp)
>  	if (hp->id >= HCI_MAX_PROTO)
>  		return -EINVAL;
>  
> -	mutex_lock(&hci_task_lock);
> -
>  	if (!hci_proto[hp->id])
>  		hci_proto[hp->id] = hp;
>  	else
>  		err = -EEXIST;
>  
> -	mutex_unlock(&hci_task_lock);
> -
>  	return err;
>  }

This only works fine because we are registering the protocols from the
module init. So what I like to see is that we get rid of this altogether
and just call directly into the specific event functions for L2CAP and
SCO since there are the only users anyway. Making them replaceable was a
nice idea, but it is not practical anymore.

Regards

Marcel


