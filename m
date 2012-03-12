Return-Path: <cyrus@holtmann.org>
Message-ID: <1331574436.14217.91.camel@aeonflux>
Subject: Re: [PATCHv2 5/6] Bluetooth: trivial: Fix endian conversion mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 12 Mar 2012 10:47:16 -0700
In-Reply-To: <1331547191-15307-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1331547191-15307-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> In L2CAP we use le16 format so change direction of conversion
> from le16_to_cpu to cpu_to_le16.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


