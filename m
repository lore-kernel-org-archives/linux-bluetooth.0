Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Thu, 5 Aug 2010 00:38:58 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/9] Bluetooth:  Only enable for L2CAP FCS for ERTM or
 streaming.
Message-ID: <20100805033858.GF7870@vigoh>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
 <1280962146-22604-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280962146-22604-2-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

HI Mat,

You are adding to spaces after "Bluetooth:" and the commit message, one is
fine. All the patches have this issue.

* Mat Martineau <mathewm@codeaurora.org> [2010-08-04 15:48:58 -0700]:

> This fixes a bug which caused the FCS setting to show L2CAP_FCS_CRC16
> with L2CAP modes other than ERTM or streaming.  At present, this only
> affects the FCS value shown with getsockopt() for basic mode.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 

-- 
Gustavo F. Padovan
http://padovan.org
