Return-Path: <cyrus@holtmann.org>
Message-ID: <1350326485.26318.18.camel@aeonflux>
Subject: Re: [PATCH 13/19] Bluetooth: Flag ACL frames as complete for AMP
 controllers
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Mon, 15 Oct 2012 20:41:25 +0200
In-Reply-To: <1350315248-7690-14-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
	 <1350315248-7690-14-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> AMP controllers expect to transmit only "complete" ACL frames.  These
> frames have both the "start" and "cont" bits set.  AMP does not allow
> fragmented ACLs.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


