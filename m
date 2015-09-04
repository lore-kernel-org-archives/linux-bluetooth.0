Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_bcm: Add wake-up capability
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441373747-23042-2-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 4 Sep 2015 11:56:18 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F856A3E4-44F7-4216-91ED-27D84A3627DE@holtmann.org>
References: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com> <1441373747-23042-2-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Retrieve the Interruption used by BCM device, which can be declared
> as Interruption or GpioInt in the ACPI table.
> Retrieve IRQ polarity from the ACPI table to use it for host_wake_active
> parameter of Setup Sleep vendor specific command.
> Configure BCM device to wake-up the host.
> Enable IRQ wake while suspended.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 160 +++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 150 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

