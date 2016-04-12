Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7] Bluetooth: hci_uart: Support firmware download for Marvell
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <dbff88372c89421b9568ad3d32aa283d@SC-EXCH04.marvell.com>
Date: Tue, 12 Apr 2016 18:17:44 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Ganapathi Bhat <gbhat@marvell.com>
Message-Id: <DEE89AB2-038B-4C0D-A06C-0A72351DD2EC@holtmann.org>
References: <1459845266-2771-1-git-send-email-akarwar@marvell.com> <dbff88372c89421b9568ad3d32aa283d@SC-EXCH04.marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

>> From: Amitkumar Karwar [mailto:akarwar@marvell.com]
>> Sent: Tuesday, April 05, 2016 2:04 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; Ganapathi Bhat; Amitkumar Karwar
>> Subject: [PATCH v7] Bluetooth: hci_uart: Support firmware download for
>> Marvell
>> 
>> From: Ganapathi Bhat <gbhat@marvell.com>
>> 
>> This patch implement firmware download feature for Marvell Bluetooth
>> devices. If firmware is already downloaded, it will skip downloading.
>> 
>> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
>> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
>> ---
>> v2: Fixed compilation warning reported by kbuild test robot
>> v3: Addressed review comments from Marcel Holtmann
>>    a) Removed vendor specific code from hci_ldisc.c
>>    b) Get rid of static forward declaration
>>    c) Removed unnecessary heavy nesting
>>    d) Git rid of module parameter and global variables
>>    e) Add logic to pick right firmware image
>> v4: Addresses review comments from Alan
>>    a) Use existing kernel helper APIs instead of writing own.
>>    b) Replace mdelay() with msleep()
>> v5: Addresses review comments from Loic Poulain
>>    a) Use bt_dev_err/warn/dbg helpers insted of BT_ERR/WARN/DBG
>>    b) Used static functions where required and removed forward
>> delcarations
>>    c) Edited comments for the function hci_uart_recv_data
>>    d) Made HCI_UART_DNLD_FW flag a part of driver private data
>> v6: Addresses review comments from Loic Poulain
>>    a) Used skb instead of array to store firmware data during download
>>    b) Used hci_uart_tx_wakeup and enqueued packets instead of tty write
>>    c) Used GFP_KERNEL instead of GFP_ATOMIC
>> v7: Edited Kconfig to add dependency for BT_HCIUART_H4. The change
>> resolves
>>    errors reported by kbuild test robot.
>> ---
>> drivers/bluetooth/Kconfig     |  11 +
>> drivers/bluetooth/Makefile    |   1 +
>> drivers/bluetooth/btmrvl.h    |  43 ++++
>> drivers/bluetooth/hci_ldisc.c |   6 +
>> drivers/bluetooth/hci_mrvl.c  | 568
>> ++++++++++++++++++++++++++++++++++++++++++
>> drivers/bluetooth/hci_uart.h  |   8 +-
>> 6 files changed, 636 insertions(+), 1 deletion(-)  create mode 100644
>> drivers/bluetooth/btmrvl.h  create mode 100644
>> drivers/bluetooth/hci_mrvl.c
>> 
> 
> Could you please take this patch if there are no further comments/suggestions?

didn't I see a kbot build warning for this version as well? Or was that the previous version?

Regards

Marcel

