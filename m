Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Oct 2013 10:34:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Improve hal_ipc_cmd helper
Message-ID: <20131022073430.GA11367@x220.p-661hnu-f1>
References: <1382426248-10793-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382426248-10793-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 22, 2013, Szymon Janc wrote:
> Handle error response inside helper so that users don't expecting any
> response don't need to provide dummy buffer only for error (which is
> already return value of helper).
> ---
>  android/hal-bluetooth.c | 7 ++-----
>  android/hal-ipc.c       | 6 ++++++
>  2 files changed, 8 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
