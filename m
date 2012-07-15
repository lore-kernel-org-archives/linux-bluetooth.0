Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Jul 2012 12:22:26 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCHv2] Bluetooth: Use transmit window from config response
 for ack timing
Message-ID: <20120715152039.GA23903@joana>
References: <1341924427-19401-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341924427-19401-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-07-10 05:47:07 -0700]:

> This change addresses an L2CAP ERTM throughput problem when a remote
> device does not fully utilize the available transmit window.
> 
> The L2CAP ERTM transmit window size determines the maximum number of
> unacked frames that may be outstanding at any time. It is configured
> separately for each direction of an ERTM connection. Each side sends a
> configuration request with a tx_win field indicating how many unacked
> frames it is capable of receiving before sending an ack. The
> configuration response's tx_win field shows how many frames the
> transmitter will actually send before waiting for an ack.
> 
> It's important to trace both the actual transmit window (to check for
> validity of incoming frames) and the number of frames that the
> transmitter will send before waiting (to send acks at the appropriate
> time). Now there are separate tx_win and ack_win values. ack_win is
> updated based on configuration responses, and is used to determine
> when acks are sent.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 59 +++++++++++++++++++++++++------------------
>  2 files changed, 35 insertions(+), 25 deletions(-)

Patch has been applied to bluetooth-next with a small title change, it is now
"Bluetooth: Use tx window from config response for ack timing". Thanks.

	Gustavo
