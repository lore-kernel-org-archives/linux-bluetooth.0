Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Hedberg, Johan" <johan.hedberg@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: bt net interface can't be set up after
 6lowpan connection
Date: Thu, 8 Oct 2015 06:26:54 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E11AC1986@SHSMSX104.ccr.corp.intel.com>
References: <1444281182-3131-1-git-send-email-wu.zheng@intel.com>
 <20151008053558.GA22761@t440s.P-661HNU-F1>
In-Reply-To: <20151008053558.GA22761@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Thanks for your info.

Best Regards
Zheng Wu

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@intel.com] 
Sent: Thursday, October 8, 2015 1:36 PM
To: Zheng, Wu
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: bt net interface can't be set up after 6lowpan connection

Hi Zheng Wu,

On Thu, Oct 08, 2015, Wu Zheng wrote:
> After set 'hciconfig leadv', bt net interface can't be created when 
> the 6lowpan over bluetooth le connection is established by another 
> bluetooth le device.
> 
> When the the 6lowpan over bluetooth le connection is established, the 
> function of chan_open in the file of 6lowpan.c is invoked.
> chan->state is set to the state of BT_CONNECTED.
> 
> Then l2cap_chan_ready in the file of l2cap_core.c is invoked.
> However, when chan->state is BT_CONNECTED, chan_ready_cb is not invoked.
> 
> It results in that bt net interface(such as bt0) can't be created.
> 
> Removing "chan->state = BT_CONNECTED" in chan_open can make 
> chan->state set the right state and fixing the issue.
> 
> Signed-off-by: Wu Zheng <wu.zheng@intel.com>
> ---
>  net/bluetooth/6lowpan.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c index 
> 131e79c..bc177c5 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -792,8 +792,6 @@ static struct l2cap_chan *chan_open(struct l2cap_chan *pchan)
>  	chan->remote_mps = chan->omtu;
>  	chan->mps = chan->omtu;
>  
> -	chan->state = BT_CONNECTED;
> -
>  	return chan;

This is actually already covered by my 6lowpan patch set that I sent a few days ago (Jukka already acked it but Marcel didn't apply it yet).

Johan
