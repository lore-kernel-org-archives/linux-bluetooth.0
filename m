Return-Path: <cyrus@holtmann.org>
Message-ID: <1326228287.6454.215.camel@aeonflux>
Subject: Re: [PATCH] net: bluetooth: Fix 'enable_hs' type
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Tue, 10 Jan 2012 12:44:47 -0800
In-Reply-To: <1326227630-2556-1-git-send-email-festevam@gmail.com>
References: <1326227630-2556-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabio,

> Fix the following build warning:
> 
>   CC [M]  net/bluetooth/hci_core.o
> net/bluetooth/hci_core.c: In function ‘__check_enable_hs’:
> net/bluetooth/hci_core.c:2587: warning: return from incompatible pointer type
> 
> module_param in hci_core.c passes 'enable_hs' as bool format, so fix this variable definition type.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  include/net/bluetooth/hci.h |    2 +-
>  net/bluetooth/hci_core.c    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


