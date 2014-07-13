Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Jul 2014 08:51:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Enable LE Long Term Key Request event only
 when supported
Message-ID: <20140713055115.GC9869@t440s.P-661HNU-F1>
References: <1405204162-64758-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405204162-64758-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 13, 2014, Marcel Holtmann wrote:
> The support for LE encryption is optional and with that also the
> LE Long Term Key Request event. If encryption is not supported, then
> do not bother enabling this event.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
