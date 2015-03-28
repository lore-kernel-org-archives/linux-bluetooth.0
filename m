Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Mar 2015 10:54:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Consolidate Broadcom based device
 entries
Message-ID: <20150328085425.GA20901@t440s.P-661HNU-F1>
References: <1427494301-13702-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427494301-13702-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 27, 2015, Marcel Holtmann wrote:
> For all modern Bluetooth USB devices from Broadcom it makes a lot more
> sense to use USB_VENDOR_AND_INTERFACE_INFO instead of manually adding
> USB_DEVICE for each one of them. There are already interface entries
> for these vendors and so just remove the duplicate device entries.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
