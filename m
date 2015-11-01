Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Nov 2015 15:42:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Move BR/EDR default events behind its
 features
Message-ID: <20151101134205.GB21304@t440s.P-661HNU-F1>
References: <1446367191-67668-2-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446367191-67668-2-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 01, 2015, Marcel Holtmann wrote:
> There are some BR/EDR default events for Bluetooth 1.2 or later
> controllers that are not conditional on their features being present.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

I realize I already applied this one, but:

> +	if (lmp_esco_capable(hdev)) {
> +		events[5] |= 0x08; /* Synchronous Connection Complete */
> +		events[5] |= 0x10; /* Synchronous Connection Changed */
> +	}

Synchronous Connection Complete is relevant also for non-ESCO
controllers, isn't it?

Johan
