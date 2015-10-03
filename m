Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH] Bluetooth: btintel: Add iBT register access over HCI support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443716181-19050-1-git-send-email-loic.poulain@intel.com>
Date: Sat, 3 Oct 2015 19:06:19 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <85632F95-C999-4F91-B1B1-A7CD489506AA@holtmann.org>
References: <1443716181-19050-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add regmap ibt to support Intel Bluetooth silicon register access
> over HCI. Intel BT/FM combo chip allows to read/write some registers
> (e.g. FM registers) via its HCI interface.
> 
> Read/Write operations are performed via a HCI transaction composed of
> a HCI command (host->controller) followed by a HCI command complete
> event (controller->host). Read/Write Command opcodes can be specified
> to the regmap init function.
> We define data formats which are intel/vendor specific.
> 
> Register Read/Write HCI command payload (Host):
> Field: | REG ADDR | MODE | DATA_LEN | DATA... |
> size:  |   32b    |  8b  |    8b    |  8b*    |
> 
> Register Read HCI command complete event payload (Controller):
> Field: | CMD STATUS | REG ADDR | DATA... |
> size:  |     8b     |   32b    |  8b*    |
> 
> Register Write HCI command complete event payload (Controller):
> Field: | CMD_STATUS |
> size:  |     8b     |
> 
> Since this payload is HCI encapsulated, Little Endian byte order is
> used.
> 
> Write/Read Example:
> 
> If we write 0x0000002a at address 0x00008c04, with opcode_write 0xfc5d,
> The resulting transaction is (btmon trace):
> 
> < HCI Command (0x3f|0x005d) plen 10 [hci0]
>        04 8c 00 00 02 04 2a 00 00 00
>> HCI Event (0x0e) plen 4
>      Unknown (0x3f|0x005d) ncmd 1
>        00
> 
> Then, if we read the same register with opcode_read 0xfc5e:
> 
> < HCI Command (0x3f|0x005e) plen 6 [hci0]
>        04 8c 00 00 02 04
>> HCI Event (0x0e) plen 12 [hci0]
>      Unknown (0x3f|0x005e) ncmd 1
>        00 04 8c 00 00 2a 00 00 00
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/Kconfig   |   1 +
> drivers/bluetooth/btintel.c | 195 ++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btintel.h |   9 ++
> 3 files changed, 205 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

