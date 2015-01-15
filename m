Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jan 2015 10:28:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix issue with switching BR/EDR back on when
 disabled
Message-ID: <20150115082830.GB29319@t440s.lan>
References: <1421275242-18674-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421275242-18674-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 14, 2015, Marcel Holtmann wrote:
> For dual-mode controllers it is possible to disable BR/EDR and operate
> as LE single mode controllers with a static random address. If that is
> the case, then refuse switching BR/EDR back on after the controller has
> been powered.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
