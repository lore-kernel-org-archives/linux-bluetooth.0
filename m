Return-Path: <cyrus@holtmann.org>
Date: Thu, 21 Apr 2011 11:10:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Subject: Re: [PATCH v2 6/6] Bluetooth: Respect local MITM req in io_cap
 reply
Message-ID: <20110421081048.GA23120@jh-x301>
References: <1303372461-11848-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1303372461-11848-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303372461-11848-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, Apr 21, 2011, Waldemar Rymarkiewicz wrote:
> If host requires MITM protection notify that to controller in
> io capabilities reply even if the remote device requires no bonding.
> 
> If it is not respected, host can get an unauthenticated link key while
> it expects authenticated one.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 087953e..3ee0060 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2369,7 +2369,7 @@ static inline u8 hci_get_auth_req(struct hci_conn *conn)
>  
>  	/* If remote requests no-bonding follow that lead */
>  	if (conn->remote_auth == 0x00 || conn->remote_auth == 0x01)
> -		return 0x00;
> +		return conn->auth_type & 0x01;
>  
>  	return conn->auth_type;
>  }

Your other patches seem ok to me, but have you verified this one with
the BITE tester? This logic is directly copied from how it is in user
space right now and that's something we have arrived at after multiple
iterations with the BITE tester over the last few years. So I'd be very
careful when changing it.

Johan
