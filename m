Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Ganapathi Bhat <gbhat@marvell.com>
Subject: RE: [PATCH v7] Bluetooth: hci_uart: Support firmware download for
 Marvell
Date: Mon, 18 Apr 2016 10:51:48 +0000
Message-ID: <cccc8d3fb57844bebb8cd93d9578122f@SC-EXCH04.marvell.com>
References: <1459845266-2771-1-git-send-email-akarwar@marvell.com>
 <dbff88372c89421b9568ad3d32aa283d@SC-EXCH04.marvell.com>
 <DEE89AB2-038B-4C0D-A06C-0A72351DD2EC@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: Amitkumar Karwar
> Sent: Tuesday, April 12, 2016 10:23 PM
> To: 'Marcel Holtmann'
> Cc: linux-bluetooth@vger.kernel.org; Ganapathi Bhat
> Subject: RE: [PATCH v7] Bluetooth: hci_uart: Support firmware download
> for Marvell
>=20
> Hi Marcel,
>=20
> > From: Marcel Holtmann [mailto:marcel@holtmann.org]
> > Sent: Tuesday, April 12, 2016 9:48 PM
> > To: Amitkumar Karwar
> > Cc: linux-bluetooth@vger.kernel.org; Ganapathi Bhat
> > Subject: Re: [PATCH v7] Bluetooth: hci_uart: Support firmware download
> > for Marvell
> >
> > Hi Amitkumar,
> >
> > >> From: Amitkumar Karwar [mailto:akarwar@marvell.com]
> > >> Sent: Tuesday, April 05, 2016 2:04 PM
> > >> To: linux-bluetooth@vger.kernel.org
> > >> Cc: linux-kernel@vger.kernel.org; Ganapathi Bhat; Amitkumar Karwar
> > >> Subject: [PATCH v7] Bluetooth: hci_uart: Support firmware download
> > >> for Marvell
> > >>
> > >> From: Ganapathi Bhat <gbhat@marvell.com>
> > >>
> > >> This patch implement firmware download feature for Marvell
> > >> Bluetooth devices. If firmware is already downloaded, it will skip
> downloading.
> > >>
> > >> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> > >> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > >> ---
> > >> v2: Fixed compilation warning reported by kbuild test robot
> > >> v3: Addressed review comments from Marcel Holtmann
> > >>    a) Removed vendor specific code from hci_ldisc.c
> > >>    b) Get rid of static forward declaration
> > >>    c) Removed unnecessary heavy nesting
> > >>    d) Git rid of module parameter and global variables
> > >>    e) Add logic to pick right firmware image
> > >> v4: Addresses review comments from Alan
> > >>    a) Use existing kernel helper APIs instead of writing own.
> > >>    b) Replace mdelay() with msleep()
> > >> v5: Addresses review comments from Loic Poulain
> > >>    a) Use bt_dev_err/warn/dbg helpers insted of BT_ERR/WARN/DBG
> > >>    b) Used static functions where required and removed forward
> > >> delcarations
> > >>    c) Edited comments for the function hci_uart_recv_data
> > >>    d) Made HCI_UART_DNLD_FW flag a part of driver private data
> > >> v6: Addresses review comments from Loic Poulain
> > >>    a) Used skb instead of array to store firmware data during
> > download
> > >>    b) Used hci_uart_tx_wakeup and enqueued packets instead of tty
> > write
> > >>    c) Used GFP_KERNEL instead of GFP_ATOMIC
> > >> v7: Edited Kconfig to add dependency for BT_HCIUART_H4. The change
> > >> resolves
> > >>    errors reported by kbuild test robot.
> > >> ---
> > >> drivers/bluetooth/Kconfig     |  11 +
> > >> drivers/bluetooth/Makefile    |   1 +
> > >> drivers/bluetooth/btmrvl.h    |  43 ++++
> > >> drivers/bluetooth/hci_ldisc.c |   6 +
> > >> drivers/bluetooth/hci_mrvl.c  | 568
> > >> ++++++++++++++++++++++++++++++++++++++++++
> > >> drivers/bluetooth/hci_uart.h  |   8 +-
> > >> 6 files changed, 636 insertions(+), 1 deletion(-)  create mode
> > >> 100644 drivers/bluetooth/btmrvl.h  create mode 100644
> > >> drivers/bluetooth/hci_mrvl.c
> > >>
> > >
> > > Could you please take this patch if there are no further
> > comments/suggestions?
> >
> > didn't I see a kbot build warning for this version as well? Or was
> > that the previous version?
> >
>=20
> Last kbot build warning was for V6 patch. It has been fixed in this
> version.
> https://lkml.org/lkml/2016/4/2/102
>=20

The warning had got fixed in latest version. Please let me know if there ar=
e any issues merging the patch.

Regards,
Amitkumar
