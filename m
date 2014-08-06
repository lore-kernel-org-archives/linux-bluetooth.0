Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Aug 2014 10:40:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 0/8] Add PAN test cases
Message-ID: <20140806074025.GE31308@t440s.lan>
References: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Aug 05, 2014, Ravi kumar Veeramally wrote:
> v2: Fixed comments.
> 
> Ravi kumar Veeramally (8):
>   android/tester: Add PAN init test case
>   android/tester: Add PAN Connect test case
>   android/tester: Add PAN Disconnect test case
>   android/tester: Add PAN Get Local Role test case
>   android/pan: Notify control state callback on HAL .enable call
>   android/tester: Add PAN Enable NAP test case
>   android/tester: Add PAN Enable PANU test case
>   android/tester: Add PAN Enable None test case
> 
>  android/Makefile.am   |   1 +
>  android/pan.c         |  21 +++--
>  android/tester-main.c | 109 +++++++++++++++++++++
>  android/tester-main.h |  29 ++++++
>  android/tester-pan.c  | 256 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 409 insertions(+), 7 deletions(-)
>  create mode 100644 android/tester-pan.c

All patches in this set have been applied. Thanks.

Johan
