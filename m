Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/8] Bluetooth:  L2CAP updates for PSM validation and ERTM.
Date: Mon,  2 Aug 2010 12:20:02 -0700
Message-Id: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This is a collection of ERTM-related patches, including some L2CAP 
configuration fixes and allowing partial-frame reads from L2CAP
SOCK_STREAM sockets.  PSM validation is also included, although that
is not restricted to ERTM.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
