Return-Path: <cyrus@holtmann.org>
Date: Sat, 16 Nov 2013 20:23:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android: Fix sending remote device property if name
 is not present
Message-ID: <20131116182347.GA13780@x220.p-661hnu-f1>
References: <1384610986-17990-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384610986-17990-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sat, Nov 16, 2013, Szymon Janc wrote:
> This fix missing bdaddr to string convertion if name was NULL. This
> was resulting in using undefined dst value.
> ---
>  android/bluetooth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

All three patches have been applied. Thanks.

Johan
