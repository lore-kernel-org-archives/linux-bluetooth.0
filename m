Return-Path: <cyrus@holtmann.org>
Message-ID: <1336412323.5970.106.camel@aeonflux>
Subject: Re: [PATCH -v2 2/2] Bluetooth: report the right security level in
 getsockopt
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 07 May 2012 10:38:43 -0700
In-Reply-To: <1336370846-7979-2-git-send-email-gustavo@padovan.org>
References: <1336370846-7979-1-git-send-email-gustavo@padovan.org>
	 <1336370846-7979-2-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> During a security level elevation we need to keep track of the current
> security level of a connection until the new one is not confirmed.
> 
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
>  net/bluetooth/l2cap_sock.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


