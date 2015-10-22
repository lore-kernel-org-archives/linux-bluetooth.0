Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Oct 2015 13:38:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increase minor version of core module
Message-ID: <20151022103821.GA13749@t440s.lan>
References: <1445509767-23389-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445509767-23389-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 22, 2015, Marcel Holtmann wrote:
> With the addition of support for diagnostic feature, it makes sense to
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
