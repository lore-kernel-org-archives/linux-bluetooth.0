Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 14:24:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Adjust header for proc socket information
Message-ID: <20131014112426.GA26222@x220.p-661hnu-f1>
References: <1381741525-22607-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381741525-22607-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 14, 2013, Marcel Holtmann wrote:
> The exposed socket information do not contain source or destination
> addresses. So adjust the header accordingly.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/af_bluetooth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
