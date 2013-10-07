Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Oct 2013 10:14:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Power off AMP controllers after setup
 phase
Message-ID: <20131007081440.GA16692@x220.p-661hnu-f1>
References: <1381130767-42488-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381130767-42488-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 07, 2013, Marcel Holtmann wrote:
> Even AMP controllers should be powered off after the setup phase. It
> is not a good idea to keep AMP controllers powered on all the time
> if they are not in use.
> 
> Power on of the AMP controller can either be done manually via
> command line commands or directly via A2MP. Especially since there
> is an indication in A2MP for powered down controllers that can
> be activated.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
