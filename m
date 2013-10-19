Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 16:52:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove interval parameter from HCI connection
Message-ID: <20131019135230.GB25024@x220.p-661hnu-f1>
References: <1382185617-43385-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382185617-43385-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 19, 2013, Marcel Holtmann wrote:
> The conn->interval parameter of HCI connections is not used at all
> and so just remove it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 1 -
>  net/bluetooth/hci_event.c        | 1 -
>  2 files changed, 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
