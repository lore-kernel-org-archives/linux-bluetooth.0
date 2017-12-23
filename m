Return-Path: <foo00@h08.hostsharing.net>
Date: Sat, 23 Dec 2017 17:47:36 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Loic Poulain <loic.poulain@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
	Eric Anholt <eric@anholt.net>, Hans de Goede <hdegoede@redhat.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: hci_bcm: Unable to handle kernel NULL pointer
 dereference in Linux 4.15rc4
Message-ID: <20171223164736.GA8808@wunner.de>
References: <692799368.42471.1513972642978@email.1und1.de>
 <1171798248.297572.1514045437425@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171798248.297572.1514045437425@email.1und1.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Dec 23, 2017 at 05:10:37PM +0100, Stefan Wahren wrote:
> > Stefan Wahren <stefan.wahren@i2se.com> hat am 22. Dezember 2017 um 20:57 geschrieben:
> > i'm working on Bluetooth support for Raspberry Pi Zero W (BCM43438) [1]. After enabling the driver and the DT stuff, i will get a NULL pointer dereference during boot of Linux 4.15-rc4:
> > 
> > [   14.934216] Bluetooth: HCI UART driver ver 2.3
> > [   14.934231] Bluetooth: HCI UART protocol H4 registered
> > [   14.934912] hci_uart_bcm serial0-0: BCM irq: -22
> > [   14.935147] uart-pl011 20201000.serial: no DMA platform data
> > [   14.948218] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > [   14.948238] pgd = a8969859
> > [   14.948247] [00000000] *pgd=00000000
> > [   14.948272] Internal error: Oops: 5 [#1] ARM
> > [   14.948279] Modules linked in: hci_uart(+) btbcm bcm2835_rng rng_core
> > [   14.948323] CPU: 0 PID: 149 Comm: kworker/u3:1 Tainted: G        W        4.15.0-rc4+ #4
> > [   14.948327] Hardware name: BCM2835
> > [   14.948363] Workqueue: hci0 hci_cmd_work
> > [   14.948499] PC is at hci_uart_tx_wakeup+0x20/0xfc [hci_uart]
> > [   14.948560] LR is at hci_uart_send_frame+0x64/0x78 [hci_uart]
> > [   14.948570] pc : [<bf018074>]    lr : [<bf019448>]    psr: 20000013
> > [   14.948579] sp : d8df9e90  ip : d8df9ea8  fp : d8df9ea4
> > [   14.948585] r10: 00000000  r9 : 00000000  r8 : d96e8700
> > [   14.948594] r7 : c0c14a40  r6 : d97d3000  r5 : d96e8c48  r4 : d96e8c10
> > [   14.948601] r3 : 00000000  r2 : 20000013  r1 : d97ae540  r0 : d96e8c10
> > [   14.948613] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > [   14.948623] Control: 00c5387d  Table: 19748008  DAC: 00000051
> > [   14.948641] Process kworker/u3:1 (pid: 149, stack limit = 0x0b8b6dd4)
> > [   14.948654] Stack: (0xd8df9e90 to 0xd8dfa000)
> > [   14.948668] 9e80:                                     d97ae540 d96e8c10 d8df9ec4 d8df9ea8
> > [   14.948689] 9ea0: bf019448 bf018060 d97ae540 d97d3000 d97ae540 d97d3000 d8df9ee4 d8df9ec8
> > [   14.948707] 9ec0: c0687a6c bf0193f0 c0596408 c0592050 d97d3700 d97ae540 d8df9f0c d8df9ee8
> > [   14.948724] 9ee0: c0687b4c c06879d4 00000000 d8df9ef4 d8df9f44 d8e04a80 d97d3700 d8edb000
> > [   14.948742] 9f00: d8df9f44 d8df9f10 c0133e78 c0687acc d8edb000 c0c14a40 c0c14a40 d8e04a80
> > [   14.948760] 9f20: d8edb000 d8edb000 c0c14a40 c0c14a40 d8edb014 d8e04a98 d8df9f7c d8df9f48
> > [   14.948778] 9f40: c0134d0c c0133c80 d8ee05d8 d8e04a80 c0134a2c d8ee05c0 d8ee0540 d8defea4
> > [   14.948796] 9f60: d8ee05d8 d8e04a80 c0134a2c 00000000 d8df9fac d8df9f80 c0139768 c0134a38
> > [   14.948811] 9f80: d8df8000 d8ee0540 c013962c 00000000 00000000 00000000 00000000 00000000
> > [   14.948827] 9fa0: 00000000 d8df9fb0 c0107e88 c0139638 00000000 00000000 00000000 00000000
> > [   14.948841] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [   14.948856] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 912f0073 00001877
> > [   14.949017] [<bf018074>] (hci_uart_tx_wakeup [hci_uart]) from [<bf019448>] (hci_uart_send_frame+0x64/0x78 [hci_uart])
> > [   14.949103] [<bf019448>] (hci_uart_send_frame [hci_uart]) from [<c0687a6c>] (hci_send_frame+0xa4/0xf8)
> > [   14.949134] [<c0687a6c>] (hci_send_frame) from [<c0687b4c>] (hci_cmd_work+0x8c/0x120)
> > [   14.949166] [<c0687b4c>] (hci_cmd_work) from [<c0133e78>] (process_one_work+0x204/0x380)
> > [   14.949194] [<c0133e78>] (process_one_work) from [<c0134d0c>] (worker_thread+0x2e0/0x450)
> > [   14.949228] [<c0134d0c>] (worker_thread) from [<c0139768>] (kthread+0x13c/0x158)
> > [   14.949270] [<c0139768>] (kthread) from [<c0107e88>] (ret_from_fork+0x14/0x2c)
> > [   14.949290] Code: e8bd4000 e1a04000 e2805038 e5903058 (e5932000) 
> > [   14.949310] ---[ end trace e0ebe7d9031c01b2 ]---
> > [   15.155799] Bluetooth: HCI UART protocol Broadcom registered
> > [   16.435744] brcmfmac: brcmf_fw_map_chip_to_name: using brcm/brcmfmac43430-sdio.bin for chip 0x00a9a6(43430) rev 0x000001
> > [   16.649373] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43430-sdio.clm_blob failed with error -2
> > [   16.651160] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Aug  7 2017 00:46:29 version 7.45.41.46 (r666254 CY) FWID 01-f8a78378
> > [   18.023283] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
> > [   21.041766] systemd-journald[97]: Received request to flush runtime journal from PID 1
> > [   25.446589] Bluetooth: hci0: BCM: failed to write update baudrate (-110)
> > [   25.474412] Bluetooth: hci0: Failed to set baudrate
> > [   35.686592] Bluetooth: hci0: BCM: Reset failed (-110)
> > 
> 
> after reverting 67d2f8781b9f ("Bluetooth: hci_ldisc: Allow sleeping while proto locks are held.") i can't reproduce this issue anymore.

A fix for this is queued on bluetooth-next:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=d73e172816652772114827abaa2dbc053eecbbd7

Thanks,

Lukas
