Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 00/15] android/gatt: Gatt client improvements
Date: Tue, 08 Apr 2014 21:57:26 +0200
Message-ID: <2361626.J53QVkP15G@athlon>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 08 April 2014 11:22:17 Lukasz Rymanowski wrote:
> This patch set adds:
> * caching primary and included sevices.
> * fix in hanling included services
> * add list of disconnected devices - thanks to this we keep
> cached services and next connect is faster.
> * Fix  instance id for primary and included services
> 
> Lukasz Rymanowski (15):
>   android/gatt: Change name of gatt_primary in service structure
>   android/gatt: Add flag primary to struct service
>   android/gatt: Add helper functions to send all primary services
>   android/gatt: Use cached primary services if possible
>   android/gatt: Add create_device helper function
>   android/gatt: Add list of disconnected device
>   android/gatt: Minor change in get_include_data
>   android/gatt: Add msg size check for get included service
>   android/gatt: Prepare to cache included services
>   android/gatt: Add helper function to create_service
>   android/gatt: Cache include services
>   android/gatt: Add helper to send included service
>   android/gatt: Change label name from failed to reply
>   android/gatt: Use cache for included services
>   android/gatt: Fix instance id for primary and included service
> 
>  android/gatt.c | 509
> +++++++++++++++++++++++++++++++++++++++------------------ 1 file changed,
> 346 insertions(+), 163 deletions(-)

All patches applied (including v2) with some changes discussed offline, 
thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
