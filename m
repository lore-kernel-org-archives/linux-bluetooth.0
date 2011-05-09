Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Fix starting security procedures when not needed
Date: Mon,  9 May 2011 20:49:54 -0300
Message-Id: <1304984994-14114-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The default value of sec_level when setting *any* option
using bt_io_set() was BT_SECURITY_MEDIUM. This was causing
the security procedure being started in some situations that
it should not.
---
 btio/btio.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index a3cf38a..df028a6 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -659,7 +659,6 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 	/* Set defaults */
 	opts->defer = DEFAULT_DEFER_TIMEOUT;
 	opts->master = -1;
-	opts->sec_level = BT_IO_SEC_MEDIUM;
 	opts->mode = L2CAP_MODE_BASIC;
 	opts->flushable = -1;
 
-- 
1.7.4.3

