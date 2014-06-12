Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/10] Some HAL IPC work
Date: Thu, 12 Jun 2014 13:07:47 +0200
Message-ID: <4128609.vozAJ6Wg1V@uw000953>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 11 of June 2014 16:32:42 Szymon Janc wrote:
> Hi,
> 
> Those patches are cleanups and fixes for HAL part of IPC. Those are
> first step to making HAL IPC library like so that it can be reused
> by audio and sco HALs.
> 
> Eventually this should also allow for better recovery in case of IPC
> error i.e. not calling exit() directly but custom destroy callback.
> But this is not implemented yet.
> 
> Last two patches add FD passing in notification (as of now this is
> needed only for health HAL).
> 
> BR
> Szymon Janc
> 
> Szymon Janc (10):
>   android/ipc: Make struct service_handler private
>   android/hal-ipc: Allow to pass custom path to IPC
>   android/hal-ipc: Fix missing mutex unlock
>   android/hal-ipc: Move exit calls outside of handle_msg
>   android/hal-ipc: Move exit calls under failed label in hal_ipc_cmd
>   android/hal-ipc: Move exit calls under label in notification_handler
>   android/hal-ipc: Split IPC init and accept to separate functions
>   android/hal-ipc: Move daemon starting to bluetooth HAL
>   android/hal-ipc: Pass FD to notification handlers
>   android/ipc: Add support for sending FD in notifications
> 
>  android/hal-a2dp.c      |   4 +-
>  android/hal-avrcp.c     |  24 +++----
>  android/hal-bluetooth.c |  40 +++++++----
>  android/hal-gatt.c      |  62 ++++++++--------
>  android/hal-handsfree.c |  32 ++++-----
>  android/hal-health.c    |   2 +-
>  android/hal-hidhost.c   |  12 ++--
>  android/hal-ipc.c       | 186 ++++++++++++++++++++++++++----------------------
>  android/hal-ipc.h       |   5 +-
>  android/hal-pan.c       |   4 +-
>  android/ipc.c           |  13 +++-
>  android/ipc.h           |   8 +--
>  12 files changed, 214 insertions(+), 178 deletions(-)
> 
> 

Pushed.

-- 
Best regards, 
Szymon Janc
