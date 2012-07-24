Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 18:10:38 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 12/20] Bluetooth: Choose connection based on capabilities
Message-ID: <20120724211038.GE20029@joana>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343136121-22476-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-24 16:21:53 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Choose which L2CAP connection to establish by checking support
> for HS and remote side supported features.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/a2mp.h |    2 ++
>  net/bluetooth/a2mp.c         |   21 +++++++++++++++++++++
>  net/bluetooth/l2cap_core.c   |   34 ++++++++++++++++++++++++++++++----
>  3 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
> index 8ba236c..bf18a37 100644
> --- a/include/net/bluetooth/a2mp.h
> +++ b/include/net/bluetooth/a2mp.h
> @@ -22,6 +22,7 @@
>  struct amp_mgr {
>  	struct l2cap_conn	*l2cap_conn;
>  	struct l2cap_chan	*a2mp_chan;
> +	struct l2cap_chan	*bredr_chan;
>  	struct kref		kref;
>  	__u8			ident;
>  	__u8			handle;
> @@ -129,5 +130,6 @@ int amp_mgr_put(struct amp_mgr *mgr);
>  struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
>  				       struct sk_buff *skb);
>  void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
> +void l2cap_discover_amp(struct l2cap_chan *chan);
>  
>  #endif /* __A2MP_H */
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 508cb79..e740bb0 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -769,3 +769,24 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
>  
>  	return mgr->a2mp_chan;
>  }
> +
> +void l2cap_discover_amp(struct l2cap_chan *chan)

prefix a function with l2cap_ outside of the l2cap code is not really a good
idea, we need a better solution here..

	Gustavo
