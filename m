Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/13] Initial code for handsfree support
Date: Wed, 05 Feb 2014 10:10:01 +0100
Message-ID: <1570104.FfihyI7Z9m@uw000953>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sunday 02 of February 2014 22:09:11 Szymon Janc wrote:
> Hi,
> 
> This adds initial support for HFP. HAL library is complete, for daemon
> only support for RFCOMM connection handling.
> 
> There is also minimal set of AT handling needed for SLC establishment
> (proper AT parsing code is still missing).
> 
> Comments are welcome.
> 
> BR
> Szymon Janc
> 
> Szymon Janc (13):
>   android/handsfree: Add initial files
>   android/handsfree: Add commands and events definition to IPC header
>   android/handsfree: Add stubs for commands handlers
>   android/hal-handsfree: Implement notifications handling
>   android/hal-handsfree: Implement sending commands
>   android/handsfree: Add SDP record for AG
>   android/handsfree: Add support for RFCOMM connection handling
>   android/handsfree: Add initial code for AT commands processing
>   android/handsfree: Add connect command handling
>   android/handsfree: Add disconnect command handling
>   android/handsfree: Add AT+BRSF command support
>   android/handsfree: Add support for AT+CIND command
>   android/handsfree: Add support for AT+CMER command
> 
>  android/Android.mk      |   2 +
>  android/Makefile.am     |   4 +
>  android/hal-bluetooth.c |   3 +
>  android/hal-handsfree.c | 598 +++++++++++++++++++++++++++++++++++++
>  android/hal-msg.h       | 208 +++++++++++++
>  android/hal.h           |   2 +
>  android/handsfree.c     | 763 ++++++++++++++++++++++++++++++++++++++++++++++++
>  android/handsfree.h     |  25 ++
>  android/main.c          |  14 +
>  9 files changed, 1619 insertions(+)
>  create mode 100644 android/hal-handsfree.c
>  create mode 100644 android/handsfree.c
>  create mode 100644 android/handsfree.h
> 
> 

Patches 1-10 are now pushed.

-- 
Best regards, 
Szymon Janc
