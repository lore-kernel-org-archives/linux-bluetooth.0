Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 25 Aug 2010 14:11:16 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Only enable for L2CAP FCS for ERTM or
 streaming
Message-ID: <20100825171116.GA13872@vigoh>
References: <1282689346-20371-1-git-send-email-mathewm@codeaurora.org>
 <1282689346-20371-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282689346-20371-2-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-24 15:35:42 -0700]:

> This fixes a bug which caused the FCS setting to show L2CAP_FCS_CRC16
> with L2CAP modes other than ERTM or streaming.  At present, this only
> affects the FCS value shown with getsockopt() for basic mode.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   19 +++++++++++++------
>  1 files changed, 13 insertions(+), 6 deletions(-)

This one is on bluetooth-testing, but Marcel should move it to
bluetooth-2.6 as this patch is planned to go into 2.6.36

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
