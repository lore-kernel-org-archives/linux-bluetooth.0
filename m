Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/12] Varios fixes
Date: Fri, 04 Jul 2014 16:48:21 +0200
Message-ID: <10484533.kHJZOD5Lcv@uw000953>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 04 of July 2014 16:43:49 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixes hanging in my tree for some time
> 
> Andrei Emeltchenko (12):
>   android/gatt: Change DBG() to error()
>   android/gatt: Fix memory leak
>   android/hal-msg: trivial: Correct coding style
>   android/gatt: Fix warning by rearranging allocation
>   android/haltest: Auto-accept pairing
>   android/hal-gatt: Remove unneeded never read initialization
>   android/gatt: Add missing error check
>   android/haltest: Add check for valid channel
>   android/tester: Remove unused assignment
>   android/gatt: Fix length check
>   cups: Remove dead code
>   core: Remove dead code
> 
>  android/android-tester.c |  2 +-
>  android/client/if-bt.c   | 16 +++++++++++++++-
>  android/client/if-hl.c   |  4 ++++
>  android/gatt.c           | 17 +++++++++++------
>  android/hal-gatt.c       |  4 +---
>  android/hal-msg.h        |  8 ++++----
>  profiles/cups/main.c     |  7 +------
>  src/profile.c            |  4 ----
>  8 files changed, 37 insertions(+), 25 deletions(-)

Patches 1-10 are now applied, thanks. 


-- 
Best regards, 
Szymon Janc
