Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 10:10:04 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org, pkrystad@codeaurora.org
Subject: Re: [RFC 1/8] Bluetooth: Improve ERTM sequence number offset
 calculation
Message-ID: <20120426071002.GB2659@aemeltch-MOBL1>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
 <1335396979-11692-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335396979-11692-2-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, Apr 25, 2012 at 04:36:12PM -0700, Mat Martineau wrote:
> Instead of using modular division, the offset can be calculated using
> only addition and subtraction.  The previous calculation did not work
> as intended and was more difficult to understand, involving unsigned
> integer underflow and a check for a negative value where one was not
> possible.

BTW: in what cases this was not working?

> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 22e9ec9..92c0423 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -724,13 +724,10 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
>  
>  static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
>  {
> -	int offset;
> -
> -	offset = (seq1 - seq2) % (chan->tx_win_max + 1);
> -	if (offset < 0)
> -		offset += (chan->tx_win_max + 1);
> -
> -	return offset;
> +	if (seq1 >= seq2)
> +		return seq1 - seq2;
> +	else
> +		return chan->tx_win_max + 1 - seq2 + seq1;
>  }

You seems are changing logic, not improving as you patch states. Your offset might be bigger
then tx_win_max. Was this intended?

Best regards 
Andrei Emeltchenko 
