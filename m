Return-Path: <cyrus@holtmann.org>
Message-ID: <1349968264.27233.180.camel@aeonflux>
Subject: Re: [RFC 3/6] Bluetooth: Factor out common L2CAP connection code
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Date: Thu, 11 Oct 2012 17:11:04 +0200
In-Reply-To: <1349966905-32336-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349966905-32336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1349966905-32336-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> L2CAP connect requests and create channel requests share a significant
> amount of code.  This change moves common code to a new function.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


