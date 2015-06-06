Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2] Bluetooth: btusb: fixed command length alignment on Intel 8260
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150518155207.31ce2835@tedd-fedora-vm>
Date: Sat, 6 Jun 2015 08:15:01 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <2A1B843F-9398-4FEA-98FA-B3D028FECAE9@holtmann.org>
References: <20150518155207.31ce2835@tedd-fedora-vm>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch fixes the command length alignment issue for Intel Bluetooth
> 8260.
> 
> The length of parameters in the firmware downloading command must be
> multiplication of 4. If not, the command must append Intel_NOP command
> with extra parameters, zeros, at the end, and the firmware file is
> already included Intel_NOP command for alignment.
> 
> This patch checks the next command and if the next command is Intel_NOP
> command, it reads the Intel_NOP command and send them together.
> 
> For example, if the data from the firmware file looks like this:
> 8E FC 03 11 22 33 02 FC 03 00 00 00
> 
> Previously, btusb sends two commands:
> 09 FC 06 8E FC 03 11 22 33
> 09 FC 06 02 FC 03 00 00 00
> 
> This won't work because the length of parameters are 6 which violates
> the 4 byte alignment.
> 
> This patch will append them together and send as one command:
> 09 FC 0B 8E FC 03 11 22 33 02 FC 03 00 00 00

I assume this should be 09 FC 0C to indicate 12 bytes of payload.

> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d21f3b4..13b9969 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2541,6 +2541,22 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 
> 		cmd_len = sizeof(*cmd) + cmd->plen;
> 
> +		/* The parameter length of secure send command should be a
> +		 * multiplication of 4. If it is not, it needs to append
> +		 * Intel_NOP command with arbitrary number of parameters (zeros)
> +		 * to meet the 4 byte alignment.
> +		 * The FW file has already formatted with this. So if the next
> +		 * command is Intel_NOP then send them together.
> +		 */
> +		cmd = (void *)(fw_ptr + cmd_len);
> +		if (le16_to_cpu(cmd->opcode) == 0xfc02) {
> +			BT_DBG("%s: Updated cmd to include Intel_NOP",
> +			       hdev->name);
> +			/* Update cmd_len to include the Intel_NOP command
> +			 */
> +			cmd_len += sizeof(*cmd) + cmd->plen;
> +		}
> +

I might have sent you down the wrong patch when looking for the Intel_NOP as next command. After starring at this problem for a bit longer, I think this might be the smarter approach to this.

        fw_ptr = fw->data + 644;
        frag_len = 0;

        while (fw_ptr - fw->data < fw->size) {
                struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);

                frag_len += sizeof(*cmd) + cmd->plen;

                /* The paramter length of the secure send command requires
                 * a 4 byte alignment. It happens so that the firmware file
                 * contains proper Intel_NOP commands to align the fragments
                 * as needed.
                 *
                 * Send set of commands with 4 byte alignment from the
                 * firmware data buffer as a single Data fragement.
                 */
                if (!(frag_len % 4)) {
                        err = btusb_intel_secure_send(hdev, 0x01, frag_len,
                                                      fw_ptr);
                        if (err < 0) {
                                BT_ERR("%s: Failed to send firmware data (%d)",
                                       hdev->name, err);
                                goto done;
                        }

                        fw_ptr += frag_len;
                        frag_len = 0;
                }
        }

I know this compiles, but I have not had a chance to actually test it with real hardware. So if this works, then I would prefer to go this route instead. Please give a try and update your patch. Thanks.

Regards

Marcel

