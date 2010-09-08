Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/4 v6] L2CAP updates for valid PSMs, SOCK_STREAM reads
Date: Wed,  8 Sep 2010 10:05:25 -0700
Message-Id: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set is the same as 'v5', with a fix to PSM validation.


[PATCH 1/4] Bluetooth: Validate PSM values in calls to connect() and bind()

Modified to bypass PSM validation for SOCK_RAW (bonding) sockets.


[PATCH 2/4] Bluetooth: Add common code for stream-oriented recvmsg()
[PATCH 3/4] Bluetooth: Use common SOCK_STREAM receive code in RFCOMM
[PATCH 4/4] Bluetooth: Use a stream-oriented recvmsg with SOCK_STREAM L2CAP sockets.

These patches change the read behavior of SOCK_STREAM L2CAP sockets to
allow reading of partial SDUs.  Same as the 'v5' patches.
