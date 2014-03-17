Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/5] android:Add initial support for GATT Client
Date: Mon, 17 Mar 2014 10:42:58 +0100
Message-ID: <4968002.FIQ5bz6tYU@leonov>
In-Reply-To: <1395014473-7600-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395014473-7600-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 17 of March 2014 01:01:08 Lukasz Rymanowski wrote:
> This patch set add GATT clien scan, connect/disconnect
> functionality.
> 
> Some changes in handling discovery has been done as
> there are two clients of discovery: HAL and GATT
> 
> For now daemon makes sure that device is available before
> connecting it. It is because in case device is not available
> we would block connect to other devices.
> 
> Once white list will be available we can simplify that code.
> 
> ===
> v2: Fixes in discovery handling
> v3: Fixes Szymon comments + adding patch for search primary services
> 
> Jakub Tyszkowski (2):
>   android/bluetooth: Add GATT notifications on LE discovery
>   android/gatt: Use Core profile for LE scan
> 
> Lukasz Rymanowski (3):
>   android/gatt: Add GATT Connect
>   android/gatt: Add disconnect GATT device
>   android/gatt: Find primary services
> 
>  android/Android.mk  |   4 +
>  android/Makefile.am |   3 +
>  android/bluetooth.c | 107 +++++++-
>  android/bluetooth.h |   7 +
>  android/gatt.c      | 717
> +++++++++++++++++++++++++++++++++++++++++++++++++++- 5 files changed, 821
> insertions(+), 17 deletions(-)

Patches 1-4 are now pushed, thanks.

-- 
BR
Szymon Janc
