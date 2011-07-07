Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jul 2011 15:36:23 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Bluetooth: Remove L2CAP busy queue
Message-ID: <20110707183623.GC16322@joana>
References: <1310056743-2643-1-git-send-email-mathewm@codeaurora.org>
 <1310056743-2643-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310056743-2643-4-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2011-07-07 09:39:03 -0700]:

> The ERTM receive buffer is now handled in a way that does not require
> the busy queue and the associated polling code.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    4 -
>  net/bluetooth/l2cap_core.c    |  125 +++--------------------------------------
>  2 files changed, 8 insertions(+), 121 deletions(-)

All 3 patches applied, thanks.

	Gustavo
