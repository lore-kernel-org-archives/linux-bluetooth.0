Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 00/15] android: HF Client initial implementation part 1
Date: Thu, 18 Sep 2014 16:37:50 +0200
Message-ID: <1738160.FZyZlhg9qk@leonov>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 15 of September 2014 13:51:13 Lukasz Rymanowski wrote:
> Following patches adds HF Client commands skeleton
> 
> v2:
> * Szymon comment from IRC handled
> * Splited patch set to smaller sets on Luiz request.
> 
> v3:
> * Changed name to handsfree-client
> * Fix compilation issues with BLUEZ_EXTENSIONS flag
> 
> Lukasz Rymanowski (15):
>   android/handsfree-client: Add handsfree-client ID
>   android/hardware: Add HFP Client Interface ID.
>   android/handsfree-client: Add handsfree-client daemon skeleton
>   android/handsfree-client: Add handsfree-client HAL skeleton
>   android/readme: Add information about handsfree-client
>   android/handsfree-client: Add Connect/Disconnect commands
>   android/handsfree-client: Add Audio Connect/Disconnect commands
>   android/handsfree-client: Add Start/Stop Voice Recognition command
>   android/handsfree-client: Add Volume Control command
>   android/handsfree-client: Add Dial and Dial Memory command
>   android/handsfree-client: Add Call Action command
>   android/handsfree-client: Add Query Current Call and Operator Name cmd
>   android/handsfree-client: Add Retrieve Subscriber Info command
>   android/handsfree-client: Add Send DTMF command
>   android/handsfree-client: Add Get Last Voice Tag Number command
> 
>  android/Android.mk             |   9 ++
>  android/Makefile.am            |   5 +-
>  android/README                 |  10 ++
>  android/hal-bluetooth.c        |   5 +
>  android/hal-handsfree-client.c | 356
> +++++++++++++++++++++++++++++++++++++++++ android/hal-msg.h              | 
> 78 ++++++++-
>  android/hal.h                  |   8 +
>  android/handsfree-client.c     | 218 +++++++++++++++++++++++++
>  android/handsfree-client.h     |  25 +++
>  android/hardware/bluetooth.h   |   1 +
>  android/main.c                 |  11 ++
>  11 files changed, 724 insertions(+), 2 deletions(-)
>  create mode 100644 android/hal-handsfree-client.c
>  create mode 100644 android/handsfree-client.c
>  create mode 100644 android/handsfree-client.h

All patches are now applied, thanks.

-- 
BR
Szymon Janc
