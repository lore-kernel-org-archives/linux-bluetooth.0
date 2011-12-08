Return-Path: <cyrus@holtmann.org>
Message-ID: <1323332741.1965.17.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Clear RFCOMM session timer when
 disconnecting last channel
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Date: Thu, 08 Dec 2011 10:25:41 +0200
In-Reply-To: <1323217407-2490-2-git-send-email-mathewm@codeaurora.org>
References: <1323217407-2490-1-git-send-email-mathewm@codeaurora.org>
	 <1323217407-2490-2-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> When the last RFCOMM data channel is closed, a timer is normally set
> up to disconnect the control channel at a later time.  If the control
> channel disconnect command is sent with the timer pending, the timer
> needs to be cancelled.
> 
> If the timer is not cancelled in this situation, the reference
> counting logic for the RFCOMM session does not work correctly when the
> remote device closes the L2CAP connection.  The session is freed at
> the wrong time, leading to a kernel panic.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/rfcomm/core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 4e32e18..2d28dfe 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1146,6 +1146,7 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
>  			if (list_empty(&s->dlcs)) {
>  				s->state = BT_DISCONN;
>  				rfcomm_send_disc(s, 0);
> +				rfcomm_session_clear_timer(s);
>  			}

I am not 100% convinced that this is correct, but going through the code
for over an hour I could not come up with a case where this would cause
problems. It is just a feeling and with RFCOMM that could be just a
bogus feeling ;)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


