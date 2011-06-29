Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi
Subject: [PATCH 0/6] Bluetooth: ERTM fixes and local busy enhancement
Date: Wed, 29 Jun 2011 14:35:18 -0700
Message-Id: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches fix various ERTM issues, mostly having to do with
receiver-side handling of flow control (the "local busy" state). This
new approach will not keep very much incoming data beyond what fits in
the socket receive buffer, so memory use is more tightly
controlled. When incoming data does not immediately fit in the socket
buffer, the L2CAP socket layer will now only check for available space
when the socket is read from instead of polling on a workqueue thread.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


