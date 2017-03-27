Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 1/4] Bluetooth: Use switch statement for Intel hardware
 variants
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170306153826.13509ae8@fedora-linux-22.shared>
Date: Mon, 27 Mar 2017 16:21:35 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <71C8F4F5-7013-47E7-9739-9EA52BEF602F@holtmann.org>
References: <20170306153826.13509ae8@fedora-linux-22.shared>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> Multiple new hardware variants are planned and the simple if statement
> would get really complicated and unreadable. So instead replace it with
> a simple switch statement.
> 
> The change is applied to both USB and UART.
> 
> Based-on-patch-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c     | 10 +++++++---
> drivers/bluetooth/hci_intel.c | 17 +++++++++++------
> 2 files changed, 18 insertions(+), 9 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

