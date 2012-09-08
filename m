Return-Path: <cyrus@holtmann.org>
Date: Sat, 8 Sep 2012 18:13:45 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] Bluetooth: debug: Print refcnt for hci_dev
Message-ID: <20120908211345.GI5788@joana>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1346933147-11789-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346933147-11789-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-09-06 15:05:45 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 4704ca4..6a3337e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -603,11 +603,17 @@ static inline void hci_conn_put(struct hci_conn *conn)
>  /* ----- HCI Devices ----- */
>  static inline void hci_dev_put(struct hci_dev *d)
>  {
> +	BT_DBG("%s orig refcnt %d", d->name,
> +	       atomic_read(&d->dev.kobj.kref.refcount));
> +
>  	put_device(&d->dev);
>  }
>  
>  static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
>  {
> +	BT_DBG("%s orig refcnt %d", d->name,
> +	       atomic_read(&d->dev.kobj.kref.refcount));
> +
>  	get_device(&d->dev);
>  	return d;
>  }

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
