Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: trivial space correction
Date: Wed, 18 Jan 2012 11:12:17 +0200
Message-Id: <1326877937-26609-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3ee9bde..a4ec5c5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4713,7 +4713,7 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 					c->state, __le16_to_cpu(c->psm),
 					c->scid, c->dcid, c->imtu, c->omtu,
 					c->sec_level, c->mode);
-}
+	}
 
 	read_unlock(&chan_list_lock);
 
-- 
1.7.4.1

