Return-Path: <cyrus@holtmann.org>
Message-ID: <1335422612.16897.429.camel@aeonflux>
Subject: Re: [RFC 7/8] Bluetooth: Refactor L2CAP ERTM and streaming transmit
 segmentation
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Date: Thu, 26 Apr 2012 08:43:32 +0200
In-Reply-To: <1335396979-11692-8-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
	 <1335396979-11692-8-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Use more common code for ERTM and streaming mode segmentation and
> transmission, and begin using skb control block data for delaying
> extended or enhanced header generation until just before the packet is
> transmitted.  This code is also better suited for resegmentation,
> which is needed when L2CAP links are reconfigured after an AMP channel
> move.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |  155 +++++++++++++++++++++++------------------
>  2 files changed, 90 insertions(+), 66 deletions(-)

from what I can see, this looks good, but I like to see a second review
of this from someone else.

Regards

Marcel


