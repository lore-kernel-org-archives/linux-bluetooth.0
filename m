Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Jul 2011 19:50:53 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: Perform L2CAP SDU reassembly without
 copying data
Message-ID: <20110725225053.GB3267@joana>
References: <1311371640-10324-1-git-send-email-mathewm@codeaurora.org>
 <1311371640-10324-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311371640-10324-4-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-07-22 14:54:00 -0700]:

> Use sk_buff fragment capabilities to link together incoming skbs
> instead of allocating a new skb for reassembly and copying.
> 
> The new reassembly code works equally well for ERTM and streaming
> mode, so there is now one reassembly function instead of two.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    3 +-
>  net/bluetooth/l2cap_core.c    |  243 ++++++++++++++---------------------------
>  2 files changed, 81 insertions(+), 165 deletions(-)

All 3 patches applied, thanks.

	Gustavo
