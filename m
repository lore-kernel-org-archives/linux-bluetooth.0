Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/8] Add PAN test cases
Date: Wed, 30 Jul 2014 12:06:34 +0200
Message-ID: <7996130.28PUDB3RGD@uw000953>
In-Reply-To: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tuesday 29 of July 2014 15:01:24 Ravi kumar Veeramally wrote:
> Ravi kumar Veeramally (8):
>   android/tester: Fix memory leak
>   android/tester-ng: Add PAN init test case
>   android/tester-ng: Add PAN Connect test case
>   android/tester-ng: Add PAN Disconnect test case
>   anrdroid/tester-ng: Add PAN Get Local Role test case
>   android/tester-ng: Add PAN Enable PANU test case
>   android/tester-ng: Add PAN Enable NAP test case
>   android/tester-ng: Add PAN Enable None test case
> 
>  android/Makefile.am   |   1 +
>  android/tester-main.c |  83 +++++++++++++++++++
>  android/tester-main.h |   8 ++
>  android/tester-pan.c  | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 android/tester-pan.c
> 

Patch 1/8 is now applied. Other patches need rebase. Also since now old tester
is removed, lets again prefix tester patches with 'android/tester'.
 

-- 
Best regards, 
Szymon Janc
