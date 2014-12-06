Return-Path: <cyrus@holtmann.org>
Date: Sat, 6 Dec 2014 09:52:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check for force_lesc_support when enabling
 SMP over BR/EDR
Message-ID: <20141206075245.GA20855@t440s.P-661HNU-F1>
References: <1417822545-92322-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417822545-92322-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Dec 06, 2014, Marcel Holtmann wrote:
> The SMP over BR/EDR support for cross-transport pairing should also be
> enabled when the debugfs setting force_lesc_support has been enabled.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
