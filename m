Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 08:35:58 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Wu Zheng <wu.zheng@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: bt net interface can't be set up after
 6lowpan connection
Message-ID: <20151008053558.GA22761@t440s.P-661HNU-F1>
References: <1444281182-3131-1-git-send-email-wu.zheng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444281182-3131-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zheng Wu,

On Thu, Oct 08, 2015, Wu Zheng wrote:
> After set 'hciconfig leadv', bt net interface can't be created
> when the 6lowpan over bluetooth le connection is established by another
> bluetooth le device.
> 
> When the the 6lowpan over bluetooth le connection is established,
> the function of chan_open in the file of 6lowpan.c is invoked.
> chan->state is set to the state of BT_CONNECTED.
> 
> Then l2cap_chan_ready in the file of l2cap_core.c is invoked.
> However, when chan->state is BT_CONNECTED, chan_ready_cb is not invoked.
> 
> It results in that bt net interface(such as bt0) can't be created.
> 
> Removing "chan->state = BT_CONNECTED" in chan_open can make chan->state
> set the right state and fixing the issue.
> 
> Signed-off-by: Wu Zheng <wu.zheng@intel.com>
> ---
>  net/bluetooth/6lowpan.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 131e79c..bc177c5 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -792,8 +792,6 @@ static struct l2cap_chan *chan_open(struct l2cap_chan *pchan)
>  	chan->remote_mps = chan->omtu;
>  	chan->mps = chan->omtu;
>  
> -	chan->state = BT_CONNECTED;
> -
>  	return chan;

This is actually already covered by my 6lowpan patch set that I sent a
few days ago (Jukka already acked it but Marcel didn't apply it yet).

Johan
