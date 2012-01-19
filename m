Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 01/34] Bluetooth: trivial: space correction
Date: Thu, 19 Jan 2012 11:19:50 +0200
Message-Id: <1326964823-26747-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e42999c..48b5c0d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4720,7 +4720,7 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 					c->state, __le16_to_cpu(c->psm),
 					c->scid, c->dcid, c->imtu, c->omtu,
 					c->sec_level, c->mode);
-}
+	}
 
 	read_unlock(&chan_list_lock);
 
-- 
1.7.4.1

