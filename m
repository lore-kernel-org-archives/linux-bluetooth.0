Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: making enable_hs independent from L2CAP
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 18 Nov 2011 13:04:57 +0100
In-Reply-To: <1321616142-19038-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321616142-19038-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321617901.15441.613.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Fixes bluetooth compiling when CONFIG_BT_L2CAP is not enabled
> 
> net/built-in.o: In function `hci_dev_open':
> (.text+0xdce9a): undefined reference to `enable_hs'
> 
> Reported-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c   |    5 +++++
>  net/bluetooth/l2cap_core.c |    4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


