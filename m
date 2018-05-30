Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 09/13] Bluetooth: hci_serdev: Fix HCI_UART_INIT_PENDING
 not working
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180527190457.2632-10-hdegoede@redhat.com>
Date: Wed, 30 May 2018 08:49:58 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        robh@kernel.org, Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <9656BBC5-4E1B-448F-AD4E-586489F92A7E@holtmann.org>
References: <20180527190457.2632-1-hdegoede@redhat.com>
 <20180527190457.2632-10-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Init hci_uart->init_ready so that hci_uart_init_ready() works properly.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_ldisc.c  | 2 +-
> drivers/bluetooth/hci_serdev.c | 1 +
> drivers/bluetooth/hci_uart.h   | 1 +
> 3 files changed, 3 insertions(+), 1 deletion(-)

this patch has been cherry-picked and applied to bluetooth-next tree.

Regards

Marcel

