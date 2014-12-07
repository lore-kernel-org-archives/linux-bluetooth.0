Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Dec 2014 20:05:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check for force_lesc_support before rejecting
 SMP over BR/EDR
Message-ID: <20141207180509.GA10086@t440s.P-661HNU-F1>
References: <1417965552-128069-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417965552-128069-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Dec 07, 2014, Marcel Holtmann wrote:
> The SMP over BR/EDR requests for cross-transport pairing should also
> accepted when the debugfs setting force_lesc_support has been enabled.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
