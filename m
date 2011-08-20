Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 7/8] Remove the default security level from btio
Date: Fri, 19 Aug 2011 21:09:28 -0300
Message-Id: <1313798969-8772-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
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
index 337dcb9..fbe6e56 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -682,7 +682,6 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 	/* Set defaults */
 	opts->defer = DEFAULT_DEFER_TIMEOUT;
 	opts->master = -1;
-	opts->sec_level = BT_IO_SEC_MEDIUM;
 	opts->mode = L2CAP_MODE_BASIC;
 	opts->flushable = -1;
 
-- 
1.7.6

