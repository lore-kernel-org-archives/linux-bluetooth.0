Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] Bluetooth: btsdio: Do not bind to non-removable BCM43341
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171129192907.27969-1-hdegoede@redhat.com>
Date: Fri, 1 Dec 2017 08:26:41 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Message-Id: <A2528688-FC8C-4F80-9B29-80FD26329F7B@holtmann.org>
References: <20171129192907.27969-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> BCM43341 devices soldered onto the PCB (non-removable) always (AFAICT)
> use an UART connection for bluetooth. But they also advertise btsdio
> support on their 3th sdio function, this causes 2 problems:
> 
> 1) A non functioning BT HCI getting registered
> 
> 2) Since the btsdio driver does not have suspend/resume callbacks,
> mmc_sdio_pre_suspend will return -ENOSYS, causing mmc_pm_notify()
> to react as if the SDIO-card is removed and since the slot is
> marked as non-removable it will never get detected as inserted again.
> Which results in wifi no longer working after a suspend/resume.
> 
> This commit fixes both by making btsdio ignore BCM43341 devices
> when connected to a slot which is marked non-removable.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btsdio.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

