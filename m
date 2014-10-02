Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Oct 2014 14:27:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mcap: Unify libmcap usage for Android and non-Android
 versions
Message-ID: <20141002112723.GA12086@t440s.lan>
References: <1412171134-29943-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412171134-29943-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wed, Oct 01, 2014, Ravi kumar Veeramally wrote:
> Now profiles/health/ , android/health and mcaptest will use
> profiles/health/mcap-lib.
> ---
>  Makefile.plugins                        |    4 +-
>  android/Android.mk                      |    4 +-
>  android/Makefile.am                     |    4 +-
>  android/health.c                        |    2 +-
>  android/mcaptest.c                      |    2 +-
>  profiles/health/hdp.c                   |    3 +-
>  profiles/health/hdp_util.c              |    3 +-
>  {android => profiles/health}/mcap-lib.c |    0
>  {android => profiles/health}/mcap-lib.h |    0
>  profiles/health/mcap.c                  | 2192 -------------------------------
>  profiles/health/mcap.h                  |  164 ---
>  profiles/health/mcap_internal.h         |  137 --
>  profiles/health/mcap_lib.h              |  224 ----
>  profiles/health/mcap_sync.c             | 1009 --------------
>  14 files changed, 9 insertions(+), 3739 deletions(-)
>  rename {android => profiles/health}/mcap-lib.c (100%)
>  rename {android => profiles/health}/mcap-lib.h (100%)
>  delete mode 100644 profiles/health/mcap.c
>  delete mode 100644 profiles/health/mcap.h
>  delete mode 100644 profiles/health/mcap_internal.h
>  delete mode 100644 profiles/health/mcap_lib.h
>  delete mode 100644 profiles/health/mcap_sync.c

Applied. Thanks.

Johan
