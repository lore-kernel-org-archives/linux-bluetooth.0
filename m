Return-Path: <cyrus@holtmann.org>
Date: Sat, 20 Dec 2014 09:52:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Support static address when BR/EDR has been
 disabled
Message-ID: <20141220075220.GA26855@t440s.P-661HNU-F1>
References: <1419026735-24536-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419026735-24536-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 19, 2014, Marcel Holtmann wrote:
> Every BR/EDR/LE dual-mode controller requires to have a public address
> and so far that has become the identity address and own address. The
> only way to change that behavior was with a force_static_address
> debugfs option.
> 
> However the host can actually disable the BR/EDR part of a dual-mode
> controller and turn into a single mode LE controller. In that case
> it makes perfect sense for a host to use a chosen static address
> instead of the public address.
> 
> So if the host disables BR/EDR and configures a static address, then
> that static address is used as identity address and own address. If
> the host does not configure a static address, then the public address
> is used as before.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c    | 8 +++++++-
>  net/bluetooth/hci_request.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
