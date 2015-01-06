Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2 4/4] bluetooth: btmrvl: increase the priority of firmware download message
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420100022-4134-4-git-send-email-akarwar@marvell.com>
Date: Tue, 6 Jan 2015 07:21:16 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>, Marc Yang <yangyang@marvell.com>
Message-Id: <7AE098C5-4668-4CFF-8DC2-1056E33606DD@holtmann.org>
References: <1420100022-4134-1-git-send-email-akarwar@marvell.com> <1420100022-4134-4-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> When driver is loaded, it is important to know if FW was already
> active or it is freshly downloaded. This patch increases the
> priority of the message.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

