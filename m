Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Feb 2015 10:03:36 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv6 0/8] AVDTP deduplication
Message-ID: <20150218080333.GA28722@aemeltch-MOBL1>
References: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Mon, Feb 16, 2015 at 03:02:22PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Changes:
> 	* v6: Fix uid_get/clear adding id checks
> 	* v5: Use POSIX ffs() for bitmap get uid, limiting maximum number of local SEPs to 32.
> 	* v4: Fix Android build and clear typos.
>         * v3: Convert gslist to queue for lseps, refactor lseps handlings, remove extra DBGs.
>         * v2: Fix fixup patch
>         * v1: Add SEID fixes with unit tests
>         * RFC: initial version
> 
> Andrei Emeltchenko (8):
>   unit/avdtp: Add SEP register/unregister tests
>   unit/avdtp: Add duplicate SEID test
>   shared/utils: Add helpers for bitfield id generation
>   android/avdtp: Fix SEID generation
>   unit/avdtp: Add check for too many SEP creation
>   android/avdtp: Fix registering SEP with wrong SEID
>   android/avdtp: Refactor local SEP list handling
>   unit/avdtp: Refactor context destroy
> 
>  android/Android.mk  |   2 +
>  android/Makefile.am |   2 +
>  android/a2dp.c      |  15 +++--
>  android/avdtp.c     | 101 +++++++++++++++++++------------
>  android/avdtp.h     |  10 ++-
>  android/avdtptest.c |  10 ++-
>  src/shared/util.c   |  29 +++++++++
>  src/shared/util.h   |   3 +
>  unit/test-avdtp.c   | 171 ++++++++++++++++++++++++++++++++++++++++++++--------
>  9 files changed, 273 insertions(+), 70 deletions(-)
> 
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
