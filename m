Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v2] Bluetooth: btintel: Create common Intel Version Read function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449415114-30029-1-git-send-email-loic.poulain@intel.com>
Date: Sun, 6 Dec 2015 17:37:08 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D3B3D47E-A140-4DEA-B132-84051D64A9FE@holtmann.org>
References: <1449415114-30029-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> The Intel Version Read command is used to retrieve information
> about hardware and firmware version/revision of Intel Bluetooth
> controllers. This is an Intel generic command used in USB and
> UART drivers.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Fix typo in inline declaration
> 
> drivers/bluetooth/btintel.c   | 25 ++++++++++++++
> drivers/bluetooth/btintel.h   |  7 ++++
> drivers/bluetooth/btusb.c     | 80 +++++++++++++------------------------------
> drivers/bluetooth/hci_intel.c | 46 ++++++-------------------
> 4 files changed, 66 insertions(+), 92 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

