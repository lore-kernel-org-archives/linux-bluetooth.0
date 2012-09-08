Return-Path: <cyrus@holtmann.org>
Date: Sat, 8 Sep 2012 16:40:13 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Make hci_chan_del return void
Message-ID: <20120908194013.GA5788@joana>
References: <1346224851-16625-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346224851-16625-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-08-29 10:20:51 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Return code is not needed in hci_chan_del
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_conn.c         |    4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0964954..36720f0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -573,7 +573,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev);
>  void hci_conn_check_pending(struct hci_dev *hdev);
>  
>  struct hci_chan *hci_chan_create(struct hci_conn *conn);
> -int hci_chan_del(struct hci_chan *chan);
> +void hci_chan_del(struct hci_chan *chan);
>  void hci_chan_list_flush(struct hci_conn *conn);
>  struct hci_chan *hci_chan_lookup_handle(struct hci_conn *hcon, __u16 handle);
>  struct hci_chan *hci_chan_lookup_handle_all(struct hci_dev *hdev,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 1c79a76..4695880 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -935,7 +935,7 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
>  	return chan;
>  }
>  
> -int hci_chan_del(struct hci_chan *chan)
> +void hci_chan_del(struct hci_chan *chan)
>  {
>  	struct hci_conn *conn = chan->conn;
>  	struct hci_dev *hdev = conn->hdev;
> @@ -948,8 +948,6 @@ int hci_chan_del(struct hci_chan *chan)
>  
>  	skb_queue_purge(&chan->data_q);
>  	kfree(chan);
> -
> -	return 0;
>  }
>  
>  void hci_chan_list_flush(struct hci_conn *conn) > -- 

This patch doesn't apply on bluetooth-next anymore, please rebase.

	Gustavo
