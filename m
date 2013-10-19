Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 16:31:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose setting if debug keys are used or not
Message-ID: <20131019133146.GF11607@x220.p-661hnu-f1>
References: <1382141662-6799-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382141662-6799-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 18, 2013, Marcel Holtmann wrote:
> The system can be figured to accept and use debug keys. Expose this
> value in debugfs for debugging purposes.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
