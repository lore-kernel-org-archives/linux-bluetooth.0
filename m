Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 16:03:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/10] Add GATT support to haltest
Message-ID: <20131031140311.GA27325@x220.p-661hnu-f1>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Thu, Oct 31, 2013, Jerzy Kasenberg wrote:
> This patachset adds code to call GATT hal methods.
> Compiles on Android 4.3 and host.
> On 4.2 it's source code is not included.
> 
> Status that is used in callbacks is currently printed as number.
> This number corresponds to series of defines from file:
> external/bluedroid/stack/include/gatt_api.h
> This file looks like implementation detail for bluedroid.
> It's to be decided it defines should be copied to bluez source code.
> Until that status is printed as numbers.
> Same applies to tGATT_WRITE_TYPE which is used as argument in
> write_characteristic and write_descriptor.
> 
> Jerzy Kasenberg (10):
>   android/client: Add skeleton for GATT interface
>   android/client: Add GATT client callbacks code
>   android/client: Add complex GATT type formating
>   android/client: Add init/cleanup for GATT
>   android/client: Add helper macros to verify args
>   android/client: Add GATT client method calls
>   android/client: Add GATT complex type parsing
>   android/client: Add tab completion to GATT client
>   android/client: Add GATT server callbacks code
>   android/client: Add GATT server methods
> 
>  android/Android.mk       |    7 +
>  android/Makefile.am      |    2 +
>  android/client/haltest.c |    5 +
>  android/client/if-bt.c   |    2 +
>  android/client/if-gatt.c | 1733 ++++++++++++++++++++++++++++++++++++++++++++++
>  android/client/if-main.h |   14 +
>  6 files changed, 1763 insertions(+)
>  create mode 100644 android/client/if-gatt.c

All patches have been applied. Thanks.

Johan
