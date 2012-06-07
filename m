Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 23:33:36 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] client: Fix not using connection passed to
 obc_transfer_register
Message-ID: <20120607153336.GA25119@x220.docomointertouch.net>
References: <1339057873-7874-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339057873-7874-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jun 07, 2012, Luiz Augusto von Dentz wrote:
> Make use of the connection parameter instead of assuming the connection
> will always be to the session bus.
> ---
>  client/transfer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches have been applied. Thanks.

Johan
