Return-Path: <cyrus@holtmann.org>
Message-ID: <1349963575.27233.174.camel@aeonflux>
Subject: Re: [PATCH -v2 8/8] Bluetooth: Call ops->teardown() without
 checking for NULL
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Thu, 11 Oct 2012 15:52:55 +0200
In-Reply-To: <1349938311-25101-8-git-send-email-gustavo@padovan.org>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
	 <1349938311-25101-8-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Users that don't implement teardown() should use l2cap_chan_no_teardown()
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


