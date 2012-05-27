Return-Path: <cyrus@holtmann.org>
Message-ID: <1338094828.15105.98.camel@aeonflux>
Subject: Re: [PATCH -v2 02/12] Bluetooth: Move clean up code and set of
 SOCK_ZAPPED to l2cap_sock.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sun, 27 May 2012 07:00:28 +0200
In-Reply-To: <1337949064-26187-3-git-send-email-gustavo@padovan.org>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
	 <1337949064-26187-3-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> This remove a bit more of socket code from l2cap core, this calls set the
> SOCK_ZAPPED and do some clean up depending on the socket state.
> 
> Reported-by: Mat Martineau <mathewm@codeaurora.org>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

the signed-off-by line indicates that this patch originally was written
by Andrei. So I prefer he gets the authorship then. The From: line at
the top should say his name.

Regards

Marcel


