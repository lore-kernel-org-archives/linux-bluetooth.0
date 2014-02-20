Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Feb 2014 08:15:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Don't send store hint for devices using
 identity addresses
Message-ID: <20140220061509.GA3739@x220.p-661hnu-f1>
References: <1392839514-36896-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392839514-36896-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 19, 2014, Marcel Holtmann wrote:
> The identity resolving keys should only be stored for devices using
> resolvable random addresses. If the device is already using an
> identity address, inform it about the new identity resolving key,
> but tell userspace that this key is not persistent.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
