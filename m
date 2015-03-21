Return-Path: <cyrus@holtmann.org>
Date: Sat, 21 Mar 2015 08:04:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Read Verbose Config Version Info for Broadcom
 devices
Message-ID: <20150321060407.GA10728@t440s.P-661HNU-F1>
References: <1426896996-26511-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426896996-26511-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 20, 2015, Marcel Holtmann wrote:
> The Broadcom devices expose their chip id via Read Verbose Config
> Version Info command. While this information is not used at the
> moment, it might be useful for debugging purposes and so read it
> before patching the firmware. This makes it show up in dmesg and
> HCI traces taken for the system.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
