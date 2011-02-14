Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Fix not stopping name resolving when discovery is suspended
Date: Mon, 14 Feb 2011 12:21:20 +0200
Message-Id: <1297678882-26893-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

During device creation if discovery is active we suspend it to avoid
interfering with pairing, but although it attempt to cancel name request
there could be one already completed which would cause next name on the
list to be requested.
---
 src/adapter.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3e609c1..fd4b685 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -268,6 +268,10 @@ int adapter_resolve_names(struct btd_adapter *adapter)
 	struct remote_dev_info *dev, match;
 	int err;
 
+	/* Do not attempt to resolve more names if on suspended state */
+	if (adapter->state & STATE_SUSPENDED)
+		return 0;
+
 	memset(&match, 0, sizeof(struct remote_dev_info));
 	bacpy(&match.bdaddr, BDADDR_ANY);
 	match.name_status = NAME_REQUIRED;
-- 
1.7.1

