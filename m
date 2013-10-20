Return-Path: <cyrus@holtmann.org>
Date: Sun, 20 Oct 2013 22:40:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/6] Logging from Android HAL library
Message-ID: <20131020194046.GB31268@x220.p-661hnu-f1>
References: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Oct 20, 2013, Szymon Janc wrote:
> This is an attempt to make library logging API similar to other parts of code.
> It maps log levels used in BlueZ to Android levels and provides log printing
> when HAL library is used by haltest on Linux. Since cutils/log.h is not used
> directly there is no need to stub it on Linux.
> 
> Another advantage is that LOG_TAG and message format is configured in single
> file (eg. modules tags could be easily added to improve readibility of
> non-debug messages)
> 
> Comments are welcome.
> 
> Szymon Janc (6):
>   android: Add wrapper for HAL logging
>   android: Use hal-log.h for logging in bluetooth HAL
>   android: Use hal-log.h for logging in hidhost HAL
>   android: Use hal-log.h for logging in pan HAL
>   android: Use hal-log.h for logging in socket HAL
>   android: Remove not needed cutils/log.h stub
> 
>  Makefile.android        |  9 ++++---
>  android/cutils/log.h    | 29 ---------------------
>  android/hal-bluetooth.c | 68 ++++++++++++++++++++++++-------------------------
>  android/hal-hidhost.c   | 26 +++++++++----------
>  android/hal-log.h       | 35 +++++++++++++++++++++++++
>  android/hal-pan.c       | 16 +++++-------
>  android/hal-sock.c      | 19 ++++++--------
>  7 files changed, 100 insertions(+), 102 deletions(-)
>  delete mode 100644 android/cutils/log.h
>  create mode 100644 android/hal-log.h

Even though you flagged this as RFC it looked fine to me and I like the
idea that we don't need to wrap our brains to different logging
conventions depending on which side of the IPC we are. So all patches
have been applied. Thanks.

Johan
