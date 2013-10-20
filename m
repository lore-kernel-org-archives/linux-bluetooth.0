Return-Path: <cyrus@holtmann.org>
Date: Sun, 20 Oct 2013 22:37:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Initial Android IPC
Message-ID: <20131020193754.GA31268@x220.p-661hnu-f1>
References: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Oct 20, 2013, Szymon Janc wrote:
> V2:
> - simplify daemon code
> - sockets handling cleanup
> - other minor fixes
> 
> -- 
> BR
> Szymon Janc
> 
> Szymon Janc (6):
>   android: Fix missing log cleanup on daemon exit
>   android: Improve cutils/log.h stubs
>   android: Define path for HAL communication socket
>   android: Connect daemon to HAL library
>   android: Make HAL library wait for daemon to connect on init
>   android: Remove not needed property_get function form cutils stubs
> 
>  android/cutils/log.h        |  10 ++--
>  android/cutils/properties.h |  27 ----------
>  android/hal-bluetooth.c     | 126 ++++++++++++++++++++++++++++++++++++--------
>  android/hal-msg.h           |   2 +
>  android/main.c              | 124 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 234 insertions(+), 55 deletions(-)

All six patches have been applied. Thanks.

Johan
