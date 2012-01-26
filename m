Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jan 2012 15:20:20 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [RFC 11/22] Bluetooth: Use RCU to manipulate chan_list
Message-ID: <20120126132019.GC3300@aemeltch-MOBL1>
References: <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sat, Dec 17, 2011 at 07:29:31PM -0200, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> 
> Instead of using tasklet_disable() to prevent acess to the channel use, we
> can use RCU and improve the performance of our code.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
...
> @@ -986,10 +984,10 @@ int hci_chan_del(struct hci_chan *chan)
>  
>  void hci_chan_list_flush(struct hci_conn *conn)
>  {
> -	struct hci_chan *chan, *tmp;
> +	struct hci_chan *chan;
>  
>  	BT_DBG("conn %p", conn);
>  
> -	list_for_each_entry_safe(chan, tmp, &conn->chan_list, list)
> +	list_for_each_entry_rcu(chan, &conn->chan_list, list)
>  		hci_chan_del(chan);
>  }

I feel that this code is not exactly correct. hci_chan_del frees chan:

<------8<--------------------------------------------------------
|  int hci_chan_del(struct hci_chan *chan)
|  {
|          struct hci_conn *conn = chan->conn;
|          struct hci_dev *hdev = conn->hdev;
|
|          BT_DBG("%s conn %p chan %p", hdev->name, conn, chan);
|
|          list_del_rcu(&chan->list);
|
|          synchronize_rcu();
|
|          skb_queue_purge(&chan->data_q);
|          kfree(chan);
|
|          return 0;
|  }
<------8<--------------------------------------------------------

and then list_for_each_entry_rcu references chan->member.next which is not
safe ;)

I've sent patch reverting this change.

Best regards 
Andrei Emeltchenko 
