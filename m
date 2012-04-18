Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, johan.hedberg@intel.com, marcel@holtmann.org,
	hemant.gupta@stericsson.com,
	Scott James Remnant <scott@netsplit.com>
Subject: [PATCH] hciops: map KeyboardDisplay IO Capability to DisplayYesNo
Date: Wed, 18 Apr 2012 15:01:01 -0700
Message-Id: <1334786461-5643-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since hciops is not used for LE devices, if an agent announces the
KeyboardDisplay IO Capability when creating a bonding, map it to
DisplayYesNo.

This matches the existing change in hciops_set_io_capability which
is only used in the RegisterAgent path.
---
 plugins/hciops.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index a62b160..ef444da 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3738,7 +3738,10 @@ static int hciops_create_bonding(int index, bdaddr_t *bdaddr,
 	if (conn->io != NULL)
 		return -EBUSY;
 
-	conn->loc_cap = io_cap;
+	/* hciops is not to be used for SMP pairing for LE devices. So
+	 * change the IO capability from KeyboardDisplay to DisplayYesNo
+	 * in case it is set. */
+	conn->loc_cap = (io_cap == 0x04 ? 0x01 : io_cap);
 
 	/* If our IO capability is NoInputNoOutput use medium security
 	 * level (i.e. don't require MITM protection) else use high
-- 
1.7.7.3

