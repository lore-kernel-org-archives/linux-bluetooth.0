Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 1/5] Bluetooth: hci_intel: Use shorter timeout for HCI commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448650563-9075-1-git-send-email-loic.poulain@intel.com>
Date: Tue, 1 Dec 2015 21:48:56 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <785CD16F-4E0F-4EEE-B0A7-C0E334A2BA8F@holtmann.org>
References: <1448650563-9075-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Use the standard HCI_CMD_TIMEOUT(1s) for HCI command instead of
> HCI_INIT_TIMEOUT(10s) which is not justified in these cases.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

