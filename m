Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 4/5] Remove the default security level from btio
Date: Tue, 13 Dec 2011 20:57:33 -0300
Message-Id: <1323820654-16820-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
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
index 5641a9c..c26a734 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -698,7 +698,6 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 	/* Set defaults */
 	opts->defer = DEFAULT_DEFER_TIMEOUT;
 	opts->master = -1;
-	opts->sec_level = BT_IO_SEC_MEDIUM;
 	opts->mode = L2CAP_MODE_BASIC;
 	opts->flushable = -1;
 	opts->priority = 0;
-- 
1.7.8

