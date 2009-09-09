Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <phurley@charter.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Peter Hurley <phurley@charter.net>
Subject: [PATCH 1/1] Fixed duplicate attempt from device to connect 'signalling' channel
Date: Wed,  9 Sep 2009 13:25:35 -0400
Message-Id: <1252517135-7753-1-git-send-email-phurley@charter.net>
In-Reply-To: <20090908222839.GA25653@jh-x301>
References: <20090908222839.GA25653@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A device may attempt to initiate a duplicate avdtp channel while
a host-initiated channel connection is still pending. This
situation is referred to as 'XCASE connect:connect' in sink.c and
source.c. This fix rejects the device-initiated connection in this
circumstance.
---
 audio/avdtp.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 131ff4f..6cb9e7d 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2119,6 +2119,18 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (!session)
 		goto drop;
 
+	/* This state (ie, session is already *connecting*) happens when the
+	 *  device initiates a connect (really a config'd L2CAP channel) even
+	 *  though there is a connect we initiated in progress.  In sink.c &
+	 *  source.c, this state is referred to as XCASE connect:connect.
+	 * Abort the device's channel in favor of our own.
+	 */
+	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
+		debug("avdtp_confirm_cb: connect already in progress" \
+					" (XCASE connect:connect)");
+		goto drop;
+	}
+
 	if (session->pending_open && session->pending_open->open_acp) {
 		if (!bt_io_accept(chan, avdtp_connect_cb, session, NULL, NULL))
 			goto drop;
-- 
1.6.0.4

