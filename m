Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/8] android: GATT IPC definition fixes
Date: Thu, 17 Apr 2014 10:48:08 +0200
Message-ID: <2481994.49Glr05R7h@uw000953>
In-Reply-To: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thursday 17 of April 2014 01:10:25 Andrzej Kaczmarek wrote:
> Hi,
> 
> Here are few patches to make GATT IPC messages structure better
> describe its actual content, especially in cases where message has
> some optional data which until now were identified by 'number' field.
> Such name is misleading since in all cases there could be only one
> optional parameter thus messages are updated to have boolean-like
> field and properly named optional parameter.
> 
> This should make code easier to read as field names in structures
> now have consistent names which describe its conents clearly.
> 
> 
> Andrzej Kaczmarek (8):
>   android/hal-gatt-api: Fix IPC definition for service_search
>   android/hal-gatt-api: Fix IPC definition for get_included_service
>   android/hal-gatt-api: Fix IPC definition for get_characteristic
>   android/hal-gatt-api: Fix IPC definition for get_descriptor
>   android/hal-gatt-api: Fix IPC definition for read_characteristic
>   android/hal-gatt-api: Fix IPC definition for write_characteristic
>   android/gatt: Add IPC message verification for service_search
>   android/ipc: Add common definitions for GATT IPC structures
> 
>  android/gatt.c          |  44 +++++++-----
>  android/hal-gatt.c      |  37 +++++-----
>  android/hal-ipc-api.txt | 175 +++++++++++++-----------------------------------
>  android/hal-msg.h       |  20 +++---
>  4 files changed, 100 insertions(+), 176 deletions(-)
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
