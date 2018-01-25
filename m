Return-Path: <fengguang.wu@intel.com>
Date: Thu, 25 Jan 2018 12:37:13 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc: kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [bluetooth-next:master 8/8] drivers/bluetooth/btintel.c:689:24:
 sparse: restricted __le16 degrades to integer
Message-ID: <201801251210.Q8lWcors%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   0bd4ded3287d4ecb9443fca7f86d45d2235f6ebc
commit: 0bd4ded3287d4ecb9443fca7f86d45d2235f6ebc [8/8] Bluetooth: btintel: Create common function for firmware download
reproduce:
        # apt-get install sparse
        git checkout 0bd4ded3287d4ecb9443fca7f86d45d2235f6ebc
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/bluetooth/btintel.c:689:24: sparse: restricted __le16 degrades to integer

vim +689 drivers/bluetooth/btintel.c

   643	
   644	int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
   645				      u32 *boot_param)
   646	{
   647		int err;
   648		const u8 *fw_ptr;
   649		u32 frag_len;
   650	
   651		/* Start the firmware download transaction with the Init fragment
   652		 * represented by the 128 bytes of CSS header.
   653		 */
   654		err = btintel_secure_send(hdev, 0x00, 128, fw->data);
   655		if (err < 0) {
   656			bt_dev_err(hdev, "Failed to send firmware header (%d)", err);
   657			goto done;
   658		}
   659	
   660		/* Send the 256 bytes of public key information from the firmware
   661		 * as the PKey fragment.
   662		 */
   663		err = btintel_secure_send(hdev, 0x03, 256, fw->data + 128);
   664		if (err < 0) {
   665			bt_dev_err(hdev, "Failed to send firmware pkey (%d)", err);
   666			goto done;
   667		}
   668	
   669		/* Send the 256 bytes of signature information from the firmware
   670		 * as the Sign fragment.
   671		 */
   672		err = btintel_secure_send(hdev, 0x02, 256, fw->data + 388);
   673		if (err < 0) {
   674			bt_dev_err(hdev, "Failed to send firmware signature (%d)", err);
   675			goto done;
   676		}
   677	
   678		fw_ptr = fw->data + 644;
   679		frag_len = 0;
   680	
   681		while (fw_ptr - fw->data < fw->size) {
   682			struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
   683	
   684			/* Each SKU has a different reset parameter to use in the
   685			 * HCI_Intel_Reset command and it is embedded in the firmware
   686			 * data. So, instead of using static value per SKU, check
   687			 * the firmware data and save it for later use.
   688			 */
 > 689			if (cmd->opcode == 0xfc0e) {
   690	
   691				/* The boot parameter is the first 32-bit value
   692				 * and rest of 3 octets are reserved.
   693				 */
   694				*boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
   695	
   696				bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
   697			}
   698	
   699			frag_len += sizeof(*cmd) + cmd->plen;
   700	
   701			/* The parameter length of the secure send command requires
   702			 * a 4 byte alignment. It happens so that the firmware file
   703			 * contains proper Intel_NOP commands to align the fragments
   704			 * as needed.
   705			 *
   706			 * Send set of commands with 4 byte alignment from the
   707			 * firmware data buffer as a single Data fragement.
   708			 */
   709			if (!(frag_len % 4)) {
   710				err = btintel_secure_send(hdev, 0x01, frag_len, fw_ptr);
   711				if (err < 0) {
   712					bt_dev_err(hdev,
   713						   "Failed to send firmware data (%d)",
   714						   err);
   715					goto done;
   716				}
   717	
   718				fw_ptr += frag_len;
   719				frag_len = 0;
   720			}
   721		}
   722	
   723	done:
   724		return err;
   725	}
   726	EXPORT_SYMBOL_GPL(btintel_download_firmware);
   727	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
