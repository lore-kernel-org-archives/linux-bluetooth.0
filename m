Return-Path: <cyrus@holtmann.org>
Message-ID: <1335422389.16897.425.camel@aeonflux>
Subject: Re: [RFC 3/8] Bluetooth: Remove duplicate structure members from
 bt_skb_cb
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Date: Thu, 26 Apr 2012 08:39:49 +0200
In-Reply-To: <1335396979-11692-4-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
	 <1335396979-11692-4-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> These values are now in the nested l2cap_ctrl struct.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/bluetooth.h |    3 ---
>  net/bluetooth/l2cap_core.c        |   34 +++++++++++++++++-----------------
>  2 files changed, 17 insertions(+), 20 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


