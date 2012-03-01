Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Mar 2012 14:36:40 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Update MGMT and SMP timeout constants to use
 msecs_to_jiffies
Message-ID: <20120301223640.GB7306@x220.amr.corp.intel.com>
References: <1330641157-32626-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330641157-32626-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Mar 01, 2012, Marcel Holtmann wrote:
> The MGMT and SMP timeout constants are always used in form of jiffies. So
> just include the conversion from msecs in the define itself. This has the
> advantage of making the code where the timeout is used more readable.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c |    5 ++---
>  net/bluetooth/smp.c  |    5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
