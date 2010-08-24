Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 0/5] L2CAP updates for FCS, valid PSMs, and stream recv
Date: Tue, 24 Aug 2010 15:35:41 -0700
Message-Id: <1282689346-20371-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

These patches incorporate requested fixes from the 'v4' submission.


[PATCH 1/5] Bluetooth: Only enable for L2CAP FCS for ERTM or streaming

This got an "applied" response on the mailing list, but it looks like
the commit got dropped during a rebase.


[PATCH 2/5] Bluetooth: Validate PSM values in calls to connect() and bind()

Fixed comments.


[PATCH 3/5] Bluetooth: Add common code for stream-oriented recvmsg()
[PATCH 4/5] Bluetooth: Use common SOCK_STREAM receive code in RFCOMM
[PATCH 5/5] Bluetooth: Use a stream-oriented recvmsg with SOCK_STREAM L2CAP sockets.

No changes were requested in these patches.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
