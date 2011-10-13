Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 8/9] Bluetooth: Add AMP header file
Date: Thu, 13 Oct 2011 15:00:46 -0700
Message-Id: <1318543247-27130-9-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This file will be home to all AMP- and A2MP-related declarations.  The
first macros map between HCI device indexes (for AMP controllers) and
AMP controller ids that are passed over the air.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/amp.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
new file mode 100644
index 0000000..b84ce53
--- /dev/null
+++ b/include/net/bluetooth/amp.h
@@ -0,0 +1,20 @@
+/*
+   Copyright (c) 2010-2011 Code Aurora Forum.  All rights reserved.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 and
+   only version 2 as published by the Free Software Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+*/
+
+#ifndef __AMP_H
+#define __AMP_H
+
+#define HCI_A2MP_ID(id)     ((id)+0x10)  /* convert HCI dev index to AMP ID */
+#define A2MP_HCI_ID(id)     ((id)-0x10)  /* convert AMP ID to HCI dev index */
+
+#endif /* __AMP_H */
-- 
1.7.7

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

