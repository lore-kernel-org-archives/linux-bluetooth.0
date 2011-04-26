Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Apr 2011 16:59:23 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Subject: Re: [PATCH v2 6/6] Bluetooth: Respect local MITM req in io_cap
 reply
Message-ID: <20110426235923.GA4486@jh-x301>
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

I had to change this to:

	return conn->remote_auth | (conn->auth_type & 0x01);

I.e. follow remote requirement and apply the MITM bit to it if the local
requirement has it. Otherwise TP/SEC/SEM/BV-04-C doesn't want to pass
(test vector used is 1.0.39.0). It seems to require us to mirror the
remote MITM requirement. Not sure why hciops is working and I haven't
had the chance to check the logs there. I'm still continuing testing so
we'll see if there are further issues with other test cases.

Johan
