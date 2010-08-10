Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/5] Bluetooth: Only enable L2CAP FCS for ERTM or
 streaming.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281466850-5297-2-git-send-email-mathewm@codeaurora.org>
References: <1281466850-5297-1-git-send-email-mathewm@codeaurora.org>
	 <1281466850-5297-2-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 17:17:11 -0400
Message-ID: <1281475031.12579.219.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> This fixes a bug which caused the FCS setting to show L2CAP_FCS_CRC16
> with L2CAP modes other than ERTM or streaming.  At present, this only
> affects the FCS value shown with getsockopt() for basic mode.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   19 +++++++++++++------
>  1 files changed, 13 insertions(+), 6 deletions(-)

patch has been applied, but please stop adding a . at the end of your
subject line ;)

Regards

Marcel


