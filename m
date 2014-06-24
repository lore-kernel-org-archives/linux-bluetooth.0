Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jun 2014 14:21:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove ssp_debug_mode debugfs option
Message-ID: <20140624112118.GA3787@t440s.lan>
References: <1403608384-59675-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403608384-59675-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jun 24, 2014, Marcel Holtmann wrote:
> The ssp_debug_mode debugfs option for developers is no longer
> needed. Support for using Secure Simple Pairing (SSP) debug
> mode is exposed by the management interface now.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 51 ------------------------------------------------
>  1 file changed, 51 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
