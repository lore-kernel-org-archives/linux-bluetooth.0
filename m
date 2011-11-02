Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2] Bluetooth: Initialize tx_win_max for fixed channel
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 02 Nov 2011 15:17:45 +0100
In-Reply-To: <1320220630-13551-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320220630-13551-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320243467.15441.281.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> tx_win_max is initialized during L2CAP configuration phase. For fixed
> channels (e.g. A2MP) we want to have it initialized when channel is
> created.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

if there are no objections from anybody else, I am fine with this.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


