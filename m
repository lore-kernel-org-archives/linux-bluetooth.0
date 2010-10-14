Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Par-Gunnar.p.HJALMDAHL@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] Unref pending call in fallback scenario.
Date: Thu, 14 Oct 2010 17:13:47 +0200
Message-ID: <1287069227-4076-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Drop the reference to pending call in fallback scenario.
Otherwise, dbus will assert once timer expires.
---
 src/agent.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index c7fdbd4..b65a550 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -706,6 +706,7 @@ static int request_fallback(struct agent_request *req,
 		return -EINVAL;
 
 	dbus_pending_call_cancel(req->call);
+	dbus_pending_call_unref(req->call);
 
 	msg = dbus_message_copy(req->msg);
 
-- 
1.6.3.3

