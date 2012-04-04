Return-Path: <cyrus@holtmann.org>
Message-ID: <1333571454.16897.0.camel@aeonflux>
Subject: Re: [PATCHv4 1/2] Bluetooth: Add the l2cap_seq_list structure for
 tracking frames
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com,
	szymon.janc@tieto.com
Date: Wed, 04 Apr 2012 13:30:54 -0700
In-Reply-To: <1333564183-23442-2-git-send-email-mathewm@codeaurora.org>
References: <1333564183-23442-1-git-send-email-mathewm@codeaurora.org>
	 <1333564183-23442-2-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> A sequence list is a data structure used to track frames that need to
> be retransmitted, and frames that have been requested for
> retransmission by the remote device.  It can compactly represent a
> list of sequence numbers within the ERTM transmit window.  Memory for
> the list is allocated once at connection time, and common operations
> in ERTM are O(1).
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   12 ++++
>  net/bluetooth/l2cap_core.c    |  148 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 152 insertions(+), 8 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


