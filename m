Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Oct 2013 17:19:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android/hal: Unify HALs callbacks pointers definition
Message-ID: <20131022141931.GA7567@x220.p-661hnu-f1>
References: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 22, 2013, Szymon Janc wrote:
> Those are not suppose to be modified or used outside of each HAL.
> ---
>  android/hal-av.c        | 2 +-
>  android/hal-bluetooth.c | 2 +-
>  android/hal-hidhost.c   | 2 +-
>  android/hal-pan.c       | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

All five patches have been applied. Thanks.

Johan
