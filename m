Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Dec 2013 21:37:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use MD SET register for changing SDIO Type-B
 to Type-A
Message-ID: <20131229193700.GC26228@x220.p-661hnu-f1>
References: <1388297402-48660-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388297402-48660-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Dec 28, 2013, Marcel Holtmann wrote:
> The register for setting the SDIO card mode of a Type-B Bluetooth card
> is called MD SET. The MD STAT register is used for reading the current
> mode back.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btsdio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
