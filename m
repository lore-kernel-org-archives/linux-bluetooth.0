Return-Path: <cyrus@holtmann.org>
From: Pavel Raiskup <praiskup@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: ovasik@redhat.com
Subject: [PATCH 6/8] Removed unnecessary memset
Date: Tue, 30 Aug 2011 15:13:59 +0200
Message-Id: <1314710039-13519-1-git-send-email-praiskup@redhat.com>
In-Reply-To: <op.v0awaqywh52hc0@dhcp-25-209.brq.redhat.com>
References: <op.v0awaqywh52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

zeroing memory with memset at "buf" position is useless because
g_try_malloc0 zeroes it also. Actually parameter sizeof(buf) is
wrong too (only 8 bytes cause it is a pointer).
---
 plugins/mgmtops.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3cdb97e..79a898f 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1877,8 +1877,6 @@ static int mgmt_load_keys(int index, GSList *keys, gboolean debug_keys)
 	if (buf == NULL)
 		return -ENOMEM;
 
-	memset(buf, 0, sizeof(buf));
-
 	hdr = (void *) buf;
 	hdr->opcode = htobs(MGMT_OP_LOAD_KEYS);
 	hdr->len = htobs(cp_size);
-- 
1.7.4.4

