Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Oct 2014 16:12:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] mcap: Rename mcap-lib to mcap
Message-ID: <20141002131250.GA26889@t440s.lan>
References: <1412252717-11671-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412252717-11671-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Thu, Oct 02, 2014, Ravi kumar Veeramally wrote:
> ---
>  Makefile.plugins                       | 2 +-
>  android/Android.mk                     | 4 ++--
>  android/Makefile.am                    | 4 ++--
>  android/health.c                       | 2 +-
>  android/mcaptest.c                     | 2 +-
>  profiles/health/hdp.c                  | 2 +-
>  profiles/health/hdp_util.c             | 2 +-
>  profiles/health/{mcap-lib.c => mcap.c} | 2 +-
>  profiles/health/{mcap-lib.h => mcap.h} | 0
>  9 files changed, 10 insertions(+), 10 deletions(-)
>  rename profiles/health/{mcap-lib.c => mcap.c} (99%)
>  rename profiles/health/{mcap-lib.h => mcap.h} (100%)

Both of these patches have been applied. Thanks.

Johan
