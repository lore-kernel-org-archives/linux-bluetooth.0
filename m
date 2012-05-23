Return-Path: <cyrus@holtmann.org>
Message-ID: <1337771233.15105.75.camel@aeonflux>
Subject: Re: [PATCH trivial 3/4] Bluetooth: Preserve flags values
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 23 May 2012 13:07:13 +0200
In-Reply-To: <1337761883-3190-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337761883-3190-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1337761883-3190-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Previous callers of l2cap_build_conf_rsp in l2cap_config_req use
> flags instead of continuation flag hardcoded value. It does not change
> logic and preserve future possible flags.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


