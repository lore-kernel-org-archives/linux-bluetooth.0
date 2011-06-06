Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jun 2011 14:38:06 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: Fix check for the ERTM local busy state
Message-ID: <20110606173806.GC30641@joana>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
 <1307143270-2655-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307143270-2655-4-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-06-03 16:21:10 -0700]:

> Local busy is encoded in a bitfield, but was not masked out correctly.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
