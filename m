Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2 2/4] Bluetooth: btmrvl: error path handling in setup  handler
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420100022-4134-2-git-send-email-akarwar@marvell.com>
Date: Tue, 6 Jan 2015 07:21:18 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>, Marc Yang <yangyang@marvell.com>
Message-Id: <AC3BCAED-7633-4BF4-9710-A03F54759AEA@holtmann.org>
References: <1420100022-4134-1-git-send-email-akarwar@marvell.com> <1420100022-4134-2-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> If module init command fails, FW might not be in good state.
> We will return from setup handler and skip downloading further
> commands.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_main.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

