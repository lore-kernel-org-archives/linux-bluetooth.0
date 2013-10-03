Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 13:08:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Drop packets on ATT fixed channel on BR/EDR
Message-ID: <20131003100806.GA7519@x220.p-661hnu-f1>
References: <1380794051-8488-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380794051-8488-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 03, 2013, Marcel Holtmann wrote:
> The ATT fixed channel is only valid when using LE connections. On
> BR/EDR it is required to go through L2CAP connection oriented
> channel for ATT.
> 
> Drop ATT packets when they are received on a BR/EDR connection.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
