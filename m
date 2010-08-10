Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 1/7] Bluetooth: Calculate L2CAP FCS on fragmented skbuffs.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281467704-5378-2-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
	 <1281467704-5378-2-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 17:22:43 -0400
Message-ID: <1281475363.12579.224.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> When L2CAP PDUs are longer than the HCI MTU, they are stored in
> fragmented skbuffs.  This adds a function to calculate the FCS
> on any skbuff (fragmented or not), and replaces direct calls
> to crc16 with calls to the new apply_fcs() function.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   57 ++++++++++++++++++++++++++++++++----------------
>  1 files changed, 38 insertions(+), 19 deletions(-)

looks fine to me. Just lets get the other ones in first and then we can
apply this one.

Regards

Marcel


