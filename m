Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] adapter: Don't store Discoverable value if DiscoverableTimeout is set
Date: Thu,  6 Dec 2012 20:41:12 -0300
Message-Id: <1354837273-31712-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1354837273-31712-1-git-send-email-andre.guedes@openbossa.org>
References: <1354837273-31712-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If adapter was set to Discoverable and DiscoverableTimeout is greater
than zero we should not store the Discoverable adapter info as long as
it is a non-persistent state. This way, we don't need to worry about
updating the Discoverable stored value once the timeout expires.
---
 src/adapter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 25501c4..35a4715 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2269,8 +2269,12 @@ static void set_mode_complete(struct btd_adapter *adapter)
 	if (err != 0)
 		error("unable to set mode: %s", mode2str(pending->mode));
 
+	if (adapter->mode == MODE_DISCOVERABLE && adapter->discov_timeout > 0)
+		goto done;
+
 	store_adapter_info(adapter);
 
+done:
 	session_unref(pending);
 }
 
-- 
1.8.0.1

