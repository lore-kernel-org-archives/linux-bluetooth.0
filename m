Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Apr 2015 22:20:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Disallow LE local out-of-band data when LE
 privacy is used
Message-ID: <20150402192045.GA26361@t440s.P-661HNU-F1>
References: <1428001258-26629-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428001258-26629-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 02, 2015, Marcel Holtmann wrote:
> When the LE pivacy feature is used, then pairing has to happen based
> on resolvable random addresses (RPA), but currently there is no clean
> way to retrieve the correct RPA. So instead of returning an outdated
> RPA, just disallow this command when LE privacy is in use.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
