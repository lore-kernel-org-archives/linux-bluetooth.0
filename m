Return-Path: <cyrus@holtmann.org>
Message-ID: <1335422414.16897.426.camel@aeonflux>
Subject: Re: [RFC 4/8] Bluetooth: Move recently-added ERTM header packing
 functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Date: Thu, 26 Apr 2012 08:40:14 +0200
In-Reply-To: <1335396979-11692-5-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
	 <1335396979-11692-5-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Moving these functions simplifies future patches by eliminating
> forward declarations, makes future patches easier to review, and
> better preserves 'git blame' information.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |  102 ++++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 51 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


