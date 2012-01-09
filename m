Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138529.6454.159.camel@aeonflux>
Subject: Re: [PATCH 2/5] Bluetooth: Set P-bit for SREJ frame only if there
 are I-frames to ack
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Mon, 09 Jan 2012 11:48:49 -0800
In-Reply-To: <1326122391-8438-3-git-send-email-szymon.janc@tieto.com>
References: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
	 <1326122391-8438-3-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> SREJ frame with P-bit set acknowledges I-frames numbered up to
> (ReqSeq - 1). Also stop ack timer before sending SREJ with P-bit set,
> otherwise I-frames would be acknowledged twice.

some notes about the qualification test cases and a bit more verbose
human explanation is expected here as well.

> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Regards

Marcel


