Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/4] Gatt database skeleton
Date: Fri, 25 Apr 2014 09:53:10 +0200
Message-ID: <11771691.Xrp9yWhCWP@leonov>
In-Reply-To: <1398338627-32588-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398338627-32588-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 24 of April 2014 13:23:43 Marcin Kraglak wrote:
> Changes in v2:
>  - removed doxygen comments
>  - in new_service method num_handle must be 1 or greater
>  - removed coding-style errors
> 
> Marcin Kraglak (4):
>   gatt: Add skeleton of gatt-db
>   gatt: Add services list to gatt_db struct
>   gatt: Add method for creating services in gatt_db
>   gatt: Add remove_service function to gatt-db
> 
>  android/Android.mk   |   1 +
>  android/Makefile.am  |   1 +
>  src/shared/gatt-db.c | 193
> +++++++++++++++++++++++++++++++++++++++++++++++++++ src/shared/gatt-db.h | 
> 31 +++++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 src/shared/gatt-db.c
>  create mode 100644 src/shared/gatt-db.h

Patches 1 and 2 are now pushed, thanks.

-- 
BR
Szymon Janc
