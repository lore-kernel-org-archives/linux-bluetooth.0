Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jul 2009 11:39:58 +0530
From: Vikram Kandukuri <vkandukuri@atheros.com>
To: <marcel@haltmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: Scheduled to kill the session whenever
	VIRTUAL_CABLE_UNPLUG is received by IUT
Message-ID: <20090701060948.GA7505@atheros-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Subject: [PATCH] Bluetooth: Scheduled to kill the session whenever VIRTUAL_CABLE_UNPLUG is received by IUT

There is a test case in PTS tool; PTS will send the VIRTUAL_CABLE_UNPLUG
command to IUT. IUT should disconnect the channel and kill the session
when it receives VIRTUAL_CABLE_UNPLUG command. VIRTUAL_CABLE_UNPLUG
is parsed by hidp.ko but it is not scheduled to do so (There is no
schedule code). So I have added hidp_schedule to kill the session.

Signed-off-by: Jothikumar Mothilal <jothikumar.mothilal@atheros.com>
---
 net/bluetooth/hidp/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index b186768..a9f7afb 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -374,6 +374,7 @@ static void hidp_process_hid_control(struct hidp_session *session,
 
 		/* Kill session thread */
 		atomic_inc(&session->terminate);
+		hidp_schedule(session);
 	}
 }
 
-- 
1.6.0.4

