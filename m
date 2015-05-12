Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: fixed command length alignment for Intel 8260
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150507090856.6c0eca7f@intel.com>
Date: Tue, 12 May 2015 17:31:49 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <91738548-8638-41AA-9BEE-757BC21BFBE2@holtmann.org>
References: <20150507090856.6c0eca7f@intel.com>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch fixes the command length alignment issue for Intel Bluetooth
> 8260.
> 
> The length of parameters in the firmware downloading command must be
> multiplication of 4. If not, the command must append Intel_NOP command
> with extra parameters, zeros, at the end and the firmware file is
> already included Intel_NOP command for alignment.
> 
> This patch checks the length of the parameters and if it is not aligned,
> then read the next command which is Intel_NOP command and append it to
> the first read command and send to the device together.
> 
> For example, if the data from the firmware file is like this:
> 8E FC 03 11 22 33 02 FC 03 00 00 00
> 
> Previously, btusb sends two commands:
> 09 FC 06 8E FC 03 11 22 33
> 09 FC 06 02 FC 03 00 00 00
> 
> This will not work due to the length of parameters are 6 and the device
> failed to align the data.
> 
> This patch will append them together and send one command:
> 09 FC 0B 8E FC 03 11 22 33 02 FC 03 00 00 00
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 35 +++++++++++++++++++++++++++++++++++
> 1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d21f3b4..57f4eac 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2541,6 +2541,41 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 
> 		cmd_len = sizeof(*cmd) + cmd->plen;
> 
> +		/* The parameter length of secure send command should be a
> +		 * multiplication of 4. If it is not, it appends Intel_NOP
> +		 * command with arbitrary number of parameters (zeros) to meet
> +		 * the 4 byte alignment.
> +		 * The FW file has already aligned and appended Intel_NOP
> +		 * command. So it needs to read next Intel_NOP command and send
> +		 * them together.
> +		 */

I would assume we just rely on the firmware file to build this correctly. So instead of checking the alignment, I would prefer that we check if the next command is a NOP and then send both commands.

> +		if ((cmd_len % 4) != 0) {
> +			/* Make sure the next command is Intel_NOP command.
> +			 */
> +			struct hci_command_hdr *nop_cmd =
> +						(void *)(fw_ptr + cmd_len);
> +			if (nop_cmd->opcode != 0xfc02) {

This is not big-endian safe.

> +				BT_ERR("%s: Intel_NOP command is missing",
> +				       hdev->name);
> +				err = -EBADF;
> +				goto done;
> +			}
> +
> +			/* Command data is updated to include NOP command
> +			 */
> +			cmd_len += sizeof(*nop_cmd) + nop_cmd->plen;
> +
> +			/* Make sure the total length is aligned and smaller
> +			 * than maximum param length
> +			 */
> +			if ((cmd_len % 4) != 0 || cmd_len > 252)   {

I wonder why we check again here? The fragmentation is done the secure_send helper.

> +				BT_ERR("%s: 4 byte alignment failed",
> +				       hdev->name);
> +				err = -EBADF;
> +				goto done;
> +			}
> +		}
> +
> 		/* Send each command from the firmware data buffer as
> 		 * a single Data fragment.
> 		 */

Regards

Marcel

