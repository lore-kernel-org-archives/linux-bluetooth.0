Return-Path: <cyrus@holtmann.org>
Message-ID: <1444127148.2982.77.camel@linux.intel.com>
Subject: Re: [PATCH 0/6] Bluetooth: 6lowpan cleanups
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 06 Oct 2015 13:25:48 +0300
In-Reply-To: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
References: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>

On ti, 2015-10-06 at 13:03 +0300, Johan Hedberg wrote:
> Hi,
> 
> Here's a set of initial cleanups for the 6lowpan code which I came up
> with as I started preparing to implement the new mgmt channel.
> 
> Johan Hedberg (6):
>       Bluetooth: 6lowpan: Fix imtu & omtu values
>       Bluetooth: 6lowpan: Remove redundant (and incorrect) MPS assignments
>       Bluetooth: 6lowpan: Remove redundant BT_CONNECTED assignment
>       Bluetooth: 6lowpan: Remove unnecessary chan_open() function
>       Bluetooth: 6lowpan: Rename confusing 'pchan' variables
>       Bluetooth: 6lowpan: Remove unnecessary chan_get() function
> 
>  net/bluetooth/6lowpan.c | 72 ++++++++++++++++--------------------------------
>  1 file changed, 24 insertions(+), 48 deletions(-)
> 
> Johan
> 

Cheers,
Jukka


