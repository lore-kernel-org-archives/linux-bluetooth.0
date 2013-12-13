Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Dec 2013 16:46:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/bluetooth: Fix missing property change
 notification
Message-ID: <20131213144648.GD30037@x220.p-661hnu-f1>
References: <1386938291-26279-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386938291-26279-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Dec 13, 2013, Szymon Janc wrote:
> After setting new discoverable timeout property change notification
> with new value should be send.
> ---
>  android/bluetooth.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied. Thanks.

Johan
