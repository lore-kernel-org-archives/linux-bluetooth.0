Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Fix crash on suspend
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440769440-17959-1-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 28 Aug 2015 12:09:58 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B2B03BFC-8B52-4BFD-A7BF-A65E97141ACE@holtmann.org>
References: <1440769440-17959-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> If bcm_suspend is called whithout device opened there is a crash as
> it tries to use bdev->hu which is NULL.
> Rename bcm_device_list_lock to bcm_device_lock as it does not only apply
> to bcm_device_list.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 36 ++++++++++++++++++++++++++----------
> 1 file changed, 26 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

