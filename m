Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Sep 2013 16:33:17 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support creating virtual AMP controllers
Message-ID: <20130910153317.GA1916@joana>
References: <1378143699-51039-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378143699-51039-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-09-02 Marcel Holtmann <marcel@holtmann.org>:

> So far the only option to create a virtual AMP controller was by
> setting a module parameter for the hci_vhci driver. This patch adds
> the functionality to define inline to create either a BR/EDR or an
> AMP controller.
> 
> In addition the client will be informed which HCI controller index
> it got assigned. That is especially useful for automated end-to-end
> testing.
> 
> To keep backwards compatibility with existing userspace, the command
> for creating a controller type needs to be send right after opening
> the device node. If the command is not send, it defaults back to
> automatically creating a BR/EDR controller.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_vhci.c | 169 +++++++++++++++++++++++++++++++------------
>  1 file changed, 123 insertions(+), 46 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
