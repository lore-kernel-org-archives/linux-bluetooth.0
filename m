Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] Add HDP channel connect and destroy test cases
Date: Thu, 28 Aug 2014 21:01:06 +0200
Message-ID: <1783062.Mcse5UZLPN@athlon>
In-Reply-To: <1409143140-19651-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1409143140-19651-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wednesday 27 August 2014 15:38:55 Ravi kumar Veeramally wrote:
> Patchset contains sdp search fix and channel connect and destroy
> test cases.
> 
> Ravi kumar Veeramally (5):
>   android/health: Avoid multiple times of sdp search
>   android/tester: Add HDP Connect Source Reliable Channel test case
>   android/tester: Add HDP Destroy Source Reliable Channel test case
>   android/tester: Add HDP Connect Sink Streaming Channel test case
>   android/tester: Add HDP Destroy Sink Streaming Channel test case
> 
>  android/health.c     |  75 ++++++-----
>  android/tester-hdp.c | 367
> +++++++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 407
> insertions(+), 35 deletions(-)

All patches applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
