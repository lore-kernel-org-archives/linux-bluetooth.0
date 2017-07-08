Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2] Bluetooth: btusb: fix QCA Rome suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170708185532.26785-1-leif.linux@gmail.com>
Date: Sat, 8 Jul 2017 21:54:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D3D507FD-4BDA-42EF-9082-084CB0E240CC@holtmann.org>
References: <20170708185532.26785-1-leif.linux@gmail.com>
To: Leif Liddy <leif.linux@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Leif,

> There's been numerous reported instances where BTUSB_QCA_ROME
> bluetooth controllers stop functioning upon resume from suspend. These
> devices seem to be losing power during suspend. Patch will detect a status
> change on resume and perform a reset.
> 
> Signed-off-by: Leif Liddy <leif.linux@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

