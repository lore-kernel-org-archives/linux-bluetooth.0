Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Fix for handling unpaired devices
Date: Fri, 29 Aug 2014 16:10:43 +0200
Message-ID: <1749806.d33yIcg8SB@uw000953>
In-Reply-To: <1409306040-3162-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409306040-3162-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 29 of August 2014 11:53:57 Lukasz Rymanowski wrote:
> Following patches fix scenario when remote device is unpaired and
> paired again. Issue found when testing HOG where basically after
> re-pair HOG was not functional.
> 
> v2:
> * bt_unpaired_register returns bool
> * unpaired callback provides also bdaddr type
> 
> v3:
> * Szymon comments addressed
> 
> Lukasz Rymanowski (3):
>   android/bluetooth: Add unpaired device callback
>   android/hidhost: Add remove bond handling
>   android/gatt: Add remove bond handling
> 
>  android/bluetooth.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  android/bluetooth.h |  4 ++++
>  android/gatt.c      | 25 +++++++++++++++++++++++++
>  android/hidhost.c   | 25 +++++++++++++++++++++++++
>  4 files changed, 102 insertions(+), 3 deletions(-)
> 

Applied. Thanks. 

-- 
Best regards, 
Szymon Janc
