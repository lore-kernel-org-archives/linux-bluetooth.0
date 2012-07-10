Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 15:33:33 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: debug: Print l2cap refcount
Message-ID: <20120710183333.GC13847@joana>
References: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1341923271-14222-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341923271-14222-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-10 15:27:45 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index d80e3f0..dfe9374 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -672,11 +672,17 @@ enum {
>  
>  static inline void l2cap_chan_hold(struct l2cap_chan *c)
>  {
> +	BT_DBG("chan %p refcnt %d -> %d", c, atomic_read(&c->refcnt),
> +	       atomic_read(&c->refcnt) + 1);
> +

We don't really need to call atomic_read() twice read. Just print the new
value and the log reader has to figure it out.

	Gustavo
