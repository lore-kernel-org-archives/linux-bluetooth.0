Return-Path: <cyrus@holtmann.org>
Message-ID: <1335422365.16897.424.camel@aeonflux>
Subject: Re: [RFC 1/8] Bluetooth: Improve ERTM sequence number offset
 calculation
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Date: Thu, 26 Apr 2012 08:39:25 +0200
In-Reply-To: <1335396979-11692-2-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
	 <1335396979-11692-2-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Instead of using modular division, the offset can be calculated using
> only addition and subtraction.  The previous calculation did not work
> as intended and was more difficult to understand, involving unsigned
> integer underflow and a check for a negative value where one was not
> possible.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


