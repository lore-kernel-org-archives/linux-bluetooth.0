Return-Path: <cyrus@holtmann.org>
Message-ID: <5564A29D.1030002@qca.qualcomm.com>
Date: Tue, 26 May 2015 09:43:09 -0700
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
MIME-Version: 1.0
To: <linux-firmware@kernel.org>, <kyle@kernel.org>,
	<kyle@infradead.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] qca: add BT firmware files for QCA61x4 series Bluetooth
References: <555D29D1.6090700@qca.qualcomm.com>
In-Reply-To: <555D29D1.6090700@qca.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kyle,

On 05/20/15 17:41, Ben Young Tae Kim wrote:
> Firmware files support QCA61x4 ROME family chips
>
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
>  WHENCE                        |  21 ++
>  qca/NOTICE.txt                | 506 ++++++++++++++++++++++++++++++++++++++++++
>  qca/nvm_00130300.bin          | Bin 0 -> 1937 bytes
>  qca/nvm_00130302.bin          | Bin 0 -> 1968 bytes
>  qca/nvm_usb_00000200.bin      | Bin 0 -> 1859 bytes
>  qca/nvm_usb_00000201.bin      | Bin 0 -> 1859 bytes
>  qca/nvm_usb_00000300.bin      | Bin 0 -> 1857 bytes
>  qca/nvm_usb_00000302.bin      | Bin 0 -> 1953 bytes
>  qca/rampatch_00130300.bin     | Bin 0 -> 65856 bytes
>  qca/rampatch_00130302.bin     | Bin 0 -> 26112 bytes
>  qca/rampatch_usb_00000200.bin | Bin 0 -> 54432 bytes
>  qca/rampatch_usb_00000201.bin | Bin 0 -> 54432 bytes
>  qca/rampatch_usb_00000300.bin | Bin 0 -> 53964 bytes
>  qca/rampatch_usb_00000302.bin | Bin 0 -> 27500 bytes
>  14 files changed, 527 insertions(+)
>  create mode 100644 qca/NOTICE.txt
>  create mode 100644 qca/nvm_00130300.bin
>  create mode 100644 qca/nvm_00130302.bin
>  create mode 100644 qca/nvm_usb_00000200.bin
>  create mode 100644 qca/nvm_usb_00000201.bin
>  create mode 100644 qca/nvm_usb_00000300.bin
>  create mode 100644 qca/nvm_usb_00000302.bin
>  create mode 100644 qca/rampatch_00130300.bin
>  create mode 100644 qca/rampatch_00130302.bin
>  create mode 100644 qca/rampatch_usb_00000200.bin
>  create mode 100644 qca/rampatch_usb_00000201.bin
>  create mode 100644 qca/rampatch_usb_00000300.bin
>  create mode 100644 qca/rampatch_usb_00000302.bin

I'm not sure you received this patch for QCA ROME BT firmware files. Can you review this and merge into the linux-firmware repository if those are okay?

Thanks
-- Ben Kim
