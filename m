Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Oct 2015 08:23:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Replace hci_notify with hci_sock_dev_event
Message-ID: <20151026062327.GC23647@t440s.P-661HNU-F1>
References: <1445812162-53215-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445812162-53215-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 25, 2015, Marcel Holtmann wrote:
> There is no point in wrapping hci_sock_dev_event around hci_notify. It
> is an empty wrapper which adds no value. So remove it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
