Return-Path: <cyrus@holtmann.org>
Date: Sat, 7 Dec 2013 21:31:25 +0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increase minor version of core module
Message-ID: <20131207173125.GA29280@x220.p-661hnu-f1>
References: <1386435984-35260-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386435984-35260-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Dec 07, 2013, Marcel Holtmann wrote:
> With the addition of L2CAP Connection Oriented Channels for Bluetooth
> Low Energy connections, it makes sense to increase the minor version
> of the Bluetooth core module.
> 
> The module version is not used anywhere, but it gives a nice extra
> hint for debugging purposes.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/af_bluetooth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
