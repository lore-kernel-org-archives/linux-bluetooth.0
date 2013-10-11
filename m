Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 23:59:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Don't advertise high speed support without SSP
Message-ID: <20131011205956.GB29176@x220.p-661hnu-f1>
References: <1381510127-1094-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381510127-1094-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 11, 2013, Marcel Holtmann wrote:
> It is not allowed to enable high speed support when Secure Simple
> Pairing is not available or disabled.
> 
> However the support for high speed gets advertised on a controller
> that does not even support Secure Simple Pairing. Since there is
> no way to enable high speed support on such a controller, do not
> even advertise its support.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
