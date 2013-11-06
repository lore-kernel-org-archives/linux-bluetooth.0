Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Nov 2013 10:03:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Fallback to 80 columns terminal if not able to
 get real size
Message-ID: <20131106080338.GB15573@x220.p-661hnu-f1>
References: <1383657773-13597-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383657773-13597-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 05, 2013, Szymon Janc wrote:
> This makes num_columns always return valid number of columns, which is
> expected by print_packets function.
> 
> This also fix garbage prints while using btmon via adb shell.
> ---
>  monitor/display.c | 8 ++++----
>  monitor/display.h | 2 ++
>  2 files changed, 6 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
