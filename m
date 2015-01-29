Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Jan 2015 09:28:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add support for USB based AMP
 controllers
Message-ID: <20150129072849.GA17579@t440s.lan>
References: <1422505654-28931-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422505654-28931-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 28, 2015, Marcel Holtmann wrote:
> The Bluetooth HCI transport specification for USB device defines on how
> a standard AMP controller is identified and operated. This patch adds
> the needed handling to hook it up to the Bluetooth stack.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
