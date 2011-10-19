Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2 1/9] Bluetooth: Add BT_CHANNEL_POLICY socket option
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Wed, 19 Oct 2011 11:55:18 -0700
In-Reply-To: <1319046247-3391-2-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
	 <1319046247-3391-2-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319050521.15441.160.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Allow control of AMP functionality on L2CAP sockets. By default,
> connections will be restricted to BR/EDR.  Manipulating the
> BT_CHANNEL_POLICY option allows for channels to be moved to or created
> on AMP controllers.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/bluetooth.h |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)

so until someone else speaks up about naming or the policy itself, then
I am fine with this right now.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


