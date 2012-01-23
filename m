Return-Path: <cyrus@holtmann.org>
Message-ID: <1327309630.1955.89.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: Make l2cap_ertm_data_rcv static
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Date: Mon, 23 Jan 2012 10:07:10 +0100
In-Reply-To: <1327309565-17367-1-git-send-email-szymon.janc@tieto.com>
References: <1327309565-17367-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> It is not used outside of l2cap_core.c. Also l2cap_ertm_data_rcv is
> only used after it is defined so there is no need for forward declaration.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

I assume that you and Andrei agreed here. If not, he needs to speak up.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


