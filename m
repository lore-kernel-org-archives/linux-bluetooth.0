Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Wed, 11 Aug 2010 02:25:42 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 7/7] Bluetooth: Do not limit enhanced L2CAP max PDU size
 to HCI MTU.
Message-ID: <20100811052542.GB10773@vigoh>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
 <1281467704-5378-8-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281467704-5378-8-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-10 12:15:04 -0700]:

> HCI MTU and PDU size have no relationship, since ERTM and streaming PDUs
> can be fragmented over HCI just like other L2CAP frames.  The only
> applicable limit for PDU size is the L2CAP MTU, which is now checked
> during L2CAP configuration.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)

This one is fine after the changes in the previous patches.

-- 
Gustavo F. Padovan
http://padovan.org
