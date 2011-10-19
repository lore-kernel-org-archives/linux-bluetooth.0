Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2 4/9] Bluetooth: Add AMP-related data and structures
 for channel signals
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Wed, 19 Oct 2011 11:58:19 -0700
In-Reply-To: <1319046247-3391-5-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
	 <1319046247-3391-5-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319050702.15441.161.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> AMP channel creation and channel moves are coordinated using the L2CAP
> signaling channel.  These definitions cover the "create channel",
> "move channel", and "move channel confirm" signals.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   54 +++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 52 insertions(+), 2 deletions(-)

looks all fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


