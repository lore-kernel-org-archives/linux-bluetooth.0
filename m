Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Jan 2015 10:24:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Show device address type for L2CAP debugfs
 entries
Message-ID: <20150115082452.GA29319@t440s.lan>
References: <1421271861-7212-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421271861-7212-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 14, 2015, Marcel Holtmann wrote:
> The devices address types are BR/EDR Public, LE Public and LE Random and
> any of these three is valid for L2CAP connections. So show the correct
> type in the debugfs list.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
