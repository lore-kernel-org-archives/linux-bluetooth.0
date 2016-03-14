Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nishant Sarmukadam <nishants@marvell.com>,
	Ganapathi Bhat <gbhat@marvell.com>
Subject: RE: [PATCH v4] Bluetooth: hci_uart: Support firmware download for
 Marvell
Date: Mon, 14 Mar 2016 06:32:24 +0000
Message-ID: <169b736d643e43598eceaad3adbdfe6d@SC-EXCH04.marvell.com>
References: <1457006200-8132-1-git-send-email-akarwar@marvell.com>
 <1457006200-8132-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1457006200-8132-2-git-send-email-akarwar@marvell.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Do you have any comments for this patch?
Please let us know if you have any more suggestions for the improvements.

> From: Amitkumar Karwar [mailto:akarwar@marvell.com]
> Sent: Thursday, March 03, 2016 5:27 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Cathy Luo; linux-kernel@vger.kernel.org; Nishant Sarmukadam;
> Ganapathi Bhat; Amitkumar Karwar
> Subject: [PATCH v4] Bluetooth: hci_uart: Support firmware download for
> Marvell
> 
> From: Ganapathi Bhat <gbhat@marvell.com>
> 
> This patch implement firmware download feature for Marvell Bluetooth
> devices. If firmware is already downloaded, it will skip downloading.
> 
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v2: Fixed compilation warning reported by kbuild test robot
> v3: Addressed review comments from Marcel Holtmann
>     a) Removed vendor specific code from hci_ldisc.c
>     b) Get rid of static forward declaration
>     c) Removed unnecessary heavy nesting
>     d) Git rid of module parameter and global variables
>     e) Add logic to pick right firmware image
> v4: Addresses review comments from Alan
>     a) Use existing kernel helper APIs instead of writing own.
>     b) Replace mdelay() with msleep()
> ---

Regards,
Amitkumar
