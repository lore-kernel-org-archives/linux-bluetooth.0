Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 07/13] Bluetooth: hci_uart: Restore hci_dev->flush
 callback on open()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180527190457.2632-8-hdegoede@redhat.com>
Date: Wed, 30 May 2018 08:47:03 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        robh@kernel.org, Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <7EF01249-EB75-4A69-A712-0DEB4AC2E538@holtmann.org>
References: <20180527190457.2632-1-hdegoede@redhat.com>
 <20180527190457.2632-8-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> For reasons explained in detail in commit 3611f4d2a5e0 ("hci_ldisc:
> fix null pointer deref") the hci_uart_close() functions sets
> hci_dev->flush to NULL.
> 
> But the device may be re-opened after a close, this commit restores the
> hci_dev->flush callback on open().
> 
> Note this commit also moves the nearly empty defition of hci_uart_open()
> a bit down in the file to avoid the need for forward declaring
> hci_uart_flush().
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_ldisc.c  | 20 +++++++++++---------
> drivers/bluetooth/hci_serdev.c | 19 +++++++++++--------
> 2 files changed, 22 insertions(+), 17 deletions(-)

this patch has been cherry-picked and applied to bluetooth-next tree.

Regards

Marcel

