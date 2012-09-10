Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Sep 2012 16:49:36 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 01/15] Bluetooth: Set Exended Flowspec flag for HS chan
In-Reply-To: <1346766274-21612-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1209101647520.2859@mathewm-linux>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1346766274-21612-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Tue, 4 Sep 2012, Andrei Emeltchenko wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> For AMP we always assume EFS L2CAP option.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> include/net/bluetooth/l2cap.h |    2 ++
> net/bluetooth/l2cap_core.c    |    7 ++++++-
> 2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 161be83..3ec8679 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -508,6 +508,8 @@ struct l2cap_chan {
> 	__u32		remote_acc_lat;
> 	__u32		remote_flush_to;
>
> +	__u8		ctrl_id;
> +

How about "remote_amp_id" instead of ctrl_id?  The channel move code 
tracks local_amp_id.  Why does the remote controller id need to be 
tracked?

> 	struct delayed_work	chan_timer;
> 	struct delayed_work	retrans_timer;
> 	struct delayed_work	monitor_timer;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index de6f52c..aea2b50 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5439,8 +5439,13 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
> void l2cap_chan_create_cfm(struct hci_conn *hcon, u8 remote_id)
> {
> 	struct amp_mgr *mgr = hcon->amp_mgr;
> +	struct l2cap_chan *chan = mgr->bredr_chan;
>
> -	l2cap_send_chan_create_req(mgr->bredr_chan, remote_id);
> +	/* Set Extended Flow Spec for AMP */
> +	set_bit(FLAG_EFS_ENABLE, &chan->flags);
> +	chan->ctrl_id = remote_id;
> +
> +	l2cap_send_chan_create_req(chan, remote_id);
> }
>
> int l2cap_disconn_ind(struct hci_conn *hcon)
> -- 
> 1.7.9.5

Regards,

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation


