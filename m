Return-Path: <cyrus@holtmann.org>
Date: Sat, 31 Jan 2015 10:24:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix OOB data present value for SMP pairing
Message-ID: <20150131082424.GA16207@t440s.P-661HNU-F1>
References: <1422692152-2802-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422692152-2802-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jan 31, 2015, Marcel Holtmann wrote:
> Before setting the OOB data present flag with SMP pairing, check the
> newly introduced present tracking that actual OOB data values have
> been provided. The existence of remote OOB data structure does not
> actually mean that the correct data values are available.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
