Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 10:47:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/10] Bluetooth: Fix controller list for AMP discover
 response
Message-ID: <20131006084737.GA5157@x220.p-661hnu-f1>
References: <1380998869-64411-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380998869-64411-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 05, 2013, Marcel Holtmann wrote:
> The AMP discover response should list exactly one BR/EDR controller
> and ignore all other BR/EDR controller.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/a2mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
