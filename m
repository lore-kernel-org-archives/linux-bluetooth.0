Return-Path: <cyrus@holtmann.org>
Date: Sun, 14 Sep 2014 10:37:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Separate TX URB allocation and
 submission
Message-ID: <20140914073717.GA18439@t440s.P-661HNU-F1>
References: <1410678666-51129-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410678666-51129-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 14, 2014, Marcel Holtmann wrote:
> The complete TX URB handling is done via a switch statement in the
> btusb_send_frame function. To allow for more clear separation between
> control, bulk and isoc URBs, split them into allocation and submission.
> 
> Previously the inc_tx function has been used for tracking in-flight
> URB for HCI commands and ACL data packets. Convert that into a common
> function that either submits the URB or queues it when needed.
> 
> This provides the flexibility to allow vendor specific hdev->send_frame
> callbacks without having to duplicate the whole URB handling logic.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 206 ++++++++++++++++++++++++++++------------------
>  1 file changed, 125 insertions(+), 81 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
