Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 16:28:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: Always write address type when converting to
 new storage
Message-ID: <20121205142824.GA11137@x220>
References: <20121205111430.GA5233@x220.ger.corp.intel.com>
 <1354710775-2670-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1354710775-2670-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Dec 05, 2012, Szymon Janc wrote:
> When address type is not present in legacy storage assume BDADDR_BREDR
> type and store it.
> 
> This also fix following compilation error on ARM:
> 
>   CC     src/bluetoothd-adapter.o
> src/adapter.c: In function ‘convert_entry’:
> src/adapter.c:2710:2: error: comparison is always true due to limited
> 	range of data type [-Werror=type-limits]
> cc1: all warnings being treated as errors
> make[1]: *** [src/bluetoothd-adapter.o] Error 1
> ---
>  src/adapter.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
