Return-Path: <cyrus@holtmann.org>
Message-ID: <1352934538.20338.14.camel@aeonflux>
Subject: Re: [RFCv1 2/3] Bluetooth: Disable FCS only for new HS channels
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 15 Nov 2012 08:08:58 +0900
In-Reply-To: <1352907572-7113-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1352907572-7113-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1352907572-7113-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Set chan->fcs to L2CAP_FCS_NONE only for new L2CAP channels
> (not moved). Other side can still request to use FCS.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/amp.c        |    1 -
>  net/bluetooth/l2cap_core.c |    2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


