Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 09:59:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add debugfs entry for setting vendor
 diagnostic mode
Message-ID: <20151008065914.GD25309@t440s.lan>
References: <1444240355-38859-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444240355-38859-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 07, 2015, Marcel Holtmann wrote:
> This adds a new debugfs entry for enabling and disabling the vendor
> diagnostic mode. It is only exposed for drivers that provide the
> set_diag driver callback and actually have an option for vendor
> specific diagnostic information.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |  1 +
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 63 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 62 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
