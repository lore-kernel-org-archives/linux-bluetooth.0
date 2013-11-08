Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 16:15:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix error handling in adapter_ready
Message-ID: <20131108141532.GA13265@x220.p-661hnu-f1>
References: <1383919259-11782-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383919259-11782-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Nov 08, 2013, Szymon Janc wrote:
> On error negative value is passed to adapter_ready callback. This fix
> passing negative error code to strerror.
> ---
>  android/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
