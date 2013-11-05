Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 14:56:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix build for android 4.3
Message-ID: <20131105125607.GA14086@x220.p-661hnu-f1>
References: <1383652121-4121-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383652121-4121-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Tue, Nov 05, 2013, Jerzy Kasenberg wrote:
> Chagnes in HAL interface from 4.3 to 4.4 result in build failure:
> 
> target thumb C: haltest <=
>     external/bluetooth/bluez/android/client/if-gatt.c
> external/bluetooth/bluez/android/client/if-gatt.c:225:1:
>     error: unknown type name 'btgatt_gatt_id_t'
> 
> This patch allows to build GATT for Android 4.3 (api level 18).
> ---
> 
> I sent this patch to the mailing list primarily to allow people
> who work on android 4.3 to be able to build GATT.
> 
>  android/client/if-gatt.c |   27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
