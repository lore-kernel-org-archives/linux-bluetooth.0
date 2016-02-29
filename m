Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 29 Feb 2016 19:26:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Add diag and address support for
 Intel/AG6xx
Message-ID: <20160229172630.GA27513@t440s.P-661HNU-F1>
References: <1456691119-64405-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456691119-64405-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Feb 28, 2016, Marcel Holtmann wrote:
> The AG6xx devices behave similar to Wilkens Peak and Stone Peak and with
> that it is needed to check for Intel default address. In addition it is
> possible to enable vendor events and diag support.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ag6xx.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
