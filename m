Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
        Nishant Sarmukadam
	<nishants@marvell.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>, Ganapathi Bhat
	<gbhat@marvell.com>
Subject: RE: [PATCH v2] Bluetooth: hci_uart: Support firmware download for
 Marvell
Date: Thu, 25 Feb 2016 14:49:02 +0000
Message-ID: <5214f565d5754440ade286fc6b83f859@SC-EXCH04.marvell.com>
References: <1455627233-6928-1-git-send-email-akarwar@marvell.com>
 <273F0F9E-5E5C-4F21-A503-027A83B7F61E@holtmann.org>
In-Reply-To: <273F0F9E-5E5C-4F21-A503-027A83B7F61E@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Saturday, February 20, 2016 1:37 PM
> To: Amitkumar Karwar
> Cc: BlueZ development; Nishant Sarmukadam; linux-kernel@vger.kernel.org;
> Cathy Luo; Ganapathi Bhat
> Subject: Re: [PATCH v2] Bluetooth: hci_uart: Support firmware download
> for Marvell
>=20
> Hi Amitkumar,
>=20
> > This patch implement firmware download feature for Marvell Bluetooth
> > devices. If firmware is already downloaded, it will skip downloading.
> >
> > Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > ---
> > v2: Fixed compilation warning reported by kbuild test robot
> > ---

Thanks for your review.
We are able to resolve all your comments. We are now checking how can we av=
oid firmware and helper file name global variables and module parameters.

Regards,
Amitkumar
