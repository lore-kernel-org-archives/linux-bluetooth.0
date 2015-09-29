Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v3 2/2] regmap: Add iBT register access over HCI support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443531945-31344-2-git-send-email-loic.poulain@intel.com>
Date: Tue, 29 Sep 2015 15:18:35 +0200
Cc: broonie@kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <E8C81944-DC07-4200-8E50-1C2EB9341AAD@holtmann.org>
References: <1443531945-31344-1-git-send-email-loic.poulain@intel.com> <1443531945-31344-2-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add support for Intel Bluetooth silicon register access over HCI.
> Intel BT/FM combo chip allows to read/write some registers (e.g. FM
> registers) via its HCI interface.
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
> v2: Change "hci" to "ibt" since it's intel specific
>    Add comments for clarification
>    Remove unjustified default opcodes
>    Protect __hci_cmd_sync call with hdev req_lock
>    Replace BUG_ON with WARN_ONCE
> v3: Use thread-safe hci_cmd_sync instead of __hci_cmd_sync
>    Update subject
> 
> drivers/base/regmap/Kconfig      |   6 +-
> drivers/base/regmap/Makefile     |   1 +
> drivers/base/regmap/regmap-ibt.c | 276 +++++++++++++++++++++++++++++++++++++++
> include/linux/regmap.h           |   7 +
> 4 files changed, 289 insertions(+), 1 deletion(-)
> create mode 100644 drivers/base/regmap/regmap-ibt.c

patch looks good to me. Now lets get some ACKs for it so I can take it through bluetooth-next tree.

Regards

Marcel

