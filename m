Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 4/7] Bluetooth: Linearize received L2CAP skbuffs.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281467704-5378-5-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
	 <1281467704-5378-5-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 17:38:33 -0400
Message-ID: <1281476313.12579.229.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Fragmented skbs are only encountered by in-kernel protocols and
> profiles when receiving ERTM or streaming mode L2CAP data.  BNEP,
> CMTP, HIDP, and RFCOMM generally use basic mode, so will not
> generally need the extra memcpy's necessary to put the L2CAP
> payload in to a linear buffer.  However, it is possible to
> use enhanced L2CAP in these modes so the possibility needs
> to be handled.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/bnep/core.c   |    5 ++++-
>  net/bluetooth/cmtp/core.c   |    5 ++++-
>  net/bluetooth/hidp/core.c   |   10 ++++++++--
>  net/bluetooth/rfcomm/core.c |    5 ++++-
>  4 files changed, 20 insertions(+), 5 deletions(-)

in general I am fine with this.

Regards

Marcel


