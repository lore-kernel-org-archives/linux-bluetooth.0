Return-Path: <cyrus@holtmann.org>
Date: Sun, 22 Mar 2015 17:17:41 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Read Broadcom chip info for Apple Bluetooth
 devices
Message-ID: <20150323001741.GA9301@t440s>
References: <1427035958-20117-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427035958-20117-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Mar 22, 2015, Marcel Holtmann wrote:
> For the Apple Bluetooth devices that are Broadcom based, it makes sense
> to read the chip information. It is a single HCI command and might help
> gathering more information about these devices.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
