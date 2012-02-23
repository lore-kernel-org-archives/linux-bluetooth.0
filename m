Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	pkrystad@codeaurora.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulisses@profusion.mobi,
	andrei.emeltchenko.news@gmail.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [RFC 2/2] Bluetooth: L2CAP ERTM state machine replacement
Date: Thu, 23 Feb 2012 12:37:49 -0800
Message-Id: <1330029469-8565-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The previous ERTM implementation had a handler for each frame type,
and each handler had to figure out what the current state was and
handle each frame accordingly.

This implementation has a state machine that chooses an execution path
first based on the receive or transmit state, then each state has
handlers for the frame types. This is easier to match up with the
spec, which is defined similarly.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---

Refer to https://www.codeaurora.org/gitweb/quic/bluetooth/?p=bluetooth-next.git;a=commit;h=bf897e8a45c3eefbb72e5057b0512f4392bffdba

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
