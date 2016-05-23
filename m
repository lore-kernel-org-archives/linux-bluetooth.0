Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ganapathi Bhat" <gbhat@marvell.com>, Cathy Luo <cluo@marvell.com>
Subject: RE: [PATCH v11 3/3] Bluetooth: hci_uart: Support firmware download
 for Marvell
Date: Mon, 23 May 2016 06:06:35 +0000
Message-ID: <b7786ce4e00b4a3cb29a18f9e0b3b2a0@SC-EXCH04.marvell.com>
References: <1462548714-7971-1-git-send-email-akarwar@marvell.com>
 <1462548714-7971-3-git-send-email-akarwar@marvell.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
 
> > From: Amitkumar Karwar [mailto:akarwar@marvell.com]
> > Sent: Friday, May 06, 2016 9:02 PM
> > To: linux-bluetooth@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; Ganapathi Bhat; Amitkumar Karwar
> > Subject: [PATCH v11 3/3] Bluetooth: hci_uart: Support firmware
> > download for Marvell
> >
> > From: Ganapathi Bhat <gbhat@marvell.com>
> >
> > This patch implement firmware download feature for Marvell Bluetooth
> > devices. If firmware is already downloaded, it will skip downloading.
> >
> > Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > ---
> > v2: Fixed compilation warning reported by kbuild test robot
> > v3: Addressed review comments from Marcel Holtmann
> >     a) Removed vendor specific code from hci_ldisc.c
> >     b) Get rid of static forward declaration
> >     c) Removed unnecessary heavy nesting
> >     d) Git rid of module parameter and global variables
> >     e) Add logic to pick right firmware image
> > v4: Addresses review comments from Alan
> >     a) Use existing kernel helper APIs instead of writing own.
> >     b) Replace mdelay() with msleep()
> > v5: Addresses review comments from Loic Poulain
> >     a) Use bt_dev_err/warn/dbg helpers insted of BT_ERR/WARN/DBG
> >     b) Used static functions where required and removed forward
> > delcarations
> >     c) Edited comments for the function hci_uart_recv_data
> >     d) Made HCI_UART_DNLD_FW flag a part of driver private data
> > v6: Addresses review comments from Loic Poulain
> >     a) Used skb instead of array to store firmware data during
> download
> >     b) Used hci_uart_tx_wakeup and enqueued packets instead of tty
> write
> >     c) Used GFP_KERNEL instead of GFP_ATOMIC
> > v7: Edited Kconfig to add dependency for BT_HCIUART_H4. The change
> > resolves
> >     errors reported by kbuild test robot.
> > v8: Addressed review comments from Marcel Holtmann
> >     a) Removed unnecessary memory allocation failure messages
> >     b) Get rid of btmrvl.h header file and add definitions in
> > hci_mrvl.c file
> > v9: Addressed review comments from Marcel Holtmann
> >     a) Moved firmware download code from setup to prepare handler.
> >     b) Change messages from bt_dev_*->BT_*, as hdev isn't available
> > during firmware
> >      download.
> > v10: Addressed review comments from Marcel Holtmann
> >     a) Added new callback recv_for_prepare to receive data from device
> >      during prepare phase
> >     b) Avoided using private flags (HCI_UART_DNLD_FW) as new receive
> > callback is
> >      added for the same purpose
> >     c) Used kernel API to handle unaligned data
> >     d) Moved mrvl_set_baud functionality inside setup callback
> > v11: Write data through ldisc in mrvl_send_ack() instead of directly
> > calling
> >     write method(One Thousand Gnomes).
> 

Could you please take this patch?

Regards,
Amitkumar
