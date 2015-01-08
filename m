Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btmrvl: fix card reset and suspend race issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420609016-24947-2-git-send-email-akarwar@marvell.com>
Date: Wed, 7 Jan 2015 21:38:59 -0800
Cc: linux-bluetooth@vger.kernel.org, Cathy Luo <cluo@marvell.com>
Message-Id: <8FDE941D-3DC4-4B5E-90DB-140E3A4C41AE@holtmann.org>
References: <1420609016-24947-1-git-send-email-akarwar@marvell.com> <1420609016-24947-2-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> Sometimes suspend thread queues a command and wait for it's
> response, meanwhile WLAN driver power cycles the card which
> leads to crash. This patch makes sure that suspend thread is
> woken up in remove path.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_main.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

