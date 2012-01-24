Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 5/6] Remove the default security level from btio
Date: Mon, 23 Jan 2012 21:27:04 -0300
Message-Id: <1327364825-7285-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1327364825-7285-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1327364825-7285-1-git-send-email-vinicius.gomes@openbossa.org>
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
index 77ddb1d..825907d 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -695,7 +695,6 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 	/* Set defaults */
 	opts->defer = DEFAULT_DEFER_TIMEOUT;
 	opts->master = -1;
-	opts->sec_level = BT_IO_SEC_MEDIUM;
 	opts->mode = L2CAP_MODE_BASIC;
 	opts->flushable = -1;
 	opts->priority = 0;
-- 
1.7.8.1

