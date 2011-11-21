Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 13:58:25 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v4 2/9] Bluetooth: User Pairing Response restructuring
Message-ID: <20111121155825.GE2552@joana>
References: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
 <1321480400-17397-3-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321480400-17397-3-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-11-16 13:53:13 -0800]:

> There are 4 possible User Responses to pairing requests,
> and they all share the same checks and handling. This
> restructures the handling of the two Confirm responses
> in preperation for the second two.
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/mgmt.c |   76 +++++++++++++++++++++++++++++++-------------------
>  1 files changed, 47 insertions(+), 29 deletions(-)

Applied, thanks.

	Gustavo
