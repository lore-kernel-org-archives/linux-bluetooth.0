Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Add support for BCM2E95 and BCM2E96
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170105171054.5256-1-drake@endlessm.com>
Date: Thu, 16 Feb 2017 17:34:56 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux@endlessm.com,
        frederic.danis@linux.intel.com
Message-Id: <7AEB9B95-E999-4D8D-A52A-D36EA4476AF8@holtmann.org>
References: <20170105171054.5256-1-drake@endlessm.com>
To: Daniel Drake <drake@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> The BCM2E96 ID is used by the ECS EF20 laptop, and BCM2E95 is present
> in the Weibu F3C. Both are now logged as:
> 
>     hci0: BCM: chip id 82
>     hci0: BCM43341B0 (002.001.014) build 0000
>     hci0: BCM (002.001.014) build 0158
> 
> The ECS vendor kernel predates the host-wakeup support in hci_bcm but
> it explicitly has a comment saying that the GPIO assignment needs to be
> reordered for BCM2E96:
> 1. (not used in vendor driver)
> 2. Device wakeup
> 3. Shutdown
> 
> For both devices in question, the DSDT has these GPIOs listed in order
> of GpioInt, GpioIo, GpioIo. And if we use the first one listed (GpioInt)
> as the host wakeup, that interrupt handler fires while doing bluetooth
> I/O.
> 
> I am assuming the convention of GPIO ordering has been changed for these
> new device IDs, so lets use the new ordering on such devices.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
> drivers/bluetooth/hci_bcm.c | 68 +++++++++++++++++++++++++++++----------------
> 1 file changed, 44 insertions(+), 24 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

