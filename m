Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jul 2012 10:51:22 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Change page scan interval in fast connectable
 mode
Message-ID: <20120716135122.GA31800@joana>
References: <1340880270-15407-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340880270-15407-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-28 13:44:30 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch is based on a user space (hciops) patch which never made it
> upstream but does make sense to include in the mgmt part of the kernel.
> 
> (User space) commit message from Dmitriy Paliy:
> "
> Page scan interval in fast connectable mode is changed from 22.5 msec to
> 160 msec to perform less aggressive page scanning. This is done
> accordingly to controller vendor recommendation.
> 
> Primary concern is that current parameters 22.5 interval, 11.25 window,
> and interleaved scanning occupy whole radio bandwidth. Changing interval
> to 160 msec should be sufficient for both speeding up connection
> establishment and leaving space for other activities, like inquiry scan,
> e.g.
> "
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
