Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 11:17:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 06/11] android/hid: Fill send data structure variables
 in hal-hidhost
Message-ID: <20131108091715.GA24795@x220.p-661hnu-f1>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383862220-29968-7-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383862220-29968-7-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Fri, Nov 08, 2013, Ravi kumar Veeramally wrote:
> ---
>  android/hal-hidhost.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

This doesn't compile:

  CC       android/android_libhal_internal_la-hal-hidhost.lo
android/hal-hidhost.c: In function 'send_data':
android/hal-hidhost.c:356:2: error: implicit declaration of function 'free' [-Werror=implicit-function-declaration]
  free(cmd);
  ^
android/hal-hidhost.c:356:2: error: incompatible implicit declaration of built-in function 'free' [-Werror]
cc1: all warnings being treated as errors
make[1]: *** [android/android_libhal_internal_la-hal-hidhost.lo] Error 1

Johan
