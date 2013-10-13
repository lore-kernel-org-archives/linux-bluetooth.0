Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 23:36:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increase minor version of core module
Message-ID: <20131013203647.GA17845@x220.p-661hnu-f1>
References: <1381694942-59440-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381694942-59440-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> There have been a lot of changes in the core Bluetooth handling
> lately. So it is a good idea to increase the module version.
> 
> The module version is not used anywhere, but it makes debugging
> a little bit simpler if versions can be distinguished.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/af_bluetooth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
