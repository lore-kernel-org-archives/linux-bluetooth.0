Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 27 Sep 2010 17:40:45 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org, rshaffer@codeaurora.org,
	haijun.liu@atheros.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Add socket option definitions for AMP
Message-ID: <20100927204045.GD5489@vigoh>
References: <1283966193-17831-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283966193-17831-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-09-08 10:16:33 -0700]:

> This adds a new BT_AMP socket option to control the use of AMP channels.
> It is for use with the SOL_BLUETOOTH option level on L2CAP sockets.
> 
> Available option values are defined as:
> 
> BT_AMP_REQUIRE_BR_EDR
>  * Default
>  * AMP controllers cannot be used
>  * Channel move requests from the remote device are denied
>  * If the L2CAP channel is currently using AMP, move the channel to
>    BR/EDR
> 
> BT_AMP_PREFER_AMP
>  * Allow use of AMP controllers
>  * If the L2CAP channel is currently on BR/EDR and AMP controller
>    resources are available, initiate a channel move to AMP
>  * Channel move requests from the remote device are allowed
>  * If the L2CAP socket has not been connected yet, try to create
>    and configure the channel directly on an AMP controller rather
>    than BR/EDR
> 
> BT_AMP_PREFER_BR_EDR
>  * Allow use of AMP controllers
>  * If the L2CAP channel is currently on AMP, move it to BR/EDR
>  * Channel move requests from the remote device are allowed
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/bluetooth.h |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)

Patch has been applied to my bluetooth-next-2.6 tree.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
