Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 May 2012 09:22:34 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Fix packet size informed to the
 controller
In-Reply-To: <1336569159-4710-1-git-send-email-gustavo@padovan.org>
Message-ID: <alpine.DEB.2.02.1205090919280.2090@mathewm-linux>
References: <1336569159-4710-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Wed, 9 May 2012, Gustavo Padovan wrote:

> skb->len is the wrong var to tell the size of a packet, skb->len keeps the
> size of the overall skb, including its head and fragments, then when
> sending the head the wrong size is passed if the we have a framented skb.
> We fix this by using skb_datalen(skb) which is the total skb size minus
> the fragments size, i.e., the actual head size.
>
> This bug appeared when implementing MSG_MORE support for L2CAP sockets, it
> never showed up before because l2cap_skbuff_fromiovec() never accounted skb
> size correctly. A following patch will fix this.
>
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
> drivers/bluetooth/bluecard_cs.c |    5 +++--
> drivers/bluetooth/bpa10x.c      |    4 ++--
> drivers/bluetooth/bt3c_cs.c     |    4 ++--
> drivers/bluetooth/btusb.c       |    4 ++--
> drivers/bluetooth/btwilink.c    |    2 +-
> drivers/bluetooth/dtl1_cs.c     |   13 +++++++------
> drivers/bluetooth/hci_bcsp.c    |    8 ++++++--
> drivers/bluetooth/hci_ldisc.c   |    7 ++++---
> drivers/bluetooth/hci_vhci.c    |    2 +-
> net/bluetooth/hci_core.c        |    2 +-
> 10 files changed, 29 insertions(+), 22 deletions(-)

The drivers should never see fragmented skbs, so this change should 
not be necessary.  See my reply to the next patch for the full 
background information.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
