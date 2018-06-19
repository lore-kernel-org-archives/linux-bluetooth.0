Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v7 7/8] Bluetooth: btqca: Add wcn3990 firmware download
 support.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180618220224.GV88063@google.com>
Date: Tue, 19 Jun 2018 08:14:27 +0200
Cc: Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Message-Id: <93B3B423-AA63-4BEC-9B8A-9C54C36F2DA6@holtmann.org>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-8-bgodavar@codeaurora.org>
 <20180618220224.GV88063@google.com>
To: Matthias Kaehlcke <mka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

>> This patch enables the RAM and NV patch download for wcn3990.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v7:
>> 	* used redefined function qca_uart_setup for firmware download.
>> 
>> Changes in v6:
>> 	* add code to derive the firmware files based on ROM Version.
>> 	* created new patch for common function of ROME and wcn3990.
>> 
>> Changes in v5:
>> 	* moved changes related to hci_qca.
>> 	* addressed review comments.
>> 
>> Changes in v4:
>> 	* initial patch.
>> ---
>> drivers/bluetooth/btqca.c | 26 +++++++++++++++++++++-----
>> 1 file changed, 21 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index f748730039cf..f0a4205068b8 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -332,6 +332,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate, uint8_t soc_type,
>> {
>> 	struct rome_config config;
>> 	int err;
>> +	u8 rom_ver;
>> 
>> 	bt_dev_dbg(hdev, "QCA setup on UART");
>> 
>> @@ -346,11 +347,21 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate, uint8_t soc_type,
>> 		}
>> 		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
>> 	}
>> -
>> 	/* Download rampatch file */
>> 	config.type = TLV_TYPE_PATCH;
>> -	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
>> -		 soc_ver);
>> +	if (soc_type == QCA_WCN3990) {
>> +		/* Firmware files to download are based on ROM version.
>> +		 * ROM version is derived from last two bytes of soc_ver.
>> +		 */
> 
> nit: new line after '/*' (https://www.kernel.org/doc/html/v4.17/process/coding-style.html#commenting))

actually not in the networking code. It has special commenting rules ;)

Regards

Marcel

