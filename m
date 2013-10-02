Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 09:41:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Enable -D__CHECK_ENDIAN__ for sparse by
 default
Message-ID: <20131002064116.GD28911@x220.p-661hnu-f1>
References: <1380694007-7946-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380694007-7946-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 01, 2013, Marcel Holtmann wrote:
> The Bluetooth protocol and hardware is pretty much all little endian
> and so when running sparse via "make C=2" for example, enable the
> endian checks by default.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/Makefile | 2 ++
>  net/bluetooth/Makefile     | 2 ++
>  2 files changed, 4 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
