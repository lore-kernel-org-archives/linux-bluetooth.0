Return-Path: <cyrus@holtmann.org>
Message-ID: <1326277684.6454.221.camel@aeonflux>
Subject: Re: [PATCH v2 0/5] Some ERTM improvements
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Wed, 11 Jan 2012 11:28:04 +0100
In-Reply-To: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
References: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

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

looks all good now. Thanks for updating the commit messages.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Johan, feel free to take the whole series.

Regards

Marcel


