Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 20:30:53 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix checks for LE support on LE-only
 controllers
Message-ID: <20130430233053.GB4456@joana>
References: <1366797932-11507-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366797932-11507-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-04-24 13:05:32 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> LE-only controllers do not support extended features so any kind of host
> feature bit checks do not make sense for them. This patch fixes code
> used for both single-mode (LE-only) and dual-mode (BR/EDR/LE) to use the
> HCI_LE_ENABLED flag instead of the "Host LE supported" feature bit for
> LE support tests.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> This one slipped by with my earlier single-mode fixes. I've added a
> mgmt-tester case for it to prevent it from returning in the future.
> Since this is probably too late for a bluetooth-next pull for 3.10 I
> suppose it'll need to wait for the first bluetooth.git pull request
> instead.
> 
>  net/bluetooth/mgmt.c |    2 +-
>  net/bluetooth/smp.c  |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
