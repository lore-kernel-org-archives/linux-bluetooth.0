Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 11:24:08 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: djenkins@mvista.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] Bluetooth: remove rfcomm session refcnt
Message-ID: <20120531142408.GQ18069@joana>
References: <1338286055-16639-1-git-send-email-djenkins@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338286055-16639-1-git-send-email-djenkins@mvista.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

* djenkins@mvista.com <djenkins@mvista.com> [2012-05-29 11:07:35 +0100]:

> From: Dean Jenkins <djenkins@mvista.com>
> 
> The rfcomm session refcnt is unworkable as it is hard
> to predict the program flow during abnormal protocol conditions
> so is easy for the refcnt to be out-of-sync. In addition, high
> processor loading can cause the run-time thread order to change
> resulting in malfunctioning of the session refcnt eg. premature
> session deletion or double session deletion resulting in
> kernel crashes.
> 
> Therefore, rely on the rfcomm session state machine to absolutely
> delete the rfcomm session at the right time. The rfcomm session
> state machine is controlled by the DLC data channel connection
> states. The rfcomm session is created when a DLC data channel is
> required. The rfcomm session is deleted when all DLC data channels
> are closed or in abnormal conditions when the socket is BT_CLOSED.
> 
> There are 4 connection / disconnection rfcomm session scenarios:
> host initiated: host disconnected
> host initiated: remote disconnected
> remote initiated: host disconnected
> remote initiated: remote disconnected
> 
> The connection procedures are independent of the disconnection
> procedures. Strangely, the session refcnt was applying special
> treatment so erroneously combining connection and disconnection
> events.
> 
> Signed-off-by: Dean Jenkins <djenkins@mvista.com>
> ---
>  include/net/bluetooth/rfcomm.h |    6 -----
>  net/bluetooth/rfcomm/core.c    |   56 +++++-----------------------------------
>  2 files changed, 6 insertions(+), 56 deletions(-)
> 
> diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
> index e2e3eca..7afd419 100644
> --- a/include/net/bluetooth/rfcomm.h
> +++ b/include/net/bluetooth/rfcomm.h
> @@ -158,7 +158,6 @@ struct rfcomm_session {
>  	struct timer_list timer;
>  	unsigned long    state;
>  	unsigned long    flags;
> -	atomic_t         refcnt;
>  	int              initiator;
>  
>  	/* Default DLC parameters */
> @@ -276,11 +275,6 @@ static inline void rfcomm_dlc_unthrottle(struct rfcomm_dlc *d)
>  void   rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src,
>  								bdaddr_t *dst);
>  
> -static inline void rfcomm_session_hold(struct rfcomm_session *s)
> -{
> -	atomic_inc(&s->refcnt);
> -}
> -
>  /* ---- RFCOMM sockets ---- */
>  struct sockaddr_rc {
>  	sa_family_t	rc_family;
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 8a60238..b0805c1 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -122,12 +122,6 @@ static inline void rfcomm_schedule(void)
>  	wake_up_process(rfcomm_thread);
>  }
>  
> -static inline void rfcomm_session_put(struct rfcomm_session *s)
> -{
> -	if (atomic_dec_and_test(&s->refcnt))
> -		rfcomm_session_del(s);
> -}
> -
>  /* ---- RFCOMM FCS computation ---- */
>  
>  /* reversed, 8-bit, poly=0x07 */
> @@ -263,16 +257,15 @@ static void rfcomm_session_set_timer(struct rfcomm_session *s, long timeout)
>  {
>  	BT_DBG("session %p state %ld timeout %ld", s, s->state, timeout);
>  
> -	if (!mod_timer(&s->timer, jiffies + timeout))
> -		rfcomm_session_hold(s);
> +	mod_timer(&s->timer, jiffies + timeout);

How do protect the timeout function now if you are removing the reference its
hold. If the timer expires after the session deletion we access a invalid
pointer and crash anyway.

	Gustavo
