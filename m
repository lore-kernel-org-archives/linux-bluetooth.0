Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 30 May 2011 17:48:52 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: David Fries <david@fries.net>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] rfcomm/core.c avoid dangling pointer, check session
 exists
Message-ID: <20110530204852.GE2556@joana>
References: <20110521190253.GA24600@spacedout.fries.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110521190253.GA24600@spacedout.fries.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Fries <david@fries.net> [2011-05-21 14:02:53 -0500]:

> rfcomm_process_sessions is calling rfcomm_process_rx, but
> in this case the session is closed and freed leaving a
> dangling pointer that blows up when rfcomm_process_rx returns
> and rfcomm_process_dlcs is called with the now dangling session
> pointer.  Check to see if the entry is still in the list.
> 
> Signed-off-by: David Fries <David@Fries.net>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
> ---
> I sent out an ealier patch,
> Date: Mon, 21 Mar 2011 21:38:10 -0500
> Subject: [PATCH] rfcomm/core.c avoid dangling pointer, check session
> 
> That version added a return value to rfcomm_session_close to determine
> if the session was closed.  I thought this would be cleaner.
> 
> I can reproduce using blueman-manager on desktop, and Motorola S305 bluetooth
> headset, 2.6.39, but it can take a few attempts.  Start out with the
> desktop as the last device the S305 paired with.
> desktop, connect to the S305,
> S305, turn on
> desktop (connection fails)
> desktop (connection automatically comes up now that S305 is on)
> desktop disconnect S305
> desktop (kernel panic)
> 
> While rfcomm_process_sessions looks symmetrical,
> rfcomm_session_hold(s);
> rfcomm_process_rx
> rfcomm_process_dlcs
> rfcomm_session_put(s);
> 
> rfcomm_process_rx
> if (sk->sk_state == BT_CLOSED) {
>         if (!s->initiator)
>                 rfcomm_session_put(s);
>         rfcomm_session_close(s, sk->sk_err);
> 
> Which isn't symmetrical.  I don't know enough about the subsystem to
> know if there is a better cleaner way to fix this, or if my patch is
> the best solution.
> 
>  net/bluetooth/rfcomm/core.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index c997393..ac47ef3 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1952,6 +1952,12 @@ static inline void rfcomm_process_sessions(void)
>  
>  		default:
>  			rfcomm_process_rx(s);
> +			/* The current session can be closed as part of rx
> +			 * in which case s is now dangling.  Check if it
> +			 * has been removed.
> +			 */
> +			if(n->prev != p)
> +				continue;
>  			break;
>  		}

I don't like this, it's not the proper fix. So I'm trying to figure out this
and fix it. Can you try this patch:


padovan bluetooth-next-2.6 $ git diff
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 5759bb7..75c58ed 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1958,6 +1958,9 @@ static inline void rfcomm_process_sessions(void)
                        break;
                }
 
+               if (s->sock->sk->sk_state == BT_CLOSED)
+                       continue;
+
                rfcomm_process_dlcs(s);
 
                rfcomm_session_put(s);

-- 
Gustavo F. Padovan
http://profusion.mobi
