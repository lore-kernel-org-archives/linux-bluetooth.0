Return-Path: <cyrus@holtmann.org>
Date: Sun, 20 Jul 2014 19:54:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded variable assignment in
 hmac_sha256
Message-ID: <20140720165434.GA9216@t440s.P-661HNU-F1>
References: <1405870987-40038-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405870987-40038-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 20, 2014, Marcel Holtmann wrote:
> The variable ret does not need to be assigned when declaring it. So
> remove this initial assignment.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/amp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
