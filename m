Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Mar 2011 14:59:30 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH] Bluetooth: Increment unacked_frames count only the first
 transmit
Message-ID: <20110311175930.GA2152@joana>
References: <1299662045-5214-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299662045-5214-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj Sumangala <suraj@atheros.com> [2011-03-09 14:44:05 +0530]:

> This patch lets 'l2cap_pinfo.unacked_frames' be incremented only
> the first time a frame is transmitted.
> 
> Previously it was being incremented for retransmitted packets
> too resulting the value to cross the transmit window size.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
