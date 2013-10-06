Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 10:47:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check for non BR/EDR controller in AMP
 discover response
Message-ID: <20131006084758.GB5157@x220.p-661hnu-f1>
References: <1381006673-14570-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381006673-14570-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Oct 05, 2013, Marcel Holtmann wrote:
> Within the AMP discover response, all controllers that are not the
> primary BR/EDR controller are valid.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/a2mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
