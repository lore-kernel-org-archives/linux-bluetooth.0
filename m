Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 00/15] Add HDP profile support at HAL side
Date: Fri, 14 Mar 2014 13:37:23 +0100
Message-ID: <1554669.5ZH3HDXFHT@uw000953>
In-Reply-To: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Thursday 13 of March 2014 13:58:37 Ravi kumar Veeramally wrote:
> v2: Solved Luiz, Szymon, Andrzej and Grzegorz comments.
> 
> v1: Patch set contains HDP profile support at HAL side and initial
> profile registration support at daemon side.
> 
> Ravi kumar Veeramally (15):
>   android/hal-msg: Add HDP app registration struct
>   android/hal-msg: Add HDP app unregistration struct
>   android/hal-msg: Add HDP connect channel struct
>   android/hal-msg: Add HDP destroy channel struct
>   android/hal-msg: Add HDP app registration state event struct
>   android/hal-msg: Add HDP app channel state event struct
>   android/hal-health: Add hal-health.c with initial get interface call
>   android/hal-health: Add HDP .init method
>   android/hal-health: Add HDP .cleanup method
>   android/hal-health: Add HDP .register_application method
>   android/hal-health: Add HDP .unregister_application method
>   android/hal-health: Add HDP .connect_channel method
>   android/hal-health: Add HDP .destroy_channel method
>   android/hal-health: Add app state and channel state event handlers
>   android/health: Add health.c|h file with basic calls
> 
>  android/Android.mk      |   2 +
>  android/Makefile.am     |   2 +
>  android/hal-bluetooth.c |   3 +
>  android/hal-health.c    | 283 ++++++++++++++++++++++++++++++++++++++++++++++++
>  android/hal-msg.h       |  72 ++++++++++++
>  android/hal.h           |   2 +
>  android/health.c        | 115 ++++++++++++++++++++
>  android/health.h        |  25 +++++
>  android/main.c          |  11 ++
>  9 files changed, 515 insertions(+)
>  create mode 100644 android/hal-health.c
>  create mode 100644 android/health.c
>  create mode 100644 android/health.h
> 
> 

Patches 1-9 and 15 are now pushed (with changes we discussed on IRC). Thanks.

-- 
Best regards, 
Szymon Janc
