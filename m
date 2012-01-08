Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jan 2012 22:29:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH 0/2] Fix L2CAP timeout values
Message-ID: <20120108202946.GD16731@x220.P-661HNU-F1>
References: <1325675442-24658-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325675442-24658-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Jan 04, 2012, Andrzej Kaczmarek wrote:
> After moving L2CAP timers to workqueues there is problem with timeout
> values which are defined in miliseconds but timer functions works with
> jiffies. As a result, timers are unreliable on platforms with CONFIG_HZ
> not set to 1000.
> 
> Similar problem was fixed before workqueues but now it's apparently
> back. This time however I left l2ca_set_timer to use values in jiffies
> to avoid confusion and make code less prone to similar issues in
> future (I hope).
> 
> Also together with patch from Peter Hurley it should fix problems with
> SSP and RFCOMM as recently discovered (on platforms with
> CONFIG_HZ != 1000).
> 
> Andrzej Kaczmarek (2):
>   Bluetooth: Fix sk_sndtimeo initialization for L2CAP socket
>   Bluetooth: l2cap_set_timer needs jiffies as timeout value
> 
>  include/net/bluetooth/l2cap.h |    6 +++---
>  net/bluetooth/l2cap_core.c    |   12 ++++++++----
>  net/bluetooth/l2cap_sock.c    |    2 +-
>  3 files changed, 12 insertions(+), 8 deletions(-)

Both patches have been applied to my bluetooth-next tree. Thanks.

Johan
