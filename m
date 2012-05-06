Return-Path: <cyrus@holtmann.org>
Message-ID: <1336320235.5970.77.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove unneeded calculation and magic number
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 06 May 2012 09:03:55 -0700
In-Reply-To: <1336116556-27540-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1336116556-27540-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove magic number unneeded calculation since
> hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards


