Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Feb 2014 06:23:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increase minor version of core module
Message-ID: <20140221042322.GB17039@x220.p-661hnu-f1>
References: <1392929060-4999-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392929060-4999-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 20, 2014, Marcel Holtmann wrote:
> With the addition of Resolvable Private Address (RPA) resolution
> support for Bluetooth Low Energy connections, it makes sense to
> increase the minor version of the Bluetooth core module.
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
