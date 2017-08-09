Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 9 Aug 2017 13:45:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: HCI over SPI support
Message-ID: <20170809104536.GA984@x1c.lan>
References: <CADAXeK1oW65U=mm_SdcahhkRM_Njc9QdUZmg1AejbsgtGcNAoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADAXeK1oW65U=mm_SdcahhkRM_Njc9QdUZmg1AejbsgtGcNAoA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ivan,

On Tue, Aug 08, 2017, Ivan Drobyshevskyi wrote:
> I need to get BlueZ working with KW30Z chip on a custom ARM board.
> It's strongly preferred to use SPI for HCI, since UART is needed for
> another purpose, but it looks HCI over SPI is not implemented in
> kernel. After some digging, it seems like the following options might
> work:
> 
> 1) Implement HCI over SPI in drivers/bluetooth, similarly to hci_uart.
> 2) use hci_vhci and make a (userspace) bridge app that would forward
> traffic between vhci and spi device. I found a python example for some
> unsupported chip connected over UART.
> 3) Implement some kind of adapter between UART and SPI (fake UART
> device), and use hci_uart.
> 
> What is the best/recommended way? It looks like the first option is
> the cleanest one, with some upstreaming potential, but it might
> involve much more work than the second one.

I'd go for proper kernel-side driver.

> On a related note, why is SPI is rarely, if at all, used for HCI?

Because SPI is not a standard HCI transport (something specified as part
of the Bluetooth Core Specification). So if you make a kernel-side
driver you need to be aware that it may not become the only SPI HCI
driver as the implementation will be vendor-specific rather than
standard.

Johan
