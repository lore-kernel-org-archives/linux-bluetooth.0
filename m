Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/13] Android HAL GATT Server API Commands
Date: Thu, 27 Feb 2014 22:16:47 +0100
Message-ID: <2015721.pAqq9raOyp@athlon>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 27 February 2014 14:28:38 Grzegorz Kolodziejczyk wrote:
> This serie of hal-gatt-api patches updates hal-ipc-api document and
> hal-msg header in parallel. Should be applied on top of GATT client
> patches.
> 
> Grzegorz Kolodziejczyk (13):
>   android/hal-gatt-api: Add Server Register
>   android/hal-gatt-api: Add Server Unregister
>   android/hal-gatt-api: Add Server Connect
>   android/hal-gatt-api: Add Server Disconnect
>   android/hal-gatt-api: Add Server Service
>   android/hal-gatt-api: Add Server Included Service
>   android/hal-gatt-api: Add Server Characteristic
>   android/hal-gatt-api: Add Server Descriptor
>   android/hal-gatt-api: Add Server Start Service
>   android/hal-gatt-api: Add Server Stop Service
>   android/hal-gatt-api: Add Server Delete Service
>   android/hal-gatt-api: Add Server Send Indication
>   android/hal-gatt-api: Add Server Send Response
> 
>  android/hal-ipc-api.txt | 119
> ++++++++++++++++++++++++++++++++++++++++++++++++ android/hal-msg.h       | 
> 93 +++++++++++++++++++++++++++++++++++++ 2 files changed, 212 insertions(+)

All patches applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
