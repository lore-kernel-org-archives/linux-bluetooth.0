Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 17:28:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	kanak.gupta@stericsson.com
Subject: Re: [PATCH 1/2] Bluetooth: Fix possible missing I-Frame
 acknowledgement
Message-ID: <20120209152854.GA24472@x220.ger.corp.intel.com>
References: <1328625782-19624-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328625782-19624-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Feb 07, 2012, Szymon Janc wrote:
> Make l2cap_ertm_send return number of pending I-Frames transmitted
> instead of all (pending + retransmitted) I-Frames transmitted.
> 
> As only pending I-Frames are considered as acknowledgement, this could
> lead to situation when no ACK was sent in __l2cap_send_ack (if only
> already transmitted I-Frames were retransmitted).
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Both patches have been applied to my bluetooth-next tree. Thanks.

Johan
