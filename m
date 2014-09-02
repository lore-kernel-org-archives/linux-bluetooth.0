Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/8] Android tester GATT test cases
Date: Tue, 02 Sep 2014 17:54:29 +0200
Message-ID: <3088084.Oi4xLR3pvB@uw000953>
In-Reply-To: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tuesday 02 of September 2014 14:04:23 Marcin Kraglak wrote:
> v1:
> This patch set improve handling of ssp requests in few test cases
> and adds GATT test cases for searching primary services and
> characteristics.
> 
> This set contains rebased version of pending commits.
> 
> v2:
> * rebased
> * fixed not comparing status of get_characteristic_cb
> 
> Marcin Kraglak (8):
>   android/tester: Simplify ACTION_FAIL and ACTION_SUCCESS defines
>   android/tester: Add function to set default ssp handler
>   android/tester: Add support for search services callbacks
>   android/tester: Add GATT Client Search Service test case
>   android/tester: Add GATT Search Service 2 test case
>   android/tester: Add negative GATT Search Service test
>   android/tester: Add support for get_characteristic_cb()
>   android/tester: Add GATT get_characteristic test
> 
>  android/tester-a2dp.c |   3 +
>  android/tester-gatt.c | 269 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  android/tester-main.c | 123 ++++++++++++++++++++++-
>  android/tester-main.h |  44 ++++++---
>  android/tester-pan.c  |   3 +
>  5 files changed, 426 insertions(+), 16 deletions(-)
 
All patches applied. Thanks. 

-- 
Best regards, 
Szymon Janc
