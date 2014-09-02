Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/16] Move reconnect logic from HOG to GATT
Date: Tue, 02 Sep 2014 17:19:57 +0200
Message-ID: <4967090.QWpRfl20sL@uw000953>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 02 of September 2014 12:09:45 Lukasz Rymanowski wrote:
> Following patches moves reconnect feature from GATT clients to GATT.
> GATT is in charge to decide if white list is used or legacy "passive scan"
> 
> There are also couple of fixes found in HOG during testing.
> 
> Tested on Android against kernel with mgmt version 1.6 and 1.7
> 
> Lukasz Rymanowski (16):
>   android/gatt: Fix for device type in gatt
>   android/hidhost: Remove invalid connecting state notification
>   android/hidhost: Allow to use cached dev when connecting
>   android/bluetooth: Add tracking if device is in white list
>   android/gatt: Add tracking for autoconnect apps
>   android/gatt: Add API to autoconnect GATT based devices
>   android/gatt: Add API to remove autoconnect GATT based device
>   android/gatt: Unsubscribe from autoconnect on unregister
>   android/gatt: Extract remove_autoconnect_device helper
>   android/gatt: Move find_conn up in the file
>   android/gatt: Notify apps interested in autoconnect about connection
>   android/gatt: Extract trigger le connection to new function
>   android/gatt: Move auto_connect_le() up in the file
>   android/gatt: Make sure GATT will reconnect after disconnection
>   android/gatt: Remove device from white list on device destroy
>   android/hidhost: Remove reconnect logic
> 
>  android/bluetooth.c |  23 ++++-
>  android/gatt.c      | 246 +++++++++++++++++++++++++++++++++++++++-------------
>  android/gatt.h      |   2 +
>  android/hidhost.c   |  38 +++-----
>  4 files changed, 218 insertions(+), 91 deletions(-)

Patches 1-6 and 10-13 are now applied. Thanks.

-- 
Best regards, 
Szymon Janc
