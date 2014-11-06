Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/9] 1st part of handsfree Android 5.0 adaptation code
Date: Thu, 06 Nov 2014 12:11:28 +0100
Message-ID: <7695076.WrWua4k2SN@uw000953>
In-Reply-To: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 05 of November 2014 16:38:44 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add support for Android 5.0 interfaces (1st part of patches).
> 
> Andrei Emeltchenko (9):
>   android/handsfree: Add support for new API for handsfree init
>   android/handsfree: Add support for new API for start_vr
>   android/handsfree: Add support for new API for stop_vr
>   android/handsfree: Add support for new API for volume_control
>   android/handsfree: Add support for new API for cops_response
>   android/handsfree: Add support for new API for cind_response
>   android/handsfree: Add support for new API for formatted_at_response
>   android/handsfree: Add support for new API for at_response
>   android/handsfree: Add support for new API for clcc_response
> 
>  android/hal-handsfree.c | 209 +++++++++++++++++++++++++++++++++++++++++++++---
>  android/hal-ipc-api.txt |  11 ++-
>  android/hal-msg.h       |  13 +++
>  android/handsfree.c     |  47 ++++++++---
>  android/handsfree.h     |   3 +-
>  android/main.c          |   3 +-
>  6 files changed, 260 insertions(+), 26 deletions(-)
> 

All patches in this set are now applied, thanks. 

-- 
Best regards, 
Szymon Janc
