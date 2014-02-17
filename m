Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 15:59:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Restrict long term keys to public and
 static addresses
Message-ID: <20140217135938.GA27312@x220.p-661hnu-f1>
References: <1392584346-64921-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392584346-64921-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Feb 16, 2014, Marcel Holtmann wrote:
> The long term keys should be associated with an identity address. Valid
> identity addresses are public addresses or static addresses. So only
> allow these two as valid address information for long term keys.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
