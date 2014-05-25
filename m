Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 4/8] Bluetooth: l2cap: Set more channel defaults
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400837248-12179-5-git-send-email-jukka.rissanen@linux.intel.com>
Date: Sat, 24 May 2014 21:49:22 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5CA60F7D-C370-48F4-B5F6-6BBE84970A01@holtmann.org>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com> <1400837248-12179-5-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/l2cap_core.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 60433c4..3a7f560 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -471,8 +471,14 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
> 	chan->max_tx = L2CAP_DEFAULT_MAX_TX;
> 	chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
> 	chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
> +	chan->remote_max_tx = chan->max_tx;
> +	chan->remote_tx_win = chan->tx_win;
> 	chan->ack_win = L2CAP_DEFAULT_TX_WINDOW;
> 	chan->sec_level = BT_SECURITY_LOW;
> +	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
> +	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
> +	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
> +	chan->conf_state = 0;

this one extremely bad without a detailed commit message explaining why the change is made.

Regards

Marcel

