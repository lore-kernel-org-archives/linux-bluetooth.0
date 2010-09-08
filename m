Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Sep 2010 16:45:40 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Validate PSM values in calls to
 connect() and bind()
Message-ID: <20100908194540.GI16973@vigoh>
References: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
 <1283965529-17068-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283965529-17068-2-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2010-09-08 10:05:26 -0700]:

> Valid L2CAP PSMs are odd numbers, and the least significant bit of the
> most significant byte must be 0.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   25 +++++++++++++++++++++----
>  1 files changed, 21 insertions(+), 4 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
