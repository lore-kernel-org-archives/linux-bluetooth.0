Return-Path: <cyrus@holtmann.org>
Message-ID: <1350493955.26318.116.camel@aeonflux>
Subject: Re: [PATCHv2 04/19] Bluetooth: Lookup channel structure based on
 DCID
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Wed, 17 Oct 2012 10:12:35 -0700
In-Reply-To: <1350430593-23565-5-git-send-email-mathewm@codeaurora.org>
References: <1350430593-23565-1-git-send-email-mathewm@codeaurora.org>
	 <1350430593-23565-5-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Processing a move channel request involves getting the channel
> structure using the destination channel ID.  Previous code could only
> look up using the source channel ID.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


