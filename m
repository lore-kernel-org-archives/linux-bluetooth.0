Return-Path: <cyrus@holtmann.org>
Message-ID: <1346339195.23377.8.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove unneeded zero init
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 30 Aug 2012 08:06:35 -0700
In-Reply-To: <1346317467-20903-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346317467-20903-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> hdev is allocated with kzalloc so zero initialization is not needed.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 36720f0..05bcea6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -443,10 +443,8 @@ static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
>  static inline void hci_conn_hash_init(struct hci_dev *hdev)
>  {
>  	struct hci_conn_hash *h = &hdev->conn_hash;
> +
>  	INIT_LIST_HEAD(&h->list);
> -	h->acl_num = 0;
> -	h->sco_num = 0;
> -	h->le_num = 0;
>  }

since there is only one user of hci_conn_hash_init, we should just
replace that call with a direct INIT_LIST_HEAD.

Regards

Marcel


