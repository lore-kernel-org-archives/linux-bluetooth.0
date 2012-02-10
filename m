Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 17/22] mgmtops: Fix doing a useless memset()
Date: Fri, 10 Feb 2012 18:40:02 -0300
Message-Id: <1328910007-25604-18-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The buffers were already allocated using g_try_malloc0().
---
 plugins/mgmtops.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 7e47386..d354bc6 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1958,8 +1958,6 @@ static int mgmt_load_link_keys(int index, GSList *keys, gboolean debug_keys)
 	if (buf == NULL)
 		return -ENOMEM;
 
-	memset(buf, 0, sizeof(buf));
-
 	hdr = (void *) buf;
 	hdr->opcode = htobs(MGMT_OP_LOAD_LINK_KEYS);
 	hdr->len = htobs(cp_size);
@@ -2169,8 +2167,6 @@ static int mgmtops_load_ltks(int index, GSList *keys)
 	if (buf == NULL)
 		return -ENOMEM;
 
-	memset(buf, 0, sizeof(buf));
-
 	hdr = (void *) buf;
 	hdr->opcode = htobs(MGMT_OP_LOAD_LONG_TERM_KEYS);
 	hdr->len = htobs(cp_size);
-- 
1.7.8.1

