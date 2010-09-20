Return-Path: <cyrus@holtmann.org>
Message-ID: <4C97CEC7.2020107@codeaurora.org>
Date: Mon, 20 Sep 2010 16:14:47 -0500
From: Ron Shaffer <rshaffer@codeaurora.org>
MIME-Version: 1.0
To: Mat Martineau <mathewm@codeaurora.org>
CC: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 gustavo@padovan.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/4 v6] L2CAP updates for valid PSMs, SOCK_STREAM reads
References: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On 9/8/2010 12:05 PM, Mat Martineau wrote:
> This patch set is the same as 'v5', with a fix to PSM validation.
> 
> 
> [PATCH 1/4] Bluetooth: Validate PSM values in calls to connect() and bind()
> 
> Modified to bypass PSM validation for SOCK_RAW (bonding) sockets.
> 
> 
> [PATCH 2/4] Bluetooth: Add common code for stream-oriented recvmsg()
> [PATCH 3/4] Bluetooth: Use common SOCK_STREAM receive code in RFCOMM
> [PATCH 4/4] Bluetooth: Use a stream-oriented recvmsg with SOCK_STREAM L2CAP sockets.
> 
> These patches change the read behavior of SOCK_STREAM L2CAP sockets to
> allow reading of partial SDUs.  Same as the 'v5' patches.
> 

Ping

-- 
Ron Shaffer
Employee of the Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
