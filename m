Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] android: GATT client test interface
Date: Wed, 28 May 2014 14:45:17 +0200
Message-ID: <28600963.hEaRg1ophi@uw000953>
In-Reply-To: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
References: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 26 of May 2014 23:53:23 Szymon Janc wrote:
> Hi,
> 
> This adds initial implementation of GATT client test command. It seems
> to be usefull when testing against PTS for executing actions that are
> no possible from standard API.
> 
> This is initial implementation with enable/connect/disconnect commands.
> 
> Commands are not defined in HAL but in here:
> http://androidxref.com/4.4.2_r1/xref/packages/apps/Bluetooth/src/com/android/bluetooth/gatt/GattDebugUtils.java#77
> 
> BR
> Szymon Janc
> 
> Szymon Janc (5):
>   android/gatt: Add initial implementation of client test command
>   android/gatt: Factor out unregistering client into helper function
>   android/gatt: Implement enable test command
>   android/gatt: Implement connect test command
>   android/gatt: Implement disconnect test command
> 
>  android/gatt.c    | 89 +++++++++++++++++++++++++++++++++++++++++++++----------
>  android/hal-msg.h |  6 ++++
>  2 files changed, 79 insertions(+), 16 deletions(-)
> 
> 

Applied.

-- 
Best regards, 
Szymon Janc
