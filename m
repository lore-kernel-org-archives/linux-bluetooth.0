Return-Path: <cyrus@holtmann.org>
Message-ID: <1337383487.2058.30.camel@aeonflux>
Subject: Re: [PATCH -v2] Bluetooth: Do not purge queue in Basic Mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Fri, 18 May 2012 16:24:47 -0700
In-Reply-To: <1337383358-19279-1-git-send-email-gustavo@padovan.org>
References: <1337383358-19279-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> chan->tx_q is only initialized if we use ERTM or Streaming mode.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


