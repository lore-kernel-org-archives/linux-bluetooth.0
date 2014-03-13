Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/8] Add initial support for GATT Client
Date: Fri, 14 Mar 2014 00:11:44 +0100
Message-ID: <2769207.04ahbSiDyh@athlon>
In-Reply-To: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 13 March 2014 19:46:07 Lukasz Rymanowski wrote:
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
> I'm sending also fixed Grzegorz and Jakub patches to avoid
> rebasing.
> 
> Grzegorz Kolodziejczyk (1):
>   android/gatt: Use queue and stdlib instead of glib
> 
> Jakub Tyszkowski (5):
>   android/gatt: Change name of match functions
>   android/bluetooth: Refactor start/stop discovery
>   android/bluetooth: Move start discovery function up in the file
>   android/bluetooth: Add GATT notifications on LE discovery
>   android/gatt: Use Core profile for LE scan
> 
> Lukasz Rymanowski (2):
>   android/gatt: Add GATT Connect
>   android/gatt: Add disconnect GATT device
> 
>  android/Android.mk  |   4 +
>  android/Makefile.am |   3 +
>  android/bluetooth.c | 195 ++++++++++++----
>  android/bluetooth.h |   7 +
>  android/gatt.c      | 623
> ++++++++++++++++++++++++++++++++++++++++++++++++++-- 5 files changed, 773
> insertions(+), 59 deletions(-)

Patches 1-4 are now applied (with some small fixes).

-- 
Szymon K. Janc
szymon.janc@gmail.com
