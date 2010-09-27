Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 27 Sep 2010 17:38:31 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/4 v6] L2CAP updates for valid PSMs, SOCK_STREAM reads
Message-ID: <20100927203831.GC5489@vigoh>
References: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-09-08 10:05:25 -0700]:

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

All 4 patches have been applied to my bluetoot-next-2.6 tree for later
merge in wireless-next-2.6

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
