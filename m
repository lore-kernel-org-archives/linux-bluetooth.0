Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 19:54:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose inquiry_cache debugfs only on BR/EDR
 controllers
Message-ID: <20131016165411.GB30104@x220.p-661hnu-f1>
References: <1381919335-59602-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381919335-59602-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 16, 2013, Marcel Holtmann wrote:
> The inquiry_cache debugfs entry is only valid for BR/EDR capable
> controllers. In case of single mode LE-only controllers that
> entry is not valid.
> 
> Move the creating of the debugfs entries to the end of controller
> init and only create the inquiry_cache entry if BR/EDR is actually
> supported.
> 
> At the same time this avoids creating any debugfs entries for
> AMP controllers since none of the entries are valid there.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++--
>  net/bluetooth/hci_sysfs.c | 39 --------------------------------
>  2 files changed, 55 insertions(+), 41 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
