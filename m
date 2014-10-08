Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/6] android/map-client: Add HAL part
Date: Wed, 08 Oct 2014 14:59:04 +0200
Message-ID: <1594333.ziacNapFH9@uw000953>
In-Reply-To: <1412345077-30317-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412345077-30317-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 03 of October 2014 16:04:37 Grzegorz Kolodziejczyk wrote:
> v2. changes:
> *Defines in HAL are the same as in IPC
> *Removed MAP instance structures section in ipc api doc
> *Check if MAP instance name is null terminated
> *Fixed multiline comment
> 
> Grzegorz Kolodziejczyk (6):
>   android/hal-ipc-api: Add MAP client HAL
>   android/hal-map-client-api: Add get remote MAS instance command and
>     event
>   android/map-client: Add Android MAP client header
>   android/hal-map-client: Add skeleton for MAP client HAL
>   android/hal-map-client: Add event handler
>   android/hal-map-client: Add API calls
> 
>  android/Android.mk           |   1 +
>  android/Makefile.am          |   2 +
>  android/hal-bluetooth.c      |   3 +
>  android/hal-ipc-api.txt      |  42 ++++++++++++
>  android/hal-map-client.c     | 152 +++++++++++++++++++++++++++++++++++++++++++
>  android/hal-msg.h            |  26 +++++++-
>  android/hal.h                |   2 +
>  android/hardware/bluetooth.h |   1 +
>  android/hardware/bt_mce.h    |  57 ++++++++++++++++
>  9 files changed, 285 insertions(+), 1 deletion(-)
>  create mode 100644 android/hal-map-client.c
>  create mode 100644 android/hardware/bt_mce.h
> 

I've applied this set after some random cleanups and fixes. In future please test
if code build on both Linux and Android. Thanks.

-- 
Best regards, 
Szymon Janc
