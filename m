Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 23:56:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Expose auto_accept_delay debugfs only when
 SSP is supported
Message-ID: <20131017205657.GA17492@x220.p-661hnu-f1>
References: <1382032486-31010-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382032486-31010-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 17, 2013, Marcel Holtmann wrote:
> The auto_accept_delay debugfs entry is only valid for BR/EDR capable
> controllers that also support SSP. If SSP is not available or it is
> a LE-only single mode controller this value has no affect and so do
> not expose it.
> 
> Since the value can be actually changed, switch the permissions
> to 0644 to clearly indicate that the value is indeed writeable.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c  | 29 +++++++++++++++++++++++++++++
>  net/bluetooth/hci_sysfs.c | 31 -------------------------------
>  2 files changed, 29 insertions(+), 31 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
