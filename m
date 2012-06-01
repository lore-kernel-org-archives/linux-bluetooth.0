Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 10:03:12 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Fix compile warning in l2cap_core.c
Message-ID: <20120601070309.GA3009@aemeltch-MOBL1>
References: <1338507556-10920-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338507556-10920-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, May 31, 2012 at 08:39:16PM -0300, Andre Guedes wrote:
> This patch fixes the following warning reported by gcc 4.7.0:
> 
> net/bluetooth/l2cap_core.c: In function 'l2cap_config_rsp':
> net/bluetooth/l2cap_core.c:3302:13: warning: 'rfc.max_pdu_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
> net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.max_pdu_size' was declared here
> net/bluetooth/l2cap_core.c:3298:25: warning: 'rfc.monitor_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
> net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.monitor_timeout' was declared here
> net/bluetooth/l2cap_core.c:3297:25: warning: 'rfc.retrans_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
> net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.retrans_timeout' was declared here
> net/bluetooth/l2cap_core.c:3295:2: warning: 'rfc.mode' may be used uninitialized in this function [-Wmaybe-uninitialized]
> net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.mode' was declared here
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/l2cap_core.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f9bffe3..6df27cd 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3270,6 +3270,14 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
>  	if ((chan->mode != L2CAP_MODE_ERTM) && (chan->mode != L2CAP_MODE_STREAMING))
>  		return;
>  
> +	/* Use sane default values in case a misbehaving remote device
> +	 * do not send an RFC option.
> +	 */
> +	rfc.mode = chan->mode;
> +	rfc.retrans_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
> +	rfc.monitor_timeout = __constant_cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
> +	rfc.max_pdu_size = cpu_to_le16(chan->imtu);
> +

I feel that this should be reworked better. If we do not get rfc we assign
to rfc those values from chan and make conversion cpu_to_le16 and then we
assign those values again to chan making reverse conversion.

Best regards 
Andrei Emeltchenko 

