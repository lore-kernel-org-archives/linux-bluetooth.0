Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Nov 2013 14:59:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Szymon Janc <szymon.janc@tieto.com>
Subject: Re: [PATCH v2 0/8] android: Some adapter and mgmt handling code
 cleanup
Message-ID: <20131114125901.GA15226@x220.p-661hnu-f1>
References: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 12, 2013, Szymon Janc wrote:
> v2:
>  - addressed Johan comments about using static adapter structure instead of
>    bunch of static adapter_* variables
>  - Added a patch for utilizing mgmt library for passing adapter ready callback
>    (patch 3)
> 
> v1:
>   This patchset moves mgmt initalization handling from main.c to adapter.c so
>   now all mgmt handling is done from adaper.c. Adapter.c is also renamed to
>   bluetooth.c to match service name implemented by it.
> 
>   Startup and shutdown timeouts are still handled in main.c (mostly due to
>   both resulting in mainloop shutdown so extra callback are avoided).
> 
>   IO handling and commands dispatch is still done in main.c
> 
> 
> Comments are welcome.
> 
> -- 
> BR
> Szymon Janc
> 
> Szymon Janc (8):
>   android: Make adapter static
>   android: Move adapter initialization to adapter.c
>   android: Don't use static pointer for storing adapter_ready callback
>   android/hidhost: Use adapter address provided on register
>   android: Report adapter address in adapter_ready callback
>   android: Remove not needed bt_adapter_get_address function
>   android: Rename adapter.c to bluetooth.c
>   android: Rename bluetooth service functions to match service name
> 
>  android/Android.mk  |    2 +-
>  android/Makefile.am |    4 +-
>  android/adapter.c   | 2008 -----------------------------------------------
>  android/adapter.h   |   37 -
>  android/bluetooth.c | 2177 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/bluetooth.h |   38 +
>  android/hidhost.c   |   21 +-
>  android/main.c      |  314 ++------
>  8 files changed, 2287 insertions(+), 2314 deletions(-)
>  delete mode 100644 android/adapter.c
>  delete mode 100644 android/adapter.h
>  create mode 100644 android/bluetooth.c
>  create mode 100644 android/bluetooth.h

All patches in this set have been applied. Thanks.

Johan
