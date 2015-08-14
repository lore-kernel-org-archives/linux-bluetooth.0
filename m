Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Aug 2015 08:40:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arkadiusz Lichwa <arkadiusz.lichwa@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] emulator: Swap max and min interval
Message-ID: <20150814054058.GA26140@t440s.P-661HNU-F1>
References: <1439390408-537-1-git-send-email-arkadiusz.lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439390408-537-1-git-send-email-arkadiusz.lichwa@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arek,

On Wed, Aug 12, 2015, Arkadiusz Lichwa wrote:
> Fixes btdev controller bits when assigning actual parameters,
> max and min interval, in LE Meta event for LE Connection Update to be sent 
> to host.
> ---
>  emulator/btdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index cd211ef..57e51a0 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -3322,8 +3322,8 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
>  			return;
>  		lecu = data;
>  		le_conn_update(btdev, le16_to_cpu(lecu->handle),
> -				le16_to_cpu(lecu->min_interval),
>  				le16_to_cpu(lecu->max_interval),
> +				le16_to_cpu(lecu->min_interval),
>  				le16_to_cpu(lecu->latency),
>  				le16_to_cpu(lecu->supv_timeout),
>  				le16_to_cpu(lecu->min_length),

Good catch, but I think it makes more sense to keep the order as min,
max since that's how it is in HCI as well. Since this is such a trivial
thing I went ahead and fixed is myself (i.e. swapped the order in the
function instead of the caller).

Johan
