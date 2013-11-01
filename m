Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan"
	<gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mike
 Frysinger <vapier@chromium.org>,
        Amitkumar Karwar <akarwar@marvell.com>
Date: Fri, 1 Nov 2013 15:11:05 -0700
Subject: RE: [PATCH 3/3] Bluetooth: btmrvl: operate on 16-bit opcodes
 instead of ogf/ocf
Message-ID: <477F20668A386D41ADCC57781B1F70430F45757D88@SC-VEXCH1.marvell.com>
References: <1383257311-1430-1-git-send-email-bzhao@marvell.com>
 <1383257311-1430-3-git-send-email-bzhao@marvell.com>
 <5C5FA2A6-6FC9-4BCC-B153-419D64AD3FCA@holtmann.org>
In-Reply-To: <5C5FA2A6-6FC9-4BCC-B153-419D64AD3FCA@holtmann.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Hi Bing,
>=20
> > Replace ogf/ocf and its packing with 16-bit opcodes.
> >
> > Signed-off-by: Bing Zhao <bzhao@marvell.com>
> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > ---
> > drivers/bluetooth/btmrvl_drv.h  | 19 +++++++++++--------
> > drivers/bluetooth/btmrvl_main.c | 21 +++++++++------------
> > 2 files changed, 20 insertions(+), 20 deletions(-)
>=20
> patch looks fine to me. Since you send it as 3/3, I don=92t know if you w=
ant me to apply it right away
> or just when the whole series is ready to be applied.

Please apply 3/3 first if that's convenient for you.
I will resend 1/3 and 2/3 in v2 series.

Thanks,
Bing
