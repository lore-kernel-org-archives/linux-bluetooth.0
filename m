Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Fix byte order problems getting PSM through btio API
Date: Wed, 30 Nov 2011 17:36:16 +0100
Message-Id: <1322670976-9517-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 btio/btio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index a129bf9..f8c5cc7 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -882,7 +882,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 			break;
 		case BT_IO_OPT_PSM:
 			*(va_arg(args, uint16_t *)) = src.l2_psm ?
-						src.l2_psm : dst.l2_psm;
+					btohs(src.l2_psm) : btohs(dst.l2_psm);
 			break;
 		case BT_IO_OPT_CID:
 			*(va_arg(args, uint16_t *)) = src.l2_cid ?
-- 
1.7.7.4

