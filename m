Return-Path: <cyrus@holtmann.org>
Message-ID: <1335422515.16897.428.camel@aeonflux>
Subject: Re: [RFC 6/8] Bluetooth: Lock the L2CAP channel when sending
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Date: Thu, 26 Apr 2012 08:41:55 +0200
In-Reply-To: <1335396979-11692-7-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
	 <1335396979-11692-7-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The ERTM and streaming mode transmit queue must only be accessed while
> the L2CAP channel lock is held.  Adding this lock ensures that
> multiple threads cannot simultaneously manipulate the queue when
> sending and receiving concurrently.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |   40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


