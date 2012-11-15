Return-Path: <cyrus@holtmann.org>
Message-ID: <1353023586.1849.0.camel@aeonflux>
Subject: Re: [RFC 1/4] Bluetooth: Use __l2cap_no_conn_pending helper
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 16 Nov 2012 08:53:06 +0900
In-Reply-To: <1352996096-27374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1352996096-27374-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use helper instead of test_bit. This is the only place left using
> test CONF_CONNECT_PEND flag.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


