Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Oct 2015 08:22:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded parenthesis around MSG_OOB
Message-ID: <20151026062247.GA23647@t440s.P-661HNU-F1>
References: <1445809518-44473-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445809518-44473-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 25, 2015, Marcel Holtmann wrote:
> There are two checks that are still using (MSG_OOB) instead of just
> MSG_OOB and so lets just fix them.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/af_bluetooth.c | 2 +-
>  net/bluetooth/hci_sock.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
