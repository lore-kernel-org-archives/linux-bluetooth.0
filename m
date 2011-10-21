Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Oct 2011 11:36:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv6 hcidump 2/4] add fixed channel definitions
Message-ID: <20111021083653.GA1800@fusion.localdomain>
References: <1319099414-27993-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1319099414-27993-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319099414-27993-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 20, 2011, Emeltchenko Andrei wrote:
> ---
>  lib/l2cap.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/l2cap.h b/lib/l2cap.h
> index 47b3dc3..3880551 100644
> --- a/lib/l2cap.h
> +++ b/lib/l2cap.h
> @@ -139,6 +139,11 @@ struct l2cap_conninfo {
>  
>  #define L2CAP_SDULEN_SIZE	2
>  
> +/* L2CAP fixed channels */
> +#define L2CAP_FC_L2CAP		0x02
> +#define L2CAP_FC_CONNLESS	0x04
> +#define L2CAP_FC_A2MP		0x08
> +
>  /* L2CAP structures */
>  typedef struct {
>  	uint16_t	len;

The first two patches have been applied.

For the rest, like Marcel suggested, I think it'd be a good idea to have
proper get_{le,be}{16,32,64} functions. Since we can use these both in
hcidump and bluez I suppose libbluetooth is the appropriate place for
them, however in that case (e.g. if you put them in lib/bluetooth.h) a
_bt prefix should be added.

Johan
