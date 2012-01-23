Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 12:50:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Make l2cap_ertm_data_rcv static
Message-ID: <20120123105019.GA13058@x220>
References: <1327309565-17367-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327309565-17367-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Jan 23, 2012, Szymon Janc wrote:
> It is not used outside of l2cap_core.c. Also l2cap_ertm_data_rcv is
> only used after it is defined so there is no need for forward declaration.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
