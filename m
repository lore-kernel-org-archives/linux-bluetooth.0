Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jan 2012 13:21:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH v2 0/5] Some ERTM improvements
Message-ID: <20120111112154.GA23277@x220>
References: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jan 11, 2012, Szymon Janc wrote:
> No code changes since v1.
> Only improved commits messages as requested by Marcel.
> 
> Szymon Janc (5):
>   Bluetooth: Make l2cap_clear_timer return if timer was running or not
>   Bluetooth: Set P-bit for SREJ frame only if there are I-frames to ack
>   Bluetooth: Clear ack_timer when sending ack
>   Bluetooth: Don't send RNR immediately when entering local busy
>   Bluetooth: Drop L2CAP chan reference if ERTM ack_timer fired
> 
>  include/net/bluetooth/l2cap.h |    9 +++++++--
>  net/bluetooth/l2cap_core.c    |   33 ++++++++++++++++++---------------
>  2 files changed, 25 insertions(+), 17 deletions(-)

All five patches have been applied to my bluetooth-next tree. Thanks.

Johan
