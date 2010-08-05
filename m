Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/9] Bluetooth: L2CAP updates for PSM validation and ERTM
Date: Thu,  5 Aug 2010 15:54:18 -0700
Message-Id: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a collection of ERTM-related patches, including some L2CAP
configuration fixes and allowing partial-frame reads from L2CAP
SOCK_STREAM sockets.  PSM validation is also included, although that
is not restricted to ERTM.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


