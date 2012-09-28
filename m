Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 16:51:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hciconfig: Clarify what oobdata command do
Message-ID: <20120928135149.GA6803@x220>
References: <1348833533-25427-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348833533-25427-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Sep 28, 2012, Szymon Janc wrote:
> oobdata command results in reading new local OOB data and invalidates
> previously read data. Current command description is misleading.
> 
> ---
>  tools/hciconfig.8 |    2 +-
>  tools/hciconfig.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
