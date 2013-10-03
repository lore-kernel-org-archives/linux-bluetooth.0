Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 09:35:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow setting static address even if LE is
 disabled
Message-ID: <20131003063506.GD20600@x220.p-661hnu-f1>
References: <1380777032-23598-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380777032-23598-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> Setting the static address does not depend on LE beeing enabled. It
> only depends on a controller with LE support.
> 
> When depending on LE enabled this command becomes really complicated
> since in case LE gets disabled, it would be required to clear the
> static address and also its random address representation inside
> the controller. With future support for private addresses such
> complex setup should be avoided.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
