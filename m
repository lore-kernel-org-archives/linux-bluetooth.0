Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Sep 2011 16:45:36 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: [PATCH] Bluetooth: Fix wrong memcpy size on LE start encryption
Message-ID: <20110919194536.GI2643@joana>
References: <y>
 <4e778cdf.c964cc0a.2f7c.5b05@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4e778cdf.c964cc0a.2f7c.5b05@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* anderson.briglia@openbossa.org <anderson.briglia@openbossa.org> [2011-09-19 14:41:09 -0400]:

> From: Anderson Briglia <anderson.briglia@openbossa.org>
> 
> This patch fixes wrong memcpy size when copying rand value to
> HCI_OP_LE_START_ENC command.
> The compiler pretends that the array parameter was declared as a pointer
> and sizeof reports the size of the pointer. [1]
> 
> [1] http://www.c-faq.com/aryptr/aryparmsize.html
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
