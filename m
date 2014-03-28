Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: bt <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan"
	<gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Amitkumar
 Karwar <akarwar@marvell.com>
Date: Fri, 28 Mar 2014 14:51:27 -0700
Subject: RE: [PATCH 2/2] Bluetooth: btmrvl: implement read-to-clear for
 SD8897 interrupts
Message-ID: <477F20668A386D41ADCC57781B1F70430F6B720F76@SC-VEXCH1.marvell.com>
References: <1395981043-2541-1-git-send-email-bzhao@marvell.com>
 <1395981043-2541-2-git-send-email-bzhao@marvell.com>
 <E92D9A61-D66B-4D57-8C12-BBC640E12CD3@holtmann.org>
In-Reply-To: <E92D9A61-D66B-4D57-8C12-BBC640E12CD3@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Hi Bing,
>=20
> > For SD8897, CMD52 write_to_clear may have missing interrupts
> > under certain corner case condition. Use CMD53 read-to-clear
> > to fix the problem.
> >
> > Signed-off-by: Bing Zhao <bzhao@marvell.com>
> > ---
> > drivers/bluetooth/btmrvl_drv.h  |  2 ++
> > drivers/bluetooth/btmrvl_main.c | 17 ++++++++++++++
> > drivers/bluetooth/btmrvl_sdio.c | 52 ++++++++++++++++++++++++++++++++++=
++++++-
> > drivers/bluetooth/btmrvl_sdio.h |  3 +++
> > 4 files changed, 73 insertions(+), 1 deletion(-)
>=20
> Applying: Bluetooth: btmrvl: implement read-to-clear for SD8897 interrupt=
s
> Applying: Bluetooth: btmrvl: separate write-to-clear function from interr=
upt handler
> error: patch failed: drivers/bluetooth/btmrvl_sdio.c:684
> error: drivers/bluetooth/btmrvl_sdio.c: patch does not apply
> Patch failed at 0002 Bluetooth: btmrvl: separate write-to-clear function =
from interrupt handler

I verified this patch 2/2 and it can apply cleanly on my bluetooth-next loc=
al tree.

I will resend this patch after a rebase.

Thanks,
Bing
