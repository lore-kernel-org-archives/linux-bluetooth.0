Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Date: Tue, 8 Aug 2017 16:09:20 +0300
Message-ID: <CADAXeK1oW65U=mm_SdcahhkRM_Njc9QdUZmg1AejbsgtGcNAoA@mail.gmail.com>
Subject: HCI over SPI support
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I need to get BlueZ working with KW30Z chip on a custom ARM board.
It's strongly preferred to use SPI for HCI, since UART is needed for
another purpose, but it looks HCI over SPI is not implemented in
kernel. After some digging, it seems like the following options might
work:

1) Implement HCI over SPI in drivers/bluetooth, similarly to hci_uart.
2) use hci_vhci and make a (userspace) bridge app that would forward
traffic between vhci and spi device. I found a python example for some
unsupported chip connected over UART.
3) Implement some kind of adapter between UART and SPI (fake UART
device), and use hci_uart.

What is the best/recommended way? It looks like the first option is
the cleanest one, with some upstreaming potential, but it might
involve much more work than the second one.

On a related note, why is SPI is rarely, if at all, used for HCI?

Thanks!
