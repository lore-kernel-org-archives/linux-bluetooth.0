Return-Path: <cyrus@holtmann.org>
Message-ID: <1332943518.1870.167.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove unneeded zero initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 28 Mar 2012 16:05:18 +0200
In-Reply-To: <1332940001-20336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332935794-15319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1332940001-20336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove zero initialization since channel is allocated with kzalloc
> in l2cap_chan_create.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


