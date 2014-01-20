Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/11] HIDHost E2E tests and fixes
Date: Mon, 20 Jan 2014 16:30:01 +0100
Message-ID: <1991876.SYBil5rWd4@uw000953>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 17 of January 2014 01:25:40 Ravi kumar Veeramally wrote:
> Patch set contains few fixes which are noticed while writing
> tests and success test cases for hidhost.
> 
> Ravi kumar Veeramally (11):
>   android/hidhost: Fix connection state notification on profile
>     unregister
>   android/hidhost: Fix miscalculation of get report event struct length
>   android/hidhost: Remove unnecessary check
>   android/tester: Add HIDhost Connect test
>   android/tester: Add HIDhost Disconnect test
>   android/tester: Add HIDhost VirtualUnplug test
>   android/tester: Add HIDhost GetProtocol test
>   android/tester: Add HIDhost SetProtocol test
>   android/tester: Add HIDhost GetReport test
>   android/tester: Add HIDhost SetReport test
>   android/tester: Add HIDhost SendData test
> 
>  android/android-tester.c | 517 ++++++++++++++++++++++++++++++++++++++++++++++-
>  android/hal-hidhost.c    |   3 +-
>  android/hidhost.c        |  14 +-
>  3 files changed, 511 insertions(+), 23 deletions(-)
> 
> 

I've applied all patches except 2 and 9, thanks.
Please see comments for 02/11.

-- 
Best regards, 
Szymon Janc
