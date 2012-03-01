Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't force DISCOVERY_STOPPED state in inquiry_cache_flush
Date: Thu,  1 Mar 2012 18:19:57 -0300
Message-Id: <1330636797-16171-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are not supposed to force DISCOVERY_STOPPED in inquiry_cache_flush
because we may break the discovery state machine. For instance,
during interleaved discovery, when we are about to start inquiry,
the state machine forcibly goes to DISCOVERY_STOPPED while it
should stay in DISCOVERY_FINDING state.

This problem results in unexpected behaviors such as sending two
mgmt_discovering events to userspace (when only one event is
expected) and Stop Discovery failures.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d3ddc0b..661d65f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -413,7 +413,6 @@ static void inquiry_cache_flush(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&cache->unknown);
 	INIT_LIST_HEAD(&cache->resolve);
-	cache->state = DISCOVERY_STOPPED;
 }
 
 struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
-- 
1.7.9.2

