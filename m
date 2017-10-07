Return-Path: <ianwmorrison@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Correct context of IRQ polarity
 message
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)"
 <linux-bluetooth@vger.kernel.org>, hdegoede@redhat.com
References: <d9ad3bdc-2f94-b3b1-1ec1-786999c1e529@gmail.com>
 <2600bbf4-e5fb-312f-0e29-5b17746844b5@gmail.com>
 <FDC710E6-4D82-487C-98AE-230DFD1F4032@holtmann.org>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Message-ID: <e042f9f1-87c9-944c-3a79-f14b69347823@gmail.com>
Date: Sat, 7 Oct 2017 17:16:15 +1100
MIME-Version: 1.0
In-Reply-To: <FDC710E6-4D82-487C-98AE-230DFD1F4032@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/7/17 5:26 AM, Marcel Holtmann wrote:
<snip>
> 
> This should have been a dev_warn(dev->dev, ..) call actually.
> 
> Regards
> 
> Marcel
> 

Hi Marcel,

I've changed the call to 'dev_warn' and issued as a revised patch.

Testing shows the following improvements using an extract from dmesg of the affected message:

Without patch:
[    5.512175] Bluetooth: (null): MINIX Z83-4: Overwriting IRQ polarity to active low

v1 (superseded) patch:
[    5.592238] Bluetooth: MINIX Z83-4: Overwriting IRQ polarity to active low

v2 patch (with a kernel excluding serdev ACPI support patches):
[    6.112265] hci_bcm BCM2EA4:00: MINIX Z83-4: Overwriting IRQ polarity to active low

v2 patch (with a kernel including serdev ACPI support patches):
[    6.367829] hci_uart_bcm serial1-0: MINIX Z83-4: Overwriting IRQ polarity to active low

Regards,
Ian
