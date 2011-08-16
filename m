Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Cc: "ovasik@redhat.com" <ovasik@redhat.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 16 Aug 2011 11:50:40 +0200
Subject: [PATCH 6/8] Removed unnecessary memset
MIME-Version: 1.0
From: "Pavel Raiskup" <praiskup@redhat.com>
Message-ID: <op.v0awaqywh52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

zeroing memory with memset at "buf" position is useless because
g_try_malloc0 zeroes is also. Actually parameter sizeof(buf) is
wrong also (only 8 bytes cause it is a pointer).
---
  plugins/mgmtops.c |    2 --
  1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3cdb97e..79a898f 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1877,8 +1877,6 @@ static int mgmt_load_keys(int index, GSList *keys,  
gboolean debug_keys)
  	if (buf == NULL)
  		return -ENOMEM;

-	memset(buf, 0, sizeof(buf));
-
  	hdr = (void *) buf;
  	hdr->opcode = htobs(MGMT_OP_LOAD_KEYS);
  	hdr->len = htobs(cp_size);
-- 
1.7.4.4
