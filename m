Return-Path: <cyrus@holtmann.org>
Message-ID: <1412238408.13121.9.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH] Bluetooth: Fix lockdep warning with l2cap_chan_connect
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 02 Oct 2014 11:26:48 +0300
In-Reply-To: <1412234182-13370-1-git-send-email-johan.hedberg@gmail.com>
References: <1412234182-13370-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On to, 2014-10-02 at 10:16 +0300, johan.hedberg@gmail.com wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The L2CAP connection's channel list lock (conn->chan_lock) must never be
> taken while already holding a channel lock (chan->lock) in order to
> avoid lock-inversion and lockdep warnings. So far the l2cap_chan_connect
> function has acquired the chan->lock early in the function and then
> later called l2cap_chan_add(conn, chan) which will try to take the
> conn->chan_lock. This violates the correct order of taking the locks and
> may lead to the following type of lockdep warnings:
> 

patch worked ok so no more lockdep warning. Patch also looked good so
ack from me.

Tested-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka


