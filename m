Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 12:02:46 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: A2MP: Fix potential NULL dereference
Message-ID: <20121001150246.GJ15463@joana>
References: <20120928012323.GG5522@localhost>
 <1348831731-12934-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348831731-12934-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-09-28 14:28:50 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Return INVALID_CTRL_ID for unknown AMP controller and for BR/EDR
> controller and fixes dereference possible NULL pointer.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/a2mp.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Patch has been applied to bluetooth-next, Thanks.

	Gustavo
