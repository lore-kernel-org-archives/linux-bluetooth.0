Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 May 2012 18:48:49 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCH] Bluetooth: Initialize the transmit queue for L2CAP
 streaming mode
Message-ID: <20120515214849.GA1414@joana>
References: <1337032167-30454-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337032167-30454-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-05-14 14:49:27 -0700]:

> Commit 105bdf9ec19e729bacdb33861c74fcf3eb39eb37 introduced a
> regression in L2CAP streaming mode due to rearranged initialization
> code that is shared between ERTM and streaming mode.  This change
> makes sure the transmit queue is initialized in both modes.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
