Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH v2] Bluetooth: hci_bcm: Correct context of IRQ polarity
 message
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <b54325b3-280f-4fc0-b340-8e4b850af603@gmail.com>
Date: Mon, 9 Oct 2017 20:04:41 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "bluez mailin list (linux-bluetooth@vger.kernel.org)"
        <linux-bluetooth@vger.kernel.org>, hdegoede@redhat.com,
        frederic.danis.oss@gmail.com
Message-Id: <556FED38-85C3-4972-9400-509A26A9D566@holtmann.org>
References: <b54325b3-280f-4fc0-b340-8e4b850af603@gmail.com>
To: Ian W MORRISON <ianwmorrison@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> As the overwriting of IRQ polarity to active low occurs during the driver probe using 'bt_dev_warn' to display the warning results in '(null)' being displayed for the device. This patch uses 'dev_warn' to correctly display the device in the warning instead.
> 
> Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
> ---
> v2: Uses 'dev_warn' (Suggested-by: Marcel Holtmann <marcel@holtmann.org>)
> 
> Testing shows the following improvements using an extract from dmesg of the affected message:
> 
> Without patch:
> [    5.512175] Bluetooth: (null): MINIX Z83-4: Overwriting IRQ polarity to active low
> 
> v1 (superseded) patch:
> [    5.592238] Bluetooth: MINIX Z83-4: Overwriting IRQ polarity to active low
> 
> v2 patch (with a kernel excluding serdev ACPI support patches):
> [    6.112265] hci_bcm BCM2EA4:00: MINIX Z83-4: Overwriting IRQ polarity to active low
> 
> v2 patch (with a kernel including serdev ACPI support patches):
> [    6.367829] hci_uart_bcm serial1-0: MINIX Z83-4: Overwriting IRQ polarity to active low
> ---
> drivers/bluetooth/hci_bcm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

