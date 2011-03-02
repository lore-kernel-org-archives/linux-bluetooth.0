Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix adapter reference count in input plugin
Date: Wed, 2 Mar 2011 10:44:57 +0100
Message-ID: <1299059097-24462-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter unref was called  on driver removal even if input server failed
to start on probe and reference was not incremented. This leads to
segmentation fault while removing adapter.
---
 input/manager.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/input/manager.c b/input/manager.c
index a98a080..259aef7 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -143,6 +143,9 @@ static void hid_server_remove(struct btd_adapter *adapter)
 {
 	bdaddr_t src;
 
+	if (!g_slist_find(adapters, adapter))
+		return;
+
 	adapter_get_address(adapter, &src);
 
 	server_stop(&src);
-- 
1.7.0.4
on behalf of ST-Ericsson
