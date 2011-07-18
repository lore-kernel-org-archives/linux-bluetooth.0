Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Jul 2011 13:02:49 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: padovan@profusion.mobi
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] Zero-copy L2CAP ERTM & streaming reassembly
In-Reply-To: <1310579919-24546-1-git-send-email-mathewm@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1107181300360.7338@mathewm-linux>
References: <1310579919-24546-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Wed, 13 Jul 2011, Mat Martineau wrote:

> This patch series changes SDU reassembly to link together PDU skbs
> using a frag list instead of copying all data bytes to a single,
> linear skb.  The reduction in overhead is especially helpful with high
> speed AMP links.
>
>
> Mat Martineau (3):
>  Bluetooth: Linearize skbs for use in BNEP, CMTP, HIDP, and RFCOMM
>  Bluetooth: Handle fragmented skbs in bt_sock_stream_recvmsg()
>  Bluetooth: Perform L2CAP SDU reassembly without copying data
>
> include/net/bluetooth/l2cap.h |    3 +-
> net/bluetooth/af_bluetooth.c  |   30 +++++-
> net/bluetooth/bnep/core.c     |    5 +-
> net/bluetooth/cmtp/core.c     |    5 +-
> net/bluetooth/hidp/core.c     |   10 ++-
> net/bluetooth/l2cap_core.c    |  239 ++++++++++++++---------------------------
> net/bluetooth/rfcomm/core.c   |    5 +-
> 7 files changed, 128 insertions(+), 169 deletions(-)
>
> -- 
> 1.7.6

Have you had a chance to look at these patches?

Thanks,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

