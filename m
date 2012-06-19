Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Jun 2012 00:26:30 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: btmrvl: Do not send vendor events to
 bluetooth stack
Message-ID: <20120619032630.GE1679@joana>
References: <477F20668A386D41ADCC57781B1F7043083A8A6E5F@SC-VEXCH1.marvell.com>
 <1339740654-5930-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339740654-5930-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-15 09:10:54 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Vendor-specific events shall be processed in driver and not sent
> to bluetooth stack where they screw up HCI command countings.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Tested-by: Bing Zhao <bzhao@marvell.com>
> ---
>  drivers/bluetooth/btmrvl_drv.h  |    2 +-
>  drivers/bluetooth/btmrvl_main.c |   18 +++++++++++++++---
>  drivers/bluetooth/btmrvl_sdio.c |    9 ++++++---
>  3 files changed, 22 insertions(+), 7 deletions(-)

Patch has been applied to the bluetooth tree. Thanks.

	Gustavo
